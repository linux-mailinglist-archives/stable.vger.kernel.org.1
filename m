Return-Path: <stable+bounces-139098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E36AA436F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761EB16A6FC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA413FEE;
	Wed, 30 Apr 2025 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OoAyxH7/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9B40BF5
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745996079; cv=none; b=nXVdO4kKd0c95M5jQ+U4L8XEEwPbZRCIE6PJpDOIp+h0Obt04JRbMTVJtxEbXHnNjutfNX67oQ7ljpcty1w0UMiHkB/e40YXKhctGtsJeVc28WpRwW+BtBkE3tEWkhHE8X7/0jrZOMSO1tjqdz9F1yYNa4eX+jd8E2gMtcTVUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745996079; c=relaxed/simple;
	bh=bqp7jpwn3EqlQt7Hg5N9JaJDJWf+o57RoxeQ3hNESqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBpeUX7fk1V/Er7MxqqssrXG4vSPlDvPAhl38j1+jBO3BIqsy7LcyekB2RO0Br5mN61Hom+XJtANyoqykx1M7d5CwnZ+CPjX4NqhW6GtDG+WKK5VKRTggto+G3SC++id6FgnIcrUwfO27z1Lyso3VS5nwlV/KnOHN5aBA33uJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OoAyxH7/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso11014047a12.1
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745996075; x=1746600875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fE+2AKL9tQoV7VjNqMUMkalVxmAieNXXm1j2vCBLH8o=;
        b=OoAyxH7/DNQnjcVztA7Eb0RzqM7NPVS+66d/SSdn6Qfjju6P+rBH+/3nq+u3gbPt35
         ZMCXj21Rq0p7M528wDz6IcDxGTqoTfKGVCKIbJA2L+FD4zJKccL2MWSElphWAr0lE7XJ
         ZOyUEqcylFuu93bGbBw8WcRliwTwXcj+0p0qhc8rE1zpGfd7qHeqzTfNU0SlloPJVga8
         TKbN2y1gad4Ph+7Q+NuFsXlBxLPa/+FqgpauqYORDVvNLgr/ENzrkotz8yRo3rR3GKBP
         oQTweznsBHlE2glGz01nOP1NXKPsV6976XyXq9ehEyayqFfmkxr1l+Q4bjaqhzc71lEh
         Gr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745996075; x=1746600875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE+2AKL9tQoV7VjNqMUMkalVxmAieNXXm1j2vCBLH8o=;
        b=Ugs5AJJaOCxKFn8ZsknoXj4e/ol2f4cponi1wTINE4J7fJXxelW5IAgFOhZ6maZA0X
         z6tSAR7g9Xwt0cu59ZobI3ddV512CXQ6XzDYwR4ynNa5PHT6nPEiCy4f1nA54VZ/yPUT
         z2YKiY0qQ/1rTUE48o9tX/3u+DFzUFMhME27j3chmp8BbPOHBi3vJDbcAT5GR1KAuAHn
         Qz+1ySGca1ewL66TMR41q6a9AryOA/geLuWcIqjRBIDAQAjbucZNYAvI9sEZXOnpXFJj
         R3XgG38WzP7n5H1RFhYXU8U6rGBulj5lXyeR+bzBm1ltnSo2667OGnZP9ejsJVt1Ei36
         tYwg==
X-Gm-Message-State: AOJu0YzUfDcKYWb5aTIgHVmqxcdTBk5SYAGxNch2XIF7DfA5iUlisYbT
	XQAQ1FV5K8HDBTKEoeRLWzGf+FgQuYiocigq6E4VPme/rKpq8NfZAE7M4TR3Bf8=
X-Gm-Gg: ASbGnctU7GNrZJfsnKuqtBH9j2bRWMmhfn2oYIFwadNvYE43izXHW8CGn/k+gKRiSOh
	3im4jzDosvUVgS/WcE3PueMfItWhliglZ80HpyLqOi9f+nx3XfK7jJ2bWvUW1NLZrix3vZ+LSuk
	7onhbMdKQMe03+NrQQ2YKOXO+M9k2FhlEV9QgG1yxMsZE13jirTW3yQnTRqszyKsl0VYaomD5RL
	CUxMV1pDtn532Qcuhy8Jkh54bCVAGIImJkdUaTCCVNafb0efNzi5Ia1kin9mFjeB2GKUada87t5
	1hqFQkrIQsPPF1CP/EHjbVEJrw5diJJ8MkRA3gVkaGQBsw==
X-Google-Smtp-Source: AGHT+IFuATXiv271EdWmYw3hf0HHyn6r6/sAcb9NULJjNpiWFngbtTkbATJSDqdNp41ZVNC+ryt9yg==
X-Received: by 2002:a17:906:a403:b0:ace:dd20:2c25 with SMTP id a640c23a62f3a-acedd202dc4mr144344866b.51.1745996074539;
        Tue, 29 Apr 2025 23:54:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acec57bece2sm245833666b.10.2025.04.29.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:54:33 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:54:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 020/204] ASoC: qcom: lpass: Make
 asoc_qcom_lpass_cpu_platform_remove() return void
Message-ID: <npexot3y75j2lyvv2w33k6clvla24hpxls32giyyzh7swoyngs@p2qwspziwcwt>
References: <20250429161059.396852607@linuxfoundation.org>
 <20250429161100.253501778@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kw7fdhv2zjl6wosn"
Content-Disposition: inline
In-Reply-To: <20250429161100.253501778@linuxfoundation.org>


--kw7fdhv2zjl6wosn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.6 020/204] ASoC: qcom: lpass: Make
 asoc_qcom_lpass_cpu_platform_remove() return void
MIME-Version: 1.0

Hello,

On Tue, Apr 29, 2025 at 06:41:48PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit d0cc676c426d1958989fac2a0d45179fb9992f0a ]
>=20
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> asoc_qcom_lpass_cpu_platform_remove() returned zero unconditionally.
> Make it return void instead and convert all users to struct
> platform_device::remove_new().
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Link: https://lore.kernel.org/r/20231013221945.1489203-15-u.kleine-koenig=
@pengutronix.de
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Stable-dep-of: a93dad6f4e6a ("ASoC: q6apm-dai: make use of q6apm_get_hw_p=
ointer")

I didn't try to actually apply the patches without this, but I guess the
upside of this commit is only to prevent a trivial merge conflict in
sound/soc/qcom/lpass.h.

Not sure this is justification enough to backport this patch to stable.
(Totally fine if you think it is, just sharing my thoughts.)

Best regards
Uwe

--kw7fdhv2zjl6wosn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgRySQACgkQj4D7WH0S
/k7LGwf6A317hago4KeiT0nTg4vmoKu5jfSr5YRv4TjS+bG+krudBhh8wGc0Bu4s
u4iDONTH1whtlN+Cl1+2YED8g69DdO0Yg04WwPJ+ArhYm9qKKAqKaOhyQDYGlZNH
BueuC1oxVgkLsDKzaD+L7nr7ERrxkkwz9AO1rRBwRnZlSgPq0GO/39LIvnnA7kK+
Y+tagJJMFJEGRhx99ehH6YDxJJBnDVIZO2ZezCX3vnoI5d4Fxd/L5WRIJUeJHtgN
XBZ4fccuEJFJR9S4UKUdMgp524bTno697UO9d9KEVOyn0380/tgUsZtWx2ZnYSlY
GMsWRVavBVeVBzp2i8xDAg0HrcU2PA==
=hS1B
-----END PGP SIGNATURE-----

--kw7fdhv2zjl6wosn--

