Return-Path: <stable+bounces-134642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3DA93C65
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF097188ED77
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9121C9F6;
	Fri, 18 Apr 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="16V1x79q"
X-Original-To: stable@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA6217F30
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998871; cv=none; b=BJ5XbsvQBLEngoVqUGyilk3LrX7WA5d1qlgEJt9BUwgwhfPxarIE12Xfv2a4K6olvnYhXnwHHoXm3gDClbmpblVhaNYIJjN1ejbud/ZILMMAtLeLdu6oPYjbveSS0D8/s0DsrZXXq6sJ8yxi4ML/lHghcjyvqnz88VievkVTWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998871; c=relaxed/simple;
	bh=P9S+s/u4bNlo45CRPhDL/lHhB855jOtABSvZuN8yQBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzPpDf878+JED4GK8453mGfYCugB5X1olSy1vYNQYL0moTJf2NC73vv/Wj73igMdQMWO8Q3vHgB7nhahFoWR15CqmfAc5GVltSCvm/gavxbORTvdCP4m5kGRZqAYont7axLiR/qbr0rGJ0CjSG+z3LgDRbYBi/AgnbrtyB2mBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=16V1x79q; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZfMpW5VlWzlxW5N;
	Fri, 18 Apr 2025 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1744998865; x=1747590866; bh=SvK6M
	JnBi0e/7tAyhzKQCcXbHMuhU88+frn6cTw7lsU=; b=16V1x79q+2o6IUeAfvzqJ
	nFIs/D9ZKES0ZQlZe7gWJuVnPdkLmGiQnKvL0l0aRkGeClJneFCuGqq4r4Pfmz5x
	koMC2/GY16mOHNzXf6fPjL19r2UfPfXX4CTyjK35jrSZtIdTePSssKM1+FOD1rTo
	mjR22ZteYb8V6QMs6WQ5IPHEBOBNI9fC01wJA5LUgZsPZfVsw0GFn6PClYyYOxQi
	Dhy0BfRUbDSEkOKgmtpV8v1ZPufI+TZMSkVwXP8NsGjE33nLdhOAa8Yc/MrTjyQZ
	qXnCzB8QwHU2kDJT0YvUQeXc6sS5OvFmbcUWWtU/G0MTkKPiw/246cKiYfuZ4yEP
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9tokVOUqRNLc; Fri, 18 Apr 2025 17:54:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZfMpP1HzqzlgqVK;
	Fri, 18 Apr 2025 17:54:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block: add a rq_list type
Date: Fri, 18 Apr 2025 10:54:00 -0700
Message-ID: <20250418175401.1936152-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250418175401.1936152-1-bvanassche@acm.org>
References: <20250418175401.1936152-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch@lst.de>

Upstream commit a3396b99990d8b4e5797e7b16fdeb64c15ae97bb.

Replace the semi-open coded request list helpers with a proper rq_list
type that mirrors the bio_list and has head and tail pointers.  Besides
better type safety this actually allows to insert at the tail of the
list, which will be useful soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241113152050.157179-5-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c              |  6 +--
 block/blk-merge.c             |  2 +-
 block/blk-mq.c                | 40 ++++++++--------
 block/blk-mq.h                |  2 +-
 drivers/block/null_blk/main.c |  9 ++--
 drivers/block/virtio_blk.c    | 13 +++---
 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/pci.c       | 15 +++---
 include/linux/blk-mq.h        | 88 +++++++++++++++++++++--------------
 include/linux/blkdev.h        | 11 +++--
 io_uring/rw.c                 |  4 +-
 11 files changed, 104 insertions(+), 88 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 42023addf9cd..c7b6c1f76359 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1121,8 +1121,8 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, u=
nsigned short nr_ios)
 		return;
=20
 	plug->cur_ktime =3D 0;
-	plug->mq_list =3D NULL;
-	plug->cached_rq =3D NULL;
+	rq_list_init(&plug->mq_list);
+	rq_list_init(&plug->cached_rqs);
 	plug->nr_ios =3D min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count =3D 0;
 	plug->multiple_queues =3D false;
@@ -1218,7 +1218,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool f=
rom_schedule)
 	 * queue for cached requests, we don't want a blocked task holding
 	 * up a queue freeze/quiesce event.
 	 */
-	if (unlikely(!rq_list_empty(plug->cached_rq)))
+	if (unlikely(!rq_list_empty(&plug->cached_rqs)))
 		blk_mq_free_plug_rqs(plug);
