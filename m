Return-Path: <stable+bounces-240653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKxROnhq62kcMwAAu9opvQ
	(envelope-from <stable+bounces-240653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:04:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C145ED22
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB94E30088A2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F923370F;
	Fri, 24 Apr 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DySnMIUo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F5357A3E
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035816; cv=none; b=q5GcL8YmyTeACjzE+cWrrULaeE4JNWjEXle2hXI5GHUhsYFDJZ5X3OvUAlF7J2/GS93CFEHq/WfWJh3zSfWS52YCjmsfHrd6oxzbpnQr3Syj0KWEhlpnurVXtyQWE32NDmS2xMV4+wm3Qh5wFpXl9AI4h4B8gjrLYWmWwKWmia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035816; c=relaxed/simple;
	bh=7DKNB++jCM5G+DzxE5CRdwaQac6/WwIdryfk2/EQm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrDN8YYtHsXxZnTCo9LxSv+Ar5euQHHrVgJxt17fFd/eldAwoRFvsUPtimaxyoLUKNQjcTD2kXHFAvku1aenmNHHIjgmIjiOgXe4NQQqYXf3Qb97Q33oaFP/PsrngADOY1cFLhwtUKVtkwdCB6DvHiNUcKTmO0MD7WwZmxYAtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DySnMIUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD17C19425;
	Fri, 24 Apr 2026 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777035816;
	bh=7DKNB++jCM5G+DzxE5CRdwaQac6/WwIdryfk2/EQm5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DySnMIUoXy6+4ym3/m9L+CSi9DTC+FuD1F5l9gVNTLmZL3JJHyuAADxTqf802M9jY
	 TiOaaaiTVNk8+J5FzbtTEomJiabSNK/MVJ//OIe9+ovic4QNDwYQpOMEXMTw6ma4SX
	 ya3gVT4tnWSN+9EauKkNu+iYdyPIco5jZI4tYc4VBpIxYQF7bucHawfPRSjjo4uvra
	 fqxPqhR6o+5qjrllElVDJqep9poxCbKN+0nuPc7L5hBAcQcx2KP2uLZ0eKowE35pFt
	 QD8WgfmTuj2vI6SYWFeni7RGTA8/orEWYrnqjLV2e8EWlHYjnD1AieAWTi+uG60AdB
	 Ir9HFH5LkmpTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	"peixuan.qiu" <peixuan.qiu@transsion.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] f2fs: use kfree() instead of kvfree() to free some memory
Date: Fri, 24 Apr 2026 09:03:32 -0400
Message-ID: <20260424130333.1916989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042413-skirmish-coma-f312@gregkh>
References: <2026042413-skirmish-coma-f312@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 693C145ED22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,transsion.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240653-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,transsion.com:email]

From: Jiazi Li <jqqlijiazi@gmail.com>

[ Upstream commit e9705c61b1dbe7bac9dc189de434994d8a76b191 ]

options in f2fs_fill_super is alloc by kstrdup:
	options = kstrdup((const char *)data, GFP_KERNEL)
sit_bitmap[_mir], nat_bitmap[_mir] are alloc by kmemdup:
	sit_i->sit_bitmap = kmemdup(src_bitmap, sit_bitmap_size, GFP_KERNEL);
	sit_i->sit_bitmap_mir = kmemdup(src_bitmap,
					sit_bitmap_size, GFP_KERNEL);
	nm_i->nat_bitmap = kmemdup(version_bitmap, nm_i->bitmap_size,
					GFP_KERNEL);
	nm_i->nat_bitmap_mir = kmemdup(version_bitmap, nm_i->bitmap_size,
					GFP_KERNEL);
write_io is alloc by f2fs_kmalloc:
	sbi->write_io[i] = f2fs_kmalloc(sbi,
			array_size(n, sizeof(struct f2fs_bio_info))

Use kfree is more efficient.

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Signed-off-by: peixuan.qiu <peixuan.qiu@transsion.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 6af249c996f7 ("f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c    | 4 ++--
 fs/f2fs/segment.c | 4 ++--
 fs/f2fs/super.c   | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2555787c79bbe..b217fd92d04f3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3418,10 +3418,10 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 	}
 	kvfree(nm_i->free_nid_count);
 
-	kvfree(nm_i->nat_bitmap);
+	kfree(nm_i->nat_bitmap);
 	kvfree(nm_i->nat_bits);
 #ifdef CONFIG_F2FS_CHECK_FS
-	kvfree(nm_i->nat_bitmap_mir);
+	kfree(nm_i->nat_bitmap_mir);
 #endif
 	sbi->nm_info = NULL;
 	kfree(nm_i);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 72bbdb29e8381..b05b587484985 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5180,9 +5180,9 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 	kvfree(sit_i->dirty_sentries_bitmap);
 
 	SM_I(sbi)->sit_info = NULL;
-	kvfree(sit_i->sit_bitmap);
+	kfree(sit_i->sit_bitmap);
 #ifdef CONFIG_F2FS_CHECK_FS
-	kvfree(sit_i->sit_bitmap_mir);
+	kfree(sit_i->sit_bitmap_mir);
 	kvfree(sit_i->invalid_segmap);
 #endif
 	kfree(sit_i);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4be332bab3b5..72cf7ed7f378a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1683,7 +1683,7 @@ static void f2fs_put_super(struct super_block *sb)
 	destroy_percpu_info(sbi);
 	f2fs_destroy_iostat(sbi);
 	for (i = 0; i < NR_PAGE_TYPE; i++)
-		kvfree(sbi->write_io[i]);
+		kfree(sbi->write_io[i]);
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
@@ -4548,7 +4548,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto sync_free_meta;
 	}
-	kvfree(options);
+	kfree(options);
 
 	/* recover broken superblock */
 	if (recovery) {
@@ -4627,7 +4627,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_destroy_iostat(sbi);
 free_bio_info:
 	for (i = 0; i < NR_PAGE_TYPE; i++)
-		kvfree(sbi->write_io[i]);
+		kfree(sbi->write_io[i]);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
@@ -4639,7 +4639,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kfree(F2FS_OPTION(sbi).s_qf_names[i]);
 #endif
 	fscrypt_free_dummy_policy(&F2FS_OPTION(sbi).dummy_enc_policy);
-	kvfree(options);
+	kfree(options);
 free_sb_buf:
 	kfree(raw_super);
 free_sbi:
-- 
2.53.0


