Return-Path: <stable+bounces-231169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INPmEetYymn27gUAu9opvQ
	(envelope-from <stable+bounces-231169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FC359E5B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34043019BBD
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520CE3C3427;
	Mon, 30 Mar 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0xQsHpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A137A4B8
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868710; cv=none; b=H5ymnI9BfE8BjbuABhUftOjZ8i6gDb0iWb0XXemRVHcGw5fwALbpN5ofQZcCmsLmBP4tsIL/0K8MlJnhhPT13x30zvPbeVFJpFVKivNqRUjTIPUsFAkPlyitlzpXhm+LFhhU+e2xkcVD3AQCParabVq54LoZbDwRfwoimwdWeDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868710; c=relaxed/simple;
	bh=bIOnqtKA0nNjCr5/6hXweofJFNBB0ZK1bcSS5KtSCos=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lbnFBWOLYAhh55RSRo91Y4ckeCbaWDA1q3dMiU2R9VTROw0krbKd22rXQw5jMFbFv1Btso0+4bQKzjY0x0c4yolnLwBodUXdVITHNfbW7bJdJtNp94p+yYW3XxVh0FGrTw+9ADGlnouZvXoyrhL0W5LAEbobt5y+4+yEKa5z/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0xQsHpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB89C4CEF7;
	Mon, 30 Mar 2026 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868708;
	bh=bIOnqtKA0nNjCr5/6hXweofJFNBB0ZK1bcSS5KtSCos=;
	h=Subject:To:Cc:From:Date:From;
	b=G0xQsHpXqA9KatwzIUaX0BU62qLvkMhQaOlG4XH9qHm8MhbvvlcqoQNqriu3DNR2f
	 MQMWKbuZAj4Oj8OGzo7lWpJf26iwSREIRlduicWwadzuYuxzn7g/4UindhAkAadTbb
	 IuvmiOgCDSU6FHb2PSq1p8hBYd2dFEyEX3kuhdqA=
Subject: FAILED: patch "[PATCH] ext4: fix use-after-free in update_super_work when racing" failed to apply to 5.15-stable tree
To: jiayuan.chen@shopee.com,jack@suse.cz,jiayuan.chen@linux.dev,ritesh.list@gmail.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:04:54 +0200
Message-ID: <2026033054-vascular-atom-023e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231169-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[shopee.com,suse.cz,linux.dev,gmail.com,mit.edu];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,shopee.com:email,msgid.link:url,gregkh:email,suse.cz:email,linux.dev:email]
X-Rspamd-Queue-Id: 9E0FC359E5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d15e4b0a418537aafa56b2cb80d44add83e83697
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033054-vascular-atom-023e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d15e4b0a418537aafa56b2cb80d44add83e83697 Mon Sep 17 00:00:00 2001
From: Jiayuan Chen <jiayuan.chen@shopee.com>
Date: Thu, 19 Mar 2026 20:03:35 +0800
Subject: [PATCH] ext4: fix use-after-free in update_super_work when racing
 with umount

Commit b98535d09179 ("ext4: fix bug_on in start_this_handle during umount
filesystem") moved ext4_unregister_sysfs() before flushing s_sb_upd_work
to prevent new error work from being queued via /proc/fs/ext4/xx/mb_groups
reads during unmount. However, this introduced a use-after-free because
update_super_work calls ext4_notify_error_sysfs() -> sysfs_notify() which
accesses the kobject's kernfs_node after it has been freed by kobject_del()
in ext4_unregister_sysfs():

  update_super_work                ext4_put_super
  -----------------                --------------
                                   ext4_unregister_sysfs(sb)
                                     kobject_del(&sbi->s_kobj)
                                       __kobject_del()
                                         sysfs_remove_dir()
                                           kobj->sd = NULL
                                         sysfs_put(sd)
                                           kernfs_put()  // RCU free
  ext4_notify_error_sysfs(sbi)
    sysfs_notify(&sbi->s_kobj)
      kn = kobj->sd              // stale pointer
      kernfs_get(kn)             // UAF on freed kernfs_node
                                   ext4_journal_destroy()
                                     flush_work(&sbi->s_sb_upd_work)

Instead of reordering the teardown sequence, fix this by making
ext4_notify_error_sysfs() detect that sysfs has already been torn down
by checking s_kobj.state_in_sysfs, and skipping the sysfs_notify() call
in that case. A dedicated mutex (s_error_notify_mutex) serializes
ext4_notify_error_sysfs() against kobject_del() in ext4_unregister_sysfs()
to prevent TOCTOU races where the kobject could be deleted between the
state_in_sysfs check and the sysfs_notify() call.

Fixes: b98535d09179 ("ext4: fix bug_on in start_this_handle during umount filesystem")
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260319120336.157873-1-jiayuan.chen@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c579f68b3c11..7617e2d454ea 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1570,6 +1570,7 @@ struct ext4_sb_info {
 	struct proc_dir_entry *s_proc;
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
+	struct mutex s_error_notify_mutex; /* protects sysfs_notify vs kobject_del */
 	struct super_block *s_sb;
 	struct buffer_head *s_mmp_bh;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index baa067eb8cf4..cb69a9b38b7c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5406,6 +5406,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
 	spin_lock_init(&sbi->s_error_lock);
+	mutex_init(&sbi->s_error_notify_mutex);
 	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
 
 	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index b87d7bdab06a..923b375e017f 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -597,7 +597,10 @@ static const struct kobj_type ext4_feat_ktype = {
 
 void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
 {
-	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+	mutex_lock(&sbi->s_error_notify_mutex);
+	if (sbi->s_kobj.state_in_sysfs)
+		sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+	mutex_unlock(&sbi->s_error_notify_mutex);
 }
 
 static struct kobject *ext4_root;
@@ -610,8 +613,10 @@ int ext4_register_sysfs(struct super_block *sb)
 	int err;
 
 	init_completion(&sbi->s_kobj_unregister);
+	mutex_lock(&sbi->s_error_notify_mutex);
 	err = kobject_init_and_add(&sbi->s_kobj, &ext4_sb_ktype, ext4_root,
 				   "%s", sb->s_id);
+	mutex_unlock(&sbi->s_error_notify_mutex);
 	if (err) {
 		kobject_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
@@ -644,7 +649,10 @@ void ext4_unregister_sysfs(struct super_block *sb)
 
 	if (sbi->s_proc)
 		remove_proc_subtree(sb->s_id, ext4_proc_root);
+
+	mutex_lock(&sbi->s_error_notify_mutex);
 	kobject_del(&sbi->s_kobj);
+	mutex_unlock(&sbi->s_error_notify_mutex);
 }
 
 int __init ext4_init_sysfs(void)


