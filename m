Return-Path: <stable+bounces-230231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCNdL3T6wmlXngQAu9opvQ
	(envelope-from <stable+bounces-230231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:56:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF331C955
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB4FB304656C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62635A38C;
	Tue, 24 Mar 2026 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWWCXBP9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64F34C989
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385773; cv=none; b=rYsjwFMr2lrlsY0qTS2vpPozJ/ePMlAg2wGdAEpdwhcH1ApEbkNla1v/bXLQA9mvZyavpKICnKVP7rNTJDaK4QI19/Ww5I2ktlGUQS//HzsJE5ND//vOeXC1HFchzgwlTM0edbvoGftSwyIgCRUFL/fGzZEd5bYwbOg4V5XjJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385773; c=relaxed/simple;
	bh=hdjKvfBWWeq0uSDptTLstowPlforQbXn8RIryJ7jeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td8Oouccy/KLRi9vnfzi6+jo6Bqny5VNBfL/dzm+e+vk+sdfoCE5IYynVrCpjw4OlrQPyUr7ZKdXnXoZcFomGRTUDV8Q+nLB0QLMqxbj9pibOB0GLPWsAOvDsa8jnC1C02XW2Td5yXx8xzlq1souWCEgwLfrc/1APY3w71oI7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWWCXBP9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b98def50bso4122206a91.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774385771; x=1774990571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FscbW10Q3KKVYse0rj9RSiZh6xJn2dHId/vIM0ejStE=;
        b=MWWCXBP9njA4Ih7o9qnRzL7XJopLZlXYq1CyMEmVuOTrjreDf4Gqu06s59wvYCkcXy
         /GgZNf2rItiY9MvErZYrMb0TeKwFEb5TfAxXoCnrE7T9uVM/VEGEXPEJNF51TopvNsQz
         oOgG6xEaKHJQnYbqKofi+I9jqM16oFjw65rhi/goso19Agntu5Ofy5H3eSkW7uLIS/L+
         j76wlBmYiRC0z7oMaiV0wZsHuJPr6vH0WXGDFICNNqASbaDIkX03fsHZP/HsNgL8kHrL
         gb24mZ2r1CzG8JqylzmDdtcF5q8rC8ZjgpdAzWTheR9d7y0hQ8zvPBPlXXZyNHPpzj8V
         VSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385771; x=1774990571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FscbW10Q3KKVYse0rj9RSiZh6xJn2dHId/vIM0ejStE=;
        b=LsCVju/ZZ4RlwYus9Gmsw7+DVNyg16Wb5PCBBo8k+YK6uKSe8Sm8W/Z6J49MJbz0CN
         jArgVXwFkbfpRYt2a8nevu4XS9SuVFJhxcCKvnUoqJhAXq69v7QsfObpQTBMGFtFa0EI
         sz88W9OpzrcFdyR9znuEUa2H6Ecu1/WqRzlWwcbLZSo/5l5Xa6xZGSipO+eT5NmUtm8l
         scVUm1t/4gsisFjCMWBSTAHqhbXhvXE32kwzMefQSsqVCnKXY3446YH1qAgdNTE6Nm3m
         fcEQ+L24RvhO39ax0E68jdwccDEfPCUbS3xSAZecntS1BB0tmsr0hemUH6VvCMO8+Wbv
         9/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWkg3y6d31lQgrSfDNkD7X2MBEaEpekM9VftiQ3KIC2Yoco0FNBCJbAtjcD4FsIogOtoNPnHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFN++5E0/2LVCWjkriQqmmlIk/p3H5s5zrQhPhAt0J35JEsBG3
	REt+DG/VXREeQMMojcE4C1zDfmfX3KQGJccQ+TPSy+L1ix1zyLYvGmJbcl1+Q446SA==
X-Gm-Gg: ATEYQzweUkzcMx/LtFC6E827UJ2NPBemr1AuDDaIG0KygI7tbH/hnsT+3y2CQZ2EtIg
	gTJGitb1Dri1SsZaFpr2IDNK+fK5UfwXj5zR5D0Ke3W0lTSvixFWjiEHs3mnOcSrXFe10Cbi5oq
	kYypWfa28/klL+KEm2OnC0qBKzKBwE8/hRaOQIKw2Z4tqGb9+iy87R8BC3301yyVmwdVzSJXd4z
	kNh53UB8Gjlemo+0L0777LzA2WOPyfpHDWztusSZpfr0z+s5aaYXYluNzjq/r3tAW/fpXFP0MQv
	uN4EZeajAs6zTdcrGsaz8NZvwiM2cRwUkLFx2QErj1PUmNjxSGoZeuPHBHz6iIUkZaQQ2ibJYhW
	2mRkdTqqohLnU+Mx5GH3/svbthIrXpAtfy1gHuQVNYNGh502RcHabYubchQnOPkU4iL9ZxJWGb7
	SsPFNteSp1I9n/bHzOQ8RVq9Sh5fzQ2NtdMMkbHU3H+SCwyZhynd5ev70O
X-Received: by 2002:a17:90b:2f0d:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35c0dd95872mr717194a91.23.1774385770651;
        Tue, 24 Mar 2026 13:56:10 -0700 (PDT)
Received: from google.com (21.59.127.34.bc.googleusercontent.com. [34.127.59.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0312ee89sm4218287a91.1.2026.03.24.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:56:08 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:56:04 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Madhu M <madhu.m@intel.corp-partner.google.com>
Subject: Re: [PATCH v2] usb: typec: Remove alt->adev.dev.class assignment
Message-ID: <acL6ZNa6ErLHqmwt@google.com>
References: <20260324102903.1416210-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mq7wClqCT9VK9him"
Content-Disposition: inline
In-Reply-To: <20260324102903.1416210-1-akuchynski@chromium.org>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-230231-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bleung@google.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6BFF331C955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Mq7wClqCT9VK9him
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:29:03AM +0000, Andrei Kuchynski wrote:
> The typec plug alternate mode is already registered as part of the bus.
> When both class and bus are set for a device, device_add() attempts to
> create the "subsystem" symlink in the device's sysfs directory twice, once
> for the bus and once for the class.
> This results in a duplicate filename error during registration,
> causing the alternate mode registration to fail with warnings:
>=20
> cannot create duplicate filename '/devices/pci0000:00/0000:00:1f.0/
>   PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto/cros_ec_ucsi.3.auto/typec/
>   port1/port1-cable/port1-plug0/port1-plug0.0/subsystem'
> typec port0-plug0: failed to register alternate mode (-17)
> cros_ec_ucsi.3.auto: failed to registers svid 0x8087 mode 1
>=20
> Cc: stable@vger.kernel.org
> Fixes: 67ab45426215 ("usb: typec: Set the bus also for the port and plug =
altmodes")
> Tested-by: Madhu M <madhu.m@intel.corp-partner.google.com>
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> Changes in V2:
> - Marked as a Fix
>=20
>  drivers/usb/typec/class.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 8314309094719..0977581ad1b6e 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -686,10 +686,6 @@ typec_register_altmode(struct device *parent,
> =20
>  	alt->adev.dev.bus =3D &typec_bus;
> =20
> -	/* Plug alt modes need a class to generate udev events. */
> -	if (is_typec_plug(parent))
> -		alt->adev.dev.class =3D &typec_class;
> -
>  	ret =3D device_register(&alt->adev.dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register alternate mode (%d)\n",
> --=20
> 2.53.0.983.g0bb29b3bc5-goog
>=20
>=20

--Mq7wClqCT9VK9him
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCacL6ZAAKCRBzbaomhzOw
wq2sAQCUZJhrv7AaalP85KIJJboMt7KzueWrl87wl1CfC8SCUwD/QYg8KuDsEZC0
WC3rvxaQqHZeB3xJMTS+O65CYaCUzQU=
=TV8y
-----END PGP SIGNATURE-----

--Mq7wClqCT9VK9him--

