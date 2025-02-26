Return-Path: <stable+bounces-119733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0DA468CF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B593AF46E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060E221DAA;
	Wed, 26 Feb 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3u2nELr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1B22A7EE
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592982; cv=none; b=HJ+Txq9/0waPUu6H3+LhabfLgiXxTGW+pqglXHs6OES5eVIaMLxt9G8qGJ0ARNZvNtCUSua4TK3xf3lwHvY3aeILJb+CBKuWr1mOXTI/xDhPCQ95C5tC+UGeSgepQA8/y/28xfc2v0h2PeFzF4FNS9coInnLGK5cTeuXlzaPG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592982; c=relaxed/simple;
	bh=RRbGFMocuFGh6eLh6bjULqTSsOkDmWDQy+xqOsyhb1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFBHcoibn6olAApMiRxHfAQ2udheT+o6NoWi45vS4dwXp0Ijrw4UpFAwCVvFivfquxZ5bcbzOBCSk//0fg5Ik8OR/B2m/umj1u9R5/9QFu6equn6TkO/iX8W0UxVVeDSly2BfrmDFBlolavHIyyTz24nDGNqbLEKNTjziB52OBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3u2nELr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2211acda7f6so571285ad.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592980; x=1741197780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AailFqvAJn1Kor0z2g0aaD8SdfRqoWZtRxdnH0Mpydk=;
        b=j3u2nELrSis0KWXX5W7+zugwU/SFtPxf8P4hH4OkcrSSfK1BcN12lsBoktbqHZhdWX
         aBOsG72aWKfBxvrrsKVguDIOAkR2o7aq3UGnglj95RccIga484Lc+CCcAHAH8AJbqZAL
         W1NXWoqU5qrNfI1UdqpG/7ev0wgC6a77ImVQhPDSjM9yBqPRgZ2s7VhYgz7nIo0mfZP7
         YOzV/kV6w5WpTO37/MAKaHqaOLiApITeVHvHm2hT8ip4hnZ9Ri2Z+cCCgpBAqFWgltWb
         i8Ylbg5qHY4ekFq/he+8Tt+lOsy+nPNZV6tjoRaLwp9iucc8bvXv051YXMUYoSOgEAeO
         EaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592980; x=1741197780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AailFqvAJn1Kor0z2g0aaD8SdfRqoWZtRxdnH0Mpydk=;
        b=TUjZlWtacUmiulpd0UfXI+quUVH3BHSyeHLVlqzMCNLLpyVcYvYhXS4y9Wco6kVuFR
         c3bdmGLhCKNTa8VphuCeEpp+y0U7ZQ56wM8wuU3ExBP8g8KVmHKtefCeE5BpBO11a534
         Z3zjN/+KurBEHL7MxuNI8x828mAEaaa+khyL4VSSDE2wlrPN368jijTE6ag0Bd8HQo3Q
         ONvgxOsrPY6JTGF/XVG3amXHGa/+PhxEz65iXTCQ+Dgwa5kjqK5r95XcvsflMEAQc3WX
         j74wqRBJjdDh0ipMGZM9bfN2VE1tUE2eJg5ymQUU3eXbwn+qANHSYDm79VNaeUiSA80l
         nxzw==
X-Gm-Message-State: AOJu0YxK2VYODuZ0FgVTy1s6mFkSDrb/r6NToZ7yoLT8ePR3ASe0/wcx
	3jwYBvmHCYlZrRw3B+CCT6L8pL80bUS2Ahb/bVkyNirm5D5asbQ8nwYumw==
X-Gm-Gg: ASbGncvLRQGBAuKGFZPNkhLg6pahiuAjmh4yrfq0YpaOZCjIBY1I9rGq0StZDX2ZK8i
	yvmM7shscG/V/FakPI7Ih/4YSeymPfrS6Abr1GDReKomDrB4XF0LaqmbgAndsNfXmHgKpshGCA6
	vvRtw/pb0mBbX5ducR8TIB8DQOvhGQoJuIlpY9oqKobAqHyevMjEFD0FYHN5z4IFKLjqhvQ/yvw
	z/RAXHwooI7fjh+/Qzd7Pug8dRqECwgFrwJb5inO2rUZJUiBuwjHvuEy1w4hYVeRK0HsSwmlPCz
	Ad7VP1iRMUmGrRSIUQPB3LhUCnA+70aNj/oPHcU2PmPDgRXDkhOAjTD9oDs4xNpl2Q==
X-Google-Smtp-Source: AGHT+IHw9F6k7vXrecF4IwGFeLsQkZcLLS18IyDQmdKT05efgaBuLlQluQg3de0rrGEenN1pTuuu+g==
X-Received: by 2002:a17:902:cf06:b0:220:bdf2:e51e with SMTP id d9443c01a7336-223200b302amr56786935ad.26.1740592980024;
        Wed, 26 Feb 2025 10:03:00 -0800 (PST)
Received: from carrot.. (i118-19-4-47.s41.a014.ap.plala.or.jp. [118.19.4.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000995sm35747655ad.46.2025.02.26.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:02:59 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 6.1 3/3] nilfs2: handle errors that nilfs_prepare_chunk() may return
Date: Thu, 27 Feb 2025 03:00:23 +0900
Message-ID: <20250226180247.4950-4-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
References: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
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
index de040ab05d37..0f3753af1674 100644
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
 	dir->i_mtime = dir->i_ctime = current_time(dir);
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
index bbd27238b0e6..67d66207fae1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -406,8 +406,10 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		err = nilfs_set_link(new_dir, new_de, new_page, old_inode);
 		nilfs_put_page(new_page);
+		if (unlikely(err))
+			goto out_dir;
 		nilfs_mark_inode_dirty(new_dir);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
@@ -430,28 +432,27 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	 */
 	old_inode->i_ctime = current_time(old_inode);
 
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
index b577ca0575d7..dadafad2fae7 100644
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


