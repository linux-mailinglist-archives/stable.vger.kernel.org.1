Return-Path: <stable+bounces-160248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D82AF9F40
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F8858440C
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBA28AAE0;
	Sat,  5 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgIuvCXK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EE27CB31
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751705541; cv=none; b=Vm+dqXE+p4hxCnLwe5DKPFZ67sWuNo5dhdE86DZAbYZ2Mxn4H+zC3wVGVtyYNa3Pli15Z294mouktQeMmf4i/wfc1SzAGro3h7zWwTXj5YojsWoc3+ILTAxUzE0ihqepp2vKlYCkTn2Z/hYeM8Tf/jDXdhKzsiRXr+LEecM6uN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751705541; c=relaxed/simple;
	bh=OH6Donon7lVbQXTIs6DE02Wj3iwK0njDFmZpSCw8VmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=clx2IlQkZxYwdBxK2vYJJmMDoOpex/c04pCyaj4SxkfoMhha7aoH5eTdKAOOpkAEF5jtWTDWkN+uRAY7TBclOZ9aFksHeEOk711S71aY0cSdFzv5Z6Z1xEFAwDcOklP0KWeCTSIz/PQYSS4hqYurglC53t9LSZ5WxLNcXtVI/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hgIuvCXK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so73201f8f.0
        for <stable@vger.kernel.org>; Sat, 05 Jul 2025 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751705538; x=1752310338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqxTDa4DhWJhcXAPACl5qTQfjpblrskBrbY4onevVXk=;
        b=hgIuvCXKVHYG0my7u6/DouDrseLTgO+Y5BWNOK3NGFHbnExAYNDuDwPafr5v3/SR9s
         fI/5avROlcemnCLixbt7QXcvF7Yn7Ts+pvAzEOucivXHOIHO+zSYIrzgO6tG+/JTvK8j
         66ne97E6QMDU5DnluuFFz2+5TD/47CJ57qcmpLLTX2Vunf6BkErefXOiEmAsqkZUxGyd
         7r+FcVeSPs+GJ2n2Ns67e+mQr4UxupgZFknYFCXlkH1K0OdEETkoHjyrsjgoisewmMxP
         DfXFxqrhDDARjjWGdaYhZrGVyPCBm/mxLg9XQAoEthJAnRwGkVCZkJXTpgf0lZZ2nidG
         hPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751705538; x=1752310338;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqxTDa4DhWJhcXAPACl5qTQfjpblrskBrbY4onevVXk=;
        b=kflvPmKwtH83EJ3Lf5IsHf2refjXO/kH3/wGaygiO40/nBh0prMEsFa/BM8IzhNlX0
         1/lq1g4hBbHhgQEbRjz/0maMm/1Qq1xS8t046an5SgCsVi/NgQmyk6B0y/ZGGauQ6Koz
         06qQgQmAcF+WsXSfRtDX8/SYsFXmQrTqhpab8/MvALgfcdFXr8HIQPZ1/PAKbI2DSXjv
         VCwg70+NpLi4MilXQpuYNP4gCYtNU2A8WvCdolVAI2eBMg8zWwSW1xmplF/4O+BqrJsy
         zLK8Fju3tSWBR/susN5Vh62kOq9xeARlZyWS08U1RNzQxjWl0T4fUJ7Zvb3k1UMXTNjw
         NfcA==
X-Forwarded-Encrypted: i=1; AJvYcCV+KHfknVyYS5HDVw/r3jKf8jFTVz4oF0UklStEZjstj4Q3k95TTiVs9keIDqkivPbouDM9888=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCT95b4itLabsOOfVQDDFoxAPWMagyJTpbeS+xE2+AURqZrdg
	XZb02Vgn/Jfb28flx43BStyhL6ypGag827Y9kW+yg40Xgc6UVBjuOuYVZ203NPEe+gC1pjuE8wG
	BDEVQ
X-Gm-Gg: ASbGncskElNhJ5BdvLM8j779P/JwrrKliBJ13cbYt/GohXdvDyYUnWxCkn+ufmTKbwf
	DgZgBWCCLJmAjdrQFt505Pm9+vi73tpwSU9cUY4pGnQeXsdPvPfFJB8zmw5hPXImlrNiC8oct+l
	VEhOXeSgF0pNLjaVPluzhf0geH1KwGIVBuk/TkAOrsrpIWU7HmSxW4+2u1/QU8noSrMZjTGotKj
	NgA+8y+H5Jf6zD1S0Dc+2WmRgVnROGwmzFU9L/p8kUPl7GxKTlnqdQMPiNVwBgUF3/793KAqbu6
	dEc2TPsxstTTDQN5xgKtomaNgYHNM2vBZcppk33wg2JhMmWsSAIWE5K9PBdT8DShJhZCjSTJxO/
	a
X-Google-Smtp-Source: AGHT+IElwpP/DQng7j4Oje4er7qQ/M9/KObJu58P5AwQY+utyeAiG9MFQncSMbCXC18YqE2yzss9aw==
X-Received: by 2002:a5d:5848:0:b0:3a4:eeeb:7e79 with SMTP id ffacd0b85a97d-3b496606062mr1737174f8f.12.1751705537562;
        Sat, 05 Jul 2025 01:52:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0af7sm4644670f8f.35.2025.07.05.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 01:52:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
References: <20250626-exynos7870-dts-fixes-v1-0-349987874d9a@disroot.org>
Subject: Re: [PATCH 0/3] Various devicetree fixes for Exynos7870 devices
Message-Id: <175170553635.13627.13202029423234330131.b4-ty@linaro.org>
Date: Sat, 05 Jul 2025 10:52:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 26 Jun 2025 13:02:55 +0530, Kaustabh Chakraborty wrote:
> This patch series introduces a few minor fixes on Exynos7870 devices.
> These fix USB gadget problems and serious crashes on certain variants of
> devices. More information is provided in respective commits.
> 
> This series has no dependencies. Would be nice to get them merged in
> 6.16 itself. I assume it's okay to cc stable as the -rc releases are
> also owned by the "Stable Group" in git.kernel.org... [1] [2]
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos7870: add quirk to disable USB2 LPM in gadget mode
      https://git.kernel.org/krzk/linux/c/e9355e894aebcbeacffd284644749190cc5f33a4
[2/3] arm64: dts: exynos7870-on7xelte: reduce memory ranges to base amount
      https://git.kernel.org/krzk/linux/c/2bdfa35a7bb6e3a319e7a290baa44720bc96e5e4
[3/3] arm64: dts: exynos7870-j6lte: reduce memory ranges to base amount
      https://git.kernel.org/krzk/linux/c/49a27c6c392dec46c826ee586f7ec8973acaeed7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


