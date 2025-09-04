import { createTheme } from '@mui/material/styles';
import { ThemeOptions } from '@mui/material/styles/createTheme';

const fontFamilyBold = [
    '"Open Sans Bold"',
    'sans-serif'
].join(',');

const fontFamilyLight = [
    '"Open Sans Light"',
    'sans-serif'
].join(',');

const themeOptions: ThemeOptions = {

    spacing: 8,
    typography: {
        h3: {
            fontFamily: fontFamilyBold,
        },
        h4: {
            fontFamily: fontFamilyBold,
        },
        h5: {
            fontFamily: fontFamilyBold,
        },
        h6: {
            fontFamily: fontFamilyBold,
        },
        fontFamily: fontFamilyLight,
    },
    palette: {
        // Harmonized with Flutter emerald/lime/teal palette
        primary: {
            main: '#16A34A', // emerald 600
        },
        secondary: {
            main: '#84CC16', // lime 500
        },
        warning: {
            main: '#EAB308', // amber 500
        },
        info: {
            main: '#14B8A6', // teal 500
        },
        success: {
            main: '#10B981', // emerald 500
        },
    }
};

export const theme = createTheme(themeOptions);
export const makeTheme = (element: HTMLDivElement) => createTheme(
    {
        ...themeOptions,
        components: {
            MuiPopover: {
                defaultProps: {
                    container: element,
                },
            },
            MuiPopper: {
                defaultProps: {
                    container: element,
                },
            },
            MuiModal: {
                defaultProps: {
                    container: element,
                },
            },
        },
    }
);
