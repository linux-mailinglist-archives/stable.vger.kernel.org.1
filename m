Return-Path: <stable+bounces-118591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50103A3F635
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364953ADAFE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF0A204590;
	Fri, 21 Feb 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAPl/Tzr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378F2054FC
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145144; cv=none; b=FbwDxSD7/I9ZSRfIN8IgySBTkW2wijWLAOZmUuhLesy00m2rJoeTwwrx1Z1gSIOFqHaieRB2fvMP4Da2nRHUSoqGTX08y3pZgr35T7Pd7j6hRADi7GANYj6V+VybFzKG8b9oz+n4RuaJneOIo44kwSNcx9+bXIHEo0BKmb5+Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145144; c=relaxed/simple;
	bh=v42QuVGi+tVtlkD1duzqNPKyyHj/5xBu2onHD0exs40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCgaVH8tTfxYgYChBG/4hMc7067nF1QYtFmSawPGHh4i6pBVZzBjAylTgpkzqPi2oiKy13D4TP+JQ/pxtUunxF/QM3k2U6gu3knDE8YXR9QUwrPHYbkQe0ZSLi3HtioFTEQm3EcDuP8VTfLWjqAU8Ob8EfyuMWxsTGni6+pjuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAPl/Tzr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221206dbd7eso41644085ad.2
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 05:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740145142; x=1740749942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlKVGtJuq9Clxy8NKSvDmJW5rbg05hgcEx0LMRVPgAo=;
        b=nAPl/TzrPSGje54ire5FcwsTqEOSNF6lKzHAo+O6JReDwyhGmuTmdpf4HFff0MfI//
         cwU2TUSD0K/O86q2+6BHvNkf3hZe+izV1jt+TY4OSticn0TQZLeRjt8JHofMq8/fDppk
         nPAcBCfPhYVCFqe4QoLHWNKNTHX0hc916qY6Qja4CgBk5Hk9LHLCPn38z/jrl3bXyESJ
         os1B23XCpV3XftvU3sSAtnQj3RyIiNp3FSRuG1pbmSRTH/bSYwzQd43hb84Net/Tqs0W
         PDWjI/YUtYMjsSecdl97m2zD47U4p4BRQQxVrSv8taqa6yhKhJ4wE6q2nNCNpCb37gex
         v/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740145142; x=1740749942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlKVGtJuq9Clxy8NKSvDmJW5rbg05hgcEx0LMRVPgAo=;
        b=PLq3xddqSOD9jLncr6O6+MeQ+iJbOQ+Vhn4maq0lQCBNccuiWlftOaA8/odBt69o8T
         Kz2y7e/v0ncnSue7Dr6KOKHX3dDHu8SLne2diPxN+Ivk/q2tZj4Y+zmte34uBBZKtNq7
         ay9TWWGCVCSsGu5kJ7bHRtXzdYnK7/3p0Qr57pVyRr08itnjjOg8w+2yjMpPEHz5Su5S
         zKJkO1BvwPZ467FmaIVY4bIk++ZqBsEXph5VZ2nGNcHh/A0nrapX+VhX84RKzcMuutJK
         X2uH2NQH2E1ABEo4iK/4lFNYucDhuP/0LzNB0qBqkSk8hY3ZIRYt/rp6wcRijTyF/cKU
         IZYQ==
X-Gm-Message-State: AOJu0YzFMDhayJIuK2bg82qHjkkNlxB7IDIoR0dJx4bHptWNej3t9tqD
	xGiZqxeZKXB0vrCJcQaatIe0BYeLJ4GttCpw0OvNtt6j0RJvlbdve2SD7Q==
X-Gm-Gg: ASbGncuDHdh2hLcjoztrC/R/1OFIjsP0P88VuMEvcBaI3uVxJHz0GnpAALC+3myeX53
	8XmR6yPZryWEkEgcsnmE6EKPtqXmC11f9H+T6HIYvcBf35YUL+dl7IY177qZxevqvMWKn0XXeS1
	Mk5Pf3HnAcT/LYkWWNwC1ifj0QN26RFe2wG/bdBXg45gGSp7MndjnrmmG+DtVGD/xTQDWkq9C9y
	Gd92aeTEfaIhhaAno9nA/NNWcS99Z06s9DtQWdRHfnfswGF2dNFAx+L34ebU4e2F7qYRTUPdjhp
	ShOLVrd+lJcXdAIaxPNIt+yzueS/yUfnzq4ARJSXJkqKyY2w1ACpieYLu1koteUeGTtP4zaJNw=
	=
