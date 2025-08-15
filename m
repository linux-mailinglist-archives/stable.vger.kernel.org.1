Return-Path: <stable+bounces-169829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147CB2882E
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B81AC3716
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA782153C7;
	Fri, 15 Aug 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRhxVPKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF628399
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295683; cv=none; b=BTx7H6QjOsxx5bqBVO1cVGxA3LbtRpqRFcPS4uJ+pjHVxGnmI/4rAT0mHpixANZjxOAhG/4+Mh4ct+EqNTRhfb3JWEWmGy68jI2MVjy41g9bk1FXplIixJR+SHnd5Qz88GRP53NrYV7eyTkPXxJEQghouuPmhcnyY2toBwA3BZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295683; c=relaxed/simple;
	bh=bJ/fO9qcIJMLq6kPhtwcGg145VT5fbGn8ELQeZ8PNdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkgjc0VijX8IjBuJ30/YxODaCA5xwtUlWn+8F8uEMDYcv4cs7WnMovPaQwKNvyG2p/lG4rhf+8YJwMNkd4i6gbiNXUZaVPGxzcKFstDqvGFFUJWSyTCwWrq1RRFySveh9esTSh5XLr6okJkmL1ieQ5zu7qw7IsO6NPK7dy9kB7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRhxVPKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2382FC4CEEB;
	Fri, 15 Aug 2025 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295682;
	bh=bJ/fO9qcIJMLq6kPhtwcGg145VT5fbGn8ELQeZ8PNdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRhxVPKUB/Drg1o7I+ahkCCQQLakx9fzaRwefLCOVb1OLwLxSOabrdy1N5zYoMF0J
	 0r68WcXOe7M6xou6YHN5ma59AGzMIUomWgoAq70Rc7SDbzkt6ZpjWBVUA6mqfXIBlP
	 o2xLjstKr/DvscoX8gkK4jGB1twSNBoAskCnNcIcBR0N+ut+uvZbZdi/lbWIIiUqgG
	 6cXnEsRKEl3c7jxipJXDEEPbbOzykOUkKgiq1Ky/4b5nnT9UDeJGkX8CVxK9TtaWpV
	 0DxA4Jc9Xp2klDdstcA3uuX8rsb3fjdh+hTANgDMaZT0LCzb9Rmw4wMaRjdaI3tWke
	 D4qQFJqD9Mkhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] block: reject invalid operation in submit_bio_noacct
Date: Fri, 15 Aug 2025 18:07:58 -0400
Message-ID: <20250815220759.248365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081543-graffiti-nastily-6e2b@gregkh>
References: <2025081543-graffiti-nastily-6e2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1c042f8d4bc342b7985b1de3d76836f1a1083b65 ]

submit_bio_noacct allows completely invalid operations, or operations
that are not supported in the bio path.  Extent the existing switch
statement to rejcect all invalid types.

Move the code point for REQ_OP_ZONE_APPEND so that it's not right in the
middle of the zone management operations and the switch statement can
follow the numerical order of the operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20231221070538.1112446-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 3f66ccbaaef3 ("block: Make REQ_OP_ZONE_FINISH a write operation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c          | 26 +++++++++++++++++++++-----
 include/linux/blk_types.h |  8 ++++----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4f25d2c4bc70..923b7d91e6dc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -775,6 +775,15 @@ void submit_bio_noacct(struct bio *bio)
 		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		break;
+	case REQ_OP_FLUSH:
+		/*
+		 * REQ_OP_FLUSH can't be submitted through bios, it is only
+		 * synthetized in struct request by the flush state machine.
+		 */
+		goto not_supported;
 	case REQ_OP_DISCARD:
 		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
@@ -788,6 +797,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (status != BLK_STS_OK)
 			goto end_io;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		if (!q->limits.max_write_zeroes_sectors)
+			goto not_supported;
+		break;
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
@@ -799,12 +812,15 @@ void submit_bio_noacct(struct bio *bio)
 		if (!bdev_is_zoned(bio->bi_bdev) || !blk_queue_zone_resetall(q))
 			goto not_supported;
 		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
+	case REQ_OP_DRV_IN:
+	case REQ_OP_DRV_OUT:
+		/*
+		 * Driver private operations are only used with passthrough
+		 * requests.
+		 */
+		fallthrough;
 	default:
-		break;
+		goto not_supported;
 	}
 
 	if (blk_throtl_bio(bio))
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 92c8997b1938..9fe714522249 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -379,6 +379,8 @@ enum req_op {
 	REQ_OP_DISCARD		= (__force blk_opf_t)3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)7,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
@@ -387,12 +389,10 @@ enum req_op {
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
-	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
-- 
2.50.1


