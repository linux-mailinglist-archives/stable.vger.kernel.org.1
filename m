Return-Path: <stable+bounces-104229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B29F227E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CE1886BCA
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BB17C96;
	Sun, 15 Dec 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxhPDnV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A84C80
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734248502; cv=none; b=GA+cc14SGsGc9Utzce+4HyjQxmvaV8WaMFVM8w1Msc36t+VsL7wpsAqFodPMwktZK/7xbRxDFGPx+TkRVUHOOG6lzfH74KpK5rt9ghWLGvHEQMk2IiK8rnx+v67Vk6Uyv5j16ax/JgbqnNK5v4bZwt/vgmoiu5BQ89GKYFP7e+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734248502; c=relaxed/simple;
	bh=5HGSxJxdrwagMo6UMP6idHNf/8+KCkpi3lnvsdBzYrI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KgbE1ayO2DHUFIgEhKOSZ4gLiJ+rMVY92xWpOns8vnbDCs42pjSuidpnB5kPMqIVxNtxwuEPVEcGuHqndr1fDDGjoR5FTP65+64m+BpScEKfgY+S3jGU1upoCPT43jy7H334W3HSVhvA+t7fNgpeEBVu4wbTYoNo1chC+vj6d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxhPDnV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B6C4CECE;
	Sun, 15 Dec 2024 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734248502;
	bh=5HGSxJxdrwagMo6UMP6idHNf/8+KCkpi3lnvsdBzYrI=;
	h=Subject:To:Cc:From:Date:From;
	b=BxhPDnV1EkGtmN3PlCT1mZpmLPjQ19i4B5LNSw/UTthjh4NMJtMo63Y9gXN5HnkcS
	 tIHNfXYvDr27fHSb1Wk9y8OhfdznjuKq2ONxOliIwSPUX6PCHh8gIJH9Z18MH+E6rm
	 fWT92Nx3k/PSipNdNEAPbvv2ZG99lZqXaIwumwc0=
Subject: FAILED: patch "[PATCH] blk-cgroup: Fix UAF in blkcg_unpin_online()" failed to apply to 5.15-stable tree
To: tj@kernel.org,axboe@kernel.dk,renzezhongucas@gmail.com,torvalds@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 08:41:38 +0100
Message-ID: <2024121538-engorge-overplant-b846@gregkh>
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
git cherry-pick -x 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121538-engorge-overplant-b846@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 6 Dec 2024 07:59:51 -1000
Subject: [PATCH] blk-cgroup: Fix UAF in blkcg_unpin_online()

blkcg_unpin_online() walks up the blkcg hierarchy putting the online pin. To
walk up, it uses blkcg_parent(blkcg) but it was calling that after
blkcg_destroy_blkgs(blkcg) which could free the blkcg, leading to the
following UAF:

  ==================================================================
  BUG: KASAN: slab-use-after-free in blkcg_unpin_online+0x15a/0x270
  Read of size 8 at addr ffff8881057678c0 by task kworker/9:1/117

  CPU: 9 UID: 0 PID: 117 Comm: kworker/9:1 Not tainted 6.13.0-rc1-work-00182-gb8f52214c61a-dirty #48
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 02/02/2022
  Workqueue: cgwb_release cgwb_release_workfn
  Call Trace:
   <TASK>
   dump_stack_lvl+0x27/0x80
   print_report+0x151/0x710
   kasan_report+0xc0/0x100
   blkcg_unpin_online+0x15a/0x270
   cgwb_release_workfn+0x194/0x480
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ...
  Freed by task 1944:
   kasan_save_track+0x2b/0x70
   kasan_save_free_info+0x3c/0x50
   __kasan_slab_free+0x33/0x50
   kfree+0x10c/0x330
   css_free_rwork_fn+0xe6/0xb30
   process_scheduled_works+0x71b/0xe20
   worker_thread+0x82a/0xbd0
   kthread+0x242/0x2c0
   ret_from_fork+0x33/0x70
   ret_from_fork_asm+0x1a/0x30

Note that the UAF is not easy to trigger as the free path is indirected
behind a couple RCU grace periods and a work item execution. I could only
trigger it with artifical msleep() injected in blkcg_unpin_online().

Fix it by reading the parent pointer before destroying the blkcg's blkg's.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Abagail ren <renzezhongucas@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Fixes: 4308a434e5e0 ("blkcg: don't offline parent blkcg first")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e68c725cf8d9..45a395862fbc 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1324,10 +1324,14 @@ void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css)
 	struct blkcg *blkcg = css_to_blkcg(blkcg_css);
 
 	do {
+		struct blkcg *parent;
+
 		if (!refcount_dec_and_test(&blkcg->online_pin))
 			break;
+
+		parent = blkcg_parent(blkcg);
 		blkcg_destroy_blkgs(blkcg);
-		blkcg = blkcg_parent(blkcg);
+		blkcg = parent;
 	} while (blkcg);
 }
 


