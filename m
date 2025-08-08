Return-Path: <stable+bounces-166836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613BCB1E8AD
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499DC189FCD7
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B827A44C;
	Fri,  8 Aug 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kJ05ffF2"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C53267F48
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657705; cv=none; b=nIO9Z9lOKrcmpnxQf/zFmGIb3HspNTa8zXH0d2audQQ3uAIcTTk2FsoQMITYtPXICnKqJLySCj4cGFiVya5kN77hyleCqplv1yWzCiGnzIy4ya0hTyAm4f4Ez01Yg82S29ud04sNbw2OU6gfSwkQzzhZUxd/6Xkxq7wLRi8DR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657705; c=relaxed/simple;
	bh=r/6JamcDOb+BB1QLDWY7RwWxRTnSYgsx4B6V9NUePbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=SH2wxRmKlihC5A7GLer+VLpznJ7U5tqgymFIo921ieU1+utZFQ/OP6aFV+HH6ylFNRWV98ilz3xDJ/Vgpbf1qxWL4122X05G2nexz4PN/83TdkCuPusNy7qdUDcths+Lnw1ou7gpjEW1svUltF1EtLLEUF7XNY38UpyJxhtvTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kJ05ffF2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250808125500epoutp0186334d2f1f28d6a77a2a8bb4ac6631ee~Zy_HgxCdi2801328013epoutp01l
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 12:55:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250808125500epoutp0186334d2f1f28d6a77a2a8bb4ac6631ee~Zy_HgxCdi2801328013epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754657700;
	bh=UMFSU8E6ZryWXDC3IWAiQpBNp2MS8aee30HaEz1fsXY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kJ05ffF2x8nqvf1qTBg3Lb2xVEuS6QcT6RliYjmGsWkrGZNfu9A+JCpVbDoMfeZuc
	 xySHS+/pOucHU6BNgOaEWxyHrSSbRSnhRBgbUXuuV2+roismGDjZ6aNKk10pNTA76D
	 /AeyPuMY15ta7WRrQbVKWe3A9hUyj+LVUYVpao8w=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250808125459epcas5p156c0da6a22a3930678f868e020ef0fe2~Zy_GVNzHK2015020150epcas5p1O;
	Fri,  8 Aug 2025 12:54:59 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bz3sG45hNz2SSKY; Fri,  8 Aug
	2025 12:54:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250808125457epcas5p111426353bf9a15dacfa217a9abff6374~Zy_EePGYI1891118911epcas5p1L;
	Fri,  8 Aug 2025 12:54:57 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250808125455epsmtip1a9ba6af23dd6253acf8f4ab8257d4ebb~Zy_CK5or81180811808epsmtip19;
	Fri,  8 Aug 2025 12:54:54 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de, balbi@ti.com, bigeasy@linutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Date: Fri,  8 Aug 2025 18:23:05 +0530
Message-ID: <20250808125315.1607-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250808125457epcas5p111426353bf9a15dacfa217a9abff6374
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250808125457epcas5p111426353bf9a15dacfa217a9abff6374
References: <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>

This commit addresses a rarely observed endpoint command timeout
which causes kernel panic due to warn when 'panic_on_warn' is enabled
and unnecessary call trace prints when 'panic_on_warn' is disabled.
It is seen during fast software-controlled connect/disconnect testcases.
The following is one such endpoint command timeout that we observed:

1. Connect
   =======
->dwc3_thread_interrupt
 ->dwc3_ep0_interrupt
  ->configfs_composite_setup
   ->composite_setup
    ->usb_ep_queue
     ->dwc3_gadget_ep0_queue
      ->__dwc3_gadget_ep0_queue
       ->__dwc3_ep0_do_control_data
        ->dwc3_send_gadget_ep_cmd

2. Disconnect
   ==========
->dwc3_thread_interrupt
 ->dwc3_gadget_disconnect_interrupt
  ->dwc3_ep0_reset_state
   ->dwc3_ep0_end_control_data
    ->dwc3_send_gadget_ep_cmd

In the issue scenario, in Exynos platforms, we observed that control
transfers for the previous connect have not yet been completed and end
transfer command sent as a part of the disconnect sequence and
processing of USB_ENDPOINT_HALT feature request from the host timeout.
This maybe an expected scenario since the controller is processing EP
commands sent as a part of the previous connect. It maybe better to
remove WARN_ON in all places where device endpoint commands are sent to
avoid unnecessary kernel panic due to warn.

Cc: stable@vger.kernel.org
Co-developed-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---

Changes in v3:
- Added Co-developed-by tags to reflect the correct authorship.
- And Added Acked-by tag as well.
Link to v2: https://lore.kernel.org/all/20250807014639.1596-1-selvarasu.g@samsung.com/

Changes in v2:
- Removed the 'Fixes' tag from the commit message, as this patch does
  not contain a fix.
- And Retained the 'stable' tag, as these changes are intended to be
  applied across all stable kernels.
- Additionally, replaced 'dev_warn*' with 'dev_err*'."
Link to v1: https://lore.kernel.org/all/20250807005638.thhsgjn73aaov2af@synopsys.com/
---
 drivers/usb/dwc3/ep0.c    | 20 ++++++++++++++++----
 drivers/usb/dwc3/gadget.c | 10 ++++++++--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..b4229aa13f37 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
+
 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
 		struct dwc3_ep *dwc3_ep;
 
@@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev,
+			"ep0 data phase start transfer failed: %d\n", ret);
 }
 
 static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
@@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	WARN_ON(dwc3_ep0_start_control_status(dep));
+	int	ret;
+
+	ret = dwc3_ep0_start_control_status(dep);
+	if (ret)
+		dev_err(dwc->dev,
+			"ep0 status phase start transfer failed: %d\n", ret);
 }
 
 static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
@@ -1121,7 +1130,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dev_err_ratelimited(dwc->dev,
+			"ep0 data phase end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4a3e97e606d1..4a3d076c1015 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1772,7 +1772,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return 0;
 	}
-	WARN_ON_ONCE(ret);
+
+	if (ret)
+		dev_err_ratelimited(dep->dwc->dev,
+				"end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 
 	if (!interrupt)
@@ -4039,7 +4043,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 		dep->flags &= ~DWC3_EP_STALL;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		WARN_ON_ONCE(ret);
+		if (ret)
+			dev_err_ratelimited(dwc->dev,
+				"failed to clear STALL on %s\n", dep->name);
 	}
 }
 
-- 
2.17.1


