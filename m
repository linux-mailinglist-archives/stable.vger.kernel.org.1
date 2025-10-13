Return-Path: <stable+bounces-184192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B5BD237E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5451899BE6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C12FBE01;
	Mon, 13 Oct 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qyn3MPeE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E432FB978
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346747; cv=none; b=RlL+qBAhBUmpw6d34DgbAv65QwSYqCIGOKfkTnsFfc+uOnb0lz3dEVVY94YOR82LThxjnwKBBwD3GtHDAbGwDa3IOojUphSl2sKasfJB70DAyREOeyhc69I+J7c1iCLFJTTObFk7mC9Srl7PY+svSN9/0nFWk4su4R8jlh07mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346747; c=relaxed/simple;
	bh=Q0cYBxjrWBhQ0dY4xi2vaY8kqe3JxzHzbqjGVgTGYEQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pja+FhxU1Z3Hhy+qCkCMQbNiOrg9Dw0qYyc4K+6tYHntc2UoES/casRn0bCAkbw0vIA1zozu2ONrmpujQ9CwFYe/uoI0b61Rur/jHhdC/20k8iE63VW3qTAIeNnG+3DX3697aHCYUsWXbhGo1ScyG9sTjxZFYNhEHFFyc6qXlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qyn3MPeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6796DC4CEE7;
	Mon, 13 Oct 2025 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760346746;
	bh=Q0cYBxjrWBhQ0dY4xi2vaY8kqe3JxzHzbqjGVgTGYEQ=;
	h=Subject:To:Cc:From:Date:From;
	b=qyn3MPeEY5F6iJGXRCbL9HRY1yS+eG5MmOPhyd+ac9N/bDjIhjzHcDtVuqUagFvjG
	 pSkvbhvv+mlX4wqQIZw+Je6rYDjkDfbSFCw+r2nCqwuzMl29cvkrgZoNeOb3rfThcp
	 N6q/CEAKgx9MvvahmLOYeQ1KwWl1LhkTXmtlIxFQ=
Subject: FAILED: patch "[PATCH] dm: fix NULL pointer dereference in __dm_suspend()" failed to apply to 5.10-stable tree
To: zhengqixing@huawei.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 11:12:16 +0200
Message-ID: <2025101316-favored-pulsate-a811@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8d33a030c566e1f105cd5bf27f37940b6367f3be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101316-favored-pulsate-a811@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d33a030c566e1f105cd5bf27f37940b6367f3be Mon Sep 17 00:00:00 2001
From: Zheng Qixing <zhengqixing@huawei.com>
Date: Tue, 26 Aug 2025 15:42:04 +0800
Subject: [PATCH] dm: fix NULL pointer dereference in __dm_suspend()

There is a race condition between dm device suspend and table load that
can lead to null pointer dereference. The issue occurs when suspend is
invoked before table load completes:

BUG: kernel NULL pointer dereference, address: 0000000000000054
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 6 PID: 6798 Comm: dmsetup Not tainted 6.6.0-g7e52f5f0ca9b #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
RIP: 0010:blk_mq_wait_quiesce_done+0x0/0x50
Call Trace:
  <TASK>
  blk_mq_quiesce_queue+0x2c/0x50
  dm_stop_queue+0xd/0x20
  __dm_suspend+0x130/0x330
  dm_suspend+0x11a/0x180
  dev_suspend+0x27e/0x560
  ctl_ioctl+0x4cf/0x850
  dm_ctl_ioctl+0xd/0x20
  vfs_ioctl+0x1d/0x50
  __se_sys_ioctl+0x9b/0xc0
  __x64_sys_ioctl+0x19/0x30
  x64_sys_call+0x2c4a/0x4620
  do_syscall_64+0x9e/0x1b0

The issue can be triggered as below:

T1 						T2
dm_suspend					table_load
__dm_suspend					dm_setup_md_queue
						dm_mq_init_request_queue
						blk_mq_init_allocated_queue
						=> q->mq_ops = set->ops; (1)
dm_stop_queue / dm_wait_for_completion
=> q->tag_set NULL pointer!	(2)
						=> q->tag_set = set; (3)

Fix this by checking if a valid table (map) exists before performing
request-based suspend and waiting for target I/O. When map is NULL,
skip these table-dependent suspend steps.

Even when map is NULL, no I/O can reach any target because there is
no table loaded; I/O submitted in this state will fail early in the
DM layer. Skipping the table-dependent suspend logic in this case
is safe and avoids NULL pointer dereferences.

Fixes: c4576aed8d85 ("dm: fix request-based dm's use of dm_wait_for_completion")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7222f20c1a83..66dd5f6ce778 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2908,7 +2908,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2960,7 +2960,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md)) {
+	if (map && dm_request_based(md)) {
 		dm_stop_queue(md->queue);
 		set_bit(DMF_QUEUE_STOPPED, &md->flags);
 	}
@@ -2972,7 +2972,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * We call dm_wait_for_completion to wait for all existing requests
 	 * to finish.
 	 */
-	r = dm_wait_for_completion(md, task_state);
+	if (map)
+		r = dm_wait_for_completion(md, task_state);
 	if (!r)
 		set_bit(dmf_suspended_flag, &md->flags);
 


