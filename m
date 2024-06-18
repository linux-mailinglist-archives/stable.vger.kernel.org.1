Return-Path: <stable+bounces-52814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE190CD87
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355EA1C213F7
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977C1B150B;
	Tue, 18 Jun 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+dXQw7T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B11B29BF;
	Tue, 18 Jun 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714563; cv=none; b=G9reV7SJqZ3PLj049y9Mza4ji63uCLKRV3LNV9YfqTss6A/OpNX1EmDZq4Bg/AX9VzA8jHNbZMp5mVUEmjftFvBv9iUVw5AbBdxOl7tEnl+Wb2WPKW1c3Zoof2IJLu1tLjisahbvV4f9sNL0lreIL/aayzedA2w2hQPgELs1hcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714563; c=relaxed/simple;
	bh=YFY+HjJitzBvcux3x//msWVLSC/kvQWZ9WefuLW/TRU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QgSIMFrtgOMEbaZn5j0a2/EPj/+y6MWj3M3tn96Jj9mYEJfDRgZcn71NibtXr3rQwemfOWg6e+23T+tI+0Y9RfuiFewrNQ4QF2kUCZbb8VUCkMxCEaazQhSCS/Px/2/AXI5BeObI3HlGJd4UE79F+1ZtumrWrkhWmpgoiKz1GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+dXQw7T; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso683736b3a.2;
        Tue, 18 Jun 2024 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718714560; x=1719319360; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5HudLGS8xpGOdXksJh80d3m6RgAVZta5JkAHQdvhSg=;
        b=c+dXQw7TrwzTH8W1Bz8YC9tAc9J3pMvVuKo+Uka0lTTDH2s0f3stPz7kJRQjjI9WTG
         bE7eCmrZsWTfqV6VsAF+iReDah6WuLOsRL3jn29kxG6hO9Z4uIhm4PH5uKYss+7Ics3F
         r4GiTy57usnTMLPaaFawewhd5+EXsG6nGHdXN0tkycnGJv42DK3ccV7+PF9+b/M7kpN5
         ZDVAFxDtpRS7B63resqt8mHoKyWquzYvq8mrJgzMKJgX5TtDVgGmUyoM+uEE7TMYPy+x
         FnNgKzM/14VTbsKa94qH8qfqtvUlDUzgjr87/ApRfw/h/+FG+/pzYApUhAPgQp28k8++
         N/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714560; x=1719319360;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5HudLGS8xpGOdXksJh80d3m6RgAVZta5JkAHQdvhSg=;
        b=s8/G+YU4GreCeXb8FgjdZEiBRCIOlG2bYkLISCN/uiBAdCmdaWPnfSJdYQPJCVSHpW
         yzyXoVF843iNwkKZtD4JPRojmbAne2aQkBDZYd3mLNCGmT2lBNjU2zq9DNkYPEh1F7jX
         0nsvu72nof9cwYgatVNDnmD26CXPjJ2yNSxEhC3IziG1HTehEU3jUSTDvONinnmUWeE+
         PzsQpaqfPsyZpBCwQtfuJyiFsHrSUHu6xetf7zqEs+6Ou/R6cr8+t4jABzLi24/O/IY+
         SxRYWGdN0AIBWS343a9+qA5z3sDJRPx5tLkQB6gHkYCpenpf67rRGCG400vQwWlsyZXV
         X/oA==
X-Forwarded-Encrypted: i=1; AJvYcCUUV7+Lp4WI21Hf4mGTUMq6+lls4Adw9hVYcQMJkOHTfxiqKgTG6igDIE4z6G3CstnOAheYMF9JPp84TIfu5CSs/wwo4TBlqz2tid9kqE3diLRWtmK/K+/d+DXTkY/1Aal78lYF
X-Gm-Message-State: AOJu0YyDiDT0HczU3AscN9mlRQkbuKMQcBIKKBfzReBQYlx1lh/69zh1
	LWpVq+3nWPcO7Ikna4L6+tmXrmDL/2VzD0bLtihrRPUWQhxuCa15
X-Google-Smtp-Source: AGHT+IFBLml7w5zlkpZKZS1zkZ/T8vrR86PFGYprdyoeL4gyHhlv3UPbh1XtqhPVoYG3Ha8HiHIlPw==
X-Received: by 2002:a05:6a21:1f24:b0:1b8:3ee2:bef1 with SMTP id adf61e73a8af0-1bae825984cmr12518482637.53.1718714560194;
        Tue, 18 Jun 2024 05:42:40 -0700 (PDT)
Received: from localhost ([113.138.207.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3e42fsm8898437b3a.100.2024.06.18.05.42.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2024 05:42:39 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v5] usb: dwc3: core: Workaround for CSR read timeout
Date: Tue, 18 Jun 2024 20:42:35 +0800
Message-Id: <20240618124235.5093-1-joswang1221@gmail.com>
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
index 7ee61a89520b..2a3adc80fe0f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -957,12 +957,16 @@ static bool dwc3_core_is_valid(struct dwc3 *dwc)
 
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
@@ -995,6 +999,20 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
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


