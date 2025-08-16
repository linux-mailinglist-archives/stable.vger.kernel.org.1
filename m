Return-Path: <stable+bounces-169843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E5B28A51
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 05:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B71C835D2
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 03:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654011C5D59;
	Sat, 16 Aug 2025 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMDXJHIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C9155333
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316086; cv=none; b=jDyBzWVAPEz8JZjyZTkVi7t0sBMN1ZCp0e6cUJAWlq2NLRky35kaZEa0OfsVXgcKysYUwJZoXpGSuqASgBHjk5hp58M14Aj95HqkAmMTmPBaDgFBlPKd9GhzKlibtojOll5HYV+z7QTVax7JszyXJmTemYxVn8Ssu3AkacyF78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316086; c=relaxed/simple;
	bh=XenhH51j0NiQKVJKh75TftHxlVN2EIUN2anXjeixQMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7CyKGk40CjR+pf7pQ6QaEZlznV3AsCJ/Jpf8DRRy9/fjt04EeaGTgi66nXVEwGwhgwjUuSE8UQpPEZbdR/96f7+LMX7XqmCb9f+g8LQOmIvM2aBz8kNNRYRwuV/3CSsqI6xJSbBusL6x6Oj9Ux9pLMQfR7OAy9wxDd8m2sXH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMDXJHIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB546C4CEF1;
	Sat, 16 Aug 2025 03:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755316085;
	bh=XenhH51j0NiQKVJKh75TftHxlVN2EIUN2anXjeixQMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMDXJHIRrr0owMK+nViSdzjVG8RHSVz67KlXdDiS+KIXDOolmUfHRL21wCXoImDmS
	 tmGd/oRzuO0HiUWWQPXxY9+k3CpuSeE8pLfxpIoOZMyKMVPVd0dj6oKABXBeVmptBA
	 LDmobO/iAjpzhSCSBR7A0HeHhpc+lk6zY7v3F3EI6bCErYvpszTkpap2dmL1PvuyYs
	 9+OYY8AH1Fb33wHFq24r71CLi7Pq/Cq1XSLaIzz7ezLVaM3xOUIA6a6lczbfjzyK2M
	 cYTxyhDPvhrH1vzzWfJ9YJmuPmHfBaA6d0uL5q7Ul/202uKDip6jJTF4BEX/CH1deE
	 l6II1MPhI/WnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] block: Make REQ_OP_ZONE_FINISH a write operation
Date: Fri, 15 Aug 2025 23:47:58 -0400
Message-ID: <20250816034758.666065-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816034758.666065-1-sashal@kernel.org>
References: <2025081543-myself-easiest-be00@gregkh>
 <20250816034758.666065-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 3f66ccbaaef3a0c5bd844eab04e3207b4061c546 ]

REQ_OP_ZONE_FINISH is defined as "12", which makes
op_is_write(REQ_OP_ZONE_FINISH) return false, despite the fact that a
zone finish operation is an operation that modifies a zone (transition
it to full) and so should be considered as a write operation (albeit
one that does not transfer any data to the device).

Fix this by redefining REQ_OP_ZONE_FINISH to be an odd number (13), and
redefine REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL using sequential
odd numbers from that new value.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250625093327.548866-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 03e570e0e5c2..7e84f414a166 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -375,11 +375,11 @@ enum req_op {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
-- 
2.50.1


