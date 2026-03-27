Return-Path: <stable+bounces-230705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC2NFpzExmm8OQUAu9opvQ
	(envelope-from <stable+bounces-230705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:55:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC857348B4A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7312030094F8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212433FF8B4;
	Fri, 27 Mar 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3tPgWE7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793333F8B1
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634132; cv=none; b=AZWfxRQwS701MFKYsKquHOB13kQZdQaD3gPvc00fpXKp3xH45dp8+axvQGo2eVbFE9jlHu6Zy7H0JpS2RmEGHeUP9APpe15WyG4sr+4HkGdPu8gFEGXiimUi6P3gWx0nppGQyDZQKPbSLnH5b7WxGj3b/DGnKi148ES79LZOoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634132; c=relaxed/simple;
	bh=RxqP/2Sw2W3S88d3knlPy6cpLmT4A2PFcVJTSRZmGxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZEUwg7AwQiATRn9X5YxUoG4nnRWQL22EeJuSAnmNt7CTqtE9l/wRnDzsf+X8eNaXGSa/Y9RiuJCrmLZAx8DpE4FcXCJCyoCRy9eYJIqazWU+7fGs47FObezwBOjTITpuHqslt30m4NmZO/GUFDJ8WVbib2iJJ8eeSIXZNmcXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3tPgWE7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c1d101355so1074013a91.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774634130; x=1775238930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zIPX8F3kcVGBD0JRYtnSPpoKgqnjM+ygoy/TOvk8t4=;
        b=H3tPgWE7FnNmHdOoRq0Z1Gc+Q8WX8f6d9px+U3miY0iCKOoHX3KsanGWPZgEcVC1Ks
         vCJ6n2tVSJe6qkdg6L50jGF/xk/QZ2K2breSdsTI2Are6ZQ1FbxdiuuIgaTf2lSUuw8j
         3d94QSPxkqOY9Ta/Be4LcmbG6wmKTYzDgpHjaTwS3/QnFQcq8KG0O9Wif7XE9TqByH+1
         hccT5I7M1iyttwllaLvgif8/5ldtO3HvY1nzMjIxHgimGEMgALu717cRUke7D5G7MEir
         Lpu3U3NRtoFC34vhLsV9fcpFJ1jrqmcXmSKI5zq00YHo4zOBYWp95wpEagXewBWkr/Ih
         XG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634130; x=1775238930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zIPX8F3kcVGBD0JRYtnSPpoKgqnjM+ygoy/TOvk8t4=;
        b=oY4MI3HDpgkjbSNXvFa2RcmsGX6grVl/BSeiBIov7ip8nj/LIxyRj1x6iiDsigBGI4
         dcc4hEevCks9oVdQpZevWQKtw4Ztihgvr0/O5InUXc8ITUeaKMql68hQjAal+cpjOKCM
         M2UNDbFLuPrTF28RC/ZZesCWEDzpUPSjGP3WkKY11yXQ1DIs8iabtGQzUttx8cCDaqJl
         rU16GTXqlUcOpVJ2zD6qFrLq7W5Otn5a0KfHWYSxBzS4W2PHUaHNtm/+vrcSYnvI43pU
         kdy5hcJB5u8JWIBJDf1yTIPOtbbfhpNIWb/fw4ClSmzu4ZIpYDIUvANe3mKvVG9d1hp7
         HOIA==
X-Forwarded-Encrypted: i=1; AJvYcCWpFBh4iuoOcroGvtbi8S1eKPfsdWAFA4tUgQXMKsTh/dPFw2yMFPw36eeYy51ChlL0aYTztog=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBwVHF+vpSqoJ5MVz/OHDBvDXxPcAFPlZh437EVtSCDBE97tN
	7KGq7G0BWAoJikA++heOF/zTL5nQ8s3kIM9Ii1FEDAB/anLR/8A9HuctghyMCyUzbQt/0BpsQkY
	teNb+fA==
X-Gm-Gg: ATEYQzyZ/PSH7C+7tJxTfc/ZCDMwZH/x3s5qhxHG9ydin/ktQ/PvjyCEOEHzSwpd7f/
	6sByO0YWADyguwi0njaA/Uda9pJqzfnpZJwK+BWHC0D8WtV+bJO5uZCDj/NzYo8Knyq7lKGfex8
	6lNvPhCikfZMz0qcs2QmFagvbG/usJ7eTsfrbWpX1TkC5wgT2fkfpTZb4fNjZByXfAl4yKsZMMq
	56z+QRnWOy+4FRs4x9AoiJiBpEgFN8Qh71yEvyUSLM/VLPxYyYX1eKg9Vqd+wpT1RwKU0rzsqSu
	MKAgOdyruf17NVVpO1VME5sUEQ4qBxdPOUU+tLgR/KDS9BHC9YdSijhzha3x/R3hZ2iYt5nUYL9
	cM+LIjvXDjpeBW+sSboM1fX7KvXOxlWXfqAFrykY0zqlRMnYl3g+4jd8WEFRqOIvz7xKm/kk8vN
	wKMoZY42QfQCyA3oPRzRBiU0bS2DpNUZwh8OA1dP5ZQQrKDdiw66+jQXVo
X-Received: by 2002:a17:90b:3fcb:b0:359:f6f8:57b8 with SMTP id 98e67ed59e1d1-35c2ffafed9mr3574710a91.1.1774634128989;
        Fri, 27 Mar 2026 10:55:28 -0700 (PDT)
Received: from google.com (21.59.127.34.bc.googleusercontent.com. [34.127.59.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ce693csm5351844a91.14.2026.03.27.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:55:27 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:55:24 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Madhu M <madhu.m@intel.corp-partner.google.com>
Subject: Re: [PATCH v2] usb: typec: thunderbolt: Set enter_vdo during
 initialization
Message-ID: <acbEjA9TjKPslH21@google.com>
References: <20260324103012.1417616-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FSLY5P0qsLBDL9bD"
Content-Disposition: inline
In-Reply-To: <20260324103012.1417616-1-akuchynski@chromium.org>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230705-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bleung@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: CC857348B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--FSLY5P0qsLBDL9bD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:30:12AM +0000, Andrei Kuchynski wrote:
> In the current implementation, if a cable's alternate mode enter operation
> is not supported, the tbt->plug[TYPEC_PLUG_SOP_P] pointer is cleared by t=
he
> time tbt_enter_mode() is called. This prevents the driver from identifying
> the cable's VDO.
>=20
> As a result, the Thunderbolt connection falls back to the default
> TBT_CABLE_USB3_PASSIVE speed, even if the cable supports higher speeds.
> To ensure the correct VDO value is used during mode entry, calculate and
> store the enter_vdo earlier during the initialization phase in tbt_ready(=
).
>=20
> Cc: stable@vger.kernel.org
> Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate =
Mode")
> Tested-by: Madhu M <madhu.m@intel.corp-partner.google.com>
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> Changes in V2:
> - Marked as a Fix
>=20
>  drivers/usb/typec/altmodes/thunderbolt.c | 44 ++++++++++++------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec=
/altmodes/thunderbolt.c
> index c4c5da6154da9..32250b94262a9 100644
> --- a/drivers/usb/typec/altmodes/thunderbolt.c
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -39,28 +39,7 @@ static bool tbt_ready(struct typec_altmode *alt);
> =20
>  static int tbt_enter_mode(struct tbt_altmode *tbt)
>  {
> -	struct typec_altmode *plug =3D tbt->plug[TYPEC_PLUG_SOP_P];
> -	u32 vdo;
> -
> -	vdo =3D tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B=
1);
> -	vdo |=3D tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
> -	vdo |=3D TBT_MODE;
> -
> -	if (plug) {
> -		if (typec_cable_is_active(tbt->cable))
> -			vdo |=3D TBT_ENTER_MODE_ACTIVE_CABLE;
> -
> -		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
> -		vdo |=3D plug->vdo & TBT_CABLE_ROUNDED;
> -		vdo |=3D plug->vdo & TBT_CABLE_OPTICAL;
> -		vdo |=3D plug->vdo & TBT_CABLE_RETIMER;
> -		vdo |=3D plug->vdo & TBT_CABLE_LINK_TRAINING;
> -	} else {
> -		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
> -	}
> -
> -	tbt->enter_vdo =3D vdo;
> -	return typec_altmode_enter(tbt->alt, &vdo);
> +	return typec_altmode_enter(tbt->alt, &tbt->enter_vdo);
>  }
> =20
>  static void tbt_altmode_work(struct work_struct *work)
> @@ -337,6 +316,7 @@ static bool tbt_ready(struct typec_altmode *alt)
>  {
>  	struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
>  	struct typec_altmode *plug;
> +	u32 vdo;
> =20
>  	if (tbt->cable)
>  		return true;
> @@ -364,6 +344,26 @@ static bool tbt_ready(struct typec_altmode *alt)
>  		tbt->plug[i] =3D plug;
>  	}
> =20
> +	vdo =3D tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B=
1);
> +	vdo |=3D tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
> +	vdo |=3D TBT_MODE;
> +	plug =3D tbt->plug[TYPEC_PLUG_SOP_P];
> +
> +	if (plug) {
> +		if (typec_cable_is_active(tbt->cable))
> +			vdo |=3D TBT_ENTER_MODE_ACTIVE_CABLE;
> +
> +		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
> +		vdo |=3D plug->vdo & TBT_CABLE_ROUNDED;
> +		vdo |=3D plug->vdo & TBT_CABLE_OPTICAL;
> +		vdo |=3D plug->vdo & TBT_CABLE_RETIMER;
> +		vdo |=3D plug->vdo & TBT_CABLE_LINK_TRAINING;
> +	} else {
> +		vdo |=3D TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
> +	}
> +
> +	tbt->enter_vdo =3D vdo;
> +
>  	return true;
>  }
> =20
> --=20
> 2.53.0.983.g0bb29b3bc5-goog
>=20
>=20

--FSLY5P0qsLBDL9bD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCacbEjAAKCRBzbaomhzOw
wkP4AQCs3BUj8LPf43DlHV0Y3GhW984p96DY4xrbXph5LRlFEwD/dL8QTN0sU6Dj
jDHaSEQwM3YWjex7S8YWMa4DMKp1QgI=
=/xiF
-----END PGP SIGNATURE-----

--FSLY5P0qsLBDL9bD--

