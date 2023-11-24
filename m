Return-Path: <stable+bounces-1226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280987F7E9C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98868B21446
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F442EAEA;
	Fri, 24 Nov 2023 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmCEsfKa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFB33E9;
	Fri, 24 Nov 2023 18:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128DFC433C7;
	Fri, 24 Nov 2023 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850872;
	bh=sTz8r0AkCXm+zoqIET7fFyuT4DbF835OawaGOfs/HEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmCEsfKa8tdpitYMLlbu9dvMGOOLWoaz5y6jbGjKr3kGrFq4/EatoWb3KVhpocQcE
	 uE0GaTAdGvwO81nnhPMMA18IOfwqdH5krqVrqgZ/AHvIhhCfWOXwtKUC/lIxSq4oqD
	 yriNqXH5Z7uawUEtZl6alY66sYcz69Zf6sT/KfPg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 188/491] blk-mq: make sure active queue usage is held for bio_integrity_prep()
Date: Fri, 24 Nov 2023 17:47:04 +0000
Message-ID: <20231124172030.125729760@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@infradead.org>

[ Upstream commit b0077e269f6c152e807fdac90b58caf012cdbaab ]

blk_integrity_unregister() can come if queue usage counter isn't held
for one bio with integrity prepared, so this request may be completed with
calling profile->complete_fn, then kernel panic.

Another constraint is that bio_integrity_prep() needs to be called
before bio merge.

Fix the issue by:

- call bio_integrity_prep() with one queue usage counter grabbed reliably

- call bio_integrity_prep() before bio merge

Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/r/20231113035231.2708053-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 75 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c21bc81a790ff..5fb31b9a16403 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2874,11 +2874,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (unlikely(bio_queue_enter(bio)))
-		return NULL;
-
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		goto queue_exit;
+		return NULL;
 
 	rq_qos_throttle(q, bio);
 
@@ -2894,35 +2891,23 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
-	blk_queue_exit(q);
 	return NULL;
 }
 
-static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
+/* return true if this @rq can be used for @bio */
+static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
+		struct bio *bio)
 {
-	struct request *rq;
-	enum hctx_type type, hctx_type;
+	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
+	enum hctx_type hctx_type = rq->mq_hctx->type;
 
-	if (!plug)
-		return NULL;
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
+	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
 
-	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
-		*bio = NULL;
-		return NULL;
-	}
-
-	type = blk_mq_get_hctx_type((*bio)->bi_opf);
-	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
 	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
-		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
-		return NULL;
+		return false;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+		return false;
 
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
@@ -2930,12 +2915,12 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	 * before we throttle.
 	 */
 	plug->cached_rq = rq_list_next(rq);
-	rq_qos_throttle(q, *bio);
+	rq_qos_throttle(rq->q, bio);
 
 	blk_mq_rq_time_init(rq, 0);
-	rq->cmd_flags = (*bio)->bi_opf;
+	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
-	return rq;
+	return true;
 }
 
 static void bio_set_ioprio(struct bio *bio)
@@ -2965,7 +2950,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
+	struct request *rq = NULL;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2976,20 +2961,36 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
-	if (!bio_integrity_prep(bio))
-		return;
-
 	bio_set_ioprio(bio);
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
-	if (!rq) {
-		if (!bio)
+	if (plug) {
+		rq = rq_list_peek(&plug->cached_rq);
+		if (rq && rq->q != q)
+			rq = NULL;
+	}
+	if (rq) {
+		if (!bio_integrity_prep(bio))
 			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 			return;
+		if (blk_mq_can_use_cached_rq(rq, plug, bio))
+			goto done;
+		percpu_ref_get(&q->q_usage_counter);
+	} else {
+		if (unlikely(bio_queue_enter(bio)))
+			return;
+		if (!bio_integrity_prep(bio))
+			goto fail;
+	}
+
+	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+	if (unlikely(!rq)) {
+fail:
+		blk_queue_exit(q);
+		return;
 	}
 
+done:
 	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
-- 
2.42.0




