Return-Path: <stable+bounces-52668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610490CB91
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1791F23824
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB81823B8;
	Tue, 18 Jun 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGSSo+mq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7160B96;
	Tue, 18 Jun 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713388; cv=none; b=jrbuQBEmoIyMP6N6pa2GZ55/UBkp8bI90QuFhi6AZW2e4wMiPShf8z5VaDb1sGbTh2wmmGWs1YNpFnQQ2dMrkmyyxm4kfJSq997x3eK+VT+pFtY4lF8rn5nQcDogZNzfRtZMq6gq3/Z0YSOdmNDZgppeYRJXzpJaOJuZYV5EmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713388; c=relaxed/simple;
	bh=LuMwyYgyDxysw8Rw+PoOzbWoqG0XXzZDNePFORWTuVY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=czKCMYAC2spSiMVzWgo0M1bx9to544ohWfp+Hg2tPuOdOSJS2L2aQ0jgovkyomPrMFahKGoE7b8avdBllJGVar+/iAqN6OIbuF1eeOXBhLFqahca0h73hMvKdNTFt6+IESq1wK0smsTYqvVTLqL6/Jz/QiBEuTaUOa/f4MnPOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGSSo+mq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7041ed475acso4160805b3a.2;
        Tue, 18 Jun 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718713386; x=1719318186; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3Y+AQGEe1ND3YEhhuT8pC8j4tmW0FR/liD7uiOkiX0=;
        b=KGSSo+mqpljG4z4u+t3fMHlLqxw9GOG9tEhtEeXmnOZFcERA+ehWjQYbbe+3JF3P0k
         eZBSC1A89T6+wvpLHd4YUujevPPdZf4I9/dujh5dYa9D+nUjhoLkKPjNm2p/DsfhGhW/
         4+oESTq+byGHWDkY0qZypH2YRXHVR2aSeSZgZuAffsRyW4MDbpojuxBslMyq4pdiXx8j
         QFcoT34JXJarTUAAvSGP60mufkQ4Vw12MMovwKfdk5ptv2W+7uX6ZvJQ+bNuL9g7ztPb
         0za0i9m0nvgJlhR1ERcopdrt8cY/EQoGhKp6KYm0gmHrr0+HbV2M5C7Wpm8H8x/MN0bh
         qeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718713386; x=1719318186;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3Y+AQGEe1ND3YEhhuT8pC8j4tmW0FR/liD7uiOkiX0=;
        b=CyWbzpsPNNCEFa3ZBGwcwFsBydiKQkZThLJ0MQR2oAuhua8xrl+2CmAMmyU2K/bsge
         YN5pHUIR8K+k8Yh7xYCilZIS6u0CiMazeRqO9DvHXzl1teJITdYY8MUNvmM5993Tl019
         RJcb2WZxtDe7uoA0Ygmgm+lRveKwY+pcTKLz4ndabl+cJoGDGQ+yzxntfgaduBBo3MFr
         O+jebOUaW9+H6Rk5gk4AaShn/xvtqk+JBB7+pPk6G93QlMtXgWafR9tYBHYT4AL6qcIF
         f/jaUr52G38zLMdUTZlbC3sFNaH+OxcqYICzXzn8PoPyikLIVpB4dx1YfZ5timKnTg4j
         2PBw==
X-Forwarded-Encrypted: i=1; AJvYcCVDNmLIK7619TlPyR2eULKly0dUC8wCcz8KKPMHuFjKr0UtgB3LxZpE4F+V7DIlI1wed6/BJR81T0cS0S79nSJ1zhYLWoroS3pWAk6Mb2hm3hbk6z0h4dy0BY4aAgflA5bBIWa8
X-Gm-Message-State: AOJu0YyQhZZ9n+KBUPeOIYc56ppqHhyM8KOV7NwKP5LbZhmBARZbBco6
	20naC73aNK8+UZ/p1jqTMgeb0nuye3Cr9RvQe6aVQNlgCcq6keZj
X-Google-Smtp-Source: AGHT+IFo0n3JP6vd7Z5VKePqIAOWVyvJ+0/C0c/s6zem4qBNkRVStrrJCvdITocevV6+8dhLkMAccg==
X-Received: by 2002:a05:6a20:7f9e:b0:1b5:e718:7a15 with SMTP id adf61e73a8af0-1bae83dda9amr12492089637.62.1718713386204;
        Tue, 18 Jun 2024 05:23:06 -0700 (PDT)
Received: from localhost ([113.138.207.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7f3fdsm96254845ad.112.2024.06.18.05.23.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2024 05:23:05 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v5 1/1] usb: dwc3: core: Workaround for CSR read timeout
Date: Tue, 18 Jun 2024 20:22:58 +0800
Message-Id: <20240618122258.3713-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
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
v4 -> v5: no change
v3 -> v4: modify commit message, add Cc: stable@vger.kernel.org
v2 -> v3:
- code refactor
- modify comment, add STAR number, workaround applied in host mode
- modify commit message, add STAR number, workaround applied in host mode
- modify Author Jos Wang
v1 -> v2: no change

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


