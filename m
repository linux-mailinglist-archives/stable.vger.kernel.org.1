Return-Path: <stable+bounces-105629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973569FB08B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B0161AC0
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40211B0F1B;
	Mon, 23 Dec 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3o2UAH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A414287;
	Mon, 23 Dec 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966536; cv=none; b=H2ojMlWD4Wf0r51bDSskyRorzw4x0FNgef99i8z23DG4Ob9jiHWyjDJfrX4UtxgNaIn/y1AWkkhmoqX7o6e/W3CdAsTlG8g9gTeEDy7marT1i+P7hlo/IGI7RW5Xp09R5nnuEkl9ncUvhtOSPFXKtCLoF087BkmSfB/AirTR1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966536; c=relaxed/simple;
	bh=5kuDSeTzV1Jw0BuP6ho8M1FKxQboDclJcHPZg3xW6zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRj7RfaHCdpK8QZPILKmIGqNj0uKr+C8vNWlLSSeSC4U05myaU4Rch9EY4Cc901mFcwNdkLHjD/5MUqQls2PbnAfockC+Zb1pwkWQDOThpXnGTBgyPIPO7AV2K037ucye063ke0ZP4f1xgfDTpumSKIIfzNS/u4PfqwNC34cdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA3o2UAH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f440e152fdso809521a91.0;
        Mon, 23 Dec 2024 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734966534; x=1735571334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF0sOZnUj8sAyucMQ2ztc2c0IcnVX/ElkSfDdu250GM=;
        b=LA3o2UAHWxFMwtc0XQdU/OpvP9TpgY0biuxWdGrk4AH3UXA9usL9Y9SEAyxbnQ3nOy
         dLKNlvyk7g/dW6/joZqfLQb/HHANd88PEamRgRVVgKY/k+4wK22hWxg39STkiqqWTgN0
         ciJxzvFp/RHCipyE0JV5LG4WEsS6ocTOZ7C/lmMi/JXtCrAAe6e4/7qwsdW9DrLPXiIx
         o3vy24DpbzLCql6VpGxe1AUTpvqZ75gwA3XvpgouSXQ+BFcNK6m0DYk3saAnyQJ0qjq5
         0sTLUSkJpVEnNwkN6Z9cLrKOvzBlr8Pt2TvelV5qqhRP/zW6YVz40NG2h47cuhnbILdg
         6UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734966534; x=1735571334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF0sOZnUj8sAyucMQ2ztc2c0IcnVX/ElkSfDdu250GM=;
        b=fQ7fFr+snChNfQyFH3TwnjrYO7b8Nn8Gy1/BRWEidug20zjNO3BbE+53C9U+TxSW4r
         Udh9rnWD3uJGMjI128zNxw72HQfH8b5UPNiL4XZS3NdNjSfOgqny0htt3XL7huEfqIxR
         h3sV+SsOgOdAtPBkGA3ULe2x5zZRs7pa8B51pgv0RuH6rxFPURYy1RYNUD4swvB0MvK7
         gTkQhj9h9WudhRByI2QQz2gQMNYtiLQYGiFirC8O2cX4p/71Gx3ywYPnlYCFCBvaKMXr
         vF+41PWbvrzW5lTk2Xe+cqZKiRl4biAzHqMLUHECKEwwZkIzbZNpL/wryPlY2RJz0jfl
         2wjA==
X-Forwarded-Encrypted: i=1; AJvYcCUhre5/CjWhXcr0JpBxnv6vSu/7oD6GMb9T7ay9FoZuyCwkePXwDPPPyv4txEIN3AJnlsXXHEEw35IRPlg=@vger.kernel.org, AJvYcCXra7hofrRzkAAxvfx3v7V919Wpa/Owa5aOi6VBKxekDxrkSlofkPmliB3HmreyuQEJJS8WG2xm@vger.kernel.org
X-Gm-Message-State: AOJu0YwcbyAXC0LiQtzI8U9w/e5uUrDO8v0rUov6zqEHgV+7znPQaA8c
	IJQCbOioCE10EFq302w/+T1IPF84X1pyl78vwoLKlCe0+6uq0YzLvzshfKXAAv0HfUPqNJAKzD4
	TGaBJ/5NN6AJLtLLbpdYyKt9Ezjo=
X-Gm-Gg: ASbGnctIdqMmE6AQU9qk5b133a0b/uE8hAj9Y7fR7mcZIkXntw128/hYG8buTqWq9Ea
	ywoXdLAWSAIVkXTOKxlxRtfubHv7FZGflQBn1dQ==
X-Google-Smtp-Source: AGHT+IEkapHYNlUUKAjZj8egJF18AjyOabciUQrTJCmtjvX4x7gga/YoC2xZlf0T/eu7KxDIYeGVatztWXLKQd3DHZE=
X-Received: by 2002:a17:90a:c884:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f452debc21mr7690176a91.1.1734966534558; Mon, 23 Dec 2024
 07:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
In-Reply-To: <D6HQK0PSRVBC.XEUGZC9N1O5K@svmhdvn.name>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Dec 2024 10:08:41 -0500
Message-ID: <CADnq5_M-aPD6tNppQ3_6dC8dgt7zeLXZPE5CdCjQEuEDxS=mWA@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu: thinkpad e495 backlight brightness resets
 after suspend
To: Siva Mahadevan <me@svmhdvn.name>
Cc: alexander.deucher@amd.com, regressions@lists.linux.dev, 
	stable@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Xinhui.Pan@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 4:08=E2=80=AFAM Siva Mahadevan <me@svmhdvn.name> wr=
ote:
>
> #regzbot introduced: 99a02eab8
>
> Observed behaviour:
> linux-stable v6.12.5 has a regression on my thinkpad e495 where
> suspend/resume of the laptop results in my backlight brightness settings
> to be reset to some very high value. After resume, I'm able to increase
> brightness further until max brightness, but I'm not able to decrease it
> anymore.
>
> Behaviour prior to regression:
> linux-stable v6.12.4 correctly maintains the same brightness setting on
> the backlight that was set prior to suspend/resume.
>
> Notes:
> I bisected this issue between v6.12.4 and v6.12.5 to commit 99a02eab8
> titled "drm/amdgpu: rework resume handling for display (v2)".

Odd.  That commit shouldn't affect the backlight per se.

>
> Hardware:
> * lenovo thinkpad e495
> * AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
> * VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>   Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile Series]
>   (rev c2)

Please file a ticket here:
https://gitlab.freedesktop.org/drm/amd/-/issues
and attach your full dmesg output and we'll take a look.

Thanks,

Alex

