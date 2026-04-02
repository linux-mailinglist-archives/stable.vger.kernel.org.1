Return-Path: <stable+bounces-233064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBajBAGczmnfowYAu9opvQ
	(envelope-from <stable+bounces-233064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:40:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1938C0F0
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83A3305DF28
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99983EE1D1;
	Thu,  2 Apr 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCFSXo97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69F3E9F80
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147479; cv=none; b=Pbwvezk4ZUy1wLOk0Vj6wQOS29xa13Nd3TwPlKin9Oi4J6RFaT90F73O9UTHEELvrURnMCc8wlzVqsyQe2S+KnNueyDPVMakMNugp4TT1qT5+3IxzvusgjN7us2qKDfEy5prkGfmWkYev3swOlOlyGHxSkjL1aSW1rpTGYo8E2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147479; c=relaxed/simple;
	bh=J6DmpZza1VpS7tI+DmC5Lunml94qPyu7D+/yXZSa/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdRjWavOuXMjG7EKE+SyulUeykzhC+v64j/2xeZIt7GyI1R4nc2Iko0ob2838KLEfNX9p8pY+s3ZoDoiSO1EK5/VD0CMO9yaehAgFAIrUaVCGez0meRjnKysXlPqoWKulOmbNI4d3oSyZL2bo8qfaKpxBUgTfwl99+PbN2HldzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCFSXo97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF020C116C6;
	Thu,  2 Apr 2026 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147479;
	bh=J6DmpZza1VpS7tI+DmC5Lunml94qPyu7D+/yXZSa/fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCFSXo978zC6EgjlTV52vWyLpu6h/BNR0QrNb7JLNGoAAgci603KMoFzju1SQGY/g
	 tgM9s8G4A8Wf9b8PDbkth9td7dEs55ciqlb5i4NzY25tdtjBZe4ZzeOju0bX68nT3y
	 Odq80vtyRbr7s//KEFLP/w+uPXafhr6/4I/Z/Jz0vFQm7Creg47ywUXLkXtoe2SqxU
	 AToAAsL4rPHdKJtp8+0WD1W4mQ7qVLVyDGViz4NweB2F+J0vAyNR33PGqSptJ+30tv
	 1IKuKVaxw1PmVAbFD9n8syztHnqZJ/uzjorg8JgupxJYtRjMvXQexPe3Nz48A4uA1V
	 5UDhOuVpHVZ/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] ext4: factor out ext4_flex_groups_free()
Date: Thu,  2 Apr 2026 12:31:14 -0400
Message-ID: <20260402163115.1385749-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402163115.1385749-1-sashal@kernel.org>
References: <2026033016-eagle-gangrene-7fc7@gregkh>
 <20260402163115.1385749-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233064-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 82E1938C0F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit dcbf87589d90e3bd5a5a4cf832517f22f3c55efb ]

Factor out ext4_flex_groups_free() and it can be used both in
__ext4_fill_super() and ext4_put_super().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20230323140517.1070239-5-yanaijie@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 496bb99b7e66 ("ext4: fix the might_sleep() warnings in kvfree()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 25d8422d9a1f8..85286a50dcb2f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1249,11 +1249,25 @@ static void ext4_group_desc_free(struct ext4_sb_info *sbi)
 	rcu_read_unlock();
 }
 
+static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
+{
+	struct flex_groups **flex_groups;
+	int i;
+
+	rcu_read_lock();
+	flex_groups = rcu_dereference(sbi->s_flex_groups);
+	if (flex_groups) {
+		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
+			kvfree(flex_groups[i]);
+		kvfree(flex_groups);
+	}
+	rcu_read_unlock();
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	struct flex_groups **flex_groups;
 	int aborted = 0;
 	int i, err;
 
@@ -1303,14 +1317,7 @@ static void ext4_put_super(struct super_block *sb)
 		ext4_commit_super(sb);
 
 	ext4_group_desc_free(sbi);
-	rcu_read_lock();
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
-	if (flex_groups) {
-		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
-			kvfree(flex_groups[i]);
-		kvfree(flex_groups);
-	}
-	rcu_read_unlock();
+	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
@@ -5114,7 +5121,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_super_block *es = NULL;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct flex_groups **flex_groups;
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
@@ -5605,14 +5611,7 @@ failed_mount9: __maybe_unused
 	ext4_unregister_li_request(sb);
 failed_mount6:
 	ext4_mb_release(sb);
-	rcu_read_lock();
-	flex_groups = rcu_dereference(sbi->s_flex_groups);
-	if (flex_groups) {
-		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
-			kvfree(flex_groups[i]);
-		kvfree(flex_groups);
-	}
-	rcu_read_unlock();
+	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 failed_mount5:
 	ext4_ext_release(sb);
-- 
2.53.0


