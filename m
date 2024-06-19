Return-Path: <stable+bounces-53682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD990E27D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 07:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923DF28471A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 05:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D47C381BD;
	Wed, 19 Jun 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4h0FgCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780552139D1;
	Wed, 19 Jun 2024 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773294; cv=none; b=lNAWPyhxuZl3ykPdVurjpIi0H7Q3VaJoJCKn119uBcjZxUTDDARigyTOX7sd3yNer2BX21FjbWujxyJxtc/cNLysUw9L+ht2Uq50hIpThdbknagI+qjx9JQN/IfKFz5dhLb02Lht6J94jz6gy0jfcbE6K4kiS8E8BfiITuWWp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773294; c=relaxed/simple;
	bh=zFdAqXFXTUQ0aIfW22Ko1WwP3Y0YrMAgFExEN9J1mTQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MAkmIjgXvc6mvhrSrRU/aqk9m2hVwnqhaZgaqANarnlFVPvzMSdDkTtMXxjGOYhd4Vq69VZsmkHI51b+c6IVcf9uUdRsDnXaMazL47u+BkbcSNP7bB+JBL1LWsubr5aTgb+KqQOsO/5+ho7m7zSg0PMy6swwKMPJGzzXNLtE5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4h0FgCZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-70b2421471aso2023569a12.0;
        Tue, 18 Jun 2024 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718773293; x=1719378093; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYBJhtOHvaDA8eM12oS44Lu+CwfEJ2j3GitQFmscezA=;
        b=J4h0FgCZc3FrKkPGgeXTsY+FnWXiRpTlnd8OYzqCL0ej8RtsrFOxSoUq+EO8NV3gQu
         22hOvlL6o/17naRyAoUWiVIW0EDL4fhkKGFdOhwGBp9lmMnRAJNE586CSZ29Er8PoIOL
         cxRsHz1tGKxGexgG8p+9JJ8BWhXomj3/yhQ+BifBFiOz5+UwJQNbHUxpBhMcyEUtGdO9
         JoCV/h13zGhzooc+89NdON07vZUvPSLpLqOY4gebpAsqaYWjIdIjEzsnVFiRb/uXKbNd
         l8uYEU9PkwFU8lrwNWt0tnxKlL9uj79rXMVukw8xGApWdumQ5JQFSsOsXFsdh4qggZhM
         GHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718773293; x=1719378093;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYBJhtOHvaDA8eM12oS44Lu+CwfEJ2j3GitQFmscezA=;
        b=i0VWoU79m8O3KgwNEIYJm95L3K8kPfzDNilaM7kurn72m4aLZcp/paBJo0AyJ8QZIb
         vOa/kYXuUIf3TjhKxYd6w488TACHCrmz0RmXETIR06LRGhI+E2P+vCuyaJZGHaG+ghTr
         KnbjTDiRcBBq/Eni4fl01P2EPVWqpD3NrCcJJ4JPg8hvK/MeX1VnRtRc7eDCfvUgG/RG
         yEzfNta48iRE9pCP6g4xXI4ig7QqaCuRyGEhjVlUPrp9XMNRSZclCCpDZXbueN8cdngj
         5pVHKxLtLwjFiToDbBuI2yQjRu3n2RmZGlpF3XwjCvMOzWpeYcGJXo9koz3NRnbItx3K
         VajA==
X-Forwarded-Encrypted: i=1; AJvYcCUOw8GYpa+UFC75Bc4yqfZc+MJXuj6jFfwN3ZBKo5K/WV04enOxw1ki3xs6ZozC63yBl8fnSSd87GN3wuuarLpEA5VUOL+3fosaSaGa+edodwL7xA0HUgjpta5A4P1MRJBWMYXxr2pIy6MAFiOe2yb+5nTaqA+mUacpa2mxv4gi
X-Gm-Message-State: AOJu0YyuStWrfkUCI6ii/3m7URZG0mRByi/ekioSNE046cb+7DWTsVTX
	iBLQiQDmSjDaZqlsjdRlIDSJJo1irc2/PREj7twYt/DWuAaI7FeE
X-Google-Smtp-Source: AGHT+IFkXL3xC/pugZMVTZ/o/03T/sS5HqaQ8/QNy0jLGvPsjCGwXxyz3L800/AUb9FCz6M1qAWlhg==
X-Received: by 2002:a05:6a20:b712:b0:1b4:da55:e1ba with SMTP id adf61e73a8af0-1bcbb45208amr1469356637.9.1718773292703;
        Tue, 18 Jun 2024 22:01:32 -0700 (PDT)
Received: from localhost ([36.40.177.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb419a3sm9796126b3a.119.2024.06.18.22.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2024 22:01:32 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v6] usb: dwc3: core: Workaround for CSR read timeout
Date: Wed, 19 Jun 2024 13:01:25 +0800
Message-Id: <20240619050125.4444-1-joswang1221@gmail.com>
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
v5 -> v6: no change
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


