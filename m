Return-Path: <stable+bounces-98863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18FB9E6113
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E7A18856E1
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17931D5AB5;
	Thu,  5 Dec 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gmp4PH7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0B1CBEA4
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440024; cv=none; b=t8VCJYIlyyE1961jhGxZJ1CRO+6IJTaqhuf+PM8lJkkUylcUethdaYQAsBtaQaBQ3WLX5M9CMlxRMTjnsfVUkT/t6Aca0lgyHFqzCV+ZWaMA6ssThLv+6sNhtyvsTFPJqI2W8D7q4i0QDqC5cKSuFlhH9I0nS7r5Ea1scvVr/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440024; c=relaxed/simple;
	bh=Zly0najbB8AlaTv0i7Gtty/UzwP5HuEtlSJYD2C3VlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qE7FesFpT0zVoa71joOsqBY9qy876o84L+XeOSCWao3x11l8ieB/AzA4Xq5MQ067L1mVbbXBfKyev4dOAl4ZaZ+w7ms4DD5IfjvCCukmLjke16T5kPvsNXSVuV9mLY+biMtY9Yr8HKe9XWgBmkJ/PTflhNloU6FZNPQWxGqFVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gmp4PH7h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eed4fa2b3aso1188093a91.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733440022; x=1734044822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kawVqvMX0D9VNq2FtIGkZW2XMQ02ABccxhfk1LIoQA=;
        b=gmp4PH7h32Iv9x8paYaVG3WwdTwMG7JHlNlf03FcxI9/aUcc6TpiAhZI3Li4gStMxG
         9zEP2/5tEg/x42DDy6zdrpHOf3n984Wv7YfP1GQL78b5Y25IxRS3furtct2bVpeCGWd7
         qhhRWN35W0h8swjJsu5s5tom3hTiNkHxD9SDlU66/HGWAa4vQPEtO5HGg2qLQ5LxTWJ9
         hKZv1YSLm6Rsq2fgDpg5mKG0dQoKJX6nr7SnBtxJpfrpY/PAseJtoRgVAtzlkXHikjZR
         l91qvx5JMBrl5GTsCgVya/54CiifjcFT7gPUjPWg0tPDT77yB2x1by5m+R960YFMJCoK
         Vqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733440022; x=1734044822;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kawVqvMX0D9VNq2FtIGkZW2XMQ02ABccxhfk1LIoQA=;
        b=KDUZZPHxEnVdQJXuRASF0g7HpQU5r4xUFVJ1Hdy/2mjd/g5dbXeJ5EAVlZY8zkkPjT
         HPCS+ZaZxgOC8Sm/1MHoWmcOyqjyAD5z6iH49FIP26iB8A21zGwspKT2ikzKrxFWgZV4
         wee/Xy+T3sgiYPSFcWZgilwXW7tpZIXj9e7pcXds/rOZzC6WJgpQsmqBBjfwNCUm55WZ
         TgE9m8H6ls0EfIdlvEMmceQTysnPVYg+d7ruzzg4GCnuV2t/j2UNrqHKDsofcBKzjiYL
         3AZ1LHigXjhAI9UJAde3j4AeBrCHv5qGKxZQRRiivsycBZmW6k7hyf3mx8l9c7NbqDuh
         Fflg==
X-Forwarded-Encrypted: i=1; AJvYcCVUZ9+v3jQr3TgDWwXCkhJIBqQIaqArzaTDqwcIPjYzua++U4US0m4GTY5h3wY4zOy3DPEIi7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCvlgBc/hHITWVVcOohfseIMI/C3e1IP/N2iE3s7RFziFmajx
	WbCJFHwdsp/enlmeVzOSKHkjhOF0tLDJpsZTu+hp58yclF1LJWAqw+VLdYj7QCw=
X-Gm-Gg: ASbGncvLPToZtuiGUAbsqUU/rhweP5/EqiVGoqMjQPTSAZIb58DRtJWQ+anndu9ml9o
	BOxZJawBlfyYYdY8DywJUeLBhOSaH9roH3STawQ70mi/KncSSvDR/htvH06Y2HXf3JhlVcj68Tq
	rUSIl31jTsiZaRMzD/oegd2EcSr/Ts1jPUoQRAybs3SG+VtJ+7iv4+m1qCth40oodBjfI+Kmm/K
	IBc8nMyxySaxzHUioPjVHMOdg4dWXAyVRb/dBjTz80KYp3w
X-Google-Smtp-Source: AGHT+IFwPmiX90gheQv9w6qawAlgtXeoPQ0CLjB5wPsG0TNidZ75wnmEAYurgATES+m8Lyvjbc3gGA==
X-Received: by 2002:a17:90a:e7c6:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-2ef69f0b06cmr1206303a91.11.1733440022328;
        Thu, 05 Dec 2024 15:07:02 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f958eesm1939311a91.13.2024.12.05.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:07:01 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: tony@atomide.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Romain Naour <romain.naour@smile.fr>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 stable@kernel.org, Romain Naour <romain.naour@skf.com>, 
 stable@vger.kernel.org
In-Reply-To: <20241115102537.1330300-1-romain.naour@smile.fr>
References: <20241115102537.1330300-1-romain.naour@smile.fr>
Subject: Re: [PATCH v2] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus
Message-Id: <173344002165.407600.61895002978409261.b4-ty@baylibre.com>
Date: Thu, 05 Dec 2024 15:07:01 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 15 Nov 2024 11:25:37 +0100, Romain Naour wrote:
> A bus_dma_limit was added for l3 bus by commit cfb5d65f2595
> ("ARM: dts: dra7: Add bus_dma_limit for L3 bus") to fix an issue
> observed only with SATA on DRA7-EVM with 4GB RAM and CONFIG_ARM_LPAE
> enabled.
> 
> Since kernel 5.13, the SATA issue can be reproduced again following
> the SATA node move from L3 bus to L4_cfg in commit 8af15365a368
> ("ARM: dts: Configure interconnect target module for dra7 sata").
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus
      commit: 08272ce1de633bc99342ac1b7a1bb69172058dc0

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


