Return-Path: <stable+bounces-119174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFACA424E2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814A81897845
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B024886B;
	Mon, 24 Feb 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j04VQpH2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645324634F;
	Mon, 24 Feb 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408572; cv=none; b=JvVQ0DZV5wIX9cf8NVXbVG1pfgbs4pYFQU7hkLAZVHmQ8nxxONfGU0b+F9kjAz+7XPfK3bMJNS1ol9SVo9xQ8DQgRP+ELjnwL5J6MmkJ350SbS/eF57IYlTKi5HPUyN3FOdFJBJev9iPm+sf1KzdN/3VUwhwszLrdMy4mvvDlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408572; c=relaxed/simple;
	bh=RPTMrh6G/eKrAQeLZSWODbShVtsZrmvpN4qlOUr9rSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/R2y/jM5gskUcr/AluMZi5cwfLqL8gAGUop77ZpcD6aY8CDpbwlR7O73Sz16ocCDZHXNAg0azVfunHxN39PDEVUpv8kgJSGN8QfqzyQoA4/wkGTc+LxCLpTtmRRfmCwn6FXmo373UPwiAb3+KYpkR6zdTRtsxjLocks4+jz/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j04VQpH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195DC4CED6;
	Mon, 24 Feb 2025 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408571;
	bh=RPTMrh6G/eKrAQeLZSWODbShVtsZrmvpN4qlOUr9rSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j04VQpH2OB6ZtierLWH+GFxZlgFTn20k9JmHA8lJM7iY6p1rU3/u/2O3mUUClNnjg
	 ceo2q9Gq3SG0gjrVPPe9x9qSqRzo8FkAeqh0iC6q9gU0DQYuHXlMI2lllx15LQnnLr
	 jW6cwZ6WHtHq/qo0FnX0zbVfFZOIb80qidA2+ErI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 089/154] md/raid*: Fix the set_queue_limits implementations
Date: Mon, 24 Feb 2025 15:34:48 +0100
Message-ID: <20250224142610.558327170@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit fbe8f2fa971c537571994a0df532c511c4fb5537 ]

queue_limits_cancel_update() must only be called if
queue_limits_start_update() is called first. Remove the
queue_limits_cancel_update() calls from the raid*_set_limits() functions
because there is no corresponding queue_limits_start_update() call.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: c6e56cf6b2e7 ("block: move integrity information into queue_limits")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-raid/20250212171108.3483150-1-bvanassche@acm.org/
Signed-off-by: Yu Kuai <yukuai@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid0.c  | 4 +---
 drivers/md/raid1.c  | 4 +---
 drivers/md/raid10.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 32d5875247784..31bea72bcb01a 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -385,10 +385,8 @@ static int raid0_set_limits(struct mddev *mddev)
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.io_opt = lim.io_min * mddev->raid_disks;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d83fe3b3abc00..8a994a1975ca7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3171,10 +3171,8 @@ static int raid1_set_limits(struct mddev *mddev)
 	md_init_stacking_limits(&lim);
 	lim.max_write_zeroes_sectors = 0;
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index daf42acc4fb6f..a214fed4f1622 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3963,10 +3963,8 @@ static int raid10_set_queue_limits(struct mddev *mddev)
 	lim.io_min = mddev->chunk_sectors << 9;
 	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
 	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
-	if (err) {
-		queue_limits_cancel_update(mddev->gendisk->queue);
+	if (err)
 		return err;
-	}
 	return queue_limits_set(mddev->gendisk->queue, &lim);
 }
 
-- 
2.39.5




