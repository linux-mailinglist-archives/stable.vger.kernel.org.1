Return-Path: <stable+bounces-267865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZzxAZIpOmpm3AcAu9opvQ
	(envelope-from <stable+bounces-267865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 08:37:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AC6B4948
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 08:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pOKR63sq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267865-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267865-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C2E30378A2
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895B1547C0;
	Tue, 23 Jun 2026 06:35:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08D314B76
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:35:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196526; cv=none; b=oZ7RqN53rui2s/ampkXqGaok+cnTztpv3zXID2sw9Az07HzLNGlLF5Cd6WQ8BsbUHyMSTafZs9MgV3RXfXu2n9XUEczpc3OxcbAZxhRqtVTSjM96QSFuHMK6yFrA+grJRZYUC/rbO8no2ig4/OyMfyuAxqr5YY4pCyc+/OYQEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196526; c=relaxed/simple;
	bh=nGze0EqFTry19kCZ46ib7RJRtq7QVUpGDz34NspoNQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gk4uhJ3pAr09fu2lduDOIy18Snn1k6tZoBpsEg00hfWS2U6m+TIGjj5VlMqBExpswRfXc2lqoFlO65eSPhEmwwSpM12Zv7ggMMVUT+uwiBq2pcXYYiOcjnbNBCfb5JlvW5l7odf14fzTy2hlMRdkpO67iIIax/u4fwDnAnDm3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOKR63sq; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84534f17866so4351395b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782196524; x=1782801324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7euHvllGVN2xR+H7CES7r8htrHKGHGiwc6X1lxzcng=;
        b=pOKR63sqWp7/rRXtkR/KLkYPkdFstrib6DNgvzgRyNVsa2bMxtulFZ5Og7GFM+Laf6
         zlugRFB/MwS4MB5hRgMG3oNbfADtY0XYczGVZchQyP7Uq++MkSh5g/6jMA3Kr5pp5Mkt
         ZQaAeQbV2POgIURRE879eRSIdYe9k7fhnsLQtEMznYB3UpgosDnloqC4Zw7Nk7g7SLdx
         ee9zX119uPjm9Xrn0tzvTCBJktoZ4Ryrcljwy1Jh2z28rNl48ge27UH2sP7ufcppx+f8
         rJif9fsaJQ/FgNV7/0iW67AKjRTxMItfrRiVz3isR+UKjzV1FwSsTayS4pZjH7YJr58j
         0EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196524; x=1782801324;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7euHvllGVN2xR+H7CES7r8htrHKGHGiwc6X1lxzcng=;
        b=WpqzdXCP79ituFHC2fCtJQyhRzJvak5KxVWnMbdl36BgkjEgwMMyRCnekZ41gJGIdG
         MndITO+VkLUr7LY1LHbECNFCNgSdbmx4btVRiqtW+Kk+qYT2K+Z51eQF9QJ5B8dvMA9J
         ZpknlSqR0AaVqUKwqCI7uG1Lq4PCtgGwywxp1bfi0arbWOBbUGxWSFnAW54bNxge7CXP
         Onz2nFSJ8u5LIj6c113aTImtH35P6Ll7lMKwq6bg3rxHcw898TbutKyLy2fuH1J+njkJ
         BmfVNKosF/SYs9WDHOvEp47GtYUbChiYEGq5Tglarm3KIpVQx6rykK+XwX4S4YAT/9PF
         McoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+56yWmbEAAt3WwlEV0Z6Kv9moFQnNB4K8pqdvWcIhq+lckYne7ja5icGNKJSLpaDmu/Zyz1Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpWV965rqHrFtUSjNP40CWxoPx+8YJC1mLj3TYzFMWKBfc1uh
	81duJqq0PyhonInSjHGnUxfwNwDsb1Kwr5J11JquzitlhgiPppR4G8dLEFTqUpCRzM74uUEmbW7
	mzZ+qpUyVoeweUiY3ZG4BF5FNiQ==
X-Received: from pfr9.prod.google.com ([2002:a05:6a00:94c9:b0:842:3697:8685])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b95:b0:842:4f20:5402 with SMTP id d2e1a72fcca58-8456253555amr14657406b3a.21.1782196524023;
 Mon, 22 Jun 2026 23:35:24 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:34:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623063428.222361-1-joannechien@google.com>
Subject: [PATCH v2] f2fs: dirty directory inodes on mtime/ctime update
From: Joanne Chang <joannechien@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Joanne Chang <joannechien@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jaegeuk@kernel.org,m:chao@kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:joannechien@google.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[joannechien@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267865-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannechien@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B4AC6B4948

Xfstests generic/547 sometimes fail with mismatched directory metadata
before and after a power failure. This happens because when a directory
entry is added, renamed, or deleted, its mtime and ctime are updated and
the inode is marked dirty via
f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
the dirty inode is not added to the global DIRTY_META list. Therefore,
subsequent checkpoints skip flushing these updated directory blocks,
causing directory timestamps to revert to stale values after a sudden
power failure.

Address this by changing the dirtying parameter to sync=true during
directory entry mutations and renames. This forces F2FS to immediately
queue the updated directory blocks on the global DIRTY_META list,
ensuring timestamps are committed to checkpoints.

Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Chang <joannechien@google.com>
---
v1 -> v2:
- added Fixes and Cc tags

 fs/f2fs/dir.c    | 6 +++---
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/namei.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..e1c42d2b5c15 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -460,7 +460,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	folio_mark_dirty(folio);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_folio_put(folio, true);
 }
 
@@ -615,7 +615,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -927,7 +927,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e2f7bedf1552..aec06fb4fd76 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -732,7 +732,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cac03b8e91a1..7ffdf23cea5e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1076,7 +1076,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
 	inode_set_ctime_current(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_folio, old_dir, NULL);
 	old_folio = NULL;
@@ -1246,7 +1246,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
@@ -1265,7 +1265,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.55.0.rc0.786.g65d90a0328-goog


