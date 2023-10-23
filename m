Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171257D3508
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjJWLo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjJWLot (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:44:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478BFF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:44:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C87C433C8;
        Mon, 23 Oct 2023 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061486;
        bh=SojQXAHtkxasikaB+kjeLS6BzVgq/68V0jvcTjzWEh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX7JrIBBhyGGNVEdKPCUBRIQ5p8ODzuLYQZjyIcsVCSPHf76cYjNhqjMuIE3yjfXs
         GGmoMFo5PjWFTO7Y1R7aeCuT6QJbj/dTFm0uxQgkV5pMSw6My9l6Frd2SsP/5/1+SF
         Wcac/KPZL4o3k9XWWZuFSfv9D+5CKKcHQiKjhIlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenta Sato <tosainu.maple@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.10 036/202] usb: dwc3: Soft reset phy on probe for host
Date:   Mon, 23 Oct 2023 12:55:43 +0200
Message-ID: <20231023104827.647518146@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 8bea147dfdf823eaa8d3baeccc7aeb041b41944b upstream.

When there's phy initialization, we need to initiate a soft-reset
sequence. That's done through USBCMD.HCRST in the xHCI driver and its
initialization, However, the dwc3 driver may modify core configs before
the soft-reset. This may result in some connection instability. So,
ensure the phy is ready before the controller updates the GCTL.PRTCAPDIR
or other settings by issuing phy soft-reset.

Note that some host-mode configurations may not expose device registers
to initiate the controller soft-reset (via DCTL.CoreSftRst). So we reset
through GUSB3PIPECTL and GUSB2PHYCFG instead.

Cc: stable@vger.kernel.org
Fixes: e835c0a4e23c ("usb: dwc3: don't reset device side if dwc3 was configured as host-only")
Reported-by: Kenta Sato <tosainu.maple@gmail.com>
Closes: https://lore.kernel.org/linux-usb/ZPUciRLUcjDywMVS@debian.me/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Kenta Sato <tosainu.maple@gmail.com>
Link: https://lore.kernel.org/r/70aea513215d273669152696cc02b20ddcdb6f1a.1694564261.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,46 @@ int dwc3_core_soft_reset(struct dwc3 *dw
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;


