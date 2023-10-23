Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764807D3500
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJWLon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjJWLog (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:44:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB0D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:44:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5922C433C8;
        Mon, 23 Oct 2023 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061468;
        bh=mjZ642sIAIsdmMCzdu3y5bcLKPE4nmt4ohx6djGodQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZalDldsnBLyImq6dcATCOdlnxUL2zK+8/EkPROm0np2YJWq3NabUG+ka7RSsOWyNZ
         GsTPM65Ga1B7SeF0VRqTUsqQuXLBb7TezP5kTOubXEWPWtqbFxifWyaiAVB8zrZo0n
         +hCAqAJ++im9/ehI4Jqn0ESwsGSxxOw7mgw2y2+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 5.10 057/202] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
Date:   Mon, 23 Oct 2023 12:56:04 +0200
Message-ID: <20231023104828.233336251@linuxfoundation.org>
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

From: Piyush Mehta <piyush.mehta@amd.com>

commit 3061b6491f491197a35e14e49f805d661b02acd4 upstream.

For ARM processor, unaligned access to device memory is not allowed.
Method memcpy does not take care of alignment.

USB detection failure with the unalingned address of memory, with
below kernel crash. To fix the unalingned address kernel panic,
replace memcpy with memcpy_toio method.

Kernel crash:
Unable to handle kernel paging request at virtual address ffff80000c05008a
Mem abort info:
  ESR = 0x96000061
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000061
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000143b000
[ffff80000c05008a] pgd=100000087ffff003, p4d=100000087ffff003,
pud=100000087fffe003, pmd=1000000800bcc003, pte=00680000a0010713
Internal error: Oops: 96000061 [#1] SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.19-xilinx-v2022.1 #1
Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __memcpy+0x30/0x260
lr : __xudc_ep0_queue+0xf0/0x110
sp : ffff800008003d00
x29: ffff800008003d00 x28: ffff800009474e80 x27: 00000000000000a0
x26: 0000000000000100 x25: 0000000000000012 x24: ffff000800bc8080
x23: 0000000000000001 x22: 0000000000000012 x21: ffff000800bc8080
x20: 0000000000000012 x19: ffff000800bc8080 x18: 0000000000000000
x17: ffff800876482000 x16: ffff800008004000 x15: 0000000000004000
x14: 00001f09785d0400 x13: 0103020101005567 x12: 0781400000000200
x11: 00000000c5672a10 x10: 00000000000008d0 x9 : ffff800009463cf0
x8 : ffff8000094757b0 x7 : 0201010055670781 x6 : 4000000002000112
x5 : ffff80000c05009a x4 : ffff000800a15012 x3 : ffff00080362ad80
x2 : 0000000000000012 x1 : ffff000800a15000 x0 : ffff80000c050088
Call trace:
 __memcpy+0x30/0x260
 xudc_ep0_queue+0x3c/0x60
 usb_ep_queue+0x38/0x44
 composite_ep0_queue.constprop.0+0x2c/0xc0
 composite_setup+0x8d0/0x185c
 configfs_composite_setup+0x74/0xb0
 xudc_irq+0x570/0xa40
 __handle_irq_event_percpu+0x58/0x170
 handle_irq_event+0x60/0x120
 handle_fasteoi_irq+0xc0/0x220
 handle_domain_irq+0x60/0x90
 gic_handle_irq+0x74/0xa0
 call_on_irq_stack+0x2c/0x60
 do_interrupt_handler+0x54/0x60
 el1_interrupt+0x30/0x50
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x78/0x7c
 arch_cpu_idle+0x18/0x2c
 do_idle+0xdc/0x15c
 cpu_startup_entry+0x28/0x60
 rest_init+0xc8/0xe0
 arch_call_rest_init+0x10/0x1c
 start_kernel+0x694/0x6d4
 __primary_switched+0xa4/0xac

Fixes: 1f7c51660034 ("usb: gadget: Add xilinx usb2 device support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202209020044.CX2PfZzM-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Link: https://lore.kernel.org/r/20230929121514.13475-1-piyush.mehta@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/udc-xilinx.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -496,11 +496,13 @@ static int xudc_eptxrx(struct xusb_ep *e
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -514,11 +516,13 @@ static int xudc_eptxrx(struct xusb_ep *e
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio((void __iomem *)eprambase, bufferptr,
+				    bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio((void __iomem *)bufferptr, eprambase,
+				    bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1020,7 +1024,7 @@ static int __xudc_ep0_queue(struct xusb_
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio((void __iomem *)corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1746,7 +1750,7 @@ static void xudc_handle_setup(struct xus
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio((void __iomem *)&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1833,7 +1837,7 @@ static void xudc_ep0_out(struct xusb_udc
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio((void __iomem *)buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1909,7 +1913,7 @@ static void xudc_ep0_in(struct xusb_udc
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio((void __iomem *)ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);


