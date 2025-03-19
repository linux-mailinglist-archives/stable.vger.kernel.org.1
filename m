Return-Path: <stable+bounces-125141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52758A691C2
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B415A19C54D4
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F11DE4FB;
	Wed, 19 Mar 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OlHhqEko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A501C8618;
	Wed, 19 Mar 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394982; cv=none; b=hEc6VCCKyjSoCwjjmeZLv+7kl4lfqVc4XGaHD9L/2tq/ZEECtZtNy//L0J1J2Bv5DpbZsCgJxt8yeaEarSpVQ+pijQl0P5WWLXZN9rfrEUlmCOSsSEjZF1pmaKDpWq69Rfv4Ui775u5uDfxnmjgkNhJbXazOw0I4CsLOMwXWEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394982; c=relaxed/simple;
	bh=Om+oZics1FDwOwQ1mLg0/9tnig5zPXMYDwvyz1sip+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjwXadd1hwA+s+PpWZZedWRFKpBFaaadadyZ3dDQqzgP/2AB24bohiOeanLIQba8GPWr++cJPZxW5qAQ4a4JN0dqWCZirrGy1IANY98qohGnT0Bu9ey6QN+fYAFygQsxIG/i8HdWxvIOHwPcgwoE+aNimQcgBVf6/B8g7Xom/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OlHhqEko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63B7C4CEE4;
	Wed, 19 Mar 2025 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394982;
	bh=Om+oZics1FDwOwQ1mLg0/9tnig5zPXMYDwvyz1sip+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlHhqEko2x+m1XIJF1mDapAohKm9mWp1vfuwwNnZ8FdYEouGZIxadTy5JUgXePe2q
	 f1TT/bLXbzNj1f0EY2NU5RLJRH3G8SdceaJ+KDmT96/y4+Gf9OmtzVhG2YOGWP2Wbn
	 ufYWuzzTEH/NhMWGeBe4k7J7sb96P6MFF06U4Ksg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 222/241] block: change blk_mq_add_to_batch() third argument type to bool
Date: Wed, 19 Mar 2025 07:31:32 -0700
Message-ID: <20250319143033.239588960@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 9bce6b5f8987678b9c6c1fe433af6b5fe41feadc ]

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") modified the evaluation criteria for the third argument,
'ioerror', in the blk_mq_add_to_batch() function. Initially, the
function had checked if 'ioerror' equals zero. Following the commit, it
started checking for negative error values, with the presumption that
such values, for instance -EIO, would be passed in.

However, blk_mq_add_to_batch() callers do not pass negative error
values. Instead, they pass status codes defined in various ways:

- NVMe PCI and Apple drivers pass NVMe status code
- virtio_blk driver passes the virtblk request header status byte
- null_blk driver passes blk_status_t

These codes are either zero or positive, therefore the revised check
fails to function as intended. Specifically, with the NVMe PCI driver,
this modification led to the failure of the blktests test case nvme/039.
In this test scenario, errors are artificially injected to the NVMe
driver, resulting in positive NVMe status codes passed to
blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
batch. Hence the failure.

To correct the ioerror check within blk_mq_add_to_batch(), make all
callers to uniformly pass the argument as boolean. Modify the callers to
check their specific status codes and pass the boolean value 'is_error'.
Also describe the arguments of blK_mq_add_to_batch as kerneldoc.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20250311104359.1767728-3-shinichiro.kawasaki@wdc.com
[axboe: fold in documentation update]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 16 ++++++++++++----
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3c3d8d200abba..f10369ad90f76 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1541,8 +1541,8 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		if (!blk_mq_add_to_batch(req, iob, (__force int) cmd->error,
-					blk_mq_end_request_batch))
+		if (!blk_mq_add_to_batch(req, iob, cmd->error != BLK_STS_OK,
+					 blk_mq_end_request_batch))
 			blk_mq_end_request(req, cmd->error);
 		nr++;
 	}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5afc8aac62ab9..9515e98292161 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1207,11 +1207,12 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
+		u8 status = virtblk_vbr_status(vbr);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-						virtblk_complete_batch))
+		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
 
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 0bca33dc48cc9..05cd4c4f1ed65 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -599,7 +599,8 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 	}
 
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
 				 apple_nvme_complete_batch))
 		apple_nvme_complete_rq(req);
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d2eeba15c73b3..0b4ca8e8f9b46 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1131,8 +1131,9 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
-	    !blk_mq_add_to_batch(req, iob, nvme_req(req)->status,
-					nvme_pci_complete_batch))
+	    !blk_mq_add_to_batch(req, iob,
+				 nvme_req(req)->status != NVME_SC_SUCCESS,
+				 nvme_pci_complete_batch))
 		nvme_pci_complete_rq(req);
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7b19b83349cf8..07af26550a5a9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -863,12 +863,20 @@ static inline bool blk_mq_is_reserved_rq(struct request *rq)
 	return rq->rq_flags & RQF_RESV;
 }
 
-/*
+/**
+ * blk_mq_add_to_batch() - add a request to the completion batch
+ * @req: The request to add to batch
+ * @iob: The batch to add the request
+ * @is_error: Specify true if the request failed with an error
+ * @complete: The completaion handler for the request
+ *
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
+ *
+ * Return: true when the request was added to the batch, otherwise false
  */
 static inline bool blk_mq_add_to_batch(struct request *req,
-				       struct io_comp_batch *iob, int ioerror,
+				       struct io_comp_batch *iob, bool is_error,
 				       void (*complete)(struct io_comp_batch *))
 {
 	/*
@@ -876,7 +884,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	 * 1) No batch container
 	 * 2) Has scheduler data attached
 	 * 3) Not a passthrough request and end_io set
-	 * 4) Not a passthrough request and an ioerror
+	 * 4) Not a passthrough request and failed with an error
 	 */
 	if (!iob)
 		return false;
@@ -885,7 +893,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	if (!blk_rq_is_passthrough(req)) {
 		if (req->end_io)
 			return false;
-		if (ioerror < 0)
+		if (is_error)
 			return false;
 	}
 
-- 
2.39.5




