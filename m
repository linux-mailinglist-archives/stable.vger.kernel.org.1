Return-Path: <stable+bounces-66096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B670994C71D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E16285C16
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 22:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DB15A86D;
	Thu,  8 Aug 2024 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QHZS3JXl"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869D4A1E
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157717; cv=none; b=U8OQNnRPWmVOEJAQDDFmT6FHbID/WUWNW6JO8IDRCHk3smzK3a+5mO2PyW4rLYhlZGh4UsPSY+VaQBIbCSpo8IL+dCQRgUp+v+6b1LAzKbXmpTMf51ybNd8quzHQK1EXTJ08qgmZv4G4YKTtPIgR+e9rMkdwEMoBdnayazAw3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157717; c=relaxed/simple;
	bh=VJiLZ7SE31aX3ZgN6TvfSqQ5hRmIM4RaaR0z6OGgZfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4ZVWUWRqeQKItkoIdPpT/QLxAL6LusQ5YsDtRWVnTPTCAZcBpwRQ8BM/8O/lP6bRfRKQN0493ri2x45jd04xgJBpXmrieLDzdDx7PeJ+01S2t75gYjLusWtz6kTGiuf4naz4/4ucopUSGN3JM1p49MvftCIUfRNf7cZYsLzTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QHZS3JXl; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wg2SM5J2GzlgVnF;
	Thu,  8 Aug 2024 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1723157712; x=1725749713; bh=axj+c
	1K6XhQQf5+eQzWSj2mNUqnrZv1hBpn3uo44fTE=; b=QHZS3JXlRajEh/084laae
	njVNgg0GrkbFes57Fh28BmKW9Q0paC65BnILPYrQCfRPw4XZ8SAAKiAfrIA//UGn
	aylBAWpaEcfrDkBTvMtZTOPIY8y48P+1siyCbAu12D3wRI+kxMBDJzbXHdOLVab2
	uGCXv5xPO/nchZfBTZ6AGUPBaNAGIV7sHQPHo2eG30jdsXhBQ9RZYGWX2/RBWqsX
	G15qpEsYkj7BAgDnraw7vxBq9WbbsIv4Aimi/T83VF0M+7BW22ZJshBLMQzfUm/6
	KPH5onWXio0qNHq8n9nh/xKMYZlUEt/y05Px6AwcO+GcEemLtooSdz42VqhpauPe
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dzj3_hLzz9tn; Thu,  8 Aug 2024 22:55:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wg2SG3dgtzlgTGW;
	Thu,  8 Aug 2024 22:55:10 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 2/2] block/mq-deadline: Fix the tag reservation code
Date: Thu,  8 Aug 2024 15:54:59 -0700
Message-ID: <20240808225459.887764-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808225459.887764-1-bvanassche@acm.org>
References: <20240808225459.887764-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8 upstream.

The current tag reservation code is based on a misunderstanding of the
meaning of data->shallow_depth. Fix the tag reservation code as follows:
* By default, do not reserve any tags for synchronous requests because
  for certain use cases reserving tags reduces performance. See also
  Harshit Mogalapalli, [bug-report] Performance regression with fio
  sequential-write on a multipath setup, 2024-03-07
  (https://lore.kernel.org/linux-block/5ce2ae5d-61e2-4ede-ad55-5511126024=
01@oracle.com/)
* Reduce min_shallow_depth to one because min_shallow_depth must be less
  than or equal any shallow_depth value.
* Scale dd->async_depth from the range [1, nr_requests] to [1,
  bits_per_sbitmap_word].

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240509170149.7639-3-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/mq-deadline.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d18d4..ff029e1acc4d 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -597,6 +597,20 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)
 	return rq;
 }
=20
+/*
+ * 'depth' is a number in the range 1..INT_MAX representing a number of
+ * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests=
 since
+ * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow()=
.
+ * Values larger than q->nr_requests have the same effect as q->nr_reque=
sts.
+ */
+static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qde=
pth)
+{
+	struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
+	const unsigned int nrr =3D hctx->queue->nr_requests;
+
+	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
+}
+
 /*
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by th=
is
  * function is used by __blk_mq_get_tag().
@@ -613,7 +627,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_=
mq_alloc_data *data)
 	 * Throttle asynchronous requests and writes such that these requests
 	 * do not block the allocation of synchronous requests.
 	 */
-	data->shallow_depth =3D dd->async_depth;
+	data->shallow_depth =3D dd_to_word_depth(data->hctx, dd->async_depth);
 }
=20
 /* Called by blk_mq_update_nr_requests(). */
@@ -623,9 +637,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)
 	struct deadline_data *dd =3D q->elevator->elevator_data;
 	struct blk_mq_tags *tags =3D hctx->sched_tags;
=20
-	dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
+	dd->async_depth =3D q->nr_requests;
=20
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
 }
=20
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */

