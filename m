Return-Path: <stable+bounces-166770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D4B1D6D4
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 13:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A8818C77D0
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF2278158;
	Thu,  7 Aug 2025 11:41:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from coelho.fi (coelho.fi [88.99.146.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0115A864
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.146.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566892; cv=none; b=S1LtFAnUzoFBq9f54QXFxDnI/19qb40XMqv+QYHLeJ0zB/C+SnOeVaFZ0j3DiI18pjhWyNyFSpCp5N9zMk8f0alOGOdR2CA4KaomSoMFUV0sHjZYVSI56s2/gHSavwApxoQGnSuus5PKt+w33Poi3V3i06GQ1tIibbT3CnoP5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566892; c=relaxed/simple;
	bh=hG/XOjPq3cMhujwC3uMjUb24yhw6tRrpoZEfzY5OOgk=;
	h=Message-ID:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Subject; b=OjS7kCegeayqECAOnDQsIbsuwp7oEEYbTKd0DGOZgE/TrKBj1V1+XpaHw4S4zxZyEAG4yFrqbBbjrRAC9KyxjkwnifQQI3khsnq4OSIlOfg+Rryo489zcQRgfMVIMP1B9VZQ2gwoLkml+Q4fqxVqQ8qjkvxcJPBTLjTgViGA9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi; spf=pass smtp.mailfrom=coelho.fi; arc=none smtp.client-ip=88.99.146.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelho.fi
Received: from 91-155-254-205.elisa-laajakaista.fi ([91.155.254.205] helo=[192.168.100.137])
	by coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <luca@coelho.fi>)
	id 1ujyLD-00000009Wpo-27Cb;
	Thu, 07 Aug 2025 13:59:28 +0300
Message-ID: <95999d2602067f556dc2e5739758deef7c462e17.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Charlton Lin <charlton.lin@intel.com>, Khaled
 Almahallawy <khaled.almahallawy@intel.com>
Date: Thu, 07 Aug 2025 13:59:21 +0300
In-Reply-To: <20250805073700.642107-2-imre.deak@intel.com>
References: <20250805073700.642107-1-imre.deak@intel.com>
	 <20250805073700.642107-2-imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
Subject: Re: [PATCH 01/19] drm/i915/lnl+/tc: Fix handling of an
 enabled/disconnected dp-alt sink

On Tue, 2025-08-05 at 10:36 +0300, Imre Deak wrote:
> The TypeC PHY HW readout during driver loading and system resume
> determines which TypeC mode the PHY is in (legacy/DP-alt/TBT-alt) and
> whether the PHY is connected, based on the PHY's Owned and Ready flags.
> For the PHY to be in DP-alt or legacy mode and for the PHY to be in the
> connected state in these modes, both the Owned (set by the BIOS/driver)
> and the Ready (set by the HW) flags should be set.
>=20
> On ICL-MTL the HW kept the PHY's Ready flag set after the driver
> connected the PHY by acquiring the PHY ownership (by setting the Owned
> flag), until the driver disconnected the PHY by releasing the PHY
> ownership (by clearing the Owned flag). On LNL+ this has changed, in
> that the HW clears the Ready flag as soon as the sink gets disconnected,
> even if the PHY ownership was acquired already and hence the PHY is
> being used by the display.
>=20
> When inheriting the HW state from BIOS for a PHY connected in DP-alt
> mode on which the sink got disconnected - i.e. in a case where the sink
> was connected while BIOS/GOP was running and so the sink got enabled
> connecting the PHY, but the user disconnected the sink by the time the
> driver loaded - the PHY Owned but not Ready state must be accounted for
> on LNL+ according to the above. Do that by assuming on LNL+ that the PHY
> is connected in DP-alt mode whenever the PHY Owned flag is set,
> regardless of the PHY Ready flag.
>=20
> This fixes a problem on LNL+, where the PHY TypeC mode / connected state
> was detected incorrectly for a DP-alt sink, which got connected and then
> disconnected by the user in the above way.
>=20
> Cc: stable@vger.kernel.org # v6.8+
> Reported-by: Charlton Lin <charlton.lin@intel.com>
> Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_tc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i9=
15/display/intel_tc.c
> index 3bc57579fe53e..73a08bd84a70a 100644
> --- a/drivers/gpu/drm/i915/display/intel_tc.c
> +++ b/drivers/gpu/drm/i915/display/intel_tc.c
> @@ -1226,14 +1226,18 @@ static void tc_phy_get_hw_state(struct intel_tc_p=
ort *tc)
>  	tc->phy_ops->get_hw_state(tc);
>  }
> =20
> -static bool tc_phy_is_ready_and_owned(struct intel_tc_port *tc,
> -				      bool phy_is_ready, bool phy_is_owned)
> +static bool tc_phy_in_legacy_or_dp_alt_mode(struct intel_tc_port *tc,
> +					    bool phy_is_ready, bool phy_is_owned)

Personally I don't like the "or" in the function name.  You're
returning a boolean which is true or false.  The return value is akin
to answering "Yes/No" to the question "Is it black or white".

This is a nitpick, obviously, so I'll leave it up to you.

Regardless:

Reviewed-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.

>  {
>  	struct intel_display *display =3D to_intel_display(tc->dig_port);
> =20
> -	drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
> +	if (DISPLAY_VER(display) < 20) {
> +		drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
> =20
> -	return phy_is_ready && phy_is_owned;
> +		return phy_is_ready && phy_is_owned;
> +	} else {
> +		return phy_is_owned;
> +	}
>  }
> =20
>  static bool tc_phy_is_connected(struct intel_tc_port *tc,
> @@ -1244,7 +1248,7 @@ static bool tc_phy_is_connected(struct intel_tc_por=
t *tc,
>  	bool phy_is_owned =3D tc_phy_is_owned(tc);
>  	bool is_connected;
> =20
> -	if (tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned))
> +	if (tc_phy_in_legacy_or_dp_alt_mode(tc, phy_is_ready, phy_is_owned))
>  		is_connected =3D port_pll_type =3D=3D ICL_PORT_DPLL_MG_PHY;
>  	else
>  		is_connected =3D port_pll_type =3D=3D ICL_PORT_DPLL_DEFAULT;
> @@ -1352,7 +1356,7 @@ tc_phy_get_current_mode(struct intel_tc_port *tc)
>  	phy_is_ready =3D tc_phy_is_ready(tc);
>  	phy_is_owned =3D tc_phy_is_owned(tc);
> =20
> -	if (!tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned)) {
> +	if (!tc_phy_in_legacy_or_dp_alt_mode(tc, phy_is_ready, phy_is_owned)) {
>  		mode =3D get_tc_mode_in_phy_not_owned_state(tc, live_mode);
>  	} else {
>  		drm_WARN_ON(display->drm, live_mode =3D=3D TC_PORT_TBT_ALT);

