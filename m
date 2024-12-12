Return-Path: <stable+bounces-103346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E522D9EF65B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE502861DF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5221660C;
	Thu, 12 Dec 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4ywVZ7k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF942176AA1;
	Thu, 12 Dec 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024291; cv=none; b=RG9g/EvW9zTO5bfGhjdb9lA2FpidJiiRKD4saBhC8H2K1G7JSb7E68K7te8Eq84XE3C/cLPWEv9PoouQFZHDMXNjruGEvc7chty2lOKJMSbj9EgXd6JWAHF8zOHNTAJaowSAzkURA+QY2mchYkjCXFQqY3EgGm9XmcQg9u2hC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024291; c=relaxed/simple;
	bh=dklD/UHi4CSiH7SCOxT0jjEln/rP3IktV7MVh1oi+zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/K/ETQSCJNCiaDkaCu54N7ddUhuHUZ7WX5i/qwfpeHBZz3GCpsKXpsBVf7Bg8W0tVERXyfeRLFI1aYnbKJQOe+9+9+YNam7uakjs/xZfz6lh0F9MBlvKuN3F6nL6H3o2KttbLDiUpjr+ZEwLYrZfn+WjEm3qIZwY8hMYF8KUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4ywVZ7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311DCC4CECE;
	Thu, 12 Dec 2024 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024290;
	bh=dklD/UHi4CSiH7SCOxT0jjEln/rP3IktV7MVh1oi+zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4ywVZ7k0JwrO3aQ3J0enDpQ/qKPFjZhcFCNY+AVy5FuBSc4q2QUUBkcbwV54VATU
	 CQNHi8cpA7whSUWsdG4fYK5GvbitDOuXg+AstTbOTWPSwkK1rz9ZC5Bt0eRKXPvpjI
	 U4m5dDasLUpCtFG285F6RpE94eEU54ZDXzy5Srsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 246/459] ext4: fix FS_IOC_GETFSMAP handling
Date: Thu, 12 Dec 2024 15:59:44 +0100
Message-ID: <20241212144303.303449193@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 4a622e4d477bb12ad5ed4abbc7ad1365de1fa347 upstream.

The original implementation ext4's FS_IOC_GETFSMAP handling only
worked when the range of queried blocks included at least one free
(unallocated) block range.  This is because how the metadata blocks
were emitted was as a side effect of ext4_mballoc_query_range()
calling ext4_getfsmap_datadev_helper(), and that function was only
called when a free block range was identified.  As a result, this
caused generic/365 to fail.

Fix this by creating a new function ext4_getfsmap_meta_helper() which
gets called so that blocks before the first free block range in a
block group can get properly reported.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/fsmap.c   |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.c |   18 ++++++++++++++----
 fs/ext4/mballoc.h |    1 +
 3 files changed, 68 insertions(+), 5 deletions(-)

--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -185,6 +185,56 @@ static inline ext4_fsblk_t ext4_fsmap_ne
 	return fmr->fmr_physical + fmr->fmr_length;
 }
 
+static int ext4_getfsmap_meta_helper(struct super_block *sb,
+				     ext4_group_t agno, ext4_grpblk_t start,
+				     ext4_grpblk_t len, void *priv)
+{
+	struct ext4_getfsmap_info *info = priv;
+	struct ext4_fsmap *p;
+	struct ext4_fsmap *tmp;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_fsblk_t fsb, fs_start, fs_end;
+	int error;
+
+	fs_start = fsb = (EXT4_C2B(sbi, start) +
+			  ext4_group_first_block_no(sb, agno));
+	fs_end = fs_start + EXT4_C2B(sbi, len);
+
+	/* Return relevant extents from the meta_list */
+	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
+		if (p->fmr_physical < info->gfi_next_fsblk) {
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+		if (p->fmr_physical <= fs_start ||
+		    p->fmr_physical + p->fmr_length <= fs_end) {
+			/* Emit the retained free extent record if present */
+			if (info->gfi_lastfree.fmr_owner) {
+				error = ext4_getfsmap_helper(sb, info,
+							&info->gfi_lastfree);
+				if (error)
+					return error;
+				info->gfi_lastfree.fmr_owner = 0;
+			}
+			error = ext4_getfsmap_helper(sb, info, p);
+			if (error)
+				return error;
+			fsb = p->fmr_physical + p->fmr_length;
+			if (info->gfi_next_fsblk < fsb)
+				info->gfi_next_fsblk = fsb;
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+	}
+	if (info->gfi_next_fsblk < fsb)
+		info->gfi_next_fsblk = fsb;
+
+	return 0;
+}
+
+
 /* Transform a blockgroup's free record into a fsmap */
 static int ext4_getfsmap_datadev_helper(struct super_block *sb,
 					ext4_group_t agno, ext4_grpblk_t start,
@@ -539,6 +589,7 @@ static int ext4_getfsmap_datadev(struct
 		error = ext4_mballoc_query_range(sb, info->gfi_agno,
 				EXT4_B2C(sbi, info->gfi_low.fmr_physical),
 				EXT4_B2C(sbi, info->gfi_high.fmr_physical),
+				ext4_getfsmap_meta_helper,
 				ext4_getfsmap_datadev_helper, info);
 		if (error)
 			goto err;
@@ -560,7 +611,8 @@ static int ext4_getfsmap_datadev(struct
 
 	/* Report any gaps at the end of the bg */
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster, 0, info);
+	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
+					     0, info);
 	if (error)
 		goto err;
 
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6162,13 +6162,14 @@ int
 ext4_mballoc_query_range(
 	struct super_block		*sb,
 	ext4_group_t			group,
-	ext4_grpblk_t			start,
+	ext4_grpblk_t			first,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv)
 {
 	void				*bitmap;
-	ext4_grpblk_t			next;
+	ext4_grpblk_t			start, next;
 	struct ext4_buddy		e4b;
 	int				error;
 
@@ -6179,10 +6180,19 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = max(e4b.bd_info->bb_first_free, start);
+	start = max(e4b.bd_info->bb_first_free, first);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-
+	if (meta_formatter && start != first) {
+		if (start > end)
+			start = end;
+		ext4_unlock_group(sb, group);
+		error = meta_formatter(sb, group, first, start - first,
+				       priv);
+		if (error)
+			goto out_unload;
+		ext4_lock_group(sb, group);
+	}
 	while (start <= end) {
 		start = mb_find_next_zero_bit(bitmap, end + 1, start);
 		if (start > end)
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -226,6 +226,7 @@ ext4_mballoc_query_range(
 	ext4_group_t			agno,
 	ext4_grpblk_t			start,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 



