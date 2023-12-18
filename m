Return-Path: <stable+bounces-7771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65018817632
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E8D280F8C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F63D574;
	Mon, 18 Dec 2023 15:43:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2973A1D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ce28ace2so4064275ad.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914180; x=1703518980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOBjBiP9c+/NpRiVeSyV6/M0GMpFQn2yyg4dAiAwy1Y=;
        b=QhBoGgFjKVjmr3QZ8pM+kgy/mDYEwBpxz7h8eJF1NZwMneJpa9UYTr9CnJ6qvYqMnr
         uejQwBGTFw3ARuBdF0IEjmefeiey8ngCgokEZDzXY+svvW4pzqdrxZcj+UjewRq1vGQq
         upQ3bdDD3sruVjEHhk3VW1FPKV8n71NBssdMFvIzbwbmoc9kYRhbe5qYeE6CweVg+Q4Z
         lKxPtPvajwYV2tokFLr7IMfH19xM8D2AKB1EotMqft5XcWuSHQCpjl62DfcMYx5/fn/y
         JzXYTxk456BBPkD6DPjF5dp4hMY0HzsFnYwChPNtoGHpF3XrI6TXyygXc7xpwkaS/7A/
         swrw==
X-Gm-Message-State: AOJu0YyyGnmS8mw3PAjyE3l0W/37LoGCgLvmAbyVp7y+EgapMIgYw0yx
	pVIzsHjqdbok+uNPBvBj6v56kHztaDVuiQ==
X-Google-Smtp-Source: AGHT+IHDpgX/sSyHPp6nYWpXyXiYMy9XBPpSiy/+cRh5gFQEMRQHs66KwnDfEO5FoG7gGU/TrZdvYQ==
X-Received: by 2002:a17:903:32c5:b0:1d0:a53e:2662 with SMTP id i5-20020a17090332c500b001d0a53e2662mr19973201plr.104.1702914179801;
        Mon, 18 Dec 2023 07:42:59 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 142/154] ksmbd: fix recursive locking in vfs helpers
Date: Tue, 19 Dec 2023 00:34:42 +0900
Message-Id: <20231218153454.8090-143-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 807252f028c59b9a3bac4d62ad84761548c10f11 ]

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
---
 fs/ksmbd/vfs.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 85346780704d..ffcc8f8f35bf 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -173,10 +173,6 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
-	err = mnt_want_write(path.mnt);
-	if (err)
-		goto out_err;
-
 	mode |= S_IFREG;
 	err = vfs_create(mnt_user_ns(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
@@ -186,9 +182,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
-	mnt_drop_write(path.mnt);
 
-out_err:
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -219,10 +213,6 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
-	err = mnt_want_write(path.mnt);
-	if (err)
-		goto out_err2;
-
 	user_ns = mnt_user_ns(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(user_ns, d_inode(path.dentry), dentry, mode);
@@ -233,21 +223,19 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
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
@@ -665,16 +653,11 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		goto out3;
 	}
 
-	err = mnt_want_write(newpath.mnt);
-	if (err)
-		goto out3;
-
 	err = vfs_link(oldpath.dentry, mnt_user_ns(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
-	mnt_drop_write(newpath.mnt);
 
 out3:
 	done_path_create(&newpath, dentry);
-- 
2.25.1


