Return-Path: <stable+bounces-160703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A1AFD16D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2EF58264A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E982E542C;
	Tue,  8 Jul 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQB//rOv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B672E5418;
	Tue,  8 Jul 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992446; cv=none; b=Gq6h/zBuyMtrKfqF9biHp+xuehJ7frudPe9SjysiwmTxmL05zFRVS5Zv4lUiiB8GoGV3iW3yfNOOuB5B2g50Z6dNbJuar2qhr7jmQu7ZW5BcPiWMD9xXhyjHsYmCTucyeNk3hKhQQ9XdmJdeT7D6ZqUlUe4U5PCXJoFg84uPEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992446; c=relaxed/simple;
	bh=zXTLyPXkulKbNiAA26oaalGOc/Q1ftNeE+f9VCb17PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIY2aa5c+I/vQ4UrNWmzjqDIpAeOj4Khyng+UXZsp6CvKHd+0sZ6NJBWIRMjYwKp94GXt08lJjPXu8baaySV94soNw2nE5FkkWqNFuVHUfkzalpJvviRdJ3ap1KhCgaGBnKAP5negJqZu3NjzY40ZL4pgaT1n/D3arTfbw8Mv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQB//rOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F598C4CEED;
	Tue,  8 Jul 2025 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992445;
	bh=zXTLyPXkulKbNiAA26oaalGOc/Q1ftNeE+f9VCb17PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQB//rOvkI7kpvst8KJwQHFmK2RtxnuR9S0DV9QgIhYuEsWwI7V6NUFETxBD1pp0k
	 bJYbxrYhFUHRdrl7zbVyYuRlBgZPbBJ9f4HLc7d0gPvJ8H1hFNya+AgW7qZkfK8ZJG
	 MAEAAyh1NtluI74n8uO5tqwbglV9P9J30P2zQ0wU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Sanders <jsanders.devel@gmail.com>,
	Valentin Kleibel <valentin@vrvis.at>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 094/132] aoe: defer rexmit timer downdev work to workqueue
Date: Tue,  8 Jul 2025 18:23:25 +0200
Message-ID: <20250708162233.366877694@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 280679bde3a50..4240e11adfb76 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -200,8 +200,11 @@ aoedev_downdev(struct aoedev *d)
 	struct list_head *head, *pos, *nx;
 	struct request *rq, *rqnext;
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




