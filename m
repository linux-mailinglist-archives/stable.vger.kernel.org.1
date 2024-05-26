Return-Path: <stable+bounces-46258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C38CF466
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 15:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C2B20B64
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22113E57F;
	Sun, 26 May 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bzF1RZFI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6E8F55
	for <stable@vger.kernel.org>; Sun, 26 May 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716731291; cv=none; b=cWakUudFSuqJkkgUvV3PlvaVYgD44bfew8J8jic3viZScvtb8do4TX9mzrMT4wy5JyJk/p8ThSqYyr5jfVGAHG1Tr4tjVCcpEfRYLOtYd7gHpS9xjpjYNVY6MyqyM+8yZRl96Ygv9FEAx+yr8NlOme6fJrDIJON++6Dlw6Oskf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716731291; c=relaxed/simple;
	bh=40snxOZavAQJIktaSr2YfuY+IenDQafeS4Q9gRdnYto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P+QfnNFFZthZiRS69yTip57AB77iPe5PI7ihUPiwTDQmnNgF8898SEwxoK4eQ1DFLiuNxmi+68ueqqjC02MImgI8AbUP7HoYmT89a7ceKYEQALIbW7wgt6AJHpzKbWAAfUtfQRRlY/uHu/GfGz7YskK8Z4agp+ulzoRGEiqX+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bzF1RZFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95F6C2BD10;
	Sun, 26 May 2024 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716731291;
	bh=40snxOZavAQJIktaSr2YfuY+IenDQafeS4Q9gRdnYto=;
	h=Subject:To:Cc:From:Date:From;
	b=bzF1RZFIJBB34WQokny++EuHV8pi6NPMlXJMfM/r/wjYWHRxAu5kYictrOmXcUsk/
	 v6/lqpcHVtTIFowDzhdVSLvMstHemSsldMBt52JrDA1n9JkXnEesb9bENMwmYC2h7S
	 /qvuK63bg0kke5T6GqpPqgZkWOom5OG9YARuI07s=
Subject: FAILED: patch "[PATCH] nilfs2: fix use-after-free of timer for log writer thread" failed to apply to 5.15-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,sjb7183@psu.edu,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 May 2024 15:48:04 +0200
Message-ID: <2024052603-probing-percolate-6265@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f5d4e04634c9cf68bdf23de08ada0bb92e8befe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052603-probing-percolate-6265@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5d4e04634c9cf68bdf23de08ada0bb92e8befe7 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 20 May 2024 22:26:19 +0900
Subject: [PATCH] nilfs2: fix use-after-free of timer for log writer thread

Patch series "nilfs2: fix log writer related issues".

This bug fix series covers three nilfs2 log writer-related issues,
including a timer use-after-free issue and potential deadlock issue on
unmount, and a potential freeze issue in event synchronization found
during their analysis.  Details are described in each commit log.


This patch (of 3):

A use-after-free issue has been reported regarding the timer sc_timer on
the nilfs_sc_info structure.

The problem is that even though it is used to wake up a sleeping log
writer thread, sc_timer is not shut down until the nilfs_sc_info structure
is about to be freed, and is used regardless of the thread's lifetime.

Fix this issue by limiting the use of sc_timer only while the log writer
thread is alive.

Link: https://lkml.kernel.org/r/20240520132621.4054-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20240520132621.4054-2-konishi.ryusuke@gmail.com
Fixes: fdce895ea5dd ("nilfs2: change sc_timer from a pointer to an embedded one in struct nilfs_sc_info")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: "Bai, Shuangpeng" <sjb7183@psu.edu>
Closes: https://groups.google.com/g/syzkaller/c/MK_LYqtt8ko/m/8rgdWeseAwAJ
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6be7dd423fbd..7cb34e1c9206 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2118,8 +2118,10 @@ static void nilfs_segctor_start_timer(struct nilfs_sc_info *sci)
 {
 	spin_lock(&sci->sc_state_lock);
 	if (!(sci->sc_state & NILFS_SEGCTOR_COMMIT)) {
-		sci->sc_timer.expires = jiffies + sci->sc_interval;
-		add_timer(&sci->sc_timer);
+		if (sci->sc_task) {
+			sci->sc_timer.expires = jiffies + sci->sc_interval;
+			add_timer(&sci->sc_timer);
+		}
 		sci->sc_state |= NILFS_SEGCTOR_COMMIT;
 	}
 	spin_unlock(&sci->sc_state_lock);
@@ -2320,10 +2322,21 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
  */
 static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 {
+	bool thread_is_alive;
+
 	spin_lock(&sci->sc_state_lock);
 	sci->sc_seq_accepted = sci->sc_seq_request;
+	thread_is_alive = (bool)sci->sc_task;
 	spin_unlock(&sci->sc_state_lock);
-	del_timer_sync(&sci->sc_timer);
+
+	/*
+	 * This function does not race with the log writer thread's
+	 * termination.  Therefore, deleting sc_timer, which should not be
+	 * done after the log writer thread exits, can be done safely outside
+	 * the area protected by sc_state_lock.
+	 */
+	if (thread_is_alive)
+		del_timer_sync(&sci->sc_timer);
 }
 
 /**
@@ -2349,7 +2362,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 			sci->sc_flush_request &= ~FLUSH_DAT_BIT;
 
 		/* re-enable timer if checkpoint creation was not done */
-		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) && sci->sc_task &&
 		    time_before(jiffies, sci->sc_timer.expires))
 			add_timer(&sci->sc_timer);
 	}
@@ -2539,6 +2552,7 @@ static int nilfs_segctor_thread(void *arg)
 	int timeout = 0;
 
 	sci->sc_timer_task = current;
+	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	/* start sync. */
 	sci->sc_task = current;
@@ -2606,6 +2620,7 @@ static int nilfs_segctor_thread(void *arg)
  end_thread:
 	/* end sync. */
 	sci->sc_task = NULL;
+	timer_shutdown_sync(&sci->sc_timer);
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
 	spin_unlock(&sci->sc_state_lock);
 	return 0;
@@ -2669,7 +2684,6 @@ static struct nilfs_sc_info *nilfs_segctor_new(struct super_block *sb,
 	INIT_LIST_HEAD(&sci->sc_gc_inodes);
 	INIT_LIST_HEAD(&sci->sc_iput_queue);
 	INIT_WORK(&sci->sc_iput_work, nilfs_iput_work_func);
-	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	sci->sc_interval = HZ * NILFS_SC_DEFAULT_TIMEOUT;
 	sci->sc_mjcp_freq = HZ * NILFS_SC_DEFAULT_SR_FREQ;
@@ -2748,7 +2762,6 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
-	timer_shutdown_sync(&sci->sc_timer);
 	kfree(sci);
 }
 


