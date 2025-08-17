Return-Path: <stable+bounces-169872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE01B29119
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 03:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A922C1B23ABF
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAB156C6A;
	Sun, 17 Aug 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A69FMf/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703A1754B
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755395372; cv=none; b=a3Y0SPrvmWkvyqHZW/zfvIvpKd3bhcuReYVPD09mNnY7nu8N+ja3pW7K1QG/YE4MywCfylMdqPAGhH8jZVFdueLClshCe0JojDoSQqswtOWtR0LJ6w/VB3v5CsPW0AFRh2uXn+cW7hDgbm2Cb6YzsrQQfcchxRH2qiacaRRAEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755395372; c=relaxed/simple;
	bh=sW75GkjrOFNEIylrxS8yvfAnps5QfhBAxsa81wOgXck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgbSsBGRgeHfPwUiXgxI5id7cHHubWWKmopCFl6/1qBCZ7qCKy8A3plobbt4jDa2xFoRlqTqLReNNCv95gkqaI4Yn4yZ1aqJR1E4w0U98kgfbRrPCqs8MW1jg0D98HkPq6ZANVoApCFJw6/Uyvjk0rnJ4cLKiGdDN70tgiCWUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A69FMf/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2AFC4CEEF;
	Sun, 17 Aug 2025 01:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755395372;
	bh=sW75GkjrOFNEIylrxS8yvfAnps5QfhBAxsa81wOgXck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A69FMf/lLkz+pRSf+yhpOS+87lABB8l6rHN/y2yQVM+IHviczENlmBxuZVYKWR6Wa
	 r+AFAz6Fiz+2XNNqyvMF6Cl6az7JwRkcoaHlMd6riDkqRm9iMlR0PjLGY6QwdlG44i
	 Dq4pqC9nXfY54CVgFDt1FNkMf+OsENH8JE/mJE7ptMmVmihELA9PB9+U+msrU4ttFP
	 qZASysoGAjpxsJVclKGFk4yPBey4LGV+FNg6lRyOQnjpXTwcqfzIGPZyE1I2b7bIr4
	 vjA7PexMHQq6/pmfSD0W7e2OIc3KchbpacwYedyJ8FiWqCMo5SFDkk/tIZaitYL1Wz
	 mg14RGW8M56XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] block: Make REQ_OP_ZONE_FINISH a write operation
Date: Sat, 16 Aug 2025 21:49:28 -0400
Message-ID: <20250817014928.1329192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081544-coliseum-cylinder-43d2@gregkh>
References: <2025081544-coliseum-cylinder-43d2@gregkh>
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
[ Extra renames ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc..4c7b7c5c8216 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -353,13 +353,13 @@ enum req_opf {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= 12,
+	REQ_OP_ZONE_FINISH	= 13,
 	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= 13,
+	REQ_OP_ZONE_APPEND	= 15,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 15,
+	REQ_OP_ZONE_RESET	= 17,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= 17,
+	REQ_OP_ZONE_RESET_ALL	= 19,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
-- 
2.50.1


