Return-Path: <stable+bounces-158274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD4AE5B21
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 06:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A43D1897749
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 04:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00303242D9A;
	Tue, 24 Jun 2025 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc+iYBCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC106221F34;
	Tue, 24 Jun 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738350; cv=none; b=VddJ6KS00DZ/m6CRnq0jFGSIx8JE+vPu1uRsa7h9uQRHzPYiVSBkLNMJ2a96nXmdTN/Xhijy8gGHHATDnu0pcE8D8L4T25PpwaMAKphpP3+aLM6oudtCzXyuTOfu0TO26XUgaYA2t29kUDCMY3aVAbgo2vxbl0dLIp2MZfdNHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738350; c=relaxed/simple;
	bh=n4rP5SHDSPoMWzPQ927lPKIYCEIu1fqSCSrktOkv3e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/zAlaK0T85K/xVbC6jfTqUY4T505BBajVPXg+TPDaxSSlRfYgvtlKH/s9jU0Fljgsn2wjKu2ccqA/zcP/N1or2+403tr4W09eFKo+KMyHWw8B9Zt6lByr16fa4Ft6vEACU2oiK1aAeFB4RvHh+4UsdZSRCvTYGPz73Tnztvo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc+iYBCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C176C4CEF2;
	Tue, 24 Jun 2025 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738350;
	bh=n4rP5SHDSPoMWzPQ927lPKIYCEIu1fqSCSrktOkv3e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lc+iYBCJHg7SwuFvnBPY4085k5lcKucDn6KKbW4g5I6CkZ9vLl6a0oY0HYOxTF7T0
	 +aMwsznEQMJInRGEusy3Cp/X+WmXKCXPELJM/MJ9t5qRw53zLiNHDH2j1MCGO9QxNg
	 u83RpoMuGfwa+JlGm2jrePKagkJcWiOj//fZ6lYjJbDcW9Y6Yol0rMGSqa5K47nrVr
	 dW56Eq4dayhOi65gSsH5GkupQT1lWDGu+ylf4NY/G/CYATZ2dcvpczt12ruxKcWC5W
	 7zGepnrdStLmIMqevIRQ+vvJPLq+LJpAeQlJo3ODpTZTtCPTTzJuHqxocwtYb5QDgZ
	 mYrPVebTrc+5Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Justin Sanders <jsanders.devel@gmail.com>,
	Valentin Kleibel <valentin@vrvis.at>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	justin@coraid.com
Subject: [PATCH AUTOSEL 6.6 13/18] aoe: defer rexmit timer downdev work to workqueue
Date: Tue, 24 Jun 2025 00:12:09 -0400
Message-Id: <20250624041214.84135-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041214.84135-1-sashal@kernel.org>
References: <20250624041214.84135-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.94
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Justin Sanders <jsanders.devel@gmail.com>

[ Upstream commit cffc873d68ab09a0432b8212008c5613f8a70a2c ]

When aoe's rexmit_timer() notices that an aoe target fails to respond to
commands for more than aoe_deadsecs, it calls aoedev_downdev() which
cleans the outstanding aoe and block queues. This can involve sleeping,
such as in blk_mq_freeze_queue(), which should not occur in irq context.

This patch defers that aoedev_downdev() call to the aoe device's
workqueue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212665
Signed-off-by: Justin Sanders <jsanders.devel@gmail.com>
Link: https://lore.kernel.org/r/20250610170600.869-2-jsanders.devel@gmail.com
Tested-By: Valentin Kleibel <valentin@vrvis.at>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the kernel repository context,
here is my determination:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive explanation:

## 1. **Critical Bug Fix for Kernel Crash/Hang**

The commit fixes a serious "scheduling while atomic" bug that can cause
kernel crashes. The issue occurs when:
- The `rexmit_timer()` function (timer callback, runs in softirq
  context) detects a device timeout
- It directly calls `aoedev_downdev()` which contains
  `blk_mq_freeze_queue()` - a sleeping operation
- Calling a sleeping function from atomic context violates kernel rules
  and causes crashes

## 2. **Clear Root Cause and Minimal Fix**

