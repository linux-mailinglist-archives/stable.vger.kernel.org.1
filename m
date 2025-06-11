Return-Path: <stable+bounces-152416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79DAD559F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9325B1E04EE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4D2E6123;
	Wed, 11 Jun 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wvgj7aGI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBF155322
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645228; cv=none; b=krtf/J07KAlm14ilgLJh+csb0wKjKCAAlL1EcckDiGxHS1DTtFOzY7JP2eIkBP50JbMWpL3QduTh+01Vp1ezFMVpmG9NmFp/pAfTPknFVxeCl+lH/CWLHq1zR7/6fCQzxX7IvZhTGPG/OGUoliWhPuUhN9SB4l6/VK3B6rg5rEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645228; c=relaxed/simple;
	bh=g3NAXjEVv53ME39m4WFK3zaviYHTbygBx9suNW1Gghc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuPdIcO+MBmkD8VK8KsCgTO+Rg6kCmZaueolN756Yg2Ua8MkPT3nJMqdqTZfxVPQxACySsW2kpE5Q1GfUHV+tBgPCWlulA3xt8iK3zvYx8kmRQn962sORPAdfhKuf40twyZoSfiA3FdFEs9yXzyj5/GJF1R3F/EvLc9hUArbejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wvgj7aGI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453066fad06so29366705e9.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749645225; x=1750250025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58tB31KJ4kl8/PiwakZKBV9Caj2k0aAHpQ5UO46MXf8=;
        b=wvgj7aGIW7nNH3KEdd/Gaao/JvQpErAchCv1Z/8i+fWdiOWJzgeMdkRorHZ/A3z1Kn
         WiMJGOqKQNoG16lUzt8h3gHqnunYgiLhTJpGNFrcvxOISyBPlv6/bC+sY1fKK0yMHpEm
         KMvuwX6If2cDtbeDAhdWqr3aNFngiulnhrneswIyZox858Tm/aQ6UAd6k5xKpL4NQvMj
         Gsx0zTVkDas0It0Wg73hGPhglCENGBImoH2iqqEJerefbTENwZ5YSLVkhjwACu9QCY1Q
         m2cEUFk6efkiYXKEecB9bFjXEqfRLrIlR2QKtlaHaJwI8aniz1MRUG8uoQRwFUW5OreI
         dpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645225; x=1750250025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58tB31KJ4kl8/PiwakZKBV9Caj2k0aAHpQ5UO46MXf8=;
        b=Gt7++hTseCVKOgY0NX/gsWKZm2eu0JgAlwGSxO4e5qY/P3HTPRzR5RcbY3to2c+vZ4
         LceXEd8zJv4LX37aClxYsGiHV0cIn40KmTPwpRIfVczuYDPNzOxUkn9imUBxwgeSTzTq
         0QV8YsRfFPq6sZcNWzuVnlInQRSTkCuktRGWxu4STqfdkLczU41vx3GDwsTi5pXUPQQs
         yDN4Zjrme/E/uJUTRbfyLDTmDsvml+j07iJnsXg8nctV8sAx2YGsXX2/0wXe6gzmpjnw
         WnVkXlt1ouavyL7Xi0eBnyQjuHJSALRE5+KApsGQFQlFLF64IqeH6iqikitSwM1uGwFs
         1JAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BPDVMtjH4AYaeXkIu51vpN/eu3T9MyJtyLkP9gqamqvFnTXxXLna0bz2ZvZ87bCqT8mw2AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOtjWKLoRiAs1y3BSIYQZy1APPrqUgRaJ0wfA1mqNuHv1dMB7
	Sn489TZWJIiwJr579LyVKH9ApzREF3JGSfQ9iBTnX2oCMsFwqfjIJUzFCoju1n/Izog=
X-Gm-Gg: ASbGnctkAWO2SDvyIk35yXjRZwVOE+H7pH8T72xLWNY+7wBmTE8A5sUdVddAKBMyI0C
	bp4H9qEFTXXchb49+10RqgoVbTGLSldfup6zfUdcaavbVHsW5by9wTWy7z6gXhOTE8nyq1bPYp6
	fiaKS3XZ/HbmiDrNeOls1x83fbvjb0NQ/r84p1AxHkPgj5QExeoqWabvEfaaDgZtPhTvJm8KJA5
	IPKpEKkMRc1Fp0NMWukKQo0kQlpLuVrO0FZmCSsOHO04O3jKFuIAlHFdDD+Mp5ccXW3ApjzeAMI
	2tuezMiYdu2QYoPopxRu+iIrxhBLgcUy7dIEL8oJ3AmC1vZkcwdDudUxqxCgh1w=
X-Google-Smtp-Source: AGHT+IH+yTHZNTGeC/+RF5wU+jFRSmzOWMhHxhfFM0B/77rWsjy5ljPuBPABLlLuzVsDVde3T5b07A==
X-Received: by 2002:a05:600c:4686:b0:453:9b3:5b65 with SMTP id 5b1f17b1804b1-453248b09a4mr27662635e9.8.1749645224718;
        Wed, 11 Jun 2025 05:33:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3994:acce:fbc8:2f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252165c6sm19762355e9.29.2025.06.11.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:33:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: loongson-64bit: Correct Loongson-7A2000 ACPI GPIO access mode
Date: Wed, 11 Jun 2025 14:33:40 +0200
Message-ID: <174964521463.38087.18017006359179937333.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250610115926.347845-1-zhoubinbin@loongson.cn>
References: <20250610115926.347845-1-zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 10 Jun 2025 19:59:26 +0800, Binbin Zhou wrote:
> According to the description of the Loongson-7A2000 ACPI GPIO register in
> the manual, its access mode should be BIT_CTRL_MODE, otherwise there maybe
> some unpredictable behavior.
> 
> 

Applied, thanks!

[1/1] gpio: loongson-64bit: Correct Loongson-7A2000 ACPI GPIO access mode
      https://git.kernel.org/brgl/linux/c/72f37957007d25f4290e3ba40d40aaec1dd0b0cf

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