=20
 	plug->cur_ktime =3D 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5baa950f34fe..ceac64e796ea 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1175,7 +1175,7 @@ bool blk_attempt_plug_merge(struct request_queue *q=
, struct bio *bio,
 	struct blk_plug *plug =3D current->plug;
 	struct request *rq;
=20
-	if (!plug || rq_list_empty(plug->mq_list))
+	if (!plug || rq_list_empty(&plug->mq_list))
 		return false;
=20
 	rq_list_for_each(&plug->mq_list, rq) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 662e52ab0646..c7fb3722d620 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -506,7 +506,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data)
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &=3D ~(1UL << i);
 		rq =3D blk_mq_rq_ctx_init(data, tags, tag);
-		rq_list_add(data->cached_rq, rq);
+		rq_list_add_head(data->cached_rqs, rq);
 		nr++;
 	}
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
@@ -515,7 +515,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data)
 	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
 	data->nr_tags -=3D nr;
=20
-	return rq_list_pop(data->cached_rq);
+	return rq_list_pop(data->cached_rqs);
 }
=20
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
@@ -612,7 +612,7 @@ static struct request *blk_mq_rq_cache_fill(struct re=
quest_queue *q,
 		.flags		=3D flags,
 		.cmd_flags	=3D opf,
 		.nr_tags	=3D plug->nr_ios,
-		.cached_rq	=3D &plug->cached_rq,
+		.cached_rqs	=3D &plug->cached_rqs,
 	};
 	struct request *rq;
=20
@@ -637,14 +637,14 @@ static struct request *blk_mq_alloc_cached_request(=
struct request_queue *q,
 	if (!plug)
 		return NULL;
=20
-	if (rq_list_empty(plug->cached_rq)) {
+	if (rq_list_empty(&plug->cached_rqs)) {
 		if (plug->nr_ios =3D=3D 1)
 			return NULL;
 		rq =3D blk_mq_rq_cache_fill(q, plug, opf, flags);
 		if (!rq)
 			return NULL;
 	} else {
-		rq =3D rq_list_peek(&plug->cached_rq);
+		rq =3D rq_list_peek(&plug->cached_rqs);
 		if (!rq || rq->q !=3D q)
 			return NULL;
=20
@@ -653,7 +653,7 @@ static struct request *blk_mq_alloc_cached_request(st=
ruct request_queue *q,
 		if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
 			return NULL;
=20
-		plug->cached_rq =3D rq_list_next(rq);
+		rq_list_pop(&plug->cached_rqs);
 		blk_mq_rq_time_init(rq, 0);
 	}
=20
@@ -830,7 +830,7 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 {
 	struct request *rq;
=20
-	while ((rq =3D rq_list_pop(&plug->cached_rq)) !=3D NULL)
+	while ((rq =3D rq_list_pop(&plug->cached_rqs)) !=3D NULL)
 		blk_mq_free_request(rq);
 }
=20
@@ -1386,8 +1386,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plu=
g, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator =3D true;
-	rq->rq_next =3D NULL;
-	rq_list_add(&plug->mq_list, rq);
+	rq_list_add_head(&plug->mq_list, rq);
 	plug->rq_count++;
 }
=20
@@ -2781,7 +2780,7 @@ static void blk_mq_plug_issue_direct(struct blk_plu=
g *plug)
 	blk_status_t ret =3D BLK_STS_OK;
=20
 	while ((rq =3D rq_list_pop(&plug->mq_list))) {
-		bool last =3D rq_list_empty(plug->mq_list);
+		bool last =3D rq_list_empty(&plug->mq_list);
=20
 		if (hctx !=3D rq->mq_hctx) {
 			if (hctx) {
@@ -2824,8 +2823,7 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx =3D NULL;
 	struct blk_mq_ctx *this_ctx =3D NULL;
-	struct request *requeue_list =3D NULL;
-	struct request **requeue_lastp =3D &requeue_list;
+	struct rq_list requeue_list =3D {};
 	unsigned int depth =3D 0;
 	bool is_passthrough =3D false;
 	LIST_HEAD(list);
@@ -2839,12 +2837,12 @@ static void blk_mq_dispatch_plug_list(struct blk_=
plug *plug, bool from_sched)
 			is_passthrough =3D blk_rq_is_passthrough(rq);
 		} else if (this_hctx !=3D rq->mq_hctx || this_ctx !=3D rq->mq_ctx ||
 			   is_passthrough !=3D blk_rq_is_passthrough(rq)) {
-			rq_list_add_tail(&requeue_lastp, rq);
+			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
 		list_add(&rq->queuelist, &list);
 		depth++;
-	} while (!rq_list_empty(plug->mq_list));
+	} while (!rq_list_empty(&plug->mq_list));
=20
 	plug->mq_list =3D requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
@@ -2899,19 +2897,19 @@ void blk_mq_flush_plug_list(struct blk_plug *plug=
, bool from_schedule)
 		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
 				__blk_mq_flush_plug_list(q, plug));
-			if (rq_list_empty(plug->mq_list))
+			if (rq_list_empty(&plug->mq_list))
 				return;
 		}
=20
 		blk_mq_run_dispatch_ops(q,
 				blk_mq_plug_issue_direct(plug));
-		if (rq_list_empty(plug->mq_list))
+		if (rq_list_empty(&plug->mq_list))
 			return;
 	}
