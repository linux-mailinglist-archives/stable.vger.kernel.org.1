Return-Path: <stable+bounces-50292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405F905727
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09F5282F2E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA55180A6A;
	Wed, 12 Jun 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TomE6Pe4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AB17B437;
	Wed, 12 Jun 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206770; cv=none; b=C20MzzUoGVGJSpZFs6XoayGX6Y2t/m1vh25XJVy6zByK1f+O8wAnsssB2P505I2WJRObNZQsCuG2dj1JFCxCK0j/Sq0HlncTcrFudb/ZtTULM0lCdf30MiFSZia1i1kpTHOBb7UcCLYVNY+6R0wnNo8tDWn0cywVZsqAGiIekIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206770; c=relaxed/simple;
	bh=dkjw2ohFiXCup80T4CFjYApo4cuECd+cmHE4G40BA1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K7exRDGEzVIXqHmZROBiIY/rygz3gAMKvhAXYvw8VZ4BfBs5j9oOCYgNdDWwMpVYIw9R9Icl4DnLlcpJel4AsM5APLCWfWB5I5QvDspf4N4NJjSBeQF0Y+PQrVqTp3vtThO1XVfOQ0wFW7tGIfKNo6ZXvntSlE85IWP5+Zt0gAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TomE6Pe4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-704090c11easo5540996b3a.2;
        Wed, 12 Jun 2024 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718206768; x=1718811568; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a5i7zUeG4PPBp0qWV+Ep+ZL6qU5kaVlXsxN+qELW5E4=;
        b=TomE6Pe4Eb0OP0TCEHy53eMPTCH1L08wHp3/UlO90b8AGmJAqU7p253l9Sts/FZkpG
         V6+erUIL6QgekCKp3j6LIk6xwmKN8kppQVGZuH/kyzyyQD89KgraRv5YG5ptioyTmt5B
         Qy+dQwbCY0V96KCoeqPCZ/ctrflUc334+AUc8LIKR3BP1p4m4vYPEblsc9ayRE7Lsiij
         ZsBZL6md6IL1fRDhPpu03T9INGMpaHIzwKZcAJhhX+vPx7FOaJmq40Vy04QAHVnKl0hM
         oh43Nwk5sKjDh79y8kKhA96ybdMsLYYMBoxKJaz2rsEQEEsnDigWZA4DyDX3grXlKwSC
         0i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206768; x=1718811568;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5i7zUeG4PPBp0qWV+Ep+ZL6qU5kaVlXsxN+qELW5E4=;
        b=MJx9z/mjxltAgnvqsysBmliA8u7UeuZlXqOqQM3MJ5Jpv/bzIpp1SQgV8TGV5+VYzF
         TcxWSGv1iTKzuaXKuxtv6S2nn/HmdPcXHw5cvR/WmA4NHr9HL0uyKFjmtVZtb3xlBYKz
         c38d2B2Jf9dhaJGJrrOVtJjj/OmA3oZF4SdE8o9Xyk+3wZEEb2dq946Wi7QI+XWf5d2h
         G164U9aQ/QFvE5vcWVYHeIL3bxr892ER9sbJ0mn6ZQWLguzdoRl4H9BSOTaFgSdPyxhm
         YLNrRKpKxJ0YyVsweq8m4VI19TGD9KHFmujhscCKWo8in6rLWpCXbPn5EurWHZW6P3uC
         R1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVNjFtkR0uQIdFkJsJNeDVMh+5IM8f02gR7bSdEPgTfVPBVHy3khebx7LK94qVG91VVBSo/gGN0aWxOyNJSYm69PeaQdXSYFzsZ/5A7IqrFgNgKgv+cmAvClXsxpPaM9/XPC5MmrIUfcLVU5DUx83WgEQcz5p3PPB3EuCaVU0Kn
X-Gm-Message-State: AOJu0YwmDmpuoj6KAtHZ2Wz7Y8pRzE3osTZ33daqelcViJyizQy8HVFF
	vmK/vbIdk0bvlNiuovDHD7lL0JCPvAS+2hUkHNqBVERDAHygb8Y3EZ3kmztqN4WHHw==
X-Google-Smtp-Source: AGHT+IG5lHab+fHfgF23kgv84wra3o3xRcQiRCRLO0Hjiemm/oKJqu5T5xBuAbkAPUeZHsR2REDBzg==
X-Received: by 2002:a05:6a20:2584:b0:1b4:e956:ae64 with SMTP id adf61e73a8af0-1b8a9c87755mr2628969637.54.1718206768211;
        Wed, 12 Jun 2024 08:39:28 -0700 (PDT)
Received: from localhost ([113.143.197.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee3f30e7sm89342385ad.173.2024.06.12.08.39.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 08:39:27 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Date: Wed, 12 Jun 2024 23:39:22 +0800
Message-Id: <20240612153922.2531-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

This is a workaround for STAR 4846132, which only affects
DWC_usb31 version2.00a operating in host mode.

There is a problem in DWC_usb31 version 2.00a operating
in host mode that would cause a CSR read timeout When CSR
read coincides with RAM Clock Gating Entry. By disable
Clock Gating, sacrificing power consumption for normal
operation.

Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v1 -> v2:
- add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
  this patch does not make any changes
v2 -> v3:
- code refactor
- modify comment, add STAR number, workaround applied in host mode
- modify commit message, add STAR number, workaround applied in host mode
- modify Author Jos Wang
v3 -> v4:
- modify commit message, add Cc: stable@vger.kernel.org
---
 drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a8fbc2d6b99..61f858f64e5a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -960,12 +960,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
+	unsigned int power_opt;
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~DWC3_GCTL_SCALEDOWN_MASK;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	power_opt = DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1);
 
-	switch (DWC3_GHWPARAMS1_EN_PWROPT(dwc->hwparams.hwparams1)) {
+	switch (power_opt) {
 	case DWC3_GHWPARAMS1_EN_PWROPT_CLK:
 		/**
 		 * WORKAROUND: DWC3 revisions between 2.10a and 2.50a have an
@@ -998,6 +1002,20 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 		break;
 	}
 
+	/*
+	 * This is a workaround for STAR#4846132, which only affects
+	 * DWC_usb31 version2.00a operating in host mode.
+	 *
+	 * There is a problem in DWC_usb31 version 2.00a operating
+	 * in host mode that would cause a CSR read timeout When CSR
+	 * read coincides with RAM Clock Gating Entry. By disable
+	 * Clock Gating, sacrificing power consumption for normal
+	 * operation.
+	 */
+	if (power_opt != DWC3_GHWPARAMS1_EN_PWROPT_NO &&
+	    hw_mode != DWC3_GHWPARAMS0_MODE_GADGET && DWC3_VER_IS(DWC31, 200A))
+		reg |= DWC3_GCTL_DSBLCLKGTNG;
+
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
 		dev_info(dwc->dev, "Running with FPGA optimizations\n");
-- 
2.17.1


