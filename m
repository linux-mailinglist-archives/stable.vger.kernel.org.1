Return-Path: <stable+bounces-35187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3B8942CE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ED31C21E5E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE41481D1;
	Mon,  1 Apr 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPLC48rC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF1481B8;
	Mon,  1 Apr 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990583; cv=none; b=lPWfGGoJijUgaegGXcDXjRyM938+f1pruzLaR49wXUkV7YSP+BQO2ej7Iq3Ca6z7B0nSWt+tD7vF2+89s8u1jE64RP8aMR/KcVY2w8J3Qx/GqTQNd/2pD1YW4CJl9TLG4GiPD+4e9TGAxlKbd/MADdQnNRIWyu7IZQd/Cxb7ZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990583; c=relaxed/simple;
	bh=5iwVYqDYuGgEQhP1+mPLbinj1Qh5Zt3OZO06Sx7lc/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miWKxkOWRV/RfQREy7nMq8QimTWnCu82dExpbPH7doMlKOk0pFAcztOhSCwVXmwTUx0XxGhwGXnysmBvuoRb2wVcxmJtH3hMMOyR31qZZ1R0PCMLxnW7kPvNgK2CV6Aacdra+g9Yx4v29Pb19YrSzY8TUeH1XUVu11MziItNRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPLC48rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946AEC433C7;
	Mon,  1 Apr 2024 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990583;
	bh=5iwVYqDYuGgEQhP1+mPLbinj1Qh5Zt3OZO06Sx7lc/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPLC48rCTHGSQ+f9SdtCQ68vEJYXpALXHlcipb1kuE9kcZl7V2THAMEtrkkWV2wYN
	 /yPjS2yTgFHbcWNf3yhDkrTDjxP09TVfjf8jRA612CY6DQ5zdBLS2LBi9i4padWSbK
	 MEul0JwWk+6TjMhXDPtYUshxo48x5Ccn8c3T8/no=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: [PATCH 6.6 370/396] usb: dwc2: gadget: LPM flow fix
Date: Mon,  1 Apr 2024 17:46:59 +0200
Message-ID: <20240401152558.945559566@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>

commit 5d69a3b54e5a630c90d82a4c2bdce3d53dc78710 upstream.

Added functionality to exit from L1 state by device initiation
using remote wakeup signaling, in case when function driver queuing
request while core in L1 state.

Fixes: 273d576c4d41 ("usb: dwc2: gadget: Add functionality to exit from LPM L1 state")
Fixes: 88b02f2cb1e1 ("usb: dwc2: Add core state checking")
CC: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Link: https://lore.kernel.org/r/b4d9de5382375dddbf7ef6049d9a82066ad87d5d.1710166393.git.Minas.Harutyunyan@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.h      |    1 
 drivers/usb/dwc2/core_intr.c |   65 ++++++++++++++++++++++++++++---------------
 drivers/usb/dwc2/gadget.c    |    4 ++
 3 files changed, 48 insertions(+), 22 deletions(-)

--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1336,6 +1336,7 @@ int dwc2_backup_global_registers(struct
 int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg);
 
 void dwc2_enable_acg(struct dwc2_hsotg *hsotg);
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup);
 
 /* This function should be called on every hardware interrupt. */
 irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -323,10 +323,11 @@ static void dwc2_handle_session_req_intr
  * @hsotg: Programming view of DWC_otg controller
  *
  */
