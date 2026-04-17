Return-Path: <stable+bounces-238491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LrDAwA34mm13QAAu9opvQ
	(envelope-from <stable+bounces-238491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02941BB53
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BE83016269
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3D359A75;
	Fri, 17 Apr 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="eilDONDE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECA1CEAC2
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432850; cv=none; b=h4OHqNJNhS6WuPa0CESH2gHQNp+xNDfaaLmwkJSLgbGNmLVVY1VpvGUBiH/r2oHLvvQW9X8RgyZU8+k73VM9M2aN4loHIcD9OV8tk6yyO/q3i9HizBhAVoJt/Cov5SP/BearHz8ntEGnwzViTuOVa7/dp2XJ5iOjw4XymsZKHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432850; c=relaxed/simple;
	bh=JdRFtBf1aF4v4sSkchCdQI8qVbld3bKQGj6ayOgyt3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZyiZdKVKpu4qHhZo2doOSNiuEXE3hz2PXgRhZweTOrddoTFi2e/XUsoQ9LMOC0JcdydMeEK3WoZdI8ZCyYMdSARvYXHTgy/1dlUtdblGnGniIDdZnKZXFI5fLPajG1EQsflDieNgejdW6EbqCLv58r3o19Jhm0/Qu1OcYKTZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=eilDONDE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so4966995e9.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776432847; x=1777037647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdRFtBf1aF4v4sSkchCdQI8qVbld3bKQGj6ayOgyt3A=;
        b=eilDONDE44tAJT4CFr8gyxv7UbyNE0Cs4WAHughxcBKkohsoUds0Ry5GtIQjb2ErRy
         O/m55qysG8YcSVHaL14Fkkq5irDNMdvZvEdIk3mDmBqGe3v2/2+HIIi9Iq4nAU0EYclu
         J8VW2FBgMNm/NnPzfxNZM8IXAsXfMA4PHhjj4JgSoFPu8/fmDXJH9zWH55m7XOXk8o9A
         zRJkC3xxojDXVNAzGJzBdQBIdnWZV5tSJ4LBF2kYGdCXDMk/tOJxdDQ4HiievKWS43gl
         upstP+w0uvKFJXrwIWXP5o3KHIwaX3M4DCT/QUZ3CZGtbLHrs7LhC95NwT7ruGDWjV5M
         t2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432847; x=1777037647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdRFtBf1aF4v4sSkchCdQI8qVbld3bKQGj6ayOgyt3A=;
        b=rEfsU19K9uxNckCdmJUuABBT/0slRwCfBoTUDQlAycFHHTDbXbJrtFH+IUaM33+Dzx
         Nz9jyOrSbYCHtGywJFvH+CMBbAhl3CvtLj1ydS3RPdLPV/BoWSk41AEPLFepVMzBi0rh
         skxr0TR6yEivTNbkDghbTR5isr1EPItVgobRQcB/rIPV08/5fNcwFqiAj5gcLUy1fldv
         H2EgqyvYBBUaQQGnC89J+rXPmNl0RbjTUuBmrAnC9qKE06tAg5pGhJPsu7sRC1wwSKVD
         vomdWbxrPiD/KqUazW3phRSuKHaDa0l0Gp61VhNaA2eRVUCP6WvgmNBUqhjlWtP33iRi
         l+Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/gXikjMExQ1sqPRkPmYPXHHB2QEmMo+S6RG3NDlGuSRQQeAbO/mueRok1eIOV5IkCosD0D2ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsuTBiljRKxf74KgTT6QEw5F4tiEZfoY7ChD6/lfNq/+gu3Kk
	0N9rLMrxl8kQ/j70rgn8uMOpCws+HwT8n4ivjlXcVph6AtjcpCH3w5ivEocvgJGegNo=
X-Gm-Gg: AeBDievemVKGlVRy+xIoUAp87Y4tBRk75A1dkCKkXEyI6/EVHF8r7I+AMiGwKw44X9d
	VqZSIlxHsSRX2ZCtox3vBOSdvzKa51wYDXN5s1lW0dJhAU8gFUs3UDeOmppADB08mjLUeQO53gf
	zYHPKKHGniT9cZG6mWlC4jEwpYrgz8JTlHxjQYF6yoMYzC5NHdyVhYdN1tkPJm9beEzRIyL07DM
	DdsaBJfPXaanCH8GO/KpoJ7ogaQRpQoqEcNND2zdCPrD4Ig2xRZzRgyKe9GcOULbc8Aunr6fLE5
	2byiJcUxaqEDRMlXtgfOyfvDraisLwZld0YLMtye4WyNbeHdA6Fo2ca5kE+AFcneOYI1e+37Hki
	O1XrhXC8HGAonD9YgpbyWticll/rRXtALYPhvP8Mi3cRu9Hbo7I2mgAI897pUnoO0sLt+AJG99t
	5JeFvVZButW4wqiPI+VhkC+Kspu36EAi0dvnDT4WvHanPkXDmOXR0+85FuUuBIb/z0QaMnO5dil
	Ks6hpzcPzaDreIOVwQTDpM7
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr32626255e9.2.1776432847288;
        Fri, 17 Apr 2026 06:34:07 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc1001bdsm75797715e9.6.2026.04.17.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:34:06 -0700 (PDT)
Date: Fri, 17 Apr 2026 15:34:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Li Jian <lazycat-xiao@foxmail.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
	loongarch@vger.kernel.org, chenhuacai@loongson.cn, zhoubinbin@loongson.cn, jeffbai@aosc.io, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Zhang Yi <zhangyi@everest-semi.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Alexandru Ardelean <aardelean@deviqon.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
Message-ID: <aeI1_C5WGY5SzzcD@monoceros>
References: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rel25duqhphg3sr5"
Content-Disposition: inline
In-Reply-To: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[foxmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238491-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,loongson.cn,aosc.io,kernel.org,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com,deviqon.com,huawei.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A02941BB53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rel25duqhphg3sr5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
MIME-Version: 1.0

Hello,

On Fri, Apr 17, 2026 at 06:53:14PM +0800, Li Jian wrote:
> When enabling ES8390 via ACPI description, es8389 would fail to
> obtain a clock source, causing the driver to fail to initialize.
> This was not an issue with older kernels, but since commit
> abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
> devm_clk_get() would return an error pointer when a clock source
> was not detected (instead of falling back to a static clock),
> causing the driver to fail early.
>=20
> Use devm_clk_get_optional() instead to return to the previous
> behaviour, allowing the use of a static clock source.
>=20
> Cc: stable@vger.kernel.org
> Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")

Are you sure you identified the breaking commit correctly? I intended
the patch not to introduce any semantic change, and even with your claim
I don't spot the issue in abae8e57e49a.

Best regards
Uwe

--rel25duqhphg3sr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmniNsoACgkQj4D7WH0S
/k7OLwgAla3lc6UEHKZ8FPKaBwDVX2b3xJqRfuPoZ1dDnhKkWZVmCIKx4ElIYb6B
kFUtzSnUdO8JkeM7hAXAOXICBTWuI4KS3yqXUCh9zIY1ZVUfWsA0zytSpqC6x0MN
4jQFKKXFv2zgtP0CKbYOGIkeYGnqmQCA+WtzbJTRX+Psnjcf1GP1U2bOfqFbyYSV
U0lwQNh43b6guht4Afy8bOtdAwXQjFTcZ2zxkvFukkClo05/oHJwj+rLaEEwXAHT
xz7l+6jVjoOZsmTPcpZfmj5KxQ4svXht7CHzM92HZ2ScAV/oJ+oJHy/TZIdVKe/m
dTynrK4A/qe0QJMt7tXSjm/kqmmcUw==
=cuEg
-----END PGP SIGNATURE-----

--rel25duqhphg3sr5--

