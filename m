Return-Path: <stable+bounces-227096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LlDB2W+umkGbgIAu9opvQ
	(envelope-from <stable+bounces-227096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:01:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE22BDC0D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39B803016717
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F5285CB9;
	Wed, 18 Mar 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Q8Wiu5LO"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DB3D7D75;
	Wed, 18 Mar 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846071; cv=none; b=bzH7SGYC4uRvWHs3aRJrwhC8N26ASERJyQfmwlxPCTkS1gAG3IQoTTgbux4f4lYo4aH/nDcgysbJXJx8uWjQ8ujgcAs8pVg5NR97XtRAL6++Z4BjV4KZht2krq1wYRhunMopCNx6rxMaa7QDFzNxCUbQ18cjsywedFlUxUe5yEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846071; c=relaxed/simple;
	bh=99t2Jul0qIhE3s0je/eG1mqEqiB3PvWKRtpR8W0Zl+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmK58lJJpGY598c3tNoy9oPhcfm70rWGxWoOVIua6tIkqWPDbguau8BGnGY0lSwsT9rEnM1DNF91TIk0I6TLBTYOL0wyux2Wcrk2g2lEQGa4UBa3AFEAkMBQ7zJXV/fVtYGJUc3/KqktwLL39dApj9dPkimIGosPQKvidVeGPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Q8Wiu5LO; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 376f04282;
	Wed, 18 Mar 2026 23:01:04 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: [PATCH v2 2/2] hfsplus: extract hidden directory search into a helper function
Date: Wed, 18 Mar 2026 23:00:46 +0800
Message-Id: <20260318150046.431428-3-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318150046.431428-1-zilin@seu.edu.cn>
References: <20260318150046.431428-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0176eb8703a1kunm8a6a5dd119444d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk5LVkJKGR9OQ09PGE9LHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Q8Wiu5LOkBGJ++kt3DL+WLu5iPXpHYJGLwGWuRrv3htf22fvxHmPjgYPMHg+q2fdMhGyas6PXpeghOEPi2zuA6nMQxqJ3dfbJlIJ2Nm5Coj1LDaanpu1wHzGVd2ciMMkqORpoaoW3SAGPXjVFUo1Q+mFyU/SKH9kPG4pboeTJ8s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=T9PwoeELAsxbhE2E7IPq2rA7XxeWVBtg7N7Xwbw8GLc=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227096-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AECE22BDC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In hfsplus_fill_super(), the process of looking up the hidden directory
involves initializing a catalog search, building a search key, reading
the b-tree record, and releasing the search data.

Currently, this logic is open-coded directly within the main superblock
initialization routine. This makes hfsplus_fill_super() quite lengthy
and its error handling paths less straightforward.

Extract the hidden directory search sequence into a new helper function,
hfsplus_get_hidden_dir_entry(). This improves overall code readability,
cleanly encapsulates the hfs_find_data lifecycle, and simplifies the
error exits in hfsplus_fill_super().

Moreover, the error handling logic for hfs_brec_read is updated to mirror
hfsplus_lookup(). This gracefully handles the -ENOENT case, keeping the
directory search behavior consistent with the rest of the filesystem.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/hfsplus/super.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index f396fee19ab8..df3f104298cf 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -424,12 +424,33 @@ void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr)
 	vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
 }
 
+static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
+					       const struct qstr *str,
+					       hfsplus_cat_entry *entry)
+{
+	struct hfs_find_data fd;
+	int err;
+
+	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
+	if (err)
+		return err;
+
+	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, str);
+	if (unlikely(err < 0))
+		goto free_fd;
+
+	err = hfs_brec_read(&fd, entry, sizeof(*entry));
+
+free_fd:
+	hfs_find_exit(&fd);
+	return err;
+}
+
 static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hfsplus_vh *vhdr;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	hfsplus_cat_entry entry;
-	struct hfs_find_data fd;
 	struct inode *root, *inode;
 	struct qstr str;
 	struct nls_table *nls;
@@ -565,16 +586,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
 	str.name = HFSP_HIDDENDIR_NAME;
-	err = hfs_find_init(sbi->cat_tree, &fd);
-	if (err)
-		goto out_put_root;
-	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
-	if (unlikely(err < 0)) {
-		hfs_find_exit(&fd);
-		goto out_put_root;
-	}
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
-		hfs_find_exit(&fd);
+	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
+	if (err) {
+		if (err != -ENOENT)
+			goto out_put_root;
+	} else {
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
 			goto out_put_root;
@@ -585,8 +601,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto out_put_root;
 		}
 		sbi->hidden_dir = inode;
-	} else
-		hfs_find_exit(&fd);
+	}
 
 	if (!sb_rdonly(sb)) {
 		/*
-- 
2.34.1


