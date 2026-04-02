Return-Path: <stable+bounces-233063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPU4NLubzmnfowYAu9opvQ
	(envelope-from <stable+bounces-233063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B75738C062
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB97D30EB1B8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79C3EC2D7;
	Thu,  2 Apr 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leOzchC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1C3E9F80
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147478; cv=none; b=kXq4P1I3hYp9HpTyR8o9vADDVuwLsicZ+l10JK/5VFTSEerAlMVscMYhkefRJa2D2KZvqvu/dIFZD1AHIVcpewQO88Bq97/dgbmoaHald+hOuOdd1lnKf52OucuFqTvOHmztWztmSTemnmYkQ7T46djmymYZtWAsxGkp9UsVv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147478; c=relaxed/simple;
	bh=PUZLx72fTlp31QqTFcDV3ACI6/T++omRA0NOtkr15X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0PYLajBcmrEjMLPoywHMeKqXpD4P7Chq5YPxVlvpsnQGuau8XuWLb95EVB6i1b8hMwUPPqb/hBQ+BY4d6nHz+wt34PJGJqBFhHiXYByD5uXQ/91jYf1tByAjk8qkDimgiAs3j5FhD3ajDsJ8uNvmQqUYPnAhVORoi/ler+n9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leOzchC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12BAC19423;
	Thu,  2 Apr 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147478;
	bh=PUZLx72fTlp31QqTFcDV3ACI6/T++omRA0NOtkr15X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leOzchC6neggre+YUQyteT/uyzyFtiXCmCSKOCHhRsYGZK2JnZ3VCtko4GQBRuVnQ
	 7uE9BhCPeso1VgRFG6JMHuRfkRsxMpb/PxwOuUeqfhz7W0GlkRxHOpyadLo5kUpJrD
	 B2YrZYpc74bbi8OoogL5gFs5SRV12phBwzVulFpX5KqwKDcdTLSi6O0J2xFDPkg9gu
	 04Ftf4HXlSVd16xiOHDMUKXNQtt61VfVrX+iqOjwGyz02WNxXuWzMNi7kiOJZ+GLwY
	 Ms2g4ettKAbFkYifXufKJYUSX5LGJyXD71SS6TIlpZge8pobqzhlEBXlAlf3JXARMw
	 23jPCsg/F+bOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] ext4: use ext4_group_desc_free() in ext4_put_super() to save some duplicated code
Date: Thu,  2 Apr 2026 12:31:13 -0400
Message-ID: <20260402163115.1385749-2-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233063-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4B75738C062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Yan <yanaijie@huawei.com>

[ Upstream commit 6ef684988816fdfa29ceff260c97d725a489a942 ]

The only difference here is that ->s_group_desc and ->s_flex_groups share
the same rcu read lock here but it is not necessary. In other places they
do not share the lock at all.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20230323140517.1070239-4-yanaijie@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 496bb99b7e66 ("ext4: fix the might_sleep() warnings in kvfree()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 31d7df1560158..25d8422d9a1f8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1236,11 +1236,23 @@ static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
 	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 }
 
+static void ext4_group_desc_free(struct ext4_sb_info *sbi)
+{
+	struct buffer_head **group_desc;
+	int i;
+
+	rcu_read_lock();
+	group_desc = rcu_dereference(sbi->s_group_desc);
+	for (i = 0; i < sbi->s_gdb_count; i++)
+		brelse(group_desc[i]);
+	kvfree(group_desc);
+	rcu_read_unlock();
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	struct buffer_head **group_desc;
 	struct flex_groups **flex_groups;
 	int aborted = 0;
 	int i, err;
@@ -1290,11 +1302,8 @@ static void ext4_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		ext4_commit_super(sb);
 
+	ext4_group_desc_free(sbi);
 	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
-	for (i = 0; i < sbi->s_gdb_count; i++)
-		brelse(group_desc[i]);
-	kvfree(group_desc);
 	flex_groups = rcu_dereference(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
@@ -4763,19 +4772,6 @@ static int ext4_geometry_check(struct super_block *sb,
 	return 0;
 }
 
-static void ext4_group_desc_free(struct ext4_sb_info *sbi)
-{
-	struct buffer_head **group_desc;
-	int i;
-
-	rcu_read_lock();
-	group_desc = rcu_dereference(sbi->s_group_desc);
-	for (i = 0; i < sbi->s_gdb_count; i++)
-		brelse(group_desc[i]);
-	kvfree(group_desc);
-	rcu_read_unlock();
-}
-
 static int ext4_group_desc_init(struct super_block *sb,
 				struct ext4_super_block *es,
 				ext4_fsblk_t logical_sb_block,
-- 
2.53.0


