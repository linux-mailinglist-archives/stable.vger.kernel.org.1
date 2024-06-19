Return-Path: <stable+bounces-53835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ECE90E9FE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962A9B24710
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB213C3CC;
	Wed, 19 Jun 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eywfknMA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F64D9EA;
	Wed, 19 Jun 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797538; cv=none; b=onNKO3Wnd7DgagsLvyOL78PCa9tQRKt1RZA+BdpV8Hatz2ftZep9W4R02Pdl+cZXoIDHCuBZQvtRgb7323jGOdnoYVV1ZPQkbRkV7W0vXkaIxjrv/j+uT9UhuUrJ6kx9IXnOCfP1duCG31An0IB8fWZm0k4exDJ4gU0G/uYewjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797538; c=relaxed/simple;
	bh=Usvplw09fKGsiiZLQgQdUOgT28EarqXCW9vrxYLVTA8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PcTFtXLr5Z3nuLMX9xGr66zvU7i0VOl3RmEgAHXv0GVw28DDIQIVtgoYu6vmKcLre69+3ut+zi8Mc6PjH0EjHIP4dT5I85hzJUkuovWBR/ziikiRuGqbwS6sUhFm3xCAKtut6Qw2siHZBIv55RJni9gEsD8IGqAW9ULIA6Fn5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eywfknMA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70631cd9e50so574207b3a.0;
        Wed, 19 Jun 2024 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718797537; x=1719402337; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/egwFMW9iKkFo/t7oosvjBn/QaAi+HmJdK9Q0QwYE2U=;
        b=eywfknMA3HryB2NrDHClsl4wm/9s6KmCKIUroCDOPCOO64vAttG2WBBlDMTsALEwui
         23mjZNDcvfhCyPHLPX2+NN8dHzz0MrROnquHH44SM+fEv98LzQOdgatow+jcBK1erDTX
         3fb6M7wMZWpcDZ5qLtj89o3GZzeu+WHTUG+YO80k8sMUYpeNGgCxy09tNVbucHvUYopL
         ztBS7qVg5RJBbcas+1D3EQh88n1+lx6a5JVPQtVlOk3DahZBryW49cZdSOttLWLPm2hq
         DVZhmUiIXj9LumLpAZAselWCK7YDtdrrD4yUjmQSxmDsjil1KVugJXqMN7LBrYXfhxFC
         DPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718797537; x=1719402337;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/egwFMW9iKkFo/t7oosvjBn/QaAi+HmJdK9Q0QwYE2U=;
        b=D3Fe0u6kVk5CY3Ier/245ykvxF/esSsz1vlRwhUV7t1OyebYUv9PxKAcHdhu405zm/
         Rkc3QwjAZtdAkizBqdKdDenCwx6wilSXfJM1O7oe8BB/Dbf/r1ScCvh+AZCtIK1I6hqN
         qJQHxLht3UMkmT1rGtW8mjMVWYMNtfF/EK8VXVxSpbA0GtqdrQyvJhE2VsiRSpU82fkc
         ukcr4jOkMYeYHOXfvthhYXkCSsiIRFDPVAkkz1jtb3sxSDTmyn+AMs9dkZ4a0OSzYJfM
         HL2dvKEmOUFr+ic4BpKaAiz/hgNHjcwpYr2Vg0tmrlfD+O3fmw9NFWkTWegOUhgL5jTf
         zp9w==
X-Forwarded-Encrypted: i=1; AJvYcCXl5JHadljukGy7Jz5jm7RYpaqo34eWRxVwpmr8xslH/WSQG68/pXHw8YTH4DCPV1FXk3bm1NAqZDXtrqfnL2aFFMRICYww1EEbGQCaTQCq0K0YRvarkOdYZawECxH4CRVA8yat4LsrU7+gkCUtxOUBQPFS6ZgAu/p7t7oJoSL4
X-Gm-Message-State: AOJu0YwKwvAutCugLli/3zScIgMcUaATLBU5Pelwn+Wl32sh9RBQLs9A
	0A76vVpZK6I1vyJaq5A/9zvV6+5ElvRxBG0B4+oQoiQgxaO3+37s
X-Google-Smtp-Source: AGHT+IGbYE0P42a31u/M1euoiEULjX6DmH/HCkACr7Q5xp0iP+rAn4Ie1AQxtDMQVZG4EODtjmHkCA==
X-Received: by 2002:a05:6a00:cc1:b0:706:2bd4:a68a with SMTP id d2e1a72fcca58-7062bd4a764mr2179308b3a.10.1718797536655;
        Wed, 19 Jun 2024 04:45:36 -0700 (PDT)
Received: from localhost ([113.135.243.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6dfcasm10858845b3a.172.2024.06.19.04.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2024 04:45:36 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Date: Wed, 19 Jun 2024 19:45:29 +0800
Message-Id: <20240619114529.3441-1-joswang1221@gmail.com>
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
v6 -> v7: code no change. Just add the v4->v5 and v5->v6
 version difference description
v5 -> v6: code no change. however, there were two v5
 patches, which confused the reviewers, so a v6 version
 was submitted.
v4 -> v5: code no change. Patches "1/3" and "2/3" of the
 patch series are under review, this patch is submitted
 independently.
v3 -> v4: modify commit message, add Cc: stable@vger.kernel.org
v2 -> v3:
- code refactor
- modify comment, add STAR number, workaround applied in host mode
- modify commit message, add STAR number, workaround applied in host mode
- modify Author Jos Wang
v1 -> v2: code no change. Add other case patches to the patch series

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


