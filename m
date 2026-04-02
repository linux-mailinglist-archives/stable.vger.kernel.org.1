Return-Path: <stable+bounces-233062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGIKCwSczmnfowYAu9opvQ
	(envelope-from <stable+bounces-233062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:40:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B613B38C0F7
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4597E301FF9F
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCD3BBA00;
	Thu,  2 Apr 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un362A3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10238337BB8
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147478; cv=none; b=KOQhz+xS67lLqd+xFPhNYU4voh4c7ECkC0U5awAwXhctBTBo8LtQoszhAGJRTOLuuFPc3YvDUGxrpx7l2v+yLGN6iKNu9aJyAw/v8yzAWPNQyHjDJ1go7croJlGFIAbwX1fHxLmj/Jcx1iU/exvkFC7v4y3dvxrU4YI450lajtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147478; c=relaxed/simple;
	bh=HMx5vMtBrD+ICN0QD6VqVg7rsTyNX1l5GWOGv1wcbPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDHi3EJkPQOgaDniZYzkEhwP2Om82HJo5/MSsjWZ0FzRGfOq9GuVDU4W4vOimgAVmqRv8rMeOfqj722pqXNSTB0k6bsU9iUIQZ0fgkJIOYYM1Xhak9vEDl1UrfPNZRC87oJ76NpaHFbDAYVnHaVU47RyJFqzrVRJtD39+Md0Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un362A3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40756C116C6;
	Thu,  2 Apr 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147477;
	bh=HMx5vMtBrD+ICN0QD6VqVg7rsTyNX1l5GWOGv1wcbPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Un362A3DePMdV9I7P3oKEmOwBCOBLt4GTL5yi9W7yFIjp38z5fXEddP7VEYTtuT3h
	 1ecImBg5tAH0wD8j7imgs4s+XVQ2773gWjw2nfRAnsOyzTHN8ml8Y+yyjoOMfm+TgB
	 Hm2ZukQfklIhAQOH2vVyqzm4gM4St9JplYrxQPqzG0oXmBTbLX7S7pZJnBrSQA8gLy
	 Q6IpiwbPwWBIiYqv3bb4nYnPoyof6FgQ7qWVhKh6Cps8AueGZ1I9J9Jhh3rAcCt0bv
	 fQUoAgrhyZ3gpbaN0PTE/SS8ozkrE/AaARYZ1vk43v2Lsg1x/qAza82M34FNM/L0zZ
	 ssNujATH6J8RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] ext4: factor out ext4_percpu_param_init() and ext4_percpu_param_destroy()
Date: Thu,  2 Apr 2026 12:31:12 -0400
Message-ID: <20260402163115.1385749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033016-eagle-gangrene-7fc7@gregkh>
References: <2026033016-eagle-gangrene-7fc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233062-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B613B38C0F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 1f79467c8a6be64940a699de1bd43338a6dd9fdd ]

Factor out ext4_percpu_param_init() and ext4_percpu_param_destroy(). And
also use ext4_percpu_param_destroy() in ext4_put_super() to avoid
duplicated code. No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20230323140517.1070239-3-yanaijie@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 496bb99b7e66 ("ext4: fix the might_sleep() warnings in kvfree()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 85 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fa5642838c79c..31d7df1560158 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1193,6 +1193,49 @@ static inline void ext4_quota_off_umount(struct super_block *sb)
 }
 #endif
 
+static int ext4_percpu_param_init(struct ext4_sb_info *sbi)
+{
+	ext4_fsblk_t block;
+	int err;
+
+	block = ext4_count_free_clusters(sbi->s_sb);
+	ext4_free_blocks_count_set(sbi->s_es, EXT4_C2B(sbi, block));
+	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
+				  GFP_KERNEL);
+	if (!err) {
+		unsigned long freei = ext4_count_free_inodes(sbi->s_sb);
+		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
+		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
+					  GFP_KERNEL);
+	}
+	if (!err)
+		err = percpu_counter_init(&sbi->s_dirs_counter,
+					  ext4_count_dirs(sbi->s_sb), GFP_KERNEL);
+	if (!err)
+		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
+					  GFP_KERNEL);
+	if (!err)
+		err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
+					  GFP_KERNEL);
+	if (!err)
+		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
+
+	if (err)
+		ext4_msg(sbi->s_sb, KERN_ERR, "insufficient memory");
+
+	return err;
+}
+
+static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
+{
+	percpu_counter_destroy(&sbi->s_freeclusters_counter);
+	percpu_counter_destroy(&sbi->s_freeinodes_counter);
+	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1259,12 +1302,7 @@ static void ext4_put_super(struct super_block *sb)
 		kvfree(flex_groups);
 	}
 	rcu_read_unlock();
-	percpu_counter_destroy(&sbi->s_freeclusters_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
-	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
-	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
@@ -5081,7 +5119,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	struct ext4_super_block *es = NULL;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **flex_groups;
-	ext4_fsblk_t block;
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
@@ -5488,33 +5525,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	block = ext4_count_free_clusters(sb);
-	ext4_free_blocks_count_set(sbi->s_es,
-				   EXT4_C2B(sbi, block));
-	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
-				  GFP_KERNEL);
-	if (!err) {
-		unsigned long freei = ext4_count_free_inodes(sb);
-		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
-		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
-					  GFP_KERNEL);
-	}
-	if (!err)
-		err = percpu_counter_init(&sbi->s_dirs_counter,
-					  ext4_count_dirs(sb), GFP_KERNEL);
-	if (!err)
-		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
-					  GFP_KERNEL);
-	if (!err)
-		err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
-					  GFP_KERNEL);
-	if (!err)
-		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
-
-	if (err) {
-		ext4_msg(sb, KERN_ERR, "insufficient memory");
+	if (ext4_percpu_param_init(sbi))
 		goto failed_mount6;
-	}
 
 	if (ext4_has_feature_flex_bg(sb))
 		if (!ext4_fill_flex_info(sb)) {
@@ -5605,12 +5617,7 @@ failed_mount9: __maybe_unused
 		kvfree(flex_groups);
 	}
 	rcu_read_unlock();
-	percpu_counter_destroy(&sbi->s_freeclusters_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
-	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
-	percpu_free_rwsem(&sbi->s_writepages_rwsem);
+	ext4_percpu_param_destroy(sbi);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
-- 
2.53.0