X-Google-Smtp-Source: AGHT+IEj+OkwTEghBCdGgf0fu4aaWLf9PjJxnkgM7BPkl93VCrJurPCS2UxhkDpO6enA2sZ6cJvaDg==
X-Received: by 2002:a17:902:c950:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-2219ff5e619mr58479805ad.25.1740145141701;
        Fri, 21 Feb 2025 05:39:01 -0800 (PST)
Received: from carrot.. (i121-113-18-240.s41.a014.ap.plala.or.jp. [121.113.18.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349047sm137818645ad.7.2025.02.21.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:39:00 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 3/3] nilfs2: handle errors that nilfs_prepare_chunk() may return
Date: Fri, 21 Feb 2025 22:37:55 +0900
Message-ID: <20250221133848.4335-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
References: <20250221133848.4335-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ee70999a988b8abc3490609142f50ebaa8344432 upstream.

Patch series "nilfs2: fix issues with rename operations".

This series fixes BUG_ON check failures reported by syzbot around rename
operations, and a minor behavioral issue where the mtime of a child
directory changes when it is renamed instead of moved.

This patch (of 2):

The directory manipulation routines nilfs_set_link() and
nilfs_delete_entry() rewrite the directory entry in the folio/page
previously read by nilfs_find_entry(), so error handling is omitted on the
assumption that nilfs_prepare_chunk(), which prepares the buffer for
rewriting, will always succeed for these.  And if an error is returned, it
triggers the legacy BUG_ON() checks in each routine.

This assumption is wrong, as proven by syzbot: the buffer layer called by
nilfs_prepare_chunk() may call nilfs_get_block() if necessary, which may
fail due to metadata corruption or other reasons.  This has been there all
along, but improved sanity checks and error handling may have made it more
reproducible in fuzzing tests.

Fix this issue by adding missing error paths in nilfs_set_link(),
nilfs_delete_entry(), and their caller nilfs_rename().

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20250111143518.7901-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20250111143518.7901-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+32c3706ebf5d95046ea1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=32c3706ebf5d95046ea1
Reported-by: syzbot+1097e95f134f37d9395c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1097e95f134f37d9395c
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/nilfs2/dir.c   | 13 ++++++++++---
 fs/nilfs2/namei.c | 29 +++++++++++++++--------------
 fs/nilfs2/nilfs.h |  4 ++--
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index c6dd8ef7d284..49ca762baa8f 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -444,7 +444,7 @@ int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
 	return 0;
 }
 
-void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 		    struct page *page, struct inode *inode)
 {
 	unsigned int from = (char *)de - (char *)page_address(page);
@@ -454,11 +454,15 @@ void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
 
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		return err;
+	}
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
 	nilfs_commit_chunk(page, mapping, from, to);
 	dir->i_mtime = inode_set_ctime_current(dir);
+	return 0;
 }
 
 /*
@@ -590,7 +594,10 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 		from = (char *)pde - (char *)page_address(page);
 	lock_page(page);
 	err = nilfs_prepare_chunk(page, from, to);
-	BUG_ON(err);
+	if (unlikely(err)) {
+		unlock_page(page);
+		goto out;
+	}
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 4d60ccdd85f3..43f01fe556fe 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -406,8 +406,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		err = nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_put_page(new_page);
+		if (unlikely(err))
+			goto out_dir;
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -430,28 +432,27 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	nilfs_delete_entry(old_de, old_page);
-
-	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
-		nilfs_put_page(dir_page);
-		drop_nlink(old_dir);
+	err = nilfs_delete_entry(old_de, old_page);
+	if (likely(!err)) {
+		if (dir_de) {
+			err = nilfs_set_link(old_inode, dir_de, dir_page,
+					     new_dir);
+			drop_nlink(old_dir);
+		}
+		nilfs_mark_inode_dirty(old_dir);
 	}
-	nilfs_put_page(old_page);
-
-	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-	err = nilfs_transaction_commit(old_dir->i_sb);
-	return err;
-
 out_dir:
 	if (dir_de)
 		nilfs_put_page(dir_page);
 out_old:
 	nilfs_put_page(old_page);
 out:
-	nilfs_transaction_abort(old_dir->i_sb);
+	if (likely(!err))
+		err = nilfs_transaction_commit(old_dir->i_sb);
+	else
+		nilfs_transaction_abort(old_dir->i_sb);
 	return err;
 }
 
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index fbf74c1cfd1d..4c4b76865484 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -240,8 +240,8 @@ nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
 extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
 extern int nilfs_empty_dir(struct inode *);
 extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct page *, struct inode *);
+int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
+		   struct page *page, struct inode *inode);
 
 static inline void nilfs_put_page(struct page *page)
 {
-- 
2.43.5


