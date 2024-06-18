Return-Path: <stable+bounces-53360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233790D14A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176D21C23CB4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BD158877;
	Tue, 18 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rLffbS/L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBD158871;
	Tue, 18 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716097; cv=none; b=FNWV6l/PJpSdfuYZIKlLzZVosf7hwXUr0szcyeoFgcyj2UAdoChcB6CxqSZDZqDqJ0kXSldfsVP9C5LvFZ0SA82Y4L2CWapYwmvqbaq2G5pmTY9MtIKM3n8e2ExQcEPq8W1vAmfS7kaEAN42sZRS8S3nU4mB4srXvJNEL1lJPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716097; c=relaxed/simple;
	bh=+/eZlcIhv08kBZlKaG+pniSKc+biQb4eabdES5fx0Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHEt3JBdjPCQCSFjiGMGlU5k67SMk2Z86Tl98qUSu++CToP4e86TRvseWzV1FK8FgkTGbAz527Iu5rePVmjQneZ7z2OUbXA2SXbv+0H5rlHXHQQxYX+qxAJEbdKbK4A4Fu7P17cRsSzTzfE5qkv9WlUcgoyxUHtIvloPY7NwWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rLffbS/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C680EC3277B;
	Tue, 18 Jun 2024 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716097;
	bh=+/eZlcIhv08kBZlKaG+pniSKc+biQb4eabdES5fx0Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLffbS/LFs6yw38aFaaHd1Uzzd0Ww1c8A5zHwvj+TsbYjqvJ6TXfmXxG22wI4apiD
	 4D+nP6lYM9cuHuBuK7e+qj08tqhnEHxPntM5WsOkpWos1tzW0ugnWX6EnAQ3kbkCcX
	 /uVZT6VWk70YlEcaHLjjQo5z/Q6B8oUKGyWR8hA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 514/770] fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
Date: Tue, 18 Jun 2024 14:36:07 +0200
Message-ID: <20240618123427.156393027@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 2443da2259e97688f93d64d17ab69b15f466078a ]

Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
lock_manager_operations to allow the lock manager to take appropriate
action to resolve the lock conflict if possible.

A new field, lm_mod_owner, is also added to lock_manager_operations.
The lm_mod_owner is used by the fs/lock code to make sure the lock
manager module such as nfsd, is not freed while lock conflict is being
resolved.

lm_lock_expirable checks and returns true to indicate that the lock
conflict can be resolved else return false. This callback must be
called with the flc_lock held so it can not block.

lm_expire_lock is called to resolve the lock conflict if the returned
value from lm_lock_expirable is true. This callback is called without
the flc_lock held since it's allowed to block. Upon returning from
this callback, the lock conflict should be resolved and the caller is
expected to restart the conflict check from the beginnning of the list.

Lock manager, such as NFSv4 courteous server, uses this callback to
resolve conflict by destroying lock owner, or the NFSv4 courtesy client
(client that has expired but allowed to maintains its states) that owns
the lock.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/locking.rst |  4 ++++
 fs/locks.c                            | 33 ++++++++++++++++++++++++---
 include/linux/fs.h                    |  3 +++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 07e57f7629202..23a0d24168bc5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -433,6 +433,8 @@ prototypes::
 	void (*lm_break)(struct file_lock *); /* break_lease callback */
 	int (*lm_change)(struct file_lock **, int);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+        bool (*lm_lock_expirable)(struct file_lock *);
+        void (*lm_expire_lock)(void);
 
 locking rules:
 
@@ -444,6 +446,8 @@ lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
+lm_lock_expirable	yes		no			no
+lm_expire_lock		no		no			yes
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index 118df2812f8aa..13a3ba97b73d1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -982,6 +982,8 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	struct file_lock *cfl;
 	struct file_lock_context *ctx;
 	struct inode *inode = locks_inode(filp);
+	void *owner;
+	void (*func)(void);
 
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
@@ -989,12 +991,23 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 		return;
 	}
 
+retry:
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
-		if (posix_locks_conflict(fl, cfl)) {
-			locks_copy_conflock(fl, cfl);
-			goto out;
+		if (!posix_locks_conflict(fl, cfl))
+			continue;
+		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
+			&& (*cfl->fl_lmops->lm_lock_expirable)(cfl)) {
+			owner = cfl->fl_lmops->lm_mod_owner;
+			func = cfl->fl_lmops->lm_expire_lock;
+			__module_get(owner);
+			spin_unlock(&ctx->flc_lock);
+			(*func)();
+			module_put(owner);
+			goto retry;
 		}
+		locks_copy_conflock(fl, cfl);
+		goto out;
 	}
 	fl->fl_type = F_UNLCK;
 out:
@@ -1168,6 +1181,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	int error;
 	bool added = false;
 	LIST_HEAD(dispose);
+	void *owner;
+	void (*func)(void);
 
 	ctx = locks_get_lock_context(inode, request->fl_type);
 	if (!ctx)
@@ -1186,6 +1201,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		new_fl2 = locks_alloc_lock();
 	}
 
+retry:
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	/*
@@ -1197,6 +1213,17 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
+			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
+				&& (*fl->fl_lmops->lm_lock_expirable)(fl)) {
+				owner = fl->fl_lmops->lm_mod_owner;
+				func = fl->fl_lmops->lm_expire_lock;
+				__module_get(owner);
+				spin_unlock(&ctx->flc_lock);
+				percpu_up_read(&file_rwsem);
+				(*func)();
+				module_put(owner);
+				goto retry;
+			}
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 17dc1ee8c6cb2..3e9105b3cc767 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1017,6 +1017,7 @@ struct file_lock_operations {
 };
 
 struct lock_manager_operations {
+	void *lm_mod_owner;
 	fl_owner_t (*lm_get_owner)(fl_owner_t);
 	void (*lm_put_owner)(fl_owner_t);
 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
@@ -1025,6 +1026,8 @@ struct lock_manager_operations {
 	int (*lm_change)(struct file_lock *, int, struct list_head *);
 	void (*lm_setup)(struct file_lock *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lock *);
+	bool (*lm_lock_expirable)(struct file_lock *cfl);
+	void (*lm_expire_lock)(void);
 };
 
 struct lock_manager {
-- 
2.43.0




