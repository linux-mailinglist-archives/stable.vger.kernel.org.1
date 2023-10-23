Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE77D34ED
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjJWLoG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjJWLno (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:43:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B9D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0E3C433C7;
        Mon, 23 Oct 2023 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061421;
        bh=sSCjHeaKN51Lx96pIBlribKtCbW2mZraF00/zWFGpf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gShG9V+7dfXk6/ex24pWjBowE/TE11fHSCUXJ1zDlJYCk1pw+EROfukl1mYoWBU0
         i0OQbkp4ybBxnrJBEyXN7CNYohnHZykRf14S4hs4/gZ4Dcq3gjfY+d9qZWYwVbyjA4
         xrFksPRWJC59MVOMjB8XO1t4gev4rUkMKs5MhcMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.10 034/202] usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer
Date:   Mon, 23 Oct 2023 12:55:41 +0200
Message-ID: <20231023104827.591405957@linuxfoundation.org>
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

From: Wesley Cheng <quic_wcheng@quicinc.com>

commit 41a43013d2366db5b88b42bbcd8e8f040b6ccf21 upstream.

As mentioned in:
  commit 474ed23a6257 ("xhci: align the last trb before link if it is
easily splittable.")

A bounce buffer is utilized for ensuring that transfers that span across
ring segments are aligned to the EP's max packet size.  However, the device
that is used to map the DMA buffer to is currently using the XHCI HCD,
which does not carry any DMA operations in certain configrations.
Migration to using the sysdev entry was introduced for DWC3 based
implementations where the IOMMU operations are present.

Replace the reference to the controller device to sysdev instead.  This
allows the bounce buffer to be properly mapped to any implementations that
have an IOMMU involved.

cc: stable@vger.kernel.org
Fixes: 4c39d4b949d3 ("usb: xhci: use bus->sysdev for DMA configuration")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20230915143108.1532163-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -742,7 +742,7 @@ static void xhci_giveback_urb_in_irq(str
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
 		struct xhci_ring *ring, struct xhci_td *td)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_segment *seg = td->bounce_seg;
 	struct urb *urb = td->urb;
 	size_t len;
@@ -3325,7 +3325,7 @@ static u32 xhci_td_remainder(struct xhci
 static int xhci_align_td(struct xhci_hcd *xhci, struct urb *urb, u32 enqd_len,
 			 u32 *trb_buff_len, struct xhci_segment *seg)
 {
-	struct device *dev = xhci_to_hcd(xhci)->self.controller;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	unsigned int unalign;
 	unsigned int max_pkt;
 	u32 new_buff_len;


