Return-Path: <stable+bounces-123065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45FA5A2AF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E113AAF1A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424F233158;
	Mon, 10 Mar 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5E3Fe4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFF234972;
	Mon, 10 Mar 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630944; cv=none; b=cmxGWD9NVPv6Y3cwqCkybXmid/MNVdW2LX3MRhjCQzA+hv3OExGNxyrOOi4ZRAoVvsSWz3XdTZYuNx7j3kro6ueXI2wx4e5yhhDynosH84mUhVYZy17xcf0ABPOh6xIvWx2P8aKBlruoAtGWxwbIBNTVz0ZlShu6dJNahdRKf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630944; c=relaxed/simple;
	bh=G7ctVaqwI4KPkdJusJyBEkIbEoFUBMPWQhIkax5atnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmWdV70kLaFf+CgIWZsHEsrOAVLC0Q4iBqCH5BGk3cn5er87jhzo2zNwmR2hl9RikD01CyyoO/w/wJxRDBDSOmue6ffG89tedSBahktBwBHPcDtYWBZeYYy+AIP1Rl+8j/crpqJEL/VIidTpRdTSNwg5aF9OaKugSKH23WtJ6sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5E3Fe4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222E1C4CEE5;
	Mon, 10 Mar 2025 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630944;
	bh=G7ctVaqwI4KPkdJusJyBEkIbEoFUBMPWQhIkax5atnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5E3Fe4cJWD85RSSoDVq5t8pLO1zH/4JXQl6jGk4a431xwkO2WIUo8Iv8qs7xiN+H
	 rAs0SEIIgV6eA40Sji+gMBJ5kdqF/QHdlFcXw2t/dkhlu1qWtciRRZuHisB6kjkwjk
	 dDaHA7BMS8+ANzTK94z0+On2hPsogWYX64BrHib0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 587/620] usb: dwc3: Set SUSPENDENABLE soon after phy init
Date: Mon, 10 Mar 2025 18:07:13 +0100
Message-ID: <20250310170608.700345889@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit cc5bfc4e16fc1d1c520cd7bb28646e82b6e69217 upstream.

After phy initialization, some phy operations can only be executed while
in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid blocking
phy ops.

Previously the SUSPENDENABLE bits are only set after the controller
initialization, which may not happen right away if there's no gadget
driver or xhci driver bound. Revise this to clear SUSPENDENABLE bits
only when there's mode switching (change in GCTL.PRTCAPDIR).

Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Cc: stable <stable@kernel.org>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/633aef0afee7d56d2316f7cc3e1b2a6d518a8cc9.1738280911.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   69 +++++++++++++++++++++++++++++-------------------
 drivers/usb/dwc3/core.h |    2 -
 drivers/usb/dwc3/drd.c  |    4 +-
 3 files changed, 45 insertions(+), 30 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -123,11 +123,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 }
 
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -207,7 +220,7 @@ static void __dwc3_set_mode(struct work_
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -651,16 +664,7 @@ static int dwc3_phy_setup(struct dwc3 *d
 	 */
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
@@ -733,15 +737,7 @@ static int dwc3_phy_setup(struct dwc3 *d
 		break;
 	}
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
@@ -1158,6 +1154,25 @@ static int dwc3_core_init(struct dwc3 *d
 		}
 	}
 
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
 
 err4:
@@ -1245,7 +1260,7 @@ static int dwc3_core_init_mode(struct dw
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1257,7 +1272,7 @@ static int dwc3_core_init_mode(struct dw
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1300,7 +1315,7 @@ static void dwc3_core_exit_mode(struct d
 	}
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
 static void dwc3_get_properties(struct dwc3 *dwc)
@@ -1882,7 +1897,7 @@ static int dwc3_resume_common(struct dwc
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -1890,7 +1905,7 @@ static int dwc3_resume_common(struct dwc
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -1915,7 +1930,7 @@ static int dwc3_resume_common(struct dwc
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
 
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1475,7 +1475,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -173,7 +173,7 @@ void dwc3_otg_init(struct dwc3 *dwc)
 	 * block "Initialize GCTL for OTG operation".
 	 */
 	/* GCTL.PrtCapDir=2'b11 */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 	/* GUSB2PHYCFG0.SusPHY=0 */
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
@@ -585,7 +585,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 
 		dwc3_drd_update(dwc);
 	} else {
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 
 		/* use OTG block to get ID event */
 		irq = dwc3_otg_get_irq(dwc);



