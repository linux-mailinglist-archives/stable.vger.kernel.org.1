Return-Path: <stable+bounces-245762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEGwM0FCA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:07:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AF5234DF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D798C316A6FA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820552848BE;
	Tue, 12 May 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXAl6wny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43328394EBD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595757; cv=none; b=DtI0yuoINVRjXZpQZ5UooyBec33Peugh4j/1LajyAm4Gf4/jogjMzzcceTmXBw0PQhfe+RQLWt/76o2U12H/Vn+ata8EGUr31miJv3oYVjK/w9cy76o46zOc03HtXZ5o9ozrXcrmqI/B6mArupvaQy8FPOxWFVIAxbUIKxGBk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595757; c=relaxed/simple;
	bh=JEYPKoiNHCYDJmPx6K9DAeVW+82CBJ062+2eEfs6DTk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K8QDCMds2743YhLae6HMTIdx+1SwZFd+Bm073IaIOtZhHao1Gov9uSRx3dygI2wQLu9MPANN80xR9YfEKCzAJ/jgef4YqsZ/povHVydvdQP5X9A/7Se6YQlK647PxA9TXsMPNJ9IbDHBzVS0kYlQ2+79ggghIF+kZklVVZBlsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXAl6wny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDDCC2BCB0;
	Tue, 12 May 2026 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595757;
	bh=JEYPKoiNHCYDJmPx6K9DAeVW+82CBJ062+2eEfs6DTk=;
	h=Subject:To:Cc:From:Date:From;
	b=fXAl6wny3IyaCGo+R6snFA1EjLm1piYLJ/W7Ixas/Dq78YiYlnUo4zm6Q8o5oH5Bo
	 xssj2yyP8hiTvObsuxlq8Zk6YCw0n/9rxGmRWT/MEL0AReFbk5xbzPgg2nwU6gMYss
	 pGzigJRM1163z4DHh/+KMRFm6dz9N3X3cb8TZqtA=
Subject: FAILED: patch "[PATCH] f2fs: fix false alarm of lockdep on cp_global_sem lock" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,shinichiro.kawasaki@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:22:39 +0200
Message-ID: <2026051239-tightly-tadpole-2db4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED1AF5234DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245762-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6a5e3de9c2bb0b691d16789a5d19e9276a09b308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051239-tightly-tadpole-2db4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


