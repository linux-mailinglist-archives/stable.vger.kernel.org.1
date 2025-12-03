Return-Path: <stable+bounces-198220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A82C9F2D5
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4E14E36B2
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24E2FC873;
	Wed,  3 Dec 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PbnNmrsN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064E2FBE09
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764769589; cv=none; b=XZ+Zi8ZOgzx5GGwB4exCBQely+pBk23u8kwFoFMDFtwtiwPTK5JMCLGKg6annDS8U+qHEixRU/u8FRiuvwAd94Ov8G7AIEbXGPcfqDGb2Xl6GQZvrEKjclP/f5KgdJS7GnMf8bGW7CBTbe2Or6P5w3ElAvd6MJFH/tfkxg7KtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764769589; c=relaxed/simple;
	bh=QoyOKOGalJTETaQ2d7JCV5VAbOwBVt88lEVeNz5ZVvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtPtqLjG58pYgkdj9hECdCpjDpKCsZz4/YO+qfGkKdZC24XkEALnNbxfS2O9+HagOONW3+atnIoMrtWi2davNTBjPOJiHZR6DeiTOs6ORgDk/nI24cdrBOotDIRb8QdQknhVlFKoFlNMu4uiPVXmUB+MzU3SPhf3810CIdU/OjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PbnNmrsN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594285c6509so7895648e87.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764769586; x=1765374386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoyOKOGalJTETaQ2d7JCV5VAbOwBVt88lEVeNz5ZVvQ=;
        b=PbnNmrsNOslJ49ITClxL1X4z5uTa9RuNu7VzpCwlbdWPui65Gq62LsA5xjQL1G+/h5
         xbxUEd8TTtcOW/df0nkASEvM1x7zg7CSNxFi7YLyxCVrU22AN8N5eFbRxCKtHI3gRtz7
         75zzgAe7Xy6e7zInt4nIfz3ODWUv8T/t5Htu3kjf4gSerEnAfYAS7Jag4IIQWqRD/v/i
         CauN5HXA4IzyWNI5G7BkI8rspdzPfZXGeQ/bsFOBy8RsuaG5vDjiiESUI+UrFY1geY2K
         dyQj3IvLjeZnYHmcGx56ldAMUuMaQQXTPJnLirnHypSiqS7aD15s9OuCQHoOTI6M+Uv7
         Hf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764769586; x=1765374386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoyOKOGalJTETaQ2d7JCV5VAbOwBVt88lEVeNz5ZVvQ=;
        b=oWLY6DxEgEkGIilak2Toxw6wrEFZ1EliuJZb/OYRF71gpgi0E7DBWKVYWjghvvG6hv
         6/WNr9BvWdTrSn3YlTfac8lfSlaQHpWiDJg3P3aYSM9RQ6RT0ieBYP7TDfxU8XtDomAp
         UVX+UM95xPgl6hPgvlMlE1ckaHoqFxEa8t3KscMvfhKWDkaFEKSkU3szXEnX0rPfZHw5
         Okf5v0HUZzxDXHHDxmVqwX4ekOaQJl1IE62vL8ji/T2Ufp43IMS66wF/5Xj6/v592n9E
         Ux4m+b2kKDJKfSRDEfg84zEwakxlfafBp1coyimUonIXYpgFo9XlhWNyGVDA7tT6EL7D
         RIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3qH7kvESKuJgOsOLGMtafjHmBM2gRzvDIeh9hnHlABAudp8wBTgW3g8kabkMtcAb33lEJdoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGURFs4nzLwWd2gEkQUKcGkKEcWtAmgmoZZda7MIz2EL9Lz/nL
	b62Rhy4Yz69oOFnqDhmMLs05yMIMLDKvbHb6MlpcVhQ1Sl4cBQRswJsFORwBWY/TQ7mWJ4om2aL
	1xhdfd1ZxAZSsQdJ0q6JRaxlEYxEq9fCRMCJ/DXaa8g==
X-Gm-Gg: ASbGncszMVa5Ij189d2nSLeLXfgi5mZjTY2KpFtQ8Tq9DEA5eqsLYcyzWXZzt3rqa3B
	h4OHWxm+2v+oeoGRPQ+xJ8c5HwumcJfyWIXGXSX30jlH1QQJpQjqa15Dym8oeE+khSxXM+fYcmB
	/BZJcWSCFL/bQWXzsByRVjVF1CNtDJL/6qARE+E+kKsLIImy5v6bqZZv6LTx9vXf9+FF4H3n9if
	nn9mrD1oAjqL8PKDxtxd5Q3D1qPlc2DwMFqeVtdSu8z+YpvzWClyYPH0PB0fLJHEPwm7dptSHXj
	8eiCdGzdjTBiWZrfEy8+S9P8eA==
X-Google-Smtp-Source: AGHT+IHFFPvlS+xnRg7LmRyAPE0Xg830mIDL8NqOuo2+jEik5URdIxtITO0Sj0/I9E3gV0KOpOR5xUo7sSaBPCH/Rcs=
X-Received: by 2002:a05:6512:31c6:b0:595:840c:cdd0 with SMTP id
 2adb3069b0e04-597d3f0180fmr914852e87.2.1764769585729; Wed, 03 Dec 2025
 05:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203020342.2564767-1-guanwentao@uniontech.com>
In-Reply-To: <20251203020342.2564767-1-guanwentao@uniontech.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Dec 2025 14:46:14 +0100
X-Gm-Features: AWmQ_bn8QlZhzSleILOTocoDoJsUikGtnai0FTYZncK91TZ-8PG9NeCR042vE3U
Message-ID: <CAMRc=Md7njO_3zrmkrSsYav-xokLix6=NwaVYbm59APwFS-Lgg@mail.gmail.com>
Subject: Re: [PATCH] gpio: regmap: Fix gpio_remap_register
To: Wentao Guan <guanwentao@uniontech.com>
Cc: andy@kernel.org, mathieu.dubois-briand@bootlin.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, stable@vger.kernel.org, 
	WangYuli <wangyl5933@chinaunicom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:05=E2=80=AFAM Wentao Guan <guanwentao@uniontech.co=
m> wrote:
>
> Because gpiochip_add_data successfully done, use
> err_remove_gpiochip instead of err_free_bitmap to free
> such as gdev,descs..
>
> Fixes: 553b75d4bfe9 ("gpio: regmap: Allow to allocate regmap-irq device")
> CC: stable@vger.kernel.org
> Co-developed-by: WangYuli <wangyl5933@chinaunicom.cn>
> Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---

Please use get_maintainers.pl - you have not put neither Linus nor I
in the Cc list.

Bart

