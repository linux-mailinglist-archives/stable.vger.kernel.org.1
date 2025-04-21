Return-Path: <stable+bounces-134824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009FA95236
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F003AD78A
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967C266B6F;
	Mon, 21 Apr 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wPSG9Lkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F70266B65
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243908; cv=none; b=VH+XFmurfMMegeQ4li8HEvNi0BnbvEV5A+KB93zI2VwTqoWiI/arConV/GMrHN2kR2VfNwAdS1o+pcCmqQ/Op8cUuRSVeoOsc9mqoFNENdSYDP7yE12st+M36a391VOnultc39J+7jjASWjx/eSxAzAXgL7Z/HD0GmkiMgTQcb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243908; c=relaxed/simple;
	bh=dejhssgF2GDMH9d+3miZLNl+3qFG/NUaF5b02rzYGFk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h25lhJ6whZzeLrbDa0nW29WHtWP9C9PpUjP8GAZ63hM/2MqPmjjaqm2Cb89hGh1iox1c5kISeryihb4JK0thOwt3lvGLUrdR/ZhQtHK3hpmhPzD/Zre8FFhn74JQ5LmwxqWqM/Hk2jGZzKSW/9RSdNa2JdXlbv/NIjyCfnSHOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wPSG9Lkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D526C4CEE4;
	Mon, 21 Apr 2025 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243908;
	bh=dejhssgF2GDMH9d+3miZLNl+3qFG/NUaF5b02rzYGFk=;
	h=Subject:To:Cc:From:Date:From;
	b=wPSG9LkhmT6/y9W90p913I7SPSqFjy0aATEeSEo46cWSrqW3QDlRcY2+bIz8vO9Pd
	 NbShuD//taTlWXnC03SAdI0mS9XW4rKjcxduCvARKBiloghplda/Q3Uzy7SB6CUw7x
	 qQwnGFbXWvB+GFjq4TpRWE4aNxNF24tTH5PQ/9vc=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free in smb_break_all_levII_oplock()" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:58:22 +0200
Message-ID: <2025042122-stallion-relapse-1076@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18b4fac5ef17f77fed9417d22210ceafd6525fc7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042122-stallion-relapse-1076@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18b4fac5ef17f77fed9417d22210ceafd6525fc7 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 15 Apr 2025 09:30:21 +0900
Subject: [PATCH] ksmbd: fix use-after-free in smb_break_all_levII_oplock()

There is a room in smb_break_all_levII_oplock that can cause racy issues
when unlocking in the middle of the loop. This patch use read lock
to protect whole loop.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index f103b1bd0400..81a29857b1e3 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -129,14 +129,6 @@ static void free_opinfo(struct oplock_info *opinfo)
 	kfree(opinfo);
 }
 
-static inline void opinfo_free_rcu(struct rcu_head *rcu_head)
-{
-	struct oplock_info *opinfo;
-
-	opinfo = container_of(rcu_head, struct oplock_info, rcu_head);
-	free_opinfo(opinfo);
-}
-
 struct oplock_info *opinfo_get(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
@@ -157,8 +149,8 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	if (list_empty(&ci->m_op_list))
 		return NULL;
 
-	rcu_read_lock();
-	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
+	down_read(&ci->m_lock);
+	opinfo = list_first_entry(&ci->m_op_list, struct oplock_info,
 					op_entry);
 	if (opinfo) {
 		if (opinfo->conn == NULL ||
@@ -171,8 +163,7 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 			}
 		}
 	}
-
-	rcu_read_unlock();
+	up_read(&ci->m_lock);
 
 	return opinfo;
 }
@@ -185,7 +176,7 @@ void opinfo_put(struct oplock_info *opinfo)
 	if (!atomic_dec_and_test(&opinfo->refcount))
 		return;
 
-	call_rcu(&opinfo->rcu_head, opinfo_free_rcu);
+	free_opinfo(opinfo);
 }
 
 static void opinfo_add(struct oplock_info *opinfo)
@@ -193,7 +184,7 @@ static void opinfo_add(struct oplock_info *opinfo)
 	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
 
 	down_write(&ci->m_lock);
-	list_add_rcu(&opinfo->op_entry, &ci->m_op_list);
+	list_add(&opinfo->op_entry, &ci->m_op_list);
 	up_write(&ci->m_lock);
 }
 
@@ -207,7 +198,7 @@ static void opinfo_del(struct oplock_info *opinfo)
 		write_unlock(&lease_list_lock);
 	}
 	down_write(&ci->m_lock);
-	list_del_rcu(&opinfo->op_entry);
+	list_del(&opinfo->op_entry);
 	up_write(&ci->m_lock);
 }
 
@@ -1347,8 +1338,8 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	ci = fp->f_ci;
 	op = opinfo_get(fp);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
+	down_read(&ci->m_lock);
+	list_for_each_entry(brk_op, &ci->m_op_list, op_entry) {
 		if (brk_op->conn == NULL)
 			continue;
 
@@ -1358,7 +1349,6 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (ksmbd_conn_releasing(brk_op->conn))
 			continue;
 
-		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
 				SMB2_LEASE_HANDLE_CACHING_LE)))) {
@@ -1388,9 +1378,8 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE, NULL);
 next:
 		opinfo_put(brk_op);
-		rcu_read_lock();
 	}
-	rcu_read_unlock();
+	up_read(&ci->m_lock);
 
 	if (op)
 		opinfo_put(op);
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 3f64f0787263..9a56eaadd0dd 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -71,7 +71,6 @@ struct oplock_info {
 	struct list_head        lease_entry;
 	wait_queue_head_t oplock_q; /* Other server threads */
 	wait_queue_head_t oplock_brk; /* oplock breaking wait */
-	struct rcu_head		rcu_head;
 };
 
 struct lease_break_info {


