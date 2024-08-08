Return-Path: <stable+bounces-66095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861D94C71B
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE801F25A54
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DA15ADBB;
	Thu,  8 Aug 2024 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MRU9Cj4A"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FB4A1E
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723157715; cv=none; b=LRuF1TtTViDH0iI0Hep41Dh1HBIk8RndJLGhg6DxE5yyX2q3uEC+H+idZ9IuPYQfBJXLp4TtWTCYoEsASg6x+gZO4SW6aGceBoMC5pd/+VbC2x0PmVtmfSFmMZJyP+XbuSmkJ7wjeToGPf0d4Hw+OaEgyUrCABtlYdLNBBLav+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723157715; c=relaxed/simple;
	bh=3IzfdR0Yycmcmhdci/oIZRvLyzZ79LMQ+2gjw9Pt8Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPGIw4c67UzcqG4BCZscRXrcWfTCnf/3tez4SgkLAlQXQGRL+7OdCNxwvAQLCx/2SUBcUjXBCaGOtUYlH/TgZiTZggbDY+cf5CQtxWYuRrVKVIWj8n+gh9VhQ9coprdZemQMv2yZNNrCoWwKAH5p+UCeblwhQfQeNbcCGJP5N7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MRU9Cj4A; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wg2SJ5b67zlgT1M;
	Thu,  8 Aug 2024 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1723157710; x=1725749711; bh=7Qai9
	fT8+as+G93XByVWkqVokqzo/q2C91NhDzzh4tc=; b=MRU9Cj4AAu1Fhmj8DWCAm
	xoBNqAs1KfWfrrJjk/57pxYD9ieV1lLOBUHH38LeuwjTTg6e/52OwdfLLo9wnqP8
	3wAu8nu8G7RjpPNWySLVCAs7dXUGEuu2tc+0QhWZVAL65hCJoC/twZwGvaqBZ6XN
	ii/3SBocr1pTFNy5oEilPcTS3NqyONno+IgmayxkjvhM/G+aKRXm614tsIsMrstT
	lj+vpkDmuHmwOTQz9YCbHUqPKA8lC6x+ZzzaVGrBJegi/llIdBePLelXmUOGR5Wq
	mVyqTDn/RLFcY8nZPITseecbiJk/fUgZBbJn1o2f4ic3kzDSvTl0DmbQXuAnm0+H
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U2B0OhN-kUNw; Thu,  8 Aug 2024 22:55:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wg2SD36SmzlgVnF;
	Thu,  8 Aug 2024 22:55:08 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 1/2] block: Call .limit_depth() after .hctx has been set
Date: Thu,  8 Aug 2024 15:54:58 -0700
Message-ID: <20240808225459.887764-2-bvanassche@acm.org>
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

commit 6259151c04d4e0085e00d2dcb471ebdd1778e72e upstream.

Call .limit_depth() after data->hctx has been set such that data->hctx ca=
n
be used in .limit_depth() implementations.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240509170149.7639-2-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3afa5c8d165b..daf0e4f3444e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -439,6 +439,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_dat=
a *data,
=20
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data =
*data)
 {
+	void (*limit_depth)(blk_opf_t, struct blk_mq_alloc_data *) =3D NULL;
 	struct request_queue *q =3D data->q;
 	u64 alloc_time_ns =3D 0;
 	struct request *rq;
@@ -465,7 +466,7 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 		    !blk_op_is_passthrough(data->cmd_flags) &&
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
-			e->type->ops.limit_depth(data->cmd_flags, data);
+			limit_depth =3D e->type->ops.limit_depth;
 	}
=20
 retry:
@@ -477,6 +478,9 @@ static struct request *__blk_mq_alloc_requests(struct=
 blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_RESERVED)
 		data->rq_flags |=3D RQF_RESV;
=20
+	if (limit_depth)
+		limit_depth(data->cmd_flags, data);
+
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */

