import React from 'react';
import ogfzaLogo from '@/src/img/OGFZAlogo.png';

type OgfzaLogoProps = {
    className?: string;
    variant?: 'full' | 'mark';
};

export function OgfzaLogo({ className, variant = 'full' }: OgfzaLogoProps) {
    if (variant === 'mark') {
        return (
            <div aria-label="Oil and Gas Free Zones Authority Nigeria" className={className} role="img">
                <img
                    alt="Oil and Gas Free Zones Authority Nigeria"
                    className="h-full w-full object-contain"
                    src={ogfzaLogo}
                />
            </div>
        );
    }

    return (
        <img
            alt="Oil and Gas Free Zones Authority Nigeria"
            className={className}
            src={ogfzaLogo}
        />
    );
}

export default OgfzaLogo;