=20
 	do {
 		blk_mq_dispatch_plug_list(plug, from_schedule);
-	} while (!rq_list_empty(plug->mq_list));
+	} while (!rq_list_empty(&plug->mq_list));
 }
=20
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -2976,7 +2974,7 @@ static struct request *blk_mq_get_new_requests(stru=
ct request_queue *q,
 	if (plug) {
 		data.nr_tags =3D plug->nr_ios;
 		plug->nr_ios =3D 1;
-		data.cached_rq =3D &plug->cached_rq;
+		data.cached_rqs =3D &plug->cached_rqs;
 	}
=20
 	rq =3D __blk_mq_alloc_requests(&data);
@@ -2999,7 +2997,7 @@ static struct request *blk_mq_peek_cached_request(s=
truct blk_plug *plug,
=20
 	if (!plug)
 		return NULL;
-	rq =3D rq_list_peek(&plug->cached_rq);
+	rq =3D rq_list_peek(&plug->cached_rqs);
 	if (!rq || rq->q !=3D q)
 		return NULL;
 	if (type !=3D rq->mq_hctx->type &&
@@ -3013,14 +3011,14 @@ static struct request *blk_mq_peek_cached_request=
(struct blk_plug *plug,
 static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *pl=
ug,
 		struct bio *bio)
 {
-	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) !=3D rq);
+	if (rq_list_pop(&plug->cached_rqs) !=3D rq)
+		WARN_ON_ONCE(1);
=20
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
 	 * plug and hence killed the cached_rq list as well. Pop this entry
 	 * before we throttle.
 	 */
-	plug->cached_rq =3D rq_list_next(rq);
 	rq_qos_throttle(rq->q, bio);
=20
 	blk_mq_rq_time_init(rq, 0);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 364c0415293c..a80d3b3105f9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -155,7 +155,7 @@ struct blk_mq_alloc_data {
=20
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
-	struct request **cached_rq;
+	struct rq_list *cached_rqs;
=20
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index c479348ce8ff..f10369ad90f7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1638,10 +1638,9 @@ static blk_status_t null_queue_rq(struct blk_mq_hw=
_ctx *hctx,
 	return BLK_STS_OK;
 }
=20
-static void null_queue_rqs(struct request **rqlist)
+static void null_queue_rqs(struct rq_list *rqlist)
 {
-	struct request *requeue_list =3D NULL;
-	struct request **requeue_lastp =3D &requeue_list;
+	struct rq_list requeue_list =3D {};
 	struct blk_mq_queue_data bd =3D { };
 	blk_status_t ret;
=20
@@ -1651,8 +1650,8 @@ static void null_queue_rqs(struct request **rqlist)
 		bd.rq =3D rq;
 		ret =3D null_queue_rq(rq->mq_hctx, &bd);
 		if (ret !=3D BLK_STS_OK)
-			rq_list_add_tail(&requeue_lastp, rq);
-	} while (!rq_list_empty(*rqlist));
+			rq_list_add_tail(&requeue_list, rq);
+	} while (!rq_list_empty(rqlist));
=20
 	*rqlist =3D requeue_list;
 }
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 44a6937a4b65..2069bf9701f5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -472,7 +472,7 @@ static bool virtblk_prep_rq_batch(struct request *req=
)
 }
=20
 static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
