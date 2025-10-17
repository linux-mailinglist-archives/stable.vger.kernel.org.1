Return-Path: <stable+bounces-186626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E99BE9886
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6657035D0B9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7F3208;
	Fri, 17 Oct 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fHPeXqm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9923EABB;
	Fri, 17 Oct 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713775; cv=none; b=Xx472Sa1P7QArSlCVsA2Sy4z69RTSmjKHR5TKUv1amde1GBBrDUkXzJj6EK4LNOfdE9d657vCFb1H2ar2hIWtEstWgLHfYFYak9SXQ/U0hKJa6cQQ1AzYO4VN3X36asTWr3u6Ut3au+gw+P2To6Gaj6ioVN2yIZjn8VAtJfUrNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713775; c=relaxed/simple;
	bh=vC7YNVcY4ayTIO/POd+wiPSpdr3zTERMzE0tNm8mEHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpW0YE4r/UJKWQ3QAkI1vBaVbaTJH1C9bkyQA3LPK0p/6M5LPUEVFk2KRF6jcERHt6iLElqDwAdQZUOBe6MYKwLxiG6G2UxmFiVvYj2zxwKmxMtTPdlsr4hB0H/JxIqQxBPVSGOAYd4+poLF7de8kxCVrTeQmKnrtSEWejcJKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fHPeXqm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B4DC4CEFE;
	Fri, 17 Oct 2025 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713775;
	bh=vC7YNVcY4ayTIO/POd+wiPSpdr3zTERMzE0tNm8mEHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHPeXqm6ye1D4AQLGJWF5aBEDJAELj2039puTnZ2xCbZE/AVedAOVcggYnT0avqz1
	 vaKIR2ujooiU4Mf1Y8Zl+4CXNyjVvuMboGukIxmHz1IQhKSKXo5BbxAXKfME9+D+Ix
	 E6YpNjLTJzNOTVGwiEoSNc2b2gupe1m8Jy0c/EjM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
	Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 6.6 082/201] bus: mhi: ep: Fix chained transfer handling in read path
Date: Fri, 17 Oct 2025 16:52:23 +0200
Message-ID: <20251017145137.767563425@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

commit f5225a34bd8f9f64eec37f6ae1461289aaa3eb86 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/ep/main.c |   37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -387,17 +387,13 @@ static int mhi_ep_read_channel(struct mh
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
@@ -410,24 +406,23 @@ static int mhi_ep_read_channel(struct mh
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
@@ -443,16 +438,12 @@ static int mhi_ep_read_channel(struct mh
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
 
@@ -486,15 +477,11 @@ static int mhi_ep_process_ch_ring(struct
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



