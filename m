Return-Path: <stable+bounces-134880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD9A956CE
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4937A8295
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54821EA7CF;
	Mon, 21 Apr 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hndL5uEk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459764C92
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745264490; cv=none; b=D3GSW/IBtMCFyQXXQWt09HwJzzw4c1R8Q9sk1EvPbSIbF6Uff+WPBnk2x1uBfZUUvTF9XpDZpVi+uX5DBy0O8q8RRL4UHA64mlfjbLBsnMm9hldyIrJv3NE4MkX0+WC/VV3Y2O0bOzVEL9JZ7eZWDKfaBN2GmUbe1M0pzb+LntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745264490; c=relaxed/simple;
	bh=fK5w7a/nfm8lT+5m5rJSp+o844kUhsXaL8VV1B3osCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lz9OikaHk6qmTZlQo8Skja7+utdZ8c8Io+THgJ57WGvh1+QX+jDw2EamWLE6xf+ZMgFWPG9xUumU3dzuorQGoWpxwgS9A2+sRNos1PIIwPCH9JPU/UIhRWZsCDIE3/XETwhdTKoXdDsD8MPB4VCKi7Kz5CYxorM8tLF5lW/aji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hndL5uEk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54af20849bbso4712475e87.0
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745264486; x=1745869286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jcldhbCN+P1wGPEV1Q31PbY34kSfRdDRYgU2LfCBVw=;
        b=hndL5uEkDvp4c8Ra2Xr9u7jIJIRtqh4MXgtD6/RIE20LzdT8IWb1djKNfhCbXaF1bv
         TDQfoOci37T7Cq0vkt0r1HKARxsNT/vrrvPU+CsFdaypAv7+dmJfRUsZyTqCQqCDu13G
         18BZMY2tABmzGK0Jhp3qZZLUYf+HV7zHuxKmCOfRj0NKITd1u0LyHbyJYvlVG1uiK5w5
         zlxIRSrf1XeOIOBAvpN6vRiSrvcB5YVND3kwxrWERA489SmXUIINwzWWJNbzJYNAyssY
         26Tmqh5wSFF+gPrLymUNw7FeUkAGlz3iAoW/6CDoZqL8ebau28pdFzwvMdfVYkD0HiNz
         TUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745264486; x=1745869286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jcldhbCN+P1wGPEV1Q31PbY34kSfRdDRYgU2LfCBVw=;
        b=B903lBVH2hrtyTGDrJTqQMdNMxhblIv/aW4FTiHDaRQPRKD32VPyoxsIyudtcziz/w
         YhIRQLDXVHyqZULCWXMRFv9UFunaptXXiUg7VbD/DK6yx4Obqy4vnbuoVJfFYpDcsvv2
         3RHNRkj+B0La2QY04rJ5kyHziJ34f9LTvSTzC01eHKGlNygJaPYZOrGRwzQEiQbHFBaX
         aV7MHUi6wqmiLBWPrjhSPamSvb9Wa9PufxW4cjvOAzxyzg6h75mtudifmVFv6brHLWrC
         oVKsYvnje1U4m3seA1opsS8d8m9nVnJfjvfd8b9KoWfIhq5hkaLm6uqwzifc6boem4C9
         PzjA==
X-Gm-Message-State: AOJu0YwFMnYZ+WmqVKsCJbv1OIcRLP/PZ/slsQO4HhoCKBTEb194+av6
	LMFCBqutJ+Ioo2xWupleWHb+sYD8r0XO4/9x5CUPYvM1pw2t9uqX829Gy0bQGKI=
X-Gm-Gg: ASbGncsJSYGeXEo/N8JG39/3cZLfamirOBVhKD5kahnk2cCCBc1TXhUkr70SWHYUQrm
	HZAc188Nw4tbr9IlER5TO4gOpOtfKYX14YLb+xju913yOYgV+kgKflRjrkqKUDmNMBQGfEi3vLn
	t7q4RkmPd8cubkr0xr9QW+MWod0ZC6tAXE0zHeV6wZs9ynM226V+QzSMZcquZtT+RlKPNX39fG/
	DK21rvTw4ITHpKNVcSdXEIceHpAvVpp2Psre3AG0uNJjPJJBExqF66AQoUYYv8Y/bks6ArPKEj2
	1IclG/X3ueLjWqgYvARSSJiW4o6z//lhNLQnsZ1oz6OVTHxSI4BQ30+j+34WrTx6mA==
X-Google-Smtp-Source: AGHT+IEbYG49W1tkTM2LwW5H/zF5vnbcXwgfgWMbXndvzGEn6RGKJcbLWr0pTrXGOYvAO2aiaxtGFg==
X-Received: by 2002:a05:6512:e94:b0:549:b10b:1efe with SMTP id 2adb3069b0e04-54d6e6372e1mr3624539e87.32.1745264485844;
        Mon, 21 Apr 2025 12:41:25 -0700 (PDT)
Received: from localhost.localdomain ([87.249.25.136])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e540c77sm1005275e87.59.2025.04.21.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 12:41:25 -0700 (PDT)
From: Evgeny Pimenov <pimenoveu12@gmail.com>
To: stable@vger.kernel.org
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 6.1.y] ASoC: qcom: Fix sc7280 lpass potential buffer overflow
Date: Mon, 21 Apr 2025 22:37:34 +0300
Message-Id: <20250421193733.46275-1-pimenoveu12@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025042138-spherical-reabsorb-d6da@gregkh>
References: <2025042138-spherical-reabsorb-d6da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Case values introduced in commit
5f78e1fb7a3e ("ASoC: qcom: Add driver support for audioreach solution")
cause out of bounds access in arrays of sc7280 driver data (e.g. in case
of RX_CODEC_DMA_RX_0 in sc7280_snd_hw_params()).

Redefine LPASS_MAX_PORTS to consider the maximum possible port id for
q6dsp as sc7280 driver utilizes some of those values.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 77d0ffef793d ("ASoC: qcom: Add macro for lpass DAI id's max limit")
Cc: stable@vger.kernel.org # v6.0+
Suggested-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Suggested-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Evgeny Pimenov <pimenoveu12@gmail.com>
---
 sound/soc/qcom/lpass.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index b96116ea8116..68594b108e0e 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -17,7 +17,7 @@
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_PORTS			(DISPLAY_PORT_RX_7 + 1)
+#define LPASS_MAX_PORTS			(QUINARY_MI2S_TX + 1)
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
-- 
2.39.5


