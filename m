Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129176AD6B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjHAJ3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjHAJ2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C044BE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617CF61508
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727A3C433C8;
        Tue,  1 Aug 2023 09:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882059;
        bh=9J+F0tZLw2xxu4hWsfxL/nhLM9XawXxT4qhccu2WICw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pp4fiTMpyX0A+NRY6F5WxMbGEEoQJLpMK9ZU95c9KpFYZi5DEKpLSaZzldgN3Eb4K
         onbQxcpr2cG9QdkoqkwitxRwXUihnTNxqo5u1UZ3oyaj8iS4yyOHxJYu3VG5feE/sE
         rCwf7Ot0//rzCjg65DRcmuSggwzTSWz3DNJqPmsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Neukum <oneukum@suse.com>,
        stable <stable@kernel.org>
Subject: [PATCH 5.15 127/155] Revert "xhci: add quirk for host controllers that dont update endpoint DCS"
Date:   Tue,  1 Aug 2023 11:20:39 +0200
Message-ID: <20230801091914.728026395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 5bef4b3cb95a5b883dfec8b3ffc0d671323d55bb upstream.

This reverts commit 5255660b208aebfdb71d574f3952cf48392f4306.

This quirk breaks at least the following hardware:

0b:00.0 0c03: 1106:3483 (rev 01) (prog-if 30 [XHCI])
        Subsystem: 1106:3483
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 66
        Region 0: Memory at fb400000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] MSI: Enable+ Count=1/4 Maskable- 64bit+
                Address: 00000000fee007b8  Data: 0000
        Capabilities: [c4] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 89W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR-
                         10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
       Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

with the quirk enabled it fails early with

[    0.754373] pci 0000:0b:00.0: xHCI HW did not halt within 32000 usec status = 0x1000
[    0.754419] pci 0000:0b:00.0: quirk_usb_early_handoff+0x0/0x7a0 took 31459 usecs
[    2.228048] xhci_hcd 0000:0b:00.0: xHCI Host Controller
[    2.228053] xhci_hcd 0000:0b:00.0: new USB bus registered, assigned bus number 7
[    2.260073] xhci_hcd 0000:0b:00.0: Host halt failed, -110
[    2.260079] xhci_hcd 0000:0b:00.0: can't setup: -110
[    2.260551] xhci_hcd 0000:0b:00.0: USB bus 7 deregistered
[    2.260624] xhci_hcd 0000:0b:00.0: init 0000:0b:00.0 fail, -110
[    2.260639] xhci_hcd: probe of 0000:0b:00.0 failed with error -110

The hardware in question is an external PCIe card. It looks to me like the quirk
needs to be narrowed down. But this needs information about the hardware showing
the issue this quirk is to fix. So for now a clean revert.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 5255660b208a ("xhci: add quirk for host controllers that don't update endpoint DCS")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230713112830.21773-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c  |    4 +---
 drivers/usb/host/xhci-ring.c |   25 +------------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -294,10 +294,8 @@ static void xhci_pci_quirks(struct devic
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
-		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
-	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -592,11 +592,8 @@ static int xhci_move_dequeue_past_td(str
 	struct xhci_ring *ep_ring;
 	struct xhci_command *cmd;
 	struct xhci_segment *new_seg;
-	struct xhci_segment *halted_seg = NULL;
 	union xhci_trb *new_deq;
 	int new_cycle;
-	union xhci_trb *halted_trb;
-	int index = 0;
 	dma_addr_t addr;
 	u64 hw_dequeue;
 	bool cycle_found = false;
@@ -634,27 +631,7 @@ static int xhci_move_dequeue_past_td(str
 	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
 	new_seg = ep_ring->deq_seg;
 	new_deq = ep_ring->dequeue;
-
-	/*
-	 * Quirk: xHC write-back of the DCS field in the hardware dequeue
-	 * pointer is wrong - use the cycle state of the TRB pointed to by
-	 * the dequeue pointer.
-	 */
-	if (xhci->quirks & XHCI_EP_CTX_BROKEN_DCS &&
-	    !(ep->ep_state & EP_HAS_STREAMS))
-		halted_seg = trb_in_td(xhci, td->start_seg,
-				       td->first_trb, td->last_trb,
-				       hw_dequeue & ~0xf, false);
-	if (halted_seg) {
-		index = ((dma_addr_t)(hw_dequeue & ~0xf) - halted_seg->dma) /
-			 sizeof(*halted_trb);
-		halted_trb = &halted_seg->trbs[index];
-		new_cycle = halted_trb->generic.field[3] & 0x1;
-		xhci_dbg(xhci, "Endpoint DCS = %d TRB index = %d cycle = %d\n",
-			 (u8)(hw_dequeue & 0x1), index, new_cycle);
-	} else {
-		new_cycle = hw_dequeue & 0x1;
-	}
+	new_cycle = hw_dequeue & 0x1;
 
 	/*
 	 * We want to find the pointer, segment and cycle state of the new trb


