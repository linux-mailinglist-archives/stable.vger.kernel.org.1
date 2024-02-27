Return-Path: <stable+bounces-24111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203D8692B0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D1228F4A8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4A13F007;
	Tue, 27 Feb 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+wICRVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F513EFE4;
	Tue, 27 Feb 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041063; cv=none; b=CokqiJDlzhjJGjhrwn42cuoNg6xfzfZKD0+1pvy5Ce3B0sIAjNw7u7TFCiHKpQx3Z6fR7GdqSWajv4jiMhJ8v9Z4a7YylCc2U6NxJe39zyOHLOSX6gsg2XypNleiFOsRUGQaZnyM2jL0AtB6aGXGe4XZlDZMyu7x8CwQL2xM5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041063; c=relaxed/simple;
	bh=KJMpjgXQ7CiP4KvpXOvjCyFMJHJjMlBTy2N1t9tpbJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtONiFfr8CvUrefD3cBuMgZZHo/CqCX7DLqtgz2NyYwAhO4B3W4ZehlkEb/KvIrXAkxbZc0NhPT7DTvj7XmkhaD/q6NwcNtcuvPrOXEGBi+/2NE4UdHog2oB+Xzfpyiyzatdr1HEnItRG40tgp2SbpAC18rKL/W+UILgkUuTgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+wICRVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFC9C433B1;
	Tue, 27 Feb 2024 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041063;
	bh=KJMpjgXQ7CiP4KvpXOvjCyFMJHJjMlBTy2N1t9tpbJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0+wICRVMg7oAtaB2L+SL2/lye2Jh3a46EhSgeLrbDByW2hQhtFCAXhilTkBEQBMqu
	 AS57M0utIM7px9YCMNxvWMViuJbLrszf0MQegOwLuEuymX4/7hZWjCTuN81tOHl3YS
	 aiQh8w7YJM9n4To6Q/SmRwmE2jmWyzvvmxxhl1GA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 6.7 206/334] usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers
Date: Tue, 27 Feb 2024 14:21:04 +0100
Message-ID: <20240227131637.412481698@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 47625b018c6bc788bc10dd654c82696eb0a5ef11 upstream.

Cadence have several controllers from 0x000403xx family but current
driver suuport detecting only one with DID equal 0x0004034E.
It causes that if someone uses different CDNSP controller then driver
will use incorrect version and register space.
Patch fix this issue.

cc: stable@vger.kernel.org
Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Link: https://lore.kernel.org/r/20240215121609.259772-1-pawell@cadence.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/core.c |    1 -
 drivers/usb/cdns3/drd.c  |   13 +++++++++----
 drivers/usb/cdns3/drd.h  |    6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -395,7 +395,6 @@ pm_put:
 	return ret;
 }
 
-
 /**
  * cdns_wakeup_irq - interrupt handler for wakeup events
  * @irq: irq number for cdns3/cdnsp core device
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -156,7 +156,8 @@ bool cdns_is_device(struct cdns *cdns)
  */
 static void cdns_otg_disable_irq(struct cdns *cdns)
 {
-	writel(0, &cdns->otg_irq_regs->ien);
+	if (cdns->version)
+		writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -422,15 +423,20 @@ int cdns_drd_init(struct cdns *cdns)
 
 		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
 
-		if (readl(&cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
+		state = readl(&cdns->otg_cdnsp_regs->did);
+
+		if (OTG_CDNSP_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_cdnsp_regs->ien;
 			cdns->version  = CDNSP_CONTROLLER_V2;
-		} else {
+		} else if (OTG_CDNS3_CHECK_DID(state)) {
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
+		} else {
+			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
+			return -EINVAL;
 		}
 
 		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
@@ -483,7 +489,6 @@ int cdns_drd_exit(struct cdns *cdns)
 	return 0;
 }
 
-
 /* Indicate the cdns3 core was power lost before */
 bool cdns_power_is_lost(struct cdns *cdns)
 {
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -79,7 +79,11 @@ struct cdnsp_otg_regs {
 	__le32 susp_timing_ctrl;
 };
 
-#define OTG_CDNSP_DID	0x0004034E
+/* CDNSP driver supports 0x000403xx Cadence USB controller family. */
+#define OTG_CDNSP_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040300)
+
+/* CDNS3 driver supports 0x000402xx Cadence USB controller family. */
+#define OTG_CDNS3_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040200)
 
 /*
  * Common registers interface for both CDNS3 and CDNSP version of DRD.



