Return-Path: <stable+bounces-167161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685FB2295C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D541BC505B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE6B286D46;
	Tue, 12 Aug 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZA9NG1ub"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B71280CC9
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006210; cv=none; b=nIibdXoWLQawLuLC1jKms909JwbtSw7BN/5rgHr7Z1byALiw4Y9oOblnCScQ0PL4pSzom/7gfr81g5ZCX8evNcpdFBxEjB+v2RYuHMK1AdH9UkIAXFrx88g3rB4l3NJCaT5tLDQtNKEhrAavUAvPj8cqvYEFdA2SgHgIlQp9hys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006210; c=relaxed/simple;
	bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB4wFU3BWPgH0R0YIV56mbDWixowc3We1Jg/2pWc2I7FPGwvcqVp+f0r9rknweS2ZBkG1Rh91RgVb478XaALjJIT6Xyj2IxQe2n2+2YPvRWiGL5w7vSmYT/Z3izfQQ5htEDiRRzEEevwIpEUD2o2GHeSVcJjlce5MKJtlHQgpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZA9NG1ub; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b9a23d633so5857786e87.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755006208; x=1755611008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
        b=ZA9NG1ubS3LVdt+RLvJW2cAJINGa5FA7N9zwkD5Ag662+zJ8N4dOaV5M3vy6f1w5E7
         ooP8pGGig7BVR8wpiywXDjBdYBG8Rg5Av4cc+NYvs3+eJtx6cj26S2++OQp99hpXd9Mp
         zFhELflYFEoOt36i90Q3ZB7DOI77rL1ZbfHP/CRMy4ULjjirkdw6QTyrEhQ/JWkSMhlZ
         j7zqjCDAxb6dZQsbhO0C42oa7wMw/zUp8uG8eejOqHSPbHV8tlH8vtNktuljrTS6raT0
         bFHLjsph7z6vrRTjWTYgDMolSdHLScwqgqKxbOns8ek9vLBLmzBGapy3Lh/LUzBdptUl
         3+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006208; x=1755611008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10DayUutEE+8+BzPqhnagZ2gFTkIus6uLskzB/ocOU8=;
        b=VtlgmU/gcvTnrcmT8kQPILpN3bh1WtTWEgxz07o2HNlMGYJg6Ct0rsvk2H3ScV0V+z
         xql8JE8vmME2OH1hqhOtv7aTwI+4GSWVCSlAsLhf1L9htg5aWOtqz6GJQNxO8Bsn18Mp
         ypGm2k1Id0II6aLfcULMUZ892PozzJlG6WmLKrQYDgz6lTHkI+8gNYELw0V32w+jgQ5k
         bYhGtPSEYDs62GJlTWB0uBnrie7giEz+DcdyUiA56QXQIkpXNXmxtetYYaVIF7bkjs5D
         qwG6LB+vKK919FFQaLBSinohSccmIbSW1MqdMXInHkUOKDnwYQW9+/J4OBscn3OLZytQ
         Bf3A==
X-Forwarded-Encrypted: i=1; AJvYcCWclxXrzbT8LhKf6Z5RfyCbomJGs038ZplwitopGFDIdlb4/Ismq9/QdgZEVAXV/vMO5STwk/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1p2cQzFXtcpGOH113gvIBALuHldb8d7SQ/gr+dbJjmHxrWPIa
	CgjzPPD32YoYOfOZYBFGiEUQFebKXO4gKUvyxHQc2pv29XjbMjMrLb8gu1gJFrYZ5Gk+2x/veJK
	QGYYwfhUSoNlr40nHvWsJwlmFmuooEWtfux5e9X2tF2kcz2C64RW1
X-Gm-Gg: ASbGncvwVtcvqaJHlOIGfgCfmHckvhbWHDx+frN1AiE/su+4jcF7xLBBQIZs6IgF3F/
	nBxKDw6hRdVe7TTwRIVeVZG8NMs/9MIynOBlKM8WtT9h8RtQIoVXKHpKzRaIGu8kUzUODWmRpbW
	UYO8kOwRpnrhXOVPCgwYpw1YsnUBd/jtR1L2PLp3BI4gfhaBzM4GjakjVEF0Rp2XXpicsdYt8FT
	r7bcTgVZiQL5xZ6K6Oq3A8hyHzoUdVF3QMe
X-Google-Smtp-Source: AGHT+IHQzp04bzC5JdlSIA4egh40+H7c7r6zkMNOXSxJb7bMpFxuyFM28d79+bAJAythGzevvvdtqJolUysV3ZHuypo=
X-Received: by 2002:a05:6512:1509:10b0:554:f82f:181a with SMTP id
 2adb3069b0e04-55cd8af0b3amr687496e87.2.1755006207600; Tue, 12 Aug 2025
 06:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754928650.git.davthompson@nvidia.com> <8d2b630c71b3742f2c74242cf7d602706a6108e6.1754928650.git.davthompson@nvidia.com>
In-Reply-To: <8d2b630c71b3742f2c74242cf7d602706a6108e6.1754928650.git.davthompson@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 15:43:16 +0200
X-Gm-Features: Ac12FXxBNvTrYsmC1epUgaIYhL60nohcjAuiTCNAcP_ercfbT7S70TOQRX_fyJY
Message-ID: <CAMRc=MfAP6sEZhcGvsyAXjTn47YPRfKsZq6MmbXjR17fQSDEXg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "gpio: mlxbf3: only get IRQ for device
 instance 0"
To: David Thompson <davthompson@nvidia.com>
Cc: linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com, 
	mika.westerberg@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:51=E2=80=AFPM David Thompson <davthompson@nvidia.=
com> wrote:
>
> This reverts commit 10af0273a35ab4513ca1546644b8c853044da134.
>
> While this change was merged, it is not the preferred solution.
> During review of a similar change to the gpio-mlxbf2 driver, the
> use of "platform_get_irq_optional" was identified as the preferred
> solution, so let's use it for gpio-mlxbf3 driver as well.
>
> Cc: stable@vger.kernel.org
> Fixes: 10af0273a35a ("gpio: mlxbf3: only get IRQ for device instance 0")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---

Ah, yes, it slipped through the crack, I should have paid more
attention like with the other one you mentioned.

Thanks!
Bart

