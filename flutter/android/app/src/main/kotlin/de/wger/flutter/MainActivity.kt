package de.wger.flutter

import android.content.SharedPreferences
import android.os.Bundle
import androidx.annotation.NonNull
import android.util.Log
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.Wearable
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity: FlutterActivity(), MessageClient.OnMessageReceivedListener {
    private val channelName = "wger/wear"
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "initWear" -> {
                    Wearable.getMessageClient(this).addListener(this)
                    result.success(null)
                }
                "sendAuth" -> {
                    val serverUrl = call.argument<String>("serverUrl")
                    val token = call.argument<String>("token")
                    if (serverUrl == null || token == null) {
                        result.error("ARG", "serverUrl/token missing", null)
                    } else {
                        sendMessageToAll("/wger/auth", JSONObject(mapOf(
                            "serverUrl" to serverUrl,
                            "token" to token
                        )).toString().toByteArray())
                        result.success(null)
                    }
                }
                "sendLogout" -> {
                    sendMessageToAll("/wger/logout", ByteArray(0))
                    result.success(null)
                }
                "sendSessionChanged" -> {
                    sendMessageToAll("/wger/session_changed", ByteArray(0))
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onDestroy() {
        super.onDestroy()
        Wearable.getMessageClient(this).removeListener(this)
    }

    private fun sendMessageToAll(path: String, data: ByteArray) {
        Wearable.getNodeClient(this).connectedNodes
            .addOnSuccessListener { nodes ->
                for (node in nodes) {
                    Wearable.getMessageClient(this)
                        .sendMessage(node.id, path, data)
                        .addOnFailureListener { e -> Log.e("WearBridge", "sendMessage failed", e) }
                }
            }
            .addOnFailureListener { e -> Log.e("WearBridge", "connectedNodes failed", e) }
    }

    override fun onMessageReceived(event: MessageEvent) {
        when (event.path) {
            "/wger/auth_request" -> {
                val prefs: SharedPreferences = this.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
                val json = prefs.getString("flutter.userData", null)
                if (json != null) {
                    val obj = JSONObject(json)
                    val serverUrl = obj.optString("serverUrl", null)
                    val token = obj.optString("token", null)
                    if (serverUrl != null && token != null) {
                        sendMessageToAll("/wger/auth", JSONObject(mapOf(
                            "serverUrl" to serverUrl,
                            "token" to token
                        )).toString().toByteArray())
                    }
                }
            }
            "/wger/session_changed" -> {
                // Let Flutter refresh providers
                methodChannel.invokeMethod("onSessionChanged", null)
            }
        }
    }
}
