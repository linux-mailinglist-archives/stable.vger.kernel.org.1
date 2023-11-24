Return-Path: <stable+bounces-790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17D7F7C91
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B41C21185
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24B364A4;
	Fri, 24 Nov 2023 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGaNXIJ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B339FE1;
	Fri, 24 Nov 2023 18:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B420BC433C8;
	Fri, 24 Nov 2023 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849783;
	bh=oQXiCxXQNRQqdKSoU7iNPy6EFLNaUjQQ4vqzAKszMEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGaNXIJ7kmwKoztLM0kMRGFMkbx+7H4MFuDXFwOwtsgU1Vb4syy+YIho6yAN80Ocr
	 9kjo2NxxAMntGfBYPFAmtsGVbkXWZEMjiPmYsUFWLMfD3Vln3PlOn9wk86pWhG7nSV
	 x/E6oSBFRgzSuwgwFyX6+BpwjVCSLemvzblAnTdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 318/530] ksmbd: fix recursive locking in vfs helpers
Date: Fri, 24 Nov 2023 17:48:04 +0000
Message-ID: <20231124172037.722833121@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marios Makassikis <mmakassikis@freebox.fr>

commit 807252f028c59b9a3bac4d62ad84761548c10f11 upstream.

Running smb2.rename test from Samba smbtorture suite against a kernel built
with lockdep triggers a "possible recursive locking detected" warning.

This is because mnt_want_write() is called twice with no mnt_drop_write()
in between:
  -> ksmbd_vfs_mkdir()
    -> ksmbd_vfs_kern_path_create()
       -> kern_path_create()
          -> filename_create()
            -> mnt_want_write()
       -> mnt_want_write()

Fix this by removing the mnt_want_write/mnt_drop_write calls from vfs
helpers that call kern_path_create().

Full lockdep trace below:

============================================
WARNING: possible recursive locking detected
6.6.0-rc5 #775 Not tainted
--------------------------------------------
kworker/1:1/32 is trying to acquire lock:
ffff888005ac83f8 (sb_writers#5){.+.+}-{0:0}, at: ksmbd_vfs_mkdir+0xe1/0x410

but task is already holding lock:
ffff888005ac83f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0xb6/0x260

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sb_writers#5);
  lock(sb_writers#5);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by kworker/1:1/32:
 #0: ffff8880064e4138 ((wq_completion)ksmbd-io){+.+.}-{0:0}, at: process_one_work+0x40e/0x980
 #1: ffff888005b0fdd0 ((work_completion)(&work->work)){+.+.}-{0:0}, at: process_one_work+0x40e/0x980
 #2: ffff888005ac83f8 (sb_writers#5){.+.+}-{0:0}, at: filename_create+0xb6/0x260
 #3: ffff8880057ce760 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: filename_create+0x123/0x260

Cc: stable@vger.kernel.org
Fixes: 40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -173,10 +173,6 @@ int ksmbd_vfs_create(struct ksmbd_work *
 		return err;
 	}
 
-	err = mnt_want_write(path.mnt);
-	if (err)
-		goto out_err;
-
 	mode |= S_IFREG;
 	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
@@ -186,9 +182,7 @@ int ksmbd_vfs_create(struct ksmbd_work *
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
-	mnt_drop_write(path.mnt);
 
-out_err:
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -219,10 +213,6 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *w
 		return err;
 	}
 
-	err = mnt_want_write(path.mnt);
-	if (err)
-		goto out_err2;
-
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
@@ -233,21 +223,19 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *w
 			       dentry->d_name.len);
 		if (IS_ERR(d)) {
 			err = PTR_ERR(d);
-			goto out_err1;
+			goto out_err;
 		}
 		if (unlikely(d_is_negative(d))) {
 			dput(d);
 			err = -ENOENT;
-			goto out_err1;
+			goto out_err;
 		}
 
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
 		dput(d);
 	}
 
-out_err1:
-	mnt_drop_write(path.mnt);
-out_err2:
+out_err:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
@@ -665,16 +653,11 @@ int ksmbd_vfs_link(struct ksmbd_work *wo
 		goto out3;
 	}
 
-	err = mnt_want_write(newpath.mnt);
-	if (err)
-		goto out3;
-
 	err = vfs_link(oldpath.dentry, mnt_idmap(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
-	mnt_drop_write(newpath.mnt);
 
 out3:
 	done_path_create(&newpath, dentry);