The fix is minimal and targeted:
- Adds a new flag `DEVFL_DEAD` to mark devices that need to be downed
- Instead of calling `aoedev_downdev()` directly from timer context, it
  sets the flag and queues work
- The actual `aoedev_downdev()` call happens in workqueue context where
  sleeping is allowed

## 3. **Part of a Series Fixing Related Issues**

This is part of a series addressing bugzilla #212665, including:
- This commit: Fixes the timer context sleeping issue
- Commit 7f90d45e57cb: Fixes the hang in `blk_mq_freeze_queue()` by
  properly cleaning request lists

Both commits are needed to fully resolve the reported issue.

## 4. **Regression from blk-mq Conversion**

The issue was introduced by commit 3582dd291788 ("aoe: convert aoeblk to
blk-mq"), making this a regression fix. The blk-mq conversion added
sleeping operations that weren't safe to call from existing timer
contexts.

## 5. **Similar to Previously Backported Fixes**

Looking at the similar commits:
- Commit 430380b4637a (fixing atomic sleep in flush) was marked as
  suitable for backporting
- It addressed the same class of bug in a different code path
- This establishes precedent for backporting such fixes

## 6. **Minimal Risk of Regression**

The changes are:
- Well-contained to the aoe driver
- Follow established patterns (deferring to workqueue)
- Don't change any user-visible behavior
- Only change the execution context of an existing operation

## 7. **Meets Stable Criteria**

According to stable tree rules, this commit:
- ✓ Fixes a real bug (kernel crash/scheduling while atomic)
- ✓ Has been tested (per commit message)
- ✓ Is minimal and targeted
- ✓ Fixes a regression from previous changes
- ✓ Has clear explanation and reproducer (bugzilla link)

The only consideration is that it should be backported together with
commit 7f90d45e57cb to ensure the complete fix for bugzilla #212665 is
applied.

 drivers/block/aoe/aoe.h    | 1 +
 drivers/block/aoe/aoecmd.c | 8 ++++++--
 drivers/block/aoe/aoedev.c | 5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4cf..d35caa3c69e15 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -80,6 +80,7 @@ enum {
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 	DEVFL_FREEING = (1<<7),	/* set when device is being cleaned up */
 	DEVFL_FREED = (1<<8),	/* device has been cleaned up */
+	DEVFL_DEAD = (1<<9),	/* device has timed out of aoe_deadsecs */
 };
 
 enum {
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d1f4ddc576451..c4c5cf1ec71ba 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -754,7 +754,7 @@ rexmit_timer(struct timer_list *timer)
 
 	utgts = count_targets(d, NULL);
 
-	if (d->flags & DEVFL_TKILL) {
+	if (d->flags & (DEVFL_TKILL | DEVFL_DEAD)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -786,7 +786,8 @@ rexmit_timer(struct timer_list *timer)
 			 * to clean up.
 			 */
 			list_splice(&flist, &d->factive[0]);
-			aoedev_downdev(d);
+			d->flags |= DEVFL_DEAD;
+			queue_work(aoe_wq, &d->work);
 			goto out;
 		}
 
@@ -898,6 +899,9 @@ aoecmd_sleepwork(struct work_struct *work)
 {
 	struct aoedev *d = container_of(work, struct aoedev, work);
 
+	if (d->flags & DEVFL_DEAD)
+		aoedev_downdev(d);
+
 	if (d->flags & DEVFL_GDALLOC)
 		aoeblk_gdalloc(d);
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a00..5f42c1a14b805 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -199,8 +199,11 @@ aoedev_downdev(struct aoedev *d)
 	struct aoetgt *t, **tt, **te;
 	struct list_head *head, *pos, *nx;
 	int i;
+	unsigned long flags;
 
-	d->flags &= ~DEVFL_UP;
+	spin_lock_irqsave(&d->lock, flags);
+	d->flags &= ~(DEVFL_UP | DEVFL_DEAD);
+	spin_unlock_irqrestore(&d->lock, flags);
 
 	/* clean out active and to-be-retransmitted buffers */
 	for (i = 0; i < NFACTIVE; i++) {
-- 
2.39.5


