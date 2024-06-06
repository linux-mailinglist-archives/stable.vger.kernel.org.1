Return-Path: <stable+bounces-48915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B58FEB16
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ADC28A3B9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C91199387;
	Thu,  6 Jun 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhrbLA+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CA199383;
	Thu,  6 Jun 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683209; cv=none; b=sTSAzjHl3s/yOeehFn9xECgHEGSbxKH+1x+EwYF8OtnLoi2dwaVAW3zOXC+0Bwr7WPWPlI1Woa20ahwHLnCN4e45DXgtBf42HOGnsf5giYmwLMz/ZEz3+wCJ33lc2F4c+spxr5/pU5NPR4V4Y5hLZQqgwO+rVfR7mlcQYP/J7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683209; c=relaxed/simple;
	bh=nbpHq8U4YxJqX04MXftGLbq38zWkZLVUUqxhmxFCPYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIi2W3PdrfppN7TX8rm5dOT4VrlJikt+wVENfo/tZhyWf3sy9tY1BL7UZSgsHbsVZWFkmwksqdO4oGc5vXmSyC732za3M6xwLfoKcQssbn4OmLNNe1BZQg7kEg9+YgIVu+3dO4lp4YctgxNF48O7frheup8KzvB1gOPMBhXPqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhrbLA+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2A4C32781;
	Thu,  6 Jun 2024 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683209;
	bh=nbpHq8U4YxJqX04MXftGLbq38zWkZLVUUqxhmxFCPYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhrbLA+WeqNukzLwbXWrMyy5Ay6aVtTjfw1Sy9GW2vORHWrPxpIfWcXfKSX6xHyGh
	 hIGp01S5otjCTts6ecu/wBjj8hfFi4w8d/Ftu5b7l9On76EEYIZrb2T/taX2CZHVfu
	 m+LP4U5pkz3o1HjXkGbUeqALrqDapfN+KRDDdvAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/473] block: open code __blk_account_io_start()
Date: Thu,  6 Jun 2024 16:00:16 +0200
Message-ID: <20240606131702.781079356@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit e165fb4dd6985b37215178e514a2e09dab8fef14 ]

There is only one caller for __blk_account_io_start(), the function
is small enough to fit in its caller blk_account_io_start().

Remove the function and opencode in the its caller
blk_account_io_start().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20230327073427.4403-2-kch@nvidia.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 99dc422335d8 ("block: support to account io_ticks precisely")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1b12f3d54bd4..33ac49dc775d7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -994,28 +994,24 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		__blk_account_io_done(req, now);
 }
 
-static void __blk_account_io_start(struct request *rq)
-{
-	/*
-	 * All non-passthrough requests are created from a bio with one
-	 * exception: when a flush command that is part of a flush sequence
-	 * generated by the state machine in blk-flush.c is cloned onto the
-	 * lower device by dm-multipath we can get here without a bio.
-	 */
-	if (rq->bio)
-		rq->part = rq->bio->bi_bdev;
-	else
-		rq->part = rq->q->disk->part0;
-
-	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
-	part_stat_unlock();
-}
-
 static inline void blk_account_io_start(struct request *req)
 {
-	if (blk_do_io_stat(req))
-		__blk_account_io_start(req);
+	if (blk_do_io_stat(req)) {
+		/*
+		 * All non-passthrough requests are created from a bio with one
+		 * exception: when a flush command that is part of a flush sequence
+		 * generated by the state machine in blk-flush.c is cloned onto the
+		 * lower device by dm-multipath we can get here without a bio.
+		 */
+		if (req->bio)
+			req->part = req->bio->bi_bdev;
+		else
+			req->part = req->q->disk->part0;
+
+		part_stat_lock();
+		update_io_ticks(req->part, jiffies, false);
+		part_stat_unlock();
+	}
 }
 
 static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
-- 
2.43.0




