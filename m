Return-Path: <stable+bounces-244309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CbHMG65+mnASAMAu9opvQ
	(envelope-from <stable+bounces-244309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD844D5FAA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C273042C4F
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 03:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8722E762C;
	Wed,  6 May 2026 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujHElCtQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8392D837C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039145; cv=none; b=FZZ5rF3/4TA6l/ueMUCaJ2MBGweSUQITulBX31lzu/lV0Z1CYr8HpAiVRRYV7XksfFW27I/tfY1WL/o5HQ9rOx3HX3JNL/ziQVjrjG3v2PCAqNMZ7riBSbcuatHJmfgtu0gqW/s4gjLY/535WcoDzy2mJqvjvGKRmrmaq+hCUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039145; c=relaxed/simple;
	bh=e7MFWAvOrD6x55/XFyvjUmf1OBviZSxCrWEKFtCHq+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw4xc4s4D7BFnjed9nQRq1x4jC1hYyvRZ5YxaVtJ+jGSc+XWK6K6GyoOVtRwtPiB6GenGawkoZKEQJ2jerH9u6kpRrTTACb5Ns3xCKDQC4CSiFjuIhLKAOXZbb2CzuupPs3bwdp2luLRl50aM7DWHAcILBPoIsaRA1A9Y85sQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujHElCtQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8383fb7143aso1313204b3a.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778039144; x=1778643944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjHOkaHu+NkO38S6EeZoMhD2GWUGazZfx6GKOrIeYZk=;
        b=ujHElCtQJT5QdGK/ui7UeLD/qSb6rDe0RTakGlx/BCkC1FTR/XCGjT8pR1jw4w7oUR
         f9FN0gEkzyHP4CKZVHi/sAAo1h/ZZ1ppsGQIWUQo5K6qAJAVGax5Wx5dhP+kFfx66w2s
         whr2UH2Q2EIbQ9+AOs2TBHv7g1edMsIBpJM3Q4+DMVi3qVnISsJJKNpVr//97oiMG1bB
         z8/F43m3fzALDERvh4SU1Xz+orIo9Aj+nA2mm1MPsLtwUzna967g+vU4kOrdLpinhR5l
         qEZjPIx8A2JcIzfFvaB6RUMUI+4S38S6QtsycQdUu8yyYN9xa2mpbaq7Ccgw6nqizazR
         St7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778039144; x=1778643944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjHOkaHu+NkO38S6EeZoMhD2GWUGazZfx6GKOrIeYZk=;
        b=iRzxUN3jkneVZ2oNOo+bZgRUFq50oh3jNOGGGIyW8CQuJV4Ndw3BG0uC1JOvX7i06V
         SQ13C5lhHPdEgKwGYmEDl575f2XawtmEiUYvnfbhGTk0oJxXr98NWgvprvRJPynqGoch
         TPAfDQP0/WZdcxauU5e8Gfo15q8da6Xemn6n7CL60Wsn7dd/87Awklrx8ecl9AfXoPUx
         JL2ZQ9AI1zLF627ZoG/pW4G3dmE6H3oTISYWyW57RErVpSfTUJAp/lkjEVgj6R3PWfNk
         ppVTBHBXV7e9kCvNQOWRxCkrqBmcNw5kl5tOOQM4rxHCvWxqSUFvsRTCkipi4AyOBHnT
         6SUw==
X-Forwarded-Encrypted: i=1; AFNElJ9KRVFTxAzPcURvhiZGKLuAuuS5mTyfeYgYP0eMQMMcoLEQFCsU5XYJghnOzxUV+pI+yzkHMSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTs54+mEPa+0RapV+xJD4Ym/8QrOgoWI6pE1sz/Dy8xESDVdis
	ArHttjwFKGmdewW0Wwt6b2YMCQJaIetX6d3KcwIOzUV7muf2T+/pqGCoZnBGUmHy1w==
X-Gm-Gg: AeBDievD0YVfv28y1xopKWlUklcE78U586TBxX7IxYnw2SwN2zjXSNJv6zgY2gqCv4g
	/TQD4FUv2RcRB5cSdKMMLXgMD6ZHu7CPraokbrAM4ShwUo2bS2+DtB4yUCmDaxsCTrlPCzc+ITF
	3B5u4dczK1TNUYwMac6z+TeKt8pyUfJpmFICRgbrZ4jOOVsjjhAweTejEp1K6D2PyG7KoZ9/n0X
	q1q60PyIC4M090xjMD1cC83GGkNgwNoS8ayOgk3y4WRlLFgprQvhUGE5zWJsfBTEi4oFy0d/iAZ
	z4eroHf+50Ga0c2enpEfpvJse63g65EUHE7AvQuAqClwQBlj1+usY7YtQdak85AsKLwx3ZQsxxs
	6Y3tfXdX2MzYmJxRO8xnTGcbAHxAWpV1+hyvB7xwIUv/9uDEiySjj/lxxPm8gjUuYmU01w33u96
	6uPUr/nRGAlI+1rB55EIp7V6jPzOa4kKQ46UuWbL4KgUuF13lTvRzyUVDRmdaqAYovKpxukyMy3
	e6e8w==
X-Received: by 2002:a05:6a20:6a09:b0:398:d82c:ae6 with SMTP id adf61e73a8af0-3aa5a936bc4mr1494087637.31.1778039143093;
        Tue, 05 May 2026 20:45:43 -0700 (PDT)
Received: from google.com (51.86.127.34.bc.googleusercontent.com. [34.127.86.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242ba1bacsm607897a12.23.2026.05.05.20.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:45:41 -0700 (PDT)
Date: Wed, 6 May 2026 03:45:36 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec: Delay dev_set_drvdata() until probe success
Message-ID: <afq5YKI6epFptp_g@google.com>
References: <20260427131721.1165078-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i1JlCb1XYyQceS4y"
Content-Disposition: inline
In-Reply-To: <20260427131721.1165078-1-akuchynski@chromium.org>
X-Rspamd-Queue-Id: 2CD844D5FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244309-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--i1JlCb1XYyQceS4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Apr 27, 2026 at 01:17:21PM +0000, Andrei Kuchynski wrote:
> If ec_device_probe() fails, cros_ec_class_release releases memory for the
> cros_ec_dev structure. However, because the drvdata was already set,
> sub-drivers like cros_ec_typec can still retrieve the stale pointer via t=
he
> platform device. This leads to a use-after-free when cros_ec_typec attemp=
ts
> to access &typec->ec->ec->dev on a device that has already been released.
> Move dev_set_drvdata() to ensure that the pointer is only made available
> once all initialization steps have succeeded.
>=20
>  sysfs: cannot create duplicate filename '/class/chromeos/cros_ec'
>  Call trace:
>   sysfs_do_create_link_sd+0x94/0xdc
>   sysfs_create_link+0x30/0x44
>   device_add_class_symlinks+0x90/0x13c
>   device_add+0xf0/0x50c
>   ec_device_probe+0x150/0x4f0
>   platform_probe+0xa0/0xe0
>  ...
>  BUG: KASAN: invalid-access in __memcpy+0x44/0x230
>  Write at addr f5ffff809e2d33ac by task kworker/u32:5/125
>  Pointer tag: [f5], memory tag: [fe]
>  Tainted : [W]=3DWARN, [O]=3DOOT_MODULE
>  Hardware name: Google Navi unprovisioned 0x7FFFFFFF/sku0 board/sku3
>  Workqueue: events_unbound deferred_probe_work_func
>  Call trace:
>   __memcpy+0x44/0x230
>   cros_ec_check_features+0x60/0xcc [cros_ec_proto]
>   cros_typec_probe+0xe8/0x6e0 [cros_ec_typec]
>   platform_probe+0xa0/0xe0
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1c1d152cc5ac ("platform/chrome: cros_ec_dev - utilize new cdev_dev=
ice_add helper function")
> Co-developed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/mfd/cros_ec_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 39430dd44e30c..56fb7cceafc6c 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -195,7 +195,6 @@ static int ec_device_probe(struct platform_device *pd=
ev)
>  	if (!ec)
>  		return retval;
> =20
> -	dev_set_drvdata(dev, ec);
>  	ec->ec_dev =3D dev_get_drvdata(dev->parent);
>  	ec->dev =3D dev;
>  	ec->cmd_offset =3D ec_platform->cmd_offset;
> @@ -237,6 +236,8 @@ static int ec_device_probe(struct platform_device *pd=
ev)
>  	if (retval)
>  		goto failed;
> =20
> +	dev_set_drvdata(dev, ec);
> +
>  	/* check whether this EC is a sensor hub. */
>  	if (cros_ec_get_sensor_count(ec) > 0) {
>  		retval =3D mfd_add_hotplug_devices(ec->dev,
> --=20
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
>=20

--i1JlCb1XYyQceS4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCafq5YAAKCRBzbaomhzOw
ws9gAP4o/Y97BIaEjbh6PIhp9H7uWtUiizV3OOo5ubeMh3h+UAEArrSpYxJLsUf7
ascjppNyslvTH/yfwtUT/0Tw00Qe1AI=
=+yyJ
-----END PGP SIGNATURE-----

--i1JlCb1XYyQceS4y--

