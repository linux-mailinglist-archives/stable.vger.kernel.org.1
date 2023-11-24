Return-Path: <stable+bounces-161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11F7F7406
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B98281DE0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334701D690;
	Fri, 24 Nov 2023 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="awIhc0LS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3F1A71D
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F0BC433C8;
	Fri, 24 Nov 2023 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700829802;
	bh=MyF+lUsAHN4Tt6joRtbv0IkJXIdeKD6JsuG0ERtV2fk=;
	h=Subject:To:Cc:From:Date:From;
	b=awIhc0LSWIH1yT/NzoZewrvNj9+UOlwciP+5iZCWM0pMc1EWH2jfoP0lbcgl47ijW
	 lV3ZXwgdAtJ6cUSsuYsCZTb6qTqUZVYZ2wEtUoujl7WYkemgOFJq7uy22HgLc3/w1T
	 Oqphwvcl7UzlNGxavskD+2cIdoMRypbaVOU50xE0=
Subject: FAILED: patch "[PATCH] dm-delay: fix a race between delay_presuspend and delay_bio" failed to apply to 6.6-stable tree
To: mpatocka@redhat.com,snitzer@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:43:20 +0000
Message-ID: <2023112420-spiritism-september-a7e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6fc45b6ed921dc00dfb264dc08c7d67ee63d2656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112420-spiritism-september-a7e1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

6fc45b6ed921 ("dm-delay: fix a race between delay_presuspend and delay_bio")
70bbeb29fab0 ("dm delay: for short delays, use kthread instead of timers and wq")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fc45b6ed921dc00dfb264dc08c7d67ee63d2656 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Nov 2023 18:21:14 +0100
Subject: [PATCH] dm-delay: fix a race between delay_presuspend and delay_bio

In delay_presuspend, we set the atomic variable may_delay and then stop
the timer and flush pending bios. The intention here is to prevent the
delay target from re-arming the timer again.

However, this test is racy. Suppose that one thread goes to delay_bio,
sees that dc->may_delay is one and proceeds; now, another thread executes
delay_presuspend, it sets dc->may_delay to zero, deletes the timer and
flushes pending bios. Then, the first thread continues and adds the bio to
delayed->list despite the fact that dc->may_delay is false.

Fix this bug by changing may_delay's type from atomic_t to bool and
only access it while holding the delayed_bios_lock mutex. Note that we
don't have to grab the mutex in delay_resume because there are no bios
in flight at this point.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index efd510984e25..2d6b900e4353 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -33,7 +33,7 @@ struct delay_c {
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
 	struct task_struct *worker;
-	atomic_t may_delay;
+	bool may_delay;
 
 	struct delay_class read;
 	struct delay_class write;
@@ -236,7 +236,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ti->private = dc;
 	INIT_LIST_HEAD(&dc->delayed_bios);
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 	dc->argc = argc;
 
 	ret = delay_class_ctr(ti, &dc->read, argv);
@@ -312,7 +312,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	struct dm_delay_info *delayed;
 	unsigned long expires = 0;
 
-	if (!c->delay || !atomic_read(&dc->may_delay))
+	if (!c->delay)
 		return DM_MAPIO_REMAPPED;
 
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
@@ -321,6 +321,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	delayed->expires = expires = jiffies + msecs_to_jiffies(c->delay);
 
 	mutex_lock(&delayed_bios_lock);
+	if (unlikely(!dc->may_delay)) {
+		mutex_unlock(&delayed_bios_lock);
+		return DM_MAPIO_REMAPPED;
+	}
 	c->ops++;
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
@@ -337,7 +341,9 @@ static void delay_presuspend(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 0);
+	mutex_lock(&delayed_bios_lock);
+	dc->may_delay = false;
+	mutex_unlock(&delayed_bios_lock);
 
 	if (delay_is_fast(dc))
 		flush_delayed_bios_fast(dc, true);
@@ -351,7 +357,7 @@ static void delay_resume(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 }
 
 static int delay_map(struct dm_target *ti, struct bio *bio)


