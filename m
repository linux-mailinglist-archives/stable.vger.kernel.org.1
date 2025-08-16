Return-Path: <stable+bounces-169842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F297B28A50
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 05:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75346586E21
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9A19E971;
	Sat, 16 Aug 2025 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlN5hgih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8B155333
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316085; cv=none; b=Cw/kRkOyPSmXornYvFka3LpgU8TGNHWtlvYcYVOPyN0OnC9A9fbLu1cm7ySS6xYqIVTGy9Stn2uspRa9HFMbAhnpHr9DSZ555nGO5lHjZcoGkVBwjLKyVQfqXs+NLrB+c2qrt/DXFlUPd6CAeWvA2FBjS1uUjaXc8MnClfOmt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316085; c=relaxed/simple;
	bh=FEM+jBNpxqkjnZ9K4qKTxJTlzecji7KntY4i+6RNlbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UflkLjncroufIDpP4onwApI+B2FAsZpsRd5WLknCv/RgANtoGPy/d45qQtwTEBK4puDpM73m3N3Hj8p3jxu0Mbrl1OnAAqv9trNPcO8wFG2+k2spSkwHMdzQ2mCyc1NV+OgP3GEYA0MhpcET68XFUSZLoiKUOOlxaqEP2IMdzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlN5hgih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC803C4CEEF;
	Sat, 16 Aug 2025 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755316084;
	bh=FEM+jBNpxqkjnZ9K4qKTxJTlzecji7KntY4i+6RNlbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VlN5hgihKcF4YNM3FzXiOLr7jaHlUYSCExALH9aAAYvzZoN7tInVDYKiMTZiu81Ab
	 Sfn53LjMJcSKissSm2d6biHRecJoBqtVRqnZU87tPj/ruvRwJi98FJSqKGu0RqVuPd
	 EeHaKeTKL32aclMYGoQWYtT+p9Tx0Nwun1JM4ns7RyZ4lQWb2nHeHJXULTRsCEGNUh
	 B+VPaqqUitC+zjHTk4MXhIDIzPPuRGxNB0QtwyUBlO8JjW7c0gh/MhdP5b/S/g2cVQ
	 9OriaEIkvqchtDkUIgAylju146EbLXhYgsX/WkfrwuAsK7xytIpOp1piaoFGwQqjmj
	 lNd/ZJhGV81SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] block: reject invalid operation in submit_bio_noacct
Date: Fri, 15 Aug 2025 23:47:57 -0400
Message-ID: <20250816034758.666065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081543-myself-easiest-be00@gregkh>
References: <2025081543-myself-easiest-be00@gregkh>
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
index 94941e3ce219..25b4733f25d3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -755,6 +755,15 @@ void submit_bio_noacct(struct bio *bio)
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
@@ -768,6 +777,10 @@ void submit_bio_noacct(struct bio *bio)
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
@@ -779,12 +792,15 @@ void submit_bio_noacct(struct bio *bio)
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
index e0b098089ef2..03e570e0e5c2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -366,6 +366,8 @@ enum req_op {
 	REQ_OP_DISCARD		= (__force blk_opf_t)3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)7,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
@@ -374,12 +376,10 @@ enum req_op {
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


