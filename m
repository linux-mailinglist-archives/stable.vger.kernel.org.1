Return-Path: <stable+bounces-151469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C42ACE5D7
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 22:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73327173872
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF4202961;
	Wed,  4 Jun 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fMc01F25"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BD1D7E54
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749069799; cv=none; b=hb7ZeuKzmHfB5hkAfhDBI4wG28AT7JTIwFlP1rEKAesgESKFr5sipL8ropX2qiT1UbENlJD1rf0pFSu1/t6PBUM68fPjwXLyLoTgygRVzXSoD/2+ydcNq6+SgiXGzAKpcVrifC5MOC3J2z11xGGEMVmIWhZAnDV8ruEkVm0kFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749069799; c=relaxed/simple;
	bh=5WPb+lWA8clJGxbCsXGFShGWo8nOHVCL1pkAlgZhQsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sl4fhmhxP3ht0Gy/PKVQDRK7OGgRkdd5mcTOgIIMYi2R1BwgcSV/sb73L9lYHQuWn/lDk47rmlPH3iZo8NLx+R2vj5udPwLuF8YLgclkOGjQ2aX2WUhqgZqkhbbs6Tgp0nTKKICf21n1Yp6ASj66DUTfyduHG9yNJQz8OD3kFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fMc01F25; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so333875a12.2
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749069794; x=1749674594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kKRVoqiT4EzLmAvw3c+r2/DBP5Y3NNX9QqIrEZPJ4M=;
        b=fMc01F25leMzFFdCvZ9yMGLFsg+DniT0o0ulj8vIspaZF0LVqHUWVoKP6yOoWdO4BU
         0e/mXoAWTttHTq4b4+i502RdsEkd5phdgyUOXHTyXVnDgnFgSSwejKm8mhqDLzdV61/L
         M8R+g2cjB6Fr3Ddd1mmCRlQA9LrpPp9nrivVEbLOEEKnZmBNmR84El0ZAH0ncdIhK9fq
         23/99OH6VWx1aXNu6DYEaLPNjzMp7aI+T/8dI4KLEj9Lx/fp8sTkrr0ujaLfQSPXo/CS
         V6HpWnRn5kN85wnH7bRxin0WSYoaDhcla0Dnlf/GiWWPrTczMLBgicWaiFjeIbGHij7s
         4lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749069794; x=1749674594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kKRVoqiT4EzLmAvw3c+r2/DBP5Y3NNX9QqIrEZPJ4M=;
        b=lgBRy/K4Vcm32LGvms2ko84HfN2Ikkt/UryLTq1umyype5gM3j6zaEHhTMsGpEgnNJ
         Uix6gOro6MuHxADkn3NZ4kXnSxcRgP4mtjIxHq0LHwA5Y8GGkKaZ7WvU2jBdcrMa7RjH
         qimcBJIO/5ZenRBo0tIYXM4xPTQ0tpIe7WwvH6yqyS6OW6B68G9ujyC3WJc4YrK8E6wP
         skpF//l8gPT5/5nOL12HK7DVM6PlthFrH6JDDRfMVybagKJ9SKDI8J/LQeSuzVf46l8x
         Lp+xsXHNHSA0SqXLaqw0B0+WEWPqgFFiDNhagh7JLctY5Vm3G4KHLqVsAa9mfgXjfI4I
         lSHg==
X-Gm-Message-State: AOJu0Ywl2SpAMErWcaVbvmuNqe/5lAjgY79S1fqoCbHr4FAS6P8gbHuy
	WP7WyQYMtYPPHbN0yRl7c++QAzOO0+YhZ7RQ/y8MuRf18AmAf0U4BwU07x9+QBo6pMM=
X-Gm-Gg: ASbGncvsnrXLKhEZs+glp3b/SqhEOnGPE9BM0a7gz/ee5N4WNCuiyvIZq2sSkUwo6or
	BUbyJG0VMB5vW01hEVHaAA+y4LAWkt0ml/u6b8WI71WNouvwovYx9hn2/gvmytHhiLp3mwk2ePP
	Ytbv507w5tUxwSxEqu8P9qMiqkQ2Z+galQUgy1OamVdpx++FrXKcRiQ505lYdpcOPsEaLk9YeF/
	bpdegkkCBaVerKuWhYmAkkAUi5upP9DoWEOnAXLVO7jf+ioB3MGplvwfj71lFbrL2W/iuSEw9Jc
	cYaOegxDynTNcgYcGyxyTyJdY3HIPNzWu/h5W9YFnGpirb8NecM1oodL
X-Google-Smtp-Source: AGHT+IEs4wThNrmRwHTKgvzNLLVLpYDCc/8CQVSXFRNcZ5WF5QPNe8tLYxPsqR2izqa8UFqnuKGNYw==
X-Received: by 2002:a05:6402:2351:b0:607:1973:2082 with SMTP id 4fb4d7f45d1cf-6071973209cmr1820906a12.11.1749069794543;
        Wed, 04 Jun 2025 13:43:14 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6059b007c66sm8002439a12.62.2025.06.04.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 13:43:14 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:43:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ingo Saitz <ingo@hannover.ccc.de>, 1104745@bugs.debian.org
Cc: stable@vger.kernel.org
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
Message-ID: <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>
References: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvttx254iueuslev"
Content-Disposition: inline
In-Reply-To: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>


--vvttx254iueuslev
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
MIME-Version: 1.0

Control: tag -1 + fixed-upstream
Control: forwarded -1 https://lore.kernel.org/r/20250530221824.work.623-kee=
s@kernel.org

Hello,

On Mon, May 05, 2025 at 05:40:57PM +0200, Ingo Saitz wrote:
> When compiling the linux kernel (tested on 6.15-rc5 and 6.14.5 from
> kernel.org) with CONFIG_RANDSTRUCT enabled, gcc-15 throws an ICE:
>=20
> arch/x86/kernel/cpu/proc.c:174:14: internal compiler error: in comptypes_=
check_enum_int, at c/c-typeck.cc:1516
>   174 | const struct seq_operations cpuinfo_op =3D {
>       |              ^~~~~~~~~~~~~~

This is claimed to be fixed in upstream by commit
https://git.kernel.org/linus/f39f18f3c3531aa802b58a20d39d96e82eb96c14
that is scheduled to be included in 6.16-rc1.

This wasn't explicitly marked for stable, but I think a backport would
be good.

Best regards
Uwe

--vvttx254iueuslev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhAr9kACgkQj4D7WH0S
/k7tOgf+LKeRJxqZooP95Bh18VIuhHKYonO0De80uNjR2yACLaxcBWZFZK1VzX7w
qlAmgjgQ/mS0umTFlUN3B4satEOnfwuea/pBwjbtqcYq/OrKvnkmWNkwR/3KWKiL
ywU7O578w8zGiTlgEA+eEgoqcZtDYuLInuvxLXRppihaadXA9u6ci3m6mJK3acW3
7mrILlrx7n/j79OINqIzGMdpEgy5uQoQyUHf6ROvBQFg7xZ0jQ9Gq5I0fyN7cs/A
VrPltgVIVvLcjltKWs4D5Nid0sEEZ7oWAiPenAlitkpkPc4Vxk62YwoIqbA5L/SJ
chXmkTriZggLYrDeFQXoARXLQjxTbA==
=BUO8
-----END PGP SIGNATURE-----

--vvttx254iueuslev--

