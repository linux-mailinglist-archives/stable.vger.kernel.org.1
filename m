Return-Path: <stable+bounces-245764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EH2HQY6A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34B52293E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02AB330FEAA8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53D3AFB1A;
	Tue, 12 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odeisgWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1621394EBD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595763; cv=none; b=iDIxylzCtlIvQdsDSbUp3nSVnqUCY0HpdKM/kfAq/UQTm+F+BZTe0jq9b7d8/NZq5uUDPDZ4BgVN3Vm5cTiMrs0TI+Ut21Zc1ttjp7Hr+qcoR2uXgIkmy1WDJ0dH4cxXoH+u9SXE2DP7Hv4nxQ4ukP9MngoN1/bSfVskv1oK0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595763; c=relaxed/simple;
	bh=I9MPKkC3pYNAtaDx4IAispabxUJ57hFTm6wmuStUM10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HsMhuZe8SZ7gjmvrmy3mzhWq5RQbDBcPDpTc8p4drkqsUoBVN0sqkTrRtoROiDlB6FmticqJqOxk1OevcGjuO7E3xycErGY1FSm7ay5RUosvYMvfNJpp4ibLoDG9jb3fTvVRB93C3lan5Hiwj7ww2fK0bZwjEW2Yc9yxom5fqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odeisgWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7274C2BCB0;
	Tue, 12 May 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595763;
	bh=I9MPKkC3pYNAtaDx4IAispabxUJ57hFTm6wmuStUM10=;
	h=Subject:To:Cc:From:Date:From;
	b=odeisgWZzQtBS61mEOEu3nD8sFPpfDlJXpQ1ugv0cY0/jw1Hv9V65ly+dnQqsZePz
	 23vZstmQ+onQUFjPws/ADNPNTQHpCI3IYm2VwH+i2QxRKKM1uu11WKUrQXEPWqMI+c
	 YJ8hlCqr1KUjRJqYPPqNN4opt41fx4CjZnfbw3kM=
Subject: FAILED: patch "[PATCH] f2fs: fix false alarm of lockdep on cp_global_sem lock" failed to apply to 6.1-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,shinichiro.kawasaki@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:22:39 +0200
Message-ID: <2026051239-spoon-mouth-0b30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B34B52293E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245764-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6a5e3de9c2bb0b691d16789a5d19e9276a09b308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051239-spoon-mouth-0b30@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a5e3de9c2bb0b691d16789a5d19e9276a09b308 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 6 Mar 2026 12:24:20 +0000
Subject: [PATCH] f2fs: fix false alarm of lockdep on cp_global_sem lock

lockdep reported a potential deadlock:

a) TCMU device removal context:
 - call del_gendisk() to get q->q_usage_counter
 - call start_flush_work() to get work_completion of wb->dwork
b) f2fs writeback context:
 - in wb_workfn(), which holds work_completion of wb->dwork
 - call f2fs_balance_fs() to get sbi->gc_lock
c) f2fs vfs_write context:
 - call f2fs_gc() to get sbi->gc_lock
 - call f2fs_write_checkpoint() to get sbi->cp_global_sem
d) f2fs mount context:
 - call recover_fsync_data() to get sbi->cp_global_sem
 - call f2fs_check_and_fix_write_pointer() to call blkdev_report_zones()
   that goes down to blk_mq_alloc_request and get q->q_usage_counter

Original callstack is in Closes tag.

However, I think this is a false alarm due to before mount returns
successfully (context d), we can not access file therein via vfs_write
(context c).

Let's introduce per-sb cp_global_sem_key, and assign the key for
cp_global_sem, so that lockdep can recognize cp_global_sem from
different super block correctly.

A lot of work are done by Shin'ichiro Kawasaki, thanks a lot for
the work.

Fixes: c426d99127b1 ("f2fs: Check write pointer consistency of open zones")
Cc: stable@kernel.org
Reported-and-tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/20260218125237.3340441-1-shinichiro.kawasaki@wdc.com
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 39b97621456a..56c4af4b1737 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2042,6 +2042,9 @@ struct f2fs_sb_info {
 	spinlock_t iostat_lat_lock;
 	struct iostat_lat_info *iostat_io_lat;
 #endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key cp_global_sem_key;
+#endif
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f626e5ca089d..ae81af5a8d29 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4964,6 +4964,11 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	init_f2fs_rwsem_trace(&sbi->gc_lock, sbi, LOCK_NAME_GC_LOCK);
 	mutex_init(&sbi->writepages);
 	init_f2fs_rwsem_trace(&sbi->cp_global_sem, sbi, LOCK_NAME_CP_GLOBAL);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&sbi->cp_global_sem_key);
+	lockdep_set_class(&sbi->cp_global_sem.internal_rwsem,
+					&sbi->cp_global_sem_key);
+#endif
 	init_f2fs_rwsem_trace(&sbi->node_write, sbi, LOCK_NAME_NODE_WRITE);
 	init_f2fs_rwsem_trace(&sbi->node_change, sbi, LOCK_NAME_NODE_CHANGE);
 	spin_lock_init(&sbi->stat_lock);
@@ -5435,6 +5440,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 
@@ -5516,6 +5524,9 @@ static void kill_f2fs_super(struct super_block *sb)
 	/* Release block devices last, after fscrypt_destroy_keyring(). */
 	if (sbi) {
 		destroy_device_list(sbi);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
 		kfree(sbi);
 		sb->s_fs_info = NULL;
 	}