-					struct request **rqlist)
+		struct rq_list *rqlist)
 {
 	struct request *req;
 	unsigned long flags;
@@ -499,11 +499,10 @@ static void virtblk_add_req_batch(struct virtio_blk=
_vq *vq,
 		virtqueue_notify(vq->vq);
 }
=20
-static void virtio_queue_rqs(struct request **rqlist)
+static void virtio_queue_rqs(struct rq_list *rqlist)
 {
-	struct request *submit_list =3D NULL;
-	struct request *requeue_list =3D NULL;
-	struct request **requeue_lastp =3D &requeue_list;
+	struct rq_list submit_list =3D { };
+	struct rq_list requeue_list =3D { };
 	struct virtio_blk_vq *vq =3D NULL;
 	struct request *req;
=20
@@ -515,9 +514,9 @@ static void virtio_queue_rqs(struct request **rqlist)
 		vq =3D this_vq;
=20
 		if (virtblk_prep_rq_batch(req))
-			rq_list_add(&submit_list, req); /* reverse order */
+			rq_list_add_head(&submit_list, req); /* reverse order */
 		else
-			rq_list_add_tail(&requeue_lastp, req);
+			rq_list_add_tail(&requeue_list, req);
 	}
=20
 	if (vq)
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e79a0adf1395..328f5a103628 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -650,7 +650,7 @@ static bool apple_nvme_handle_cq(struct apple_nvme_qu=
eue *q, bool force)
=20
 	found =3D apple_nvme_poll_cq(q, &iob);
=20
-	if (!rq_list_empty(iob.req_list))
+	if (!rq_list_empty(&iob.req_list))
 		apple_nvme_complete_batch(&iob);
=20
 	return found;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index af45a1b865ee..e943c1be0fca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -985,7 +985,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ct=
x *hctx,
 	return BLK_STS_OK;
 }
=20
-static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **=
rqlist)
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *r=
qlist)
 {
 	struct request *req;
=20
@@ -1013,11 +1013,10 @@ static bool nvme_prep_rq_batch(struct nvme_queue =
*nvmeq, struct request *req)
 	return nvme_prep_rq(nvmeq->dev, req) =3D=3D BLK_STS_OK;
 }
=20
-static void nvme_queue_rqs(struct request **rqlist)
+static void nvme_queue_rqs(struct rq_list *rqlist)
 {
-	struct request *submit_list =3D NULL;
-	struct request *requeue_list =3D NULL;
-	struct request **requeue_lastp =3D &requeue_list;
+	struct rq_list submit_list =3D { };
+	struct rq_list requeue_list =3D { };
 	struct nvme_queue *nvmeq =3D NULL;
 	struct request *req;
=20
@@ -1027,9 +1026,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 		nvmeq =3D req->mq_hctx->driver_data;
=20
 		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add(&submit_list, req); /* reverse order */
+			rq_list_add_head(&submit_list, req); /* reverse order */
 		else
-			rq_list_add_tail(&requeue_lastp, req);
+			rq_list_add_tail(&requeue_list, req);
 	}
=20
 	if (nvmeq)
@@ -1176,7 +1175,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	DEFINE_IO_COMP_BATCH(iob);
=20
 	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(iob.req_list))
