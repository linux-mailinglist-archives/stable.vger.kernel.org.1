Return-Path: <stable+bounces-192217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CECC2C9A9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7085344FF4
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654073148C8;
	Mon,  3 Nov 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZzT0j/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F330E842
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181960; cv=none; b=pvPlCSiABuWn5D3Xw1LBzNIoC2otlGv6JkaGSuxrOneMB5VE4TTP/PpQGh+ALHC2PJRmcKEjsaJQLoCxZFTr+40/B5HBPe5oP0UyDKl8AKAmftU4RbhvaIkEjbEyFezxa5My7E/YDJJjJ2S6nEflBWJZ+LaHmR85L0m+XPPhOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181960; c=relaxed/simple;
	bh=KR5MIgYDh6KHr6N/43cOyZbGusZMxpyl2JZf8exChwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4L7yrIr7rFbIRjsTCxbMIVHiakOZlqFw4pG6xSGmkh/3ih1L4b5zD3gb0K8uQjhsYGYmahw5Vlaw6IjNsDHTa+sJ1TmbsGST6G1Pqvi36f55pLkSXVqiwo0kzKUewcBpAX/nwYC8RV9VLQgn3IsTDYA42g62xWWrJ3gLyqDGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZzT0j/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD52AC4CEE7;
	Mon,  3 Nov 2025 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181959;
	bh=KR5MIgYDh6KHr6N/43cOyZbGusZMxpyl2JZf8exChwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZzT0j/tLeblLLjLHyiEKvmZzG4AKLKAsM/uXDXkHcLYADkUqq2ojm4w2pqcBxM1o
	 xSgVw09zbXwKTb6cCRHvCmuWPfYKYY9RMFG0L5kwInF8Ne2FOA1kl8VqzN+VayqQqC
	 I8FsQat1OZ6RZHrpIMhonZr7ehhtsABa0hfQawieOg9X8qVuHKYe4Slwknb5m+Yggd
	 7EHQZnayKjA+TytXkBKeWl0y+LxA92g4kDdEM4bl6+HAL1F61mhqX6UWWBIYWiRjSC
	 YmUAquYQ+zUXWCzf34VVmPqhtM2XKby72PMmHw0A+hRskJiU4iHt/AFW6ewz6PwShX
	 atNQq4R2+swog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] block: make REQ_OP_ZONE_OPEN a write operation
Date: Mon,  3 Nov 2025 09:59:16 -0500
Message-ID: <20251103145916.4040700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110306-unclaimed-spinach-e0cc@gregkh>
References: <2025110306-unclaimed-spinach-e0cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 19de03b312d69a7e9bacb51c806c6e3f4207376c ]

A REQ_OP_OPEN_ZONE request changes the condition of a sequential zone of
a zoned block device to the explicitly open condition
(BLK_ZONE_COND_EXP_OPEN). As such, it should be considered a write
operation.

Change this operation code to be an odd number to reflect this. The
following operation numbers are changed to keep the numbering compact.

No problems were reported without this change as this operation has no
data. However, this unifies the zone operation to reflect that they
modify the device state and also allows strengthening checks in the
block layer, e.g. checking if this operation is not issued against a
read-only device.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ relocated REQ_OP_ZONE_APPEND from 15 to 21 to resolve numbering conflict ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4c7b7c5c82169..ee61e0831e1cf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -349,17 +349,17 @@ enum req_opf {
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 	/* Open a zone */
-	REQ_OP_ZONE_OPEN	= 10,
+	REQ_OP_ZONE_OPEN	= 11,
 	/* Close a zone */
-	REQ_OP_ZONE_CLOSE	= 11,
+	REQ_OP_ZONE_CLOSE	= 13,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= 13,
-	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= 15,
+	REQ_OP_ZONE_FINISH	= 15,
 	/* reset a zone write pointer */
 	REQ_OP_ZONE_RESET	= 17,
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= 19,
+	/* write data at the current zone write pointer */
+	REQ_OP_ZONE_APPEND	= 21,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
-- 
2.51.0


