Return-Path: <stable+bounces-210006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25CD2E659
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 182453016BE4
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA551315D28;
	Fri, 16 Jan 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lmXCId86"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3E315D3F
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554024; cv=none; b=qpGCB1mboiSgOdwcm7yvIIQ+X5p0WxKeQPP2J5AOYO5zwFJrxIzV0eMXeANOLk58LpMdm+48rxYW4hj3TxTFTQ3NpSx3J/I7OVwpAZOVxqU/S0hNAzrH25DuMDJx2GOaurJRy+0fTuYZI9DTYhFBTLigqCA2dkQM3CME0zSsiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554024; c=relaxed/simple;
	bh=A+E5AWDmmOM4IRBV0FHjijfa+4SMFzrmm7kov35h9Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaPiIGSg5t0eF1CwgtZ+yjhPvuuP4TjA2Wu41YQ+LQjzaLpC/Aq9P57VWE1UQVW567Mtq12SXm1Q6y4Fxoj0pUZ+WwzJ1a6tyU5qxlXXCkNAg2XTXhitdKtN9EaKctc5rk2CM4bwX4FTkqw67bnFSW9RP/K+cSPSiIBiG5ciW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lmXCId86; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so15205325e9.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768554019; x=1769158819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUMUTMwiWEJ7+ksilVolcJXR96N0AiCWE01lI6b1ngI=;
        b=lmXCId86BrOF/G4SIJQArjjWkn02iOoD5dqID8iG2KJozKvZchqif9Jib6jP93PI9U
         HAzbxTAv6dxPYE5pnvLGhBUPmgea0VeKelKlN+LRaiBDpdXdIbq6ukPV4kRk9EDp2tXK
         kJJnlxGHfxqQ9xKFSU71UsN2TItq1oroHfi4f6u8Mj4tl4L3i0tYoaBD8bSPHKVWPXZy
         mVgVe+x55dIl0/Uko6xYsVielXEnvTSousDWFwMhFK6DpVboK08rGXcgawqTc/ePxiV1
         7UP26bqKP2oZdz7Q6kdmFOqBKy8aTSwm3Z+Q8YyAuOgfSaTNuwnjIEk6UaG26asHfN1F
         kARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554019; x=1769158819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUMUTMwiWEJ7+ksilVolcJXR96N0AiCWE01lI6b1ngI=;
        b=pDRgTf7x+1SdmtVlGjFexeIgYqoyCrYFXgPkOKiwxAzRL5H2zDk+n7eKde5bqAvt9/
         UmwHFSwbozsO86QwuiDgB0R5z19J1igMWijUnsTWdJj5/q7le7ycZsCfsZ9pob+7dQ2B
         o9qKmhDjrlM9SgdpZSwV3NJoDFOZl37WcVheVppcf1sXKSzTu+p/QHqSr0hWmQsPWgh0
         UOm7CkaZP4uU9hBddm4kGIg8teCOB+uuSCG6HOkGAml40Hhq7wS9nZB7q+JmhgiphDLd
         Gf7Ma7cfFwGHxHWIcZTjLnj7HB0X3ljbIViqPfJIpudw0rh8yvt4VY/miTkvZvIOIFE0
         RY5A==
X-Gm-Message-State: AOJu0YyuLqRUqKg7K1cds/Zr/1a5U1w17LhjRR5GHn9v4Rjq452lE+f4
	VWDnTTZUJseSI/rcFprRUNI8VzecqdmS/a93VOHFFsWl0sPFX9P4Rdmt1+/dNAVs9Js=
X-Gm-Gg: AY/fxX6B1HD/+YjrzVLZP/k2HKi9M6e41U+1VjUc9v1na18UhunshR+JolqsCURHFLK
	WGQxDiEFqX4wf8wXC6eXp/B+RP3Qs9xkPFw/QOqyfFwflZPA/vjmvWmL9MXWK07E7JEwxxERr4B
	OgQYN+TqxqA3vnAHSmyPXd9QOizk5edDF1e6MLOiEEADw1Vc+FOEqcKRlgtlt1FCBvuFQ+MHrbl
	/GxAx22XUsizbemy1DBMs+DHqYLoQRsEMw9iPdWAWOBDt84ciLX6MuUrDoFtNsW+5fNtWT3HuSC
	pn0tHQeGyb8rZtYQEayB4+saevCgXQn5tqKapGatonc9aiFq0pHOHPfqj0RG7X+Y71Tqq1ECaJ2
	9wuSb2p6XeCHis+rGq3yfmC6l7HskqXGTYC6Z/HIbChymA9lmdtiCQ+BWOctdru1cDnD+auNxp9
	9FbBbDFCwAVP+Cwp400nuhJ+iteY3gmrEuFuw7lnoXJroO4ICHnAI5Gi4lAYh3+FxPILBSS1Agz
	MY=
