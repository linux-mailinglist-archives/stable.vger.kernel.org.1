Return-Path: <stable+bounces-134643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BDA93C66
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12159188D624
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6221C9F7;
	Fri, 18 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wQMnCzSH"
X-Original-To: stable@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9621ADC5
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998877; cv=none; b=m9F2IyazWqhZT9pR9ufUSzPkH3w6HIUl41cuH7VfQHVgzV5iMBuJmdyHwXesTMowz/dwrMDRSYN6Aa//EuWnyDK4TNc1XSsG05I0x+5Q3TS3ZYjdoQgZoocc8emS6cQu8/1Tq9H3Q6Z7PTRVu93RyMjxQBCh/ZzEwsdY7cNrjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998877; c=relaxed/simple;
	bh=o8C7A5nKQwQTyIESy8LSJpXNqXMkY5846rISVa46hrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd+/RhPK9i8S5NTFuLxYqaHe1MUVfU738oXEiGmncxtM9r7RiPyxGBa0D1qrxaGIIFU7hhpcCuObrm/9fOgPi6QUe27AYhDFOhq1i/Oso9RygDq9X5ARoveG7hByd0lREZXlBsflyRp9BDwhJhHPLeChVBiT1XCKttozKm92S4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wQMnCzSH; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZfMpd6JxFzlxW5M;
	Fri, 18 Apr 2025 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1744998872; x=1747590873; bh=lqGrq
	q70W7otRDOThFH++VgFho3plmK2ibleTydJcWo=; b=wQMnCzSH9NJOqvPwu9p4Z
	uzhDb2liK5doFh4+jVlByVhSVJfaJmgVJ9wq3/CKLUFunlT5JVIAlUICYtI9C337
	XJ2MPj5Wvvgb6wYjy5KoDxvfUp3E/kI3IPXzgiQ9Y4ZTZ5g8t2leiPM00mzCabYH
	0yCUsWs5QJTH04HtZgxLB739ndO2g0N+PgNidhRupkfDcequ1o+NwAwPPlSmQf1a
	nuQrmo5JRdgYVkxNWhI1QzmwQdqb4Bq7YTs2MXv2mmtPhvG8VXWNGF7Op3b4Eunk
	PIe0hJSNIU6BPOZdljDRUaMvN6D8Wm3KLM9tYQ+4LNN10G6rk/W03aFvdl1lMzV2
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hbYx_8k6aB0y; Fri, 18 Apr 2025 17:54:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZfMpV6pcCzlgqV9;
	Fri, 18 Apr 2025 17:54:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] block: don't reorder requests in blk_add_rq_to_plug
Date: Fri, 18 Apr 2025 10:54:01 -0700
Message-ID: <20250418175401.1936152-4-bvanassche@acm.org>
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

Upstream commit e70c301faece15b618e54b613b1fd6ece3dd05b4.

Add requests to the tail of the list instead of the front so that they
are queued up in submission order.

Remove the re-reordering in blk_mq_dispatch_plug_list, virtio_queue_rqs
and nvme_queue_rqs now that the list is ordered as expected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241113152050.157179-6-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c             | 4 ++--
 drivers/block/virtio_blk.c | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c7fb3722d620..f26bee562693 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1386,7 +1386,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plu=
g, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator =3D true;
-	rq_list_add_head(&plug->mq_list, rq);
+	rq_list_add_tail(&plug->mq_list, rq);
 	plug->rq_count++;
 }
=20
@@ -2840,7 +2840,7 @@ static void blk_mq_dispatch_plug_list(struct blk_pl=
ug *plug, bool from_sched)
 			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
-		list_add(&rq->queuelist, &list);
+		list_add_tail(&rq->queuelist, &list);
 		depth++;
 	} while (!rq_list_empty(&plug->mq_list));
=20
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2069bf9701f5..fd6c565f8a50 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -514,7 +514,7 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
 		vq =3D this_vq;
=20
 		if (virtblk_prep_rq_batch(req))
-			rq_list_add_head(&submit_list, req); /* reverse order */
+			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e943c1be0fca..e70618e8d35e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1026,7 +1026,7 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvmeq =3D req->mq_hctx->driver_data;
=20
 		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add_head(&submit_list, req); /* reverse order */
+			rq_list_add_tail(&submit_list, req);
 		else
 			rq_list_add_tail(&requeue_list, req);
 	}

