Return-Path: <stable+bounces-188179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89623BF259E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3570134DF85
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2B2848A0;
	Mon, 20 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdY8yuGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B827F00A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976970; cv=none; b=O/WxyFOeskFnagCMKzrJXvlrCYgUvonJSV8kmuP33A7HEFo/QRtOorY+VTxIgX0QcHb8jls8Ve5N9Lupb4sKfpR6L8TDRKGdG6NuXx5oROvQDZOx9i9Xb9f0gYmDAB+c08Gh+LcKuhsSjz0Ll7Whs1NMZEIY6gHxPqq6IdMXaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976970; c=relaxed/simple;
	bh=h4fIqP79GSp7vEar+qmejlnqSrD6GaDEAk+HT0Hmp70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6waX39O7yPigxpHusiJYJEVvYAcicjurDKFWwYj+7Fl3fp+fBOZLDybXbbIZaZh7J7NTHqvO52XZD6hit9GahR5fuZocKMLv1CXeCCBRymMqeNyPUwLXYvWSpiusxnRss9tt7QIzH6OE4SFULXmTl0aBhVb3gbyNyuB7Ymkvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdY8yuGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11358C4CEFE;
	Mon, 20 Oct 2025 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976969;
	bh=h4fIqP79GSp7vEar+qmejlnqSrD6GaDEAk+HT0Hmp70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdY8yuGXiF1Gccks0LAq3pidP0fE+3y4jpL09pLNeq3qBGD1bCta43UhKmT8ZCnCH
	 iwL/o09pgFgiPqxdL6Nbrt07eRKv97PqPG27U0EzeQPcHA2HL7w575lVAczYk9RKnG
	 tueUHdyjMd3tyzdusJiqqEL7i0OHJYkZpr6mVKiNgcqASToCmvPSneYw8s4N432aQY
	 pg/5xeXv3DD0gyLVzwxlID62oL90sBzbMQydoJ5dSmNVd3mfmxkyE1cIf18kd8dNWs
	 4idI8xcwKGgNsfwPV2RGz9RLLBOUm5nWIBbq2rlvaUStcRUBIn7VeRDAzQFr3iaiAO
	 nDD1mFyV3Me2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shashank A P <shashank.ap@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] fs: quota: create dedicated workqueue for quota_release_work
Date: Mon, 20 Oct 2025 12:16:05 -0400
Message-ID: <20251020161605.1834667-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020161605.1834667-1-sashal@kernel.org>
References: <2025101650-tighten-fleshed-6fe0@gregkh>
 <20251020161605.1834667-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shashank A P <shashank.ap@samsung.com>

[ Upstream commit 72b7ceca857f38a8ca7c5629feffc63769638974 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ba227502b03d7..42a7d0a71b22e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -163,6 +163,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
+/* workqueue for work quota_release_work*/
+static struct workqueue_struct *quota_unbound_wq;
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -891,7 +894,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3046,6 +3049,11 @@ static int __init dquot_init(void)
 	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
 		panic("Cannot register dquot shrinker");
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);
-- 
2.51.0