X-Received: by 2002:a05:600c:4e43:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4801e3342eemr27983545e9.19.1768554018135;
        Fri, 16 Jan 2026 01:00:18 -0800 (PST)
Received: from localhost (p200300f65f20eb04b8d7be8ab7c139c4.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:b8d7:be8a:b7c1:39c4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47f428ac749sm88493015e9.5.2026.01.16.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:00:17 -0800 (PST)
Date: Fri, 16 Jan 2026 10:00:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Takashi Iwai <tiwai@suse.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 477/554] ASoC: stm: stm32_sai_sub: Convert to
 platform remove callback returning void
Message-ID: <3tzxbwj2j7jph4virzzizrd66qikkjofz34koc5s5hmrynhaek@dyx2xciugqep>
References: <20260115164246.225995385@linuxfoundation.org>
 <20260115164303.569810160@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ki5nd46iygwjhyk6"
Content-Disposition: inline
In-Reply-To: <20260115164303.569810160@linuxfoundation.org>


--ki5nd46iygwjhyk6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5.15 477/554] ASoC: stm: stm32_sai_sub: Convert to
 platform remove callback returning void
MIME-Version: 1.0

Hello,

On Thu, Jan 15, 2026 at 05:49:03PM +0100, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit a3bd37e2e2bce4fb1757a940fa985d556662ba80 ]
>=20
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Link: https://lore.kernel.org/r/20230315150745.67084-139-u.kleine-koenig@=
pengutronix.de
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Stable-dep-of: 23261f0de094 ("ASoC: stm32: sai: fix OF node leak on probe=
")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

While this patch is trivial and there are many patches like that in both
mainline and already backported to stable without any known problems, it
is also not very hard to backport 23261f0de094 to 5.15.y without this
patch. The merge resolution relevant is just:

diff --cc sound/soc/stm/stm32_sai_sub.c
index 2a2fc2f0ebbd,c7930d8f9ded..000000000000
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@@ -1579,8 -1587,7 +1587,9 @@@ static int stm32_sai_sub_remove(struct=20
  	snd_dmaengine_pcm_unregister(&pdev->dev);
  	snd_soc_unregister_component(&pdev->dev);
  	pm_runtime_disable(&pdev->dev);
+ 	of_node_put(sai->np_sync_provider);
 +
 +	return 0;
  }
 =20
  #ifdef CONFIG_PM_SLEEP

I don't feel very strong here, but IMHO this is trivial enough to skip
backporting the conversion to .remove_new() and it would be the right
thing from a pedantic POV. OTOH I also don't want to reply to each such
backport, don't object getting patches into stable, don't know how
the stable maintainers feel here and don't want to impose additional
work on anyone if just picking up the conversion is considered ok and
easier with the established workflow.

Best regards
Uwe

--ki5nd46iygwjhyk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlp/h0ACgkQj4D7WH0S
/k4F4wf9HhPDgCWIxfWSQsW0GdhqOlgt54pNJ7KLakNiwJwc+GZ1t5/5j8hmU6QR
yevcgw+nEPswftHUM3Ev/MsP8Gk+AK1e4ry0bz9/x9E2OX1FqjeovJqJkTiVt4T3
oGzUUIYqWVCRPjs498k9Nwkxig026ds2qDbDpb0YUrmSc4wufkliICxG8lQaMWMj
xV4wwIrH5/POSvN2dIwB90CIbFWrfhJ9G3gJUhfz4eTzrXReB+Fe0hH57ngy7p/B
PNfIsPGF1Aynixe2fPSF3RX+oBBSq8WVB3XDxs68ij16m/vb1IZI1YHgZbddwAug
8GYhT5lXC5I6H5fNClfbyJ2tzfaQVw==
=Suk+
-----END PGP SIGNATURE-----

--ki5nd46iygwjhyk6--

