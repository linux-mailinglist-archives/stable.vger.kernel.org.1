Return-Path: <stable+bounces-192200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65239C2BD21
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AA4188A3DD
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A72D8360;
	Mon,  3 Nov 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa4rSely"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341E22A4D8
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173995; cv=none; b=b4K6M240RP2CTC1rZYw0m0Fs4NWfZSeQWajqJN16spEjQ2diWSLPkith1ddR0BIt8hNuKg1JyvjV1uPyH+g7N+sEno0F5+3tziMTAdZ1qr2nvrovCWH/1kRUpO4r5Dl7FQTumXSaGa+1cJLMo9hAyuKobJnKNtWC5U9MEP9x9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173995; c=relaxed/simple;
	bh=yKJbnv1pY54Y/fZecMe9JuVY6CmNAyFtw/uq5eTj3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2DsfgG5Z3w/90ePIOhK9cUqw57wq3yBHhN0xLnjRrMi8zYLJ1yg1w+Q9e9PkwzSLi6b45cPTIPy3/79nhTDcO1EbmRNwzINvJm6ZFtXuG9LnZDqrnAnC3KcHNMkAkXmqUgNvLI30FQatGuV+gLNZ7n7zx+zIOPteqY9qMpHfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa4rSely; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C5C4CEE7;
	Mon,  3 Nov 2025 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762173994;
	bh=yKJbnv1pY54Y/fZecMe9JuVY6CmNAyFtw/uq5eTj3dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aa4rSely4SLygcebPq7Snv2dCdirYep6wIS7aCIqXn2uihWqQTfAzQLkUQgjTOaYW
	 WnCRatCMXzRRvbs+roCJvNl2y5MiT1Lbv+Q15kEK4/DQCb+wuFLeJRtUv2GG2RhD4+
	 fEORcJwWaI2Q+E4/Mot5ifZHxVmqIh/Ec7LqZPqFvw9YWlhnxGHC+TbtBxcGxCp7QI
	 Cy4F6yhMl3bdJlK/MmK1W/6D0RcJ2VgrzZvtIxMX/RvLccmKVeIXRJVm1oTfvgo6Wn
	 MiGS95ZJqqw3uRs1PlTeEeKxCrMsKjPTBAL3cLHIrPoWj8+l9NNVikS8qqgmM7pYZm
	 2VP1TrKzEZAaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] block: make REQ_OP_ZONE_OPEN a write operation
Date: Mon,  3 Nov 2025 07:46:31 -0500
Message-ID: <20251103124631.4003336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110306-catcher-numerous-6cd3@gregkh>
References: <2025110306-catcher-numerous-6cd3@gregkh>
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
index 86da1c97e4abe..264f24f7225bd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -337,17 +337,17 @@ enum req_opf {
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
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= 34,
-- 
2.51.0


