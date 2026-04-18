Return-Path: <stable+bounces-238586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HiOfBElu42kyGwEAu9opvQ
	(envelope-from <stable+bounces-238586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:43:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B3421013
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11759303E498
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B035DA76;
	Sat, 18 Apr 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WGMbrXIp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDADF3537F2
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512452; cv=none; b=E8U4XjcrtpWmt/MT9KrNRaQOyCeL7/maQuMZ/URq5WD201dkQwWVyn24iQC8vARM96v2bRE7KAOzo/IWAZwQG2RzWw2/pKFaHb+cHvZeF5BrdkxA6by3LBEuOeooJNOH9AQb4GsfJ1p7PrqU14fyjLd4DEdBa0OSmyBApUJdPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512452; c=relaxed/simple;
	bh=152FCEZ6y9LZI6H9RnVi6/PPlNvFNYw8/yMF/6yJduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0t6FKsM9L33KVxcEav6UYaREUC5y6BXAW5rzbPJxlcnwMs1yxDzUJTMeNud51nHFYeSPmAMItxdmG/saRAtNCV3/E6RFusFnRFdRyK1/npTJ5Z/PkdVe9c8PuCFSRQjpFx+JZtuyteH7PDMY6A40qadNQ6nJ6Se+xjA/UB75EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=WGMbrXIp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so1330672f8f.2
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776512448; x=1777117248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=152FCEZ6y9LZI6H9RnVi6/PPlNvFNYw8/yMF/6yJduI=;
        b=WGMbrXIphdlXyDIB8K/AMt8jWqOLjeQ6frUG/vNKdfosHQMKJYUDEpobBKLbL5CtR1
         AN14+kCP9Q/NHiYJ894zWyroTgzSdVrZDWyxGUXsEj23h1jBaUBWvKqBYrtHxtSoOvr5
         NZ00Af43bHgJoacJsTC43XS5T6pRV5hbm7BLMKW+x1ZO9s9JncI6sEke31+l7QXmb/7d
         l/Be5xHbctEae7UlTML9UuDEpjOl3eQI/DVnsTxQloaZf3Onyvf47fSt83gWQiNv/qm+
         N1QDlVtyZNb4J5NxN6q4O+AC5SOSxCJnTYl6EL1ZbkELojscoxRE7nUEwGRKug2fbEHj
         We5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512448; x=1777117248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=152FCEZ6y9LZI6H9RnVi6/PPlNvFNYw8/yMF/6yJduI=;
        b=RHdvxoS3CwUYbGgFx48OBZ6Dq+c7+FhzgqgvhyIAIOrDRR09kr/goGEfF4ZMSjClF6
         1ZqtjxcnVVCiRDhX9oneduHV5Xt8X8vss+Xhg7s8EmK0tkN70LbdUooLF8eKtC8vsHcO
         sryybf6lByUZTc/w60WbDszCLbMYaVsb83bU5dT+xNgJltdt2N64Tp3GZsWM5mBczQTM
         smJ/a6w8l3yDd31jMTAAJv5Rut0pPBdb7oZSdP420lJl8EPo8fIY4j4TNe6DKZ2ONIPn
         9I1v/gEt0By7EWey4BLoQEnDpLaUx1GBPBDnxlxHt1SjhHVeph95aSqRKye/83gygwBA
         HZZw==
X-Forwarded-Encrypted: i=1; AFNElJ97izs9mYIksz9T4EdSN6tG78is3QM572SefWRzd4pOsL57xuwRtfLJZGZP//HZWPvs1H8QhgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nRnyc/L9nTNv/wV0B8FWxIcD//oFCix0vtoHViwlHCyOXWMq
	FtUZcHxFp4LzH8Bqy+sirr7+J3/ZbprMH5QX/HHA4IUHfXuGbqgix4ITcaT17nKS7E0=
X-Gm-Gg: AeBDieuVGcKMFy6BXi5fEXR3L2LlR06dFGalJKyQJ3zCn1KDALyk/H6DzUfF1acmBUx
	B4Em/Satmh4XwnFJe6r30K0sheQ+seGrgA1YqdXuS9086NO+d7dgBmU9aQly6hbuZM6Lq9pwqUw
	bxZ/9N4fFGYJzprbtAusJs+ZHh1tC+pmriDRqoAov1gOE7H7cQyJael0Lxw5OEwhExLU1jLfm4B
	Dond/75aC89vMjKYaIuSqwfGXPjR5zm+EZS9RXbDN7xE0h347jJoaj3l953IT4a4TU4/QdQi66F
	x9SBWRoUyz0HVoZPOSI6DnD9SElTAUNx3bYB6HRAQngRk2Iq92F7ZMRzzLIFUnZeFeIuUzmKPX9
	bEgJHGNMKOxJ8PypfaFSw6y5QCVNZTl6ixoIwrt1Uv3gCLgbyGXMFTDARQww5uImw8ljBXCiwVc
	lZAZfyUiHW1nI38UYiYNfJyIFWSlr8pjNsbhtwVRM=
X-Received: by 2002:a05:6000:1843:b0:43e:a6f3:b763 with SMTP id ffacd0b85a97d-43fe3e237dfmr10429773f8f.44.1776512447854;
        Sat, 18 Apr 2026 04:40:47 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a341sm13536078f8f.24.2026.04.18.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:40:47 -0700 (PDT)
Date: Sat, 18 Apr 2026 13:40:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Li Jian <lazycat-xiao@foxmail.com>
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, 
	loongarch@lists.linux.dev, chenhuacai@loongson.cn, zhoubinbin@loongson.cn, jeffbai@aosc.io, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Zhang Yi <zhangyi@everest-semi.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Alexandru Ardelean <aardelean@deviqon.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
Message-ID: <aeNrKkEjYDlvsuLM@monoceros>
References: <tencent_7C78374FB9F4B3A37101E5C719715D8BC40A@qq.com>
 <aeI1_C5WGY5SzzcD@monoceros>
 <tencent_EA958964799F4CF9F76BA2D10149C4E9720A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="36zcp734q3dnoypj"
Content-Disposition: inline
In-Reply-To: <tencent_EA958964799F4CF9F76BA2D10149C4E9720A@qq.com>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
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
	TAGGED_FROM(0.00)[bounces-238586-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev,loongson.cn,aosc.io,kernel.org,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com,deviqon.com,huawei.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5B2B3421013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--36zcp734q3dnoypj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get
 clock
MIME-Version: 1.0

Hello,

[Fixed address of loongarch mailing list]

On Sat, Apr 18, 2026 at 04:18:10PM +0800, Li Jian wrote:
> =E5=9C=A8 2026/4/17 21:34, Uwe Kleine-K=C3=B6nig =E5=86=99=E9=81=93:
> > On Fri, Apr 17, 2026 at 06:53:14PM +0800, Li Jian wrote:
> > > When enabling ES8390 via ACPI description, es8389 would fail to
> > > obtain a clock source, causing the driver to fail to initialize.
> > > This was not an issue with older kernels, but since commit
> > > abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
> > > devm_clk_get() would return an error pointer when a clock source
> > > was not detected (instead of falling back to a static clock),
> > > causing the driver to fail early.
> > >=20
> > > Use devm_clk_get_optional() instead to return to the previous
> > > behaviour, allowing the use of a static clock source.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
> >=20
> > Are you sure you identified the breaking commit correctly? I intended
> > the patch not to introduce any semantic change, and even with your claim
> > I don't spot the issue in abae8e57e49a.
>=20
> There was a misunderstanding on how the Fixes: tag should be used - I mea=
nt
> to say that your commit changed a behaviour, not that it was broken. I

In principle the usage is fine: *If* a commit changed behaviour and
failed to adapt a user relying on the old behaviour, that warrants a
Fixes line.

*But* I claim the commit didn't change behaviour. devm_clk_get()
returned and returns whatever clk_get() returned; with and without
abae8e57e49a. And clk_get() wasn't touched in my commit.

> should have pointed to a commit to this driver instead.
>=20
> In my case, since the device was described in ACPI and it does not export=
 a
> clock to the operating system, it was then necessary to utilize a fallbac=
k.
> Before your commit, missing clocks returned a NULL pointer.

So I'm pretty sure you're wrong here. Did you try reverting abae8e57e49a
on a broken state and confirm that fixes things for you?

Best regards
Uwe

--36zcp734q3dnoypj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnjbbsACgkQj4D7WH0S
/k610AgAu+LKDGBFbOvkeruzFxDgI8KjJ02DhdrZFeCHXxpJvN0WT/lbtVjcB7y/
MA8YGt3CV3z8idnWGk3W9o5ukCNMZWoPTXkjOon8xSPnIauiQjtEw/Afkc96vzRF
IroKFWaGVx0YOV3b1dGTti1YyMCLLTQfGxKtCZPYW8UU64oC+9HNTkHtJkyYqAxC
aZfpvddNGcdGHOMc6ZmauZ98/bTLB4RocqZCkfa7kuTZr9jekmMoryZgJJ9PsXUv
6f69bf4UYxfWp5AnpvSY/6VyRw2dDsx1+aNqFFSC6cZeaSov0ArL3vkVKWd6Ihk1
7QQCoKSEgeYWm/nTdfu2AAI2euNaIw==
=Pe/z
-----END PGP SIGNATURE-----

--36zcp734q3dnoypj--