-static void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg)
+void dwc2_wakeup_from_lpm_l1(struct dwc2_hsotg *hsotg, bool remotewakeup)
 {
 	u32 glpmcfg;
-	u32 i = 0;
+	u32 pcgctl;
+	u32 dctl;
 
 	if (hsotg->lx_state != DWC2_L1) {
 		dev_err(hsotg->dev, "Core isn't in DWC2_L1 state\n");
@@ -335,37 +336,57 @@ static void dwc2_wakeup_from_lpm_l1(stru
 
 	glpmcfg = dwc2_readl(hsotg, GLPMCFG);
 	if (dwc2_is_device_mode(hsotg)) {
-		dev_dbg(hsotg->dev, "Exit from L1 state\n");
+		dev_dbg(hsotg->dev, "Exit from L1 state, remotewakeup=%d\n", remotewakeup);
 		glpmcfg &= ~GLPMCFG_ENBLSLPM;
-		glpmcfg &= ~GLPMCFG_HIRD_THRES_EN;
+		glpmcfg &= ~GLPMCFG_HIRD_THRES_MASK;
 		dwc2_writel(hsotg, glpmcfg, GLPMCFG);
 
-		do {
-			glpmcfg = dwc2_readl(hsotg, GLPMCFG);
-
-			if (!(glpmcfg & (GLPMCFG_COREL1RES_MASK |
-					 GLPMCFG_L1RESUMEOK | GLPMCFG_SLPSTS)))
-				break;
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
+		pcgctl &= ~PCGCTL_ENBL_SLEEP_GATING;
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
+
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_ENBESL) {
+			glpmcfg |= GLPMCFG_RSTRSLPSTS;
+			dwc2_writel(hsotg, glpmcfg, GLPMCFG);
+		}
 
-			udelay(1);
-		} while (++i < 200);
+		if (remotewakeup) {
+			if (dwc2_hsotg_wait_bit_set(hsotg, GLPMCFG, GLPMCFG_L1RESUMEOK, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GLPMCFG_L1RESUMEOK\n", __func__);
+				goto fail;
+				return;
+			}
+
+			dctl = dwc2_readl(hsotg, DCTL);
+			dctl |= DCTL_RMTWKUPSIG;
+			dwc2_writel(hsotg, dctl, DCTL);
+
+			if (dwc2_hsotg_wait_bit_set(hsotg, GINTSTS, GINTSTS_WKUPINT, 1000)) {
+				dev_warn(hsotg->dev, "%s: timeout GINTSTS_WKUPINT\n", __func__);
+				goto fail;
+				return;
+			}
+		}
 
-		if (i == 200) {
-			dev_err(hsotg->dev, "Failed to exit L1 sleep state in 200us.\n");
+		glpmcfg = dwc2_readl(hsotg, GLPMCFG);
+		if (glpmcfg & GLPMCFG_COREL1RES_MASK || glpmcfg & GLPMCFG_SLPSTS ||
+		    glpmcfg & GLPMCFG_L1RESUMEOK) {
+			goto fail;
 			return;
 		}
-		dwc2_gadget_init_lpm(hsotg);
+
+		/* Inform gadget to exit from L1 */
+		call_gadget(hsotg, resume);
+		/* Change to L0 state */
+		hsotg->lx_state = DWC2_L0;
+		hsotg->bus_suspended = false;
+fail:		dwc2_gadget_init_lpm(hsotg);
 	} else {
 		/* TODO */
 		dev_err(hsotg->dev, "Host side LPM is not supported.\n");
 		return;
 	}
-
-	/* Change to L0 state */
-	hsotg->lx_state = DWC2_L0;
-
-	/* Inform gadget to exit from L1 */
-	call_gadget(hsotg, resume);
 }
 
 /*
@@ -386,7 +407,7 @@ static void dwc2_handle_wakeup_detected_
 	dev_dbg(hsotg->dev, "%s lxstate = %d\n", __func__, hsotg->lx_state);
 
 	if (hsotg->lx_state == DWC2_L1) {
-		dwc2_wakeup_from_lpm_l1(hsotg);
+		dwc2_wakeup_from_lpm_l1(hsotg, false);
 		return;
 	}
 
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1415,6 +1415,10 @@ static int dwc2_hsotg_ep_queue(struct us
 		ep->name, req, req->length, req->buf, req->no_interrupt,
 		req->zero, req->short_not_ok);
 
+	if (hs->lx_state == DWC2_L1) {
+		dwc2_wakeup_from_lpm_l1(hs, true);
+	}
+
 	/* Prevent new request submission when controller is suspended */
 	if (hs->lx_state != DWC2_L0) {
 		dev_dbg(hs->dev, "%s: submit request only in active state\n",



