Return-Path: <stable+bounces-186013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F6BE3381
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A4E4EE444
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6AB31AF2F;
	Thu, 16 Oct 2025 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSgv/NLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFE30FC1B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616267; cv=none; b=Q+A9Jm5gJpv+jneC00Zh0/zRC/13ln5rjkhW+0TUgvLBFDgh+xgkPnwSenBicLmqPYjepYr/Gc/4yTybdosMP9v2LxXi29xehtskbA8PD7pxodA9nCTo68WDqfkNBJlx7iueMrOzi18U4ir9/TCRmEhsrW3N3x8yOVzPUcQu1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616267; c=relaxed/simple;
	bh=PlZUAwT9aI/yKfrj11JPPB220jO4pIE0bL6PakElWUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yh8Tuz2DwYP/JVselbdUahYGoWlEIXjH33aBN6vfQSR2RcSdXvioowSeF56GB6T/Pe5UzIpn7qmDk9fFvTc4OOP4aS3LAP0cMgvH9aihw2UcsMTI92UNyRzkIQq1h4Bpegv1qG5CQFk6e19n6xjTfYIMzAyX1VSF+4a9E3MIVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSgv/NLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3910C4CEF1;
	Thu, 16 Oct 2025 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760616266;
	bh=PlZUAwT9aI/yKfrj11JPPB220jO4pIE0bL6PakElWUw=;
	h=Subject:To:Cc:From:Date:From;
	b=hSgv/NLTmhP41zirarxHwT45nq2Iix9+kG06N6fPW6+2fou9rxkHz8t0keS/35v2f
	 C71x/Lu0HNVcVH8GEFlfFlTYiVjpWHyibkgcesPGa5t2HEAiSwvvQYSo5jmMklGBb+
	 Kynum6uO+TJMBbJ8DOYjDCto0osCPBkcvM8SX2dE=
Subject: FAILED: patch "[PATCH] bus: mhi: ep: Fix chained transfer handling in read path" failed to apply to 6.1-stable tree
To: sumit.kumar@oss.qualcomm.com,akhil.vinod@oss.qualcomm.com,krishna.chundru@oss.qualcomm.com,manivannan.sadhasivam@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:04:23 +0200
Message-ID: <2025101623-error-attain-05f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f5225a34bd8f9f64eec37f6ae1461289aaa3eb86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101623-error-attain-05f5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5225a34bd8f9f64eec37f6ae1461289aaa3eb86 Mon Sep 17 00:00:00 2001
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 18:11:09 +0530
Subject: [PATCH] bus: mhi: ep: Fix chained transfer handling in read path

The mhi_ep_read_channel function incorrectly assumes the End of Transfer
(EOT) bit is present for each packet in a chained transactions, causing
it to advance mhi_chan->rd_offset beyond wr_offset during host-to-device
transfers when EOT has not yet arrived. This leads to access of unmapped
host memory, causing IOMMU faults and processing of stale TREs.

Modify the loop condition to ensure mhi_queue is not empty, allowing the
function to process only valid TREs up to the current write pointer to
prevent premature reads and ensure safe traversal of chained TREs.

Due to this change, buf_left needs to be removed from the while loop
condition to avoid exiting prematurely before reading the ring completely,
and also remove write_offset since it will always be zero because the new
cache buffer is allocated every time.

Fixes: 5301258899773 ("bus: mhi: ep: Add support for reading from the host")
Co-developed-by: Akhil Vinod <akhil.vinod@oss.qualcomm.com>
Signed-off-by: Akhil Vinod <akhil.vinod@oss.qualcomm.com>
Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
[mani: reworded description slightly]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250910-final_chained-v3-1-ec77c9d88ace@oss.qualcomm.com

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index b3eafcf2a2c5..cdea24e92919 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -403,17 +403,13 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 {
 	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	size_t tr_len, read_offset, write_offset;
+	size_t tr_len, read_offset;
 	struct mhi_ep_buf_info buf_info = {};
 	u32 len = MHI_EP_DEFAULT_MTU;
 	struct mhi_ring_element *el;
-	bool tr_done = false;
 	void *buf_addr;
-	u32 buf_left;
 	int ret;
 
-	buf_left = len;
-
 	do {
 		/* Don't process the transfer ring if the channel is not in RUNNING state */
 		if (mhi_chan->state != MHI_CH_STATE_RUNNING) {
@@ -426,24 +422,23 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		/* Check if there is data pending to be read from previous read operation */
 		if (mhi_chan->tre_bytes_left) {
 			dev_dbg(dev, "TRE bytes remaining: %u\n", mhi_chan->tre_bytes_left);
-			tr_len = min(buf_left, mhi_chan->tre_bytes_left);
+			tr_len = min(len, mhi_chan->tre_bytes_left);
 		} else {
 			mhi_chan->tre_loc = MHI_TRE_DATA_GET_PTR(el);
 			mhi_chan->tre_size = MHI_TRE_DATA_GET_LEN(el);
 			mhi_chan->tre_bytes_left = mhi_chan->tre_size;
 
-			tr_len = min(buf_left, mhi_chan->tre_size);
+			tr_len = min(len, mhi_chan->tre_size);
 		}
 
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
-		write_offset = len - buf_left;
 
 		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL);
 		if (!buf_addr)
 			return -ENOMEM;
 
 		buf_info.host_addr = mhi_chan->tre_loc + read_offset;
-		buf_info.dev_addr = buf_addr + write_offset;
+		buf_info.dev_addr = buf_addr;
 		buf_info.size = tr_len;
 		buf_info.cb = mhi_ep_read_completion;
 		buf_info.cb_buf = buf_addr;
@@ -459,16 +454,12 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 			goto err_free_buf_addr;
 		}
 
-		buf_left -= tr_len;
 		mhi_chan->tre_bytes_left -= tr_len;
 
-		if (!mhi_chan->tre_bytes_left) {
-			if (MHI_TRE_DATA_GET_IEOT(el))
-				tr_done = true;
-
+		if (!mhi_chan->tre_bytes_left)
 			mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
-		}
-	} while (buf_left && !tr_done);
+	/* Read until the some buffer is left or the ring becomes not empty */
+	} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
 
 	return 0;
 
@@ -502,15 +493,11 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring)
 		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 	} else {
 		/* UL channel */
-		do {
-			ret = mhi_ep_read_channel(mhi_cntrl, ring);
-			if (ret < 0) {
-				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
-				return ret;
-			}
-
-			/* Read until the ring becomes empty */
-		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
+		ret = mhi_ep_read_channel(mhi_cntrl, ring);
+		if (ret < 0) {
+			dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
+			return ret;
+		}
 	}
 
 	return 0;


