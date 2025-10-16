Return-Path: <stable+bounces-186037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D542BE368F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35CC84EEED9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9D1607AC;
	Thu, 16 Oct 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1GviAaPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684631AF1E
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618164; cv=none; b=WDR+paME4uKEabRyxiaC+KkTTS0gMG2hVTlYcd/aJVkSqAZon5Xi6GMiaAx7LcayAKlKIX7KTiM6ZcJoZ/2SUtzH+jjfoenXJ9XQ5IlYw7Siwk4AWPvr/dp7zY5izHextDa6O6ky/WRs0FMlNu0upn64aysTxKhkGn94zhLtUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618164; c=relaxed/simple;
	bh=cpIlPyXf73XovrxyYI/BqJyf5GXN/p3wpxJ3Q6MW8u4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b2oUcKT5oUsPruuj9XrmyRAMa3V5ax4Xx2OHzpF1uFLAQii6PErTpUDIbZZ13JZMzBPT8b7I6d2/+3ccKkJNOPSsekprdbrQId8AuNwWZPVhxQCBqJ5FJuKqiqJtvjdldY+Pjv4EeR8IqSfb8Tbzp+GC6OaBqDXNag7ecsi/hFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1GviAaPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E89C4CEF1;
	Thu, 16 Oct 2025 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618164;
	bh=cpIlPyXf73XovrxyYI/BqJyf5GXN/p3wpxJ3Q6MW8u4=;
	h=Subject:To:Cc:From:Date:From;
	b=1GviAaPwgJT+kmYQT0tK5tmJLydVxKrtkPupnAE6uyow/tFw1p/YmygOMlyfa1aQy
	 MOnZbHnB11UPevaYe3AM69T8k3W7fOzjYBGbqD9lBVCP5wlMKgHHIMx7hCNMCX5fQs
	 sEf9Xilxmy6n1DzkdSatbnla/piSWcKVsxovh3yg=
Subject: FAILED: patch "[PATCH] fs: quota: create dedicated workqueue for quota_release_work" failed to apply to 5.4-stable tree
To: shashank.ap@samsung.com,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:35:53 +0200
Message-ID: <2025101653-unloved-prodigal-b5e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 72b7ceca857f38a8ca7c5629feffc63769638974
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101653-unloved-prodigal-b5e0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72b7ceca857f38a8ca7c5629feffc63769638974 Mon Sep 17 00:00:00 2001
From: Shashank A P <shashank.ap@samsung.com>
Date: Mon, 1 Sep 2025 14:59:00 +0530
Subject: [PATCH] fs: quota: create dedicated workqueue for quota_release_work

There is a kernel panic due to WARN_ONCE when panic_on_warn is set.

This issue occurs when writeback is triggered due to sync call for an
opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
is needed at sync path, flush for quota_release_work is triggered.
By default quota_release_work is queued to "events_unbound" queue which
does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
workqueue tries to flush quota_release_work causing kernel panic due to
MEM_RECLAIM flag mismatch errors.

This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
for work quota_release_work.

------------[ cut here ]------------
WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
Call trace:
 check_flush_dependency+0x13c/0x148
 __flush_work+0xd0/0x398
 flush_delayed_work+0x44/0x5c
 dquot_writeback_dquots+0x54/0x318
 f2fs_do_quota_sync+0xb8/0x1a8
 f2fs_write_checkpoint+0x3cc/0x99c
 f2fs_gc+0x190/0x750
 f2fs_balance_fs+0x110/0x168
 f2fs_write_single_data_page+0x474/0x7dc
 f2fs_write_data_pages+0x7d0/0xd0c
 do_writepages+0xe0/0x2f4
 __writeback_single_inode+0x44/0x4ac
 writeback_sb_inodes+0x30c/0x538
 wb_writeback+0xf4/0x440
 wb_workfn+0x128/0x5d4
 process_scheduled_works+0x1c4/0x45c
 worker_thread+0x32c/0x3e8
 kthread+0x11c/0x1b0
 ret_from_fork+0x10/0x20
Kernel panic - not syncing: kernel: panic_on_warn set ...

Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
CC: stable@vger.kernel.org
Signed-off-by: Shashank A P <shashank.ap@samsung.com>
Link: https://patch.msgid.link/20250901092905.2115-1-shashank.ap@samsung.com
Signed-off-by: Jan Kara <jack@suse.cz>

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..6c4a6ee1fa2b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -162,6 +162,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
+/* workqueue for work quota_release_work*/
+static struct workqueue_struct *quota_unbound_wq;
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -881,7 +884,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3041,6 +3044,11 @@ static int __init dquot_init(void)
 
 	shrinker_register(dqcache_shrinker);
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);