+		if (!rq_list_empty(&iob.req_list))
 			nvme_pci_complete_batch(&iob);
 		return IRQ_HANDLED;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cd04e71ecb88..b160d131204e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -230,44 +230,60 @@ static inline unsigned short req_get_ioprio(struct =
request *req)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
=20
-#define rq_list_add(listptr, rq)	do {		\
-	(rq)->rq_next =3D *(listptr);			\
-	*(listptr) =3D rq;				\
-} while (0)
-
-#define rq_list_add_tail(lastpptr, rq)	do {		\
-	(rq)->rq_next =3D NULL;				\
-	**(lastpptr) =3D rq;				\
-	*(lastpptr) =3D &rq->rq_next;			\
-} while (0)
-
-#define rq_list_pop(listptr)				\
-({							\
-	struct request *__req =3D NULL;			\
-	if ((listptr) && *(listptr))	{		\
-		__req =3D *(listptr);			\
-		*(listptr) =3D __req->rq_next;		\
-	}						\
-	__req;						\
-})
+static inline int rq_list_empty(const struct rq_list *rl)
+{
+	return rl->head =3D=3D NULL;
+}
=20
-#define rq_list_peek(listptr)				\
-({							\
-	struct request *__req =3D NULL;			\
-	if ((listptr) && *(listptr))			\
-		__req =3D *(listptr);			\
-	__req;						\
-})
+static inline void rq_list_init(struct rq_list *rl)
+{
+	rl->head =3D NULL;
+	rl->tail =3D NULL;
+}
+
+static inline void rq_list_add_tail(struct rq_list *rl, struct request *=
rq)
+{
+	rq->rq_next =3D NULL;
+	if (rl->tail)
+		rl->tail->rq_next =3D rq;
+	else
+		rl->head =3D rq;
+	rl->tail =3D rq;
+}
+
+static inline void rq_list_add_head(struct rq_list *rl, struct request *=
rq)
+{
+	rq->rq_next =3D rl->head;
+	rl->head =3D rq;
+	if (!rl->tail)
+		rl->tail =3D rq;
+}
+
+static inline struct request *rq_list_pop(struct rq_list *rl)
+{
+	struct request *rq =3D rl->head;
+
+	if (rq) {
+		rl->head =3D rl->head->rq_next;
+		if (!rl->head)
+			rl->tail =3D NULL;
+		rq->rq_next =3D NULL;
+	}
+
+	return rq;
+}
=20
-#define rq_list_for_each(listptr, pos)			\
-	for (pos =3D rq_list_peek((listptr)); pos; pos =3D rq_list_next(pos))
+static inline struct request *rq_list_peek(struct rq_list *rl)
+{
+	return rl->head;
+}
=20
-#define rq_list_for_each_safe(listptr, pos, nxt)			\
-	for (pos =3D rq_list_peek((listptr)), nxt =3D rq_list_next(pos);	\
-		pos; pos =3D nxt, nxt =3D pos ? rq_list_next(pos) : NULL)
+#define rq_list_for_each(rl, pos)					\
+	for (pos =3D rq_list_peek((rl)); (pos); pos =3D pos->rq_next)
=20
-#define rq_list_next(rq)	(rq)->rq_next
-#define rq_list_empty(list)	((list) =3D=3D (struct request *) NULL)
+#define rq_list_for_each_safe(rl, pos, nxt)				\
+	for (pos =3D rq_list_peek((rl)), nxt =3D pos->rq_next;		\
+		pos; pos =3D nxt, nxt =3D pos ? pos->rq_next : NULL)
=20
 /**
  * enum blk_eh_timer_return - How the timeout handler should proceed
@@ -560,7 +576,7 @@ struct blk_mq_ops {
 	 * empty the @rqlist completely, then the rest will be queued
 	 * individually by the block layer upon return.
 	 */
-	void (*queue_rqs)(struct request **rqlist);
+	void (*queue_rqs)(struct rq_list *rqlist);
=20
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
@@ -893,7 +909,7 @@ static inline bool blk_mq_add_to_batch(struct request=
 *req,
 	else if (iob->complete !=3D complete)
 		return false;
 	iob->need_ts |=3D blk_mq_need_time_stamp(req);
-	rq_list_add(&iob->req_list, req);
+	rq_list_add_head(&iob->req_list, req);
 	return true;
 }
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8f37c5dd52b2..402a7d7fe98d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -996,6 +996,11 @@ extern void blk_put_queue(struct request_queue *);
 void blk_mark_disk_dead(struct gendisk *disk);
=20
 #ifdef CONFIG_BLOCK
+struct rq_list {
+	struct request *head;
+	struct request *tail;
+};
+
 /*
  * blk_plug permits building a queue of related requests by holding the =
I/O
  * fragments for a short period. This allows merging of sequential reque=
sts
@@ -1008,10 +1013,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
  * blk_flush_plug() is called.
  */
 struct blk_plug {
-	struct request *mq_list; /* blk-mq requests */
+	struct rq_list mq_list; /* blk-mq requests */
=20
 	/* if ios_left is > 1, we can batch tag/rq allocations */
-	struct request *cached_rq;
+	struct rq_list cached_rqs;
 	u64 cur_ktime;
 	unsigned short nr_ios;
=20
@@ -1660,7 +1665,7 @@ int bdev_thaw(struct block_device *bdev);
 void bdev_fput(struct file *bdev_file);
=20
 struct io_comp_batch {
-	struct request *req_list;
+	struct rq_list req_list;
 	bool need_ts;
 	void (*complete)(struct io_comp_batch *);
 };
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 6abc495602a4..a1ed64760eba 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1190,12 +1190,12 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool fo=
rce_nonspin)
 			poll_flags |=3D BLK_POLL_ONESHOT;
=20
 		/* iopoll may have completed current req */
-		if (!rq_list_empty(iob.req_list) ||
+		if (!rq_list_empty(&iob.req_list) ||
 		    READ_ONCE(req->iopoll_completed))
 			break;
 	}
=20
-	if (!rq_list_empty(iob.req_list))
+	if (!rq_list_empty(&iob.req_list))
 		iob.complete(&iob);
 	else if (!pos)
 		return 0;

