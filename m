Return-Path: <stable+bounces-196947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5FC87F54
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 04:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E707E3AEE62
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4330DEA3;
	Wed, 26 Nov 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN13IDGS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1F30DD1D
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127762; cv=none; b=p793imX2V4i8c7gW8GBFMY9uXomJ1oZsH+DfMqEk49WaPxJ+b0lOAdkhsUC1txNkhCBZtL0YBLxLoOQ1QRY1fvumSIdcMEQqMYOj4XKA9gsUrrZtfZo/LjiMCi70Z5vOgLCqhRF1clc8EvjZKqdoqOdi1DhlgocPoiXVseqREPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127762; c=relaxed/simple;
	bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB3ndbbdxSVSv6E6FXcRbnB/4U4WaLibIHuecU2vtyBZva2e9WRwVwXPY7Qzv10RiB4sfOfw5vLEMcvMRWzdQLuxb2llnRGXWhXn+gZP6/mFDDpHrWDqsx3iTOQSk9D+z6H3Zi0aIaM+U6Fgidrh4jxiwIVImN21oBGt2IRtFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN13IDGS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b999d0c81so44512551fa.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 19:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127759; x=1764732559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
        b=YN13IDGSY92h9kDSlSF8YG3C050KMI1VARITQqyZZGfuCUUYLJMFwyIbO+/IAYTFtV
         wq1eKuzKSCG10ArqrimWUjpJIBDc9ajdt9iICgZFzF/pz9Zbyrf9/K7pj0zYG3u32FqP
         JMJ9kZlPgiRx4FZ+OEVF/Rh5ViVxJDw4MrKEaKspIoKwuANhaSliE8BYAmkuKKdOvGY9
         wXbyPi1O/FkhNXBDzw7vjxklc/0g4L0duyJdaUHAbQGEGSAGgf6drmu1Na+6BCa2H50l
         5Y2v3xISuqxNjcrikdAw9nf0Y+WUweKjJAt5eOfKykyc4hIhs+vnKWDsJWNoaY6Ft6gk
         zs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127759; x=1764732559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66TuTBZPQ5vsv3Iv0COl1blnafpP7gUF+2AzcPsJnME=;
        b=VG7c1lfyj+Wcm7YHVVGYzjD7pL1p0wu1xZ6iOLL8QucSdmy1tIqgA/UcF0diex4U4G
         IuhBEDWBBlSWKPTqyosV5iNFkIMuqcthpHdtCnrpoobrwUOWMPljL5mtk2yqWBt1X9WU
         DZbnp3GtYxIit121X9VsPEPzm9Wx34YbFHxjzcTeMaz9teHKpJopAgF41ZW65HKZdv3k
         ghHH0tlZfrXQ2g0KKwYFI4jWKQZl12zRY1VHvJyFDXyhJPoRVV1FZn8d1519q93Rqe6c
         bZ7DXn+1FP6p7xsvCT+ECRUBSPUMnKM6Pnki5ySkL3I6xCIAiKdEcNkF3u3Hq9TYcMDY
         8c3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKmXQnqCx4HtiuYJybqN8/XWSGl/bYSCpAT0OWFT1kJJR6CYyYLkKt2jAeolJdP7c0zd3S35o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQr15Gws3y6wdOdT31Z/08R0Y0F5w5dQ8YhVltBqw13ifYXNQg
	a22RrjJhMYwQBDDl7dqmZeB7y7dsDf00NxJY6Vb6RFQ6OBDW2V11VB4gFHtZh9JQkt7Zzn5D9NA
	tnCX4l8HpUCs0d9SX5UhFT42W6zBTcKY=
X-Gm-Gg: ASbGncvQoQiDt5w9Baqj7n+wsyBWif5h2tTHiF7EwdEb+bTtlg1ZXmY4srzk8HNUwil
	o0DO4Y5r1ycZLEBSnJyNTUJymTQnMzSAlRi2dLsuIqFAWV6BmaqlV0V7uZfUKZ3hvRfUhnwVN9z
	Ub7ZO5vWaePYvtP9hUYAEb51Q3M/j+3hoyd6VaRMqRUDDt9woPXGuE6Ki2GqGDkWemeyte5tD47
	YIl4g/wqG8zAP0ETMi/8/I9sI6P/vyN6IVGFEV3/lAjVd4vzYk+hZDh9zK1vs9J9bGG8Q==
X-Google-Smtp-Source: AGHT+IFXNDNWfBE/jdt0Dz9W+S2FZLkrdTl/cEteRJj+bVHvSnDXE5eODbEtCrm2sfh2BeISb+8B1VHSywmIxbn2U6I=
X-Received: by 2002:a05:651c:43d8:20b0:37a:432f:8ecc with SMTP id
 38308e7fff4ca-37d07953a3emr15608421fa.33.1764127759248; Tue, 25 Nov 2025
 19:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120081227.v3.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
 <176366460701.1748676.511972373877694762.git-patchwork-notify@kernel.org> <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me>
In-Reply-To: <fcMPe6V9vMYxkXRMnKXiaeTnOwAMBNRTmF1mgLePTpz3Q4hPqpb0WVQ5aXZljqkOtZ2W_47PVL1Q4lnf7kZJhFS4aGwP8_4QiqJl2ScKSi4=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Nov 2025 22:29:06 -0500
X-Gm-Features: AWmQ_bm2zfUBQgnJooefgPcNZ-tIRrataC9j9VnWGhDa0KJzloTqrrroBYDFEXM
Message-ID: <CABBYNZ+LrMOr-Bb-Sfk--FAHjMWxzeUCdDoGLuRqhF99xaGE3A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: incogcyberpunk@proton.me
Cc: patchwork-bot+bluetooth@kernel.org, Doug Anderson <dianders@chromium.org>, 
	marcel@holtmann.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, regressions@leemhuis.info, 
	regressions@lists.linux.dev, johan.hedberg@gmail.com, sean.wang@mediatek.com, 
	stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 25, 2025 at 10:18=E2=80=AFPM <incogcyberpunk@proton.me> wrote:
>
> Hey,
>
> It's been almost a week since the regression was reported and an patch wa=
s provided to fix the issue, which has now been accepted in the linux-next =
tree; but I see that despite being a patch for regression, a merge/pull req=
uest was not made upstream for the latest -rc mainline release.
>
> Is there any way that I can track the updates for this patch to be onto t=
he mainline release?
>
> Sorry, if I am missing anything.

This was merged into net tree a few days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D8a4dfa8fa6b5

So it should get into Linus tree in the next few days.

> Regards,
> IncogCyberpunk



--=20
Luiz Augusto von Dentz

