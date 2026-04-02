Return-Path: <stable+bounces-233068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIefDoSdzmnfowYAu9opvQ
	(envelope-from <stable+bounces-233068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:47:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A267D38C25E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62FD23027348
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D44361DA9;
	Thu,  2 Apr 2026 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsWhQUDO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612F3F23AE
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147863; cv=none; b=eJnWSAjtJLgPvpmxriG2R12FLUMUZQVJYpg4TqCgjmtyIYcemv27Ccd2qXJ1HNTozXIKPermR4JIzk50W//AF8ky2qY/qUptACZr7W8fo/kW8TpDX6NU+69YLGqr0drHPT8/3wnAztzdidV5D769Sax7B7/RJivt15AeS3fzGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147863; c=relaxed/simple;
	bh=zDrM3WFhaUfffdL9KS0yQheID4gCwoh1TPDNejl7DLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N78gaq2loBaoKYlfCSwEadPkSFVJlHKJ4s6xlzAe1Euba47+7WMzkS5x+1RsotUVc+ylVfWR+2IJPSIP2jR0Kz89y9Xq3GvsUd8MLPE5xcEpgbiFdd/E0tnQzLASrmX3OfsQThQiCfeAqRwEyBYV/8fad77KXWcrbkoY0sJZ9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsWhQUDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50847C19423;
	Thu,  2 Apr 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147863;
	bh=zDrM3WFhaUfffdL9KS0yQheID4gCwoh1TPDNejl7DLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsWhQUDOtonsDv2CmO39xQL2IbVa3uLHVSvPOLG1GPF0Y5jr1V3Ywskdxy5Xr5TmC
	 d1fC5oYiQStMtbv7+Pl5HUvhBBlx3b8aE8RSCpX+pEvt0JZ3ImsJFSx9oC7EzeXvDv
	 sorw8IlKpSosFO6wYp5rY5IUVPoMv3upeIyvkUz/dUs0ANhgKmFtKmMQSV2TYP7Odq
	 pGjVoxXGLL2ejgxd2NB41ahxE53uEwPTpVBEVLI6GBFuLY9KXT2cwRrR99oPmfLGV0
	 Kq8DX6Cewx7lO5VZYttBAm83v/11jk2eSs+Y64skEGhhTCWmO51bkXDG2OITyRIcDq
	 D6L09HBeKZsMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: fix use-after-free in update_super_work when racing with umount
Date: Thu,  2 Apr 2026 12:37:40 -0400
Message-ID: <20260402163740.1407640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033054-vascular-atom-023e@gregkh>
References: <2026033054-vascular-atom-023e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,linux.dev,suse.cz,gmail.com,mit.edu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233068-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email,linux.dev:email]
X-Rspamd-Queue-Id: A267D38C25E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit d15e4b0a418537aafa56b2cb80d44add83e83697 ]

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
[ adapted mutex_init placement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c |  1 +
 fs/ext4/sysfs.c | 10 +++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d2158866a4b52..d99eabf846b8e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1540,6 +1540,7 @@ struct ext4_sb_info {
 	struct proc_dir_entry *s_proc;
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
+	struct mutex s_error_notify_mutex; /* protects sysfs_notify vs kobject_del */
 	struct super_block *s_sb;
 	struct buffer_head *s_mmp_bh;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 05f1f9b7ad0c4..170bc58b61577 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4621,6 +4621,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
 	spin_lock_init(&sbi->s_error_lock);
+	mutex_init(&sbi->s_error_notify_mutex);
 	INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
 
 	/* Register extent status tree shrinker */
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index aa07b78ba9104..492f5351e267b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -513,7 +513,10 @@ static struct kobj_type ext4_feat_ktype = {
 
 void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
 {
-	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+	mutex_lock(&sbi->s_error_notify_mutex);
+	if (sbi->s_kobj.state_in_sysfs)
+		sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+	mutex_unlock(&sbi->s_error_notify_mutex);
 }
 
 static struct kobject *ext4_root;
@@ -526,8 +529,10 @@ int ext4_register_sysfs(struct super_block *sb)
 	int err;
 
 	init_completion(&sbi->s_kobj_unregister);
+	mutex_lock(&sbi->s_error_notify_mutex);
 	err = kobject_init_and_add(&sbi->s_kobj, &ext4_sb_ktype, ext4_root,
 				   "%s", sb->s_id);
+	mutex_unlock(&sbi->s_error_notify_mutex);
 	if (err) {
 		kobject_put(&sbi->s_kobj);
 		wait_for_completion(&sbi->s_kobj_unregister);
@@ -560,7 +565,10 @@ void ext4_unregister_sysfs(struct super_block *sb)
 
 	if (sbi->s_proc)
 		remove_proc_subtree(sb->s_id, ext4_proc_root);
+
+	mutex_lock(&sbi->s_error_notify_mutex);
 	kobject_del(&sbi->s_kobj);
+	mutex_unlock(&sbi->s_error_notify_mutex);
 }
 
 int __init ext4_init_sysfs(void)
-- 
2.53.0


