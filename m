Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531FE7ECCAC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjKOTb5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjKOTbz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED701AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532DFC433CB;
        Wed, 15 Nov 2023 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076711;
        bh=vMzIKzHyG3eDprz42f33hvttuVZkZdxyb/4Wx8YWPV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgqpYbxsEqEgaymhETic1O/C01l4MzGq7eUsNd81TWIrQbbXyRi6e0afgGAVNeOU0
         ER/F/YVE1U2QVCqgxqqGJ8+Gwd59X5ufZqzyyZw7JH7IRbehd6p7DhpW1j4/GqnaVa
         ktJkJMsVCLLwzx2p1sOQOvP+n016wtHs2TLejQeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 398/550] usb: chipidea: Simplify Tegra DMA alignment code
Date:   Wed, 15 Nov 2023 14:16:22 -0500
Message-ID: <20231115191628.447556981@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 2ae61a2562c0d1720545b0845829a65fb6a9c2c6 ]

The USB host on Tegra3 works with 32-bit alignment. Previous code tried
to align the buffer, but it did align the wrapper struct instead, so
the buffer was at a constant offset of 8 bytes (two pointers) from
expected alignment.  Since kmalloc() guarantees at least 8-byte
alignment already, the alignment-extending is removed.

Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/a0d917d492b1f91ee0019e68b8e8bca9c585393f.1695934946.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/host.c | 45 +++++++++++++++----------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index abddd39d1ff1e..0cce192083701 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -30,8 +30,7 @@ struct ehci_ci_priv {
 };
 
 struct ci_hdrc_dma_aligned_buffer {
-	void *kmalloc_ptr;
-	void *old_xfer_buffer;
+	void *original_buffer;
 	u8 data[];
 };
 
@@ -380,60 +379,52 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb)
+static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb, bool copy_back)
 {
 	struct ci_hdrc_dma_aligned_buffer *temp;
-	size_t length;
 
 	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
 		return;
+	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
 
 	temp = container_of(urb->transfer_buffer,
 			    struct ci_hdrc_dma_aligned_buffer, data);
+	urb->transfer_buffer = temp->original_buffer;
+
+	if (copy_back && usb_urb_dir_in(urb)) {
+		size_t length;
 
-	if (usb_urb_dir_in(urb)) {
 		if (usb_pipeisoc(urb->pipe))
 			length = urb->transfer_buffer_length;
 		else
 			length = urb->actual_length;
 
-		memcpy(temp->old_xfer_buffer, temp->data, length);
+		memcpy(temp->original_buffer, temp->data, length);
 	}
-	urb->transfer_buffer = temp->old_xfer_buffer;
-	kfree(temp->kmalloc_ptr);
 
-	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
+	kfree(temp);
 }
 
 static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 {
-	struct ci_hdrc_dma_aligned_buffer *temp, *kmalloc_ptr;
-	const unsigned int ci_hdrc_usb_dma_align = 32;
-	size_t kmalloc_size;
+	struct ci_hdrc_dma_aligned_buffer *temp;
 
 	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0)
 		return 0;
-	if (!((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)) && !(urb->transfer_buffer_length & 3))
+	if (IS_ALIGNED((uintptr_t)urb->transfer_buffer, 4)
+	    && IS_ALIGNED(urb->transfer_buffer_length, 4))
 		return 0;
 
-	/* Allocate a buffer with enough padding for alignment */
-	kmalloc_size = ALIGN(urb->transfer_buffer_length, 4) +
-		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
-		       ci_hdrc_usb_dma_align - 1;
-
-	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
-	if (!kmalloc_ptr)
+	temp = kmalloc(sizeof(*temp) + ALIGN(urb->transfer_buffer_length, 4), mem_flags);
+	if (!temp)
 		return -ENOMEM;
 
-	/* Position our struct dma_aligned_buffer such that data is aligned */
-	temp = PTR_ALIGN(kmalloc_ptr + 1, ci_hdrc_usb_dma_align) - 1;
-	temp->kmalloc_ptr = kmalloc_ptr;
-	temp->old_xfer_buffer = urb->transfer_buffer;
 	if (usb_urb_dir_out(urb))
 		memcpy(temp->data, urb->transfer_buffer,
 		       urb->transfer_buffer_length);
-	urb->transfer_buffer = temp->data;
 
+	temp->original_buffer = urb->transfer_buffer;
+	urb->transfer_buffer = temp->data;
 	urb->transfer_flags |= URB_ALIGNED_TEMP_BUFFER;
 
 	return 0;
@@ -450,7 +441,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 
 	ret = usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
 	if (ret)
-		ci_hdrc_free_dma_aligned_buffer(urb);
+		ci_hdrc_free_dma_aligned_buffer(urb, false);
 
 	return ret;
 }
@@ -458,7 +449,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 static void ci_hdrc_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
 	usb_hcd_unmap_urb_for_dma(hcd, urb);
-	ci_hdrc_free_dma_aligned_buffer(urb);
+	ci_hdrc_free_dma_aligned_buffer(urb, true);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.42.0



