Return-Path: <stable+bounces-43716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED28C4414
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9C1C21720
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49F539C;
	Mon, 13 May 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0yjlLCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06021EB5C
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613729; cv=none; b=kjSEAR2O+I9UzEEMPrbvIRoDruhXeEPZj67VyOLOPqfwV/a3NW3qwwPeBYQgFn8MgDfgCHjZfyrhqcivqlDW+I1EkoCWHOOzWsz3mZqJ6MB1Ric3axAYxa/CBLIQ6asbtQ/fdwgbJV+f2Ghu+8XugvDV2xNcpShEknI4HnU1gt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613729; c=relaxed/simple;
	bh=VH/rChWlqvCuKOwZPmDMxefsBeNIb58D/3EYopsdxR8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=soBUYYMabsZIydnBjy1R4wDQVpoPEGAtMRtC4mmx3kIplCQ0wbDrbXQLGKI5LiKCqnzlpCJ2sqjXusrrTm6j0tQ8B8SdLEeKXIfiHuO3e6KQu+WPWkfKPDNQbwycGtbQVZGXNRrSfEibmDBdBbIXzhyaj5J5f69K1js3I0Kkek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0yjlLCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77520C2BD11;
	Mon, 13 May 2024 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613728;
	bh=VH/rChWlqvCuKOwZPmDMxefsBeNIb58D/3EYopsdxR8=;
	h=Subject:To:Cc:From:Date:From;
	b=M0yjlLCaoeT/9UrqbGVS9IIdXCFLqxQuiigb7ImN1kx8/FTdgxPvk2AZXkofZVswp
	 LUwzESwUlVYzls4clQnDwTzudrbfpMsOCCY2Rlr6eoLDgIZrM/1JrkjnCflsPbQa/6
	 5L/ZFg5HEocJOzVpO4Hw8+Wmj48f3uZP/9GQ7bRI=
Subject: FAILED: patch "[PATCH] ksmbd: use rwsem instead of rwlock for lease break" failed to apply to 6.1-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:21:55 +0200
Message-ID: <2024051355-hypnotize-anchor-2de7@gregkh>
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
git cherry-pick -x d1c189c6cb8b0fb7b5ee549237d27889c40c2f8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051355-hypnotize-anchor-2de7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d1c189c6cb8b ("ksmbd: use rwsem instead of rwlock for lease break")
c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
fa9415d4024f ("ksmbd: mark SMB2_SESSION_EXPIRED to session when destroying previous session")
c2a721eead71 ("ksmbd: lazy v2 lease break on smb2_write()")
d47d9886aeef ("ksmbd: send v2 lease break notification for directory")
eb547407f357 ("ksmbd: downgrade RWH lease caching state to RH for directory")
2e450920d58b ("ksmbd: move oplock handling after unlock parent dir")
4274a9dc6aeb ("ksmbd: separately allocate ci per dentry")
864fb5d37163 ("ksmbd: fix possible deadlock in smb2_open")
5a7ee91d1154 ("ksmbd: fix race condition with fp")
e2b76ab8b5c9 ("ksmbd: add support for read compound")
e202a1e8634b ("ksmbd: no response from compound read")
2b57a4322b1b ("ksmbd: check if a mount point is crossed during path lookup")
7b7d709ef7cf ("ksmbd: add missing compound request handing in some commands")
81a94b27847f ("ksmbd: use kvzalloc instead of kvmalloc")
40b268d384a2 ("ksmbd: add mnt_want_write to ksmbd vfs functions")
fc6c6a3c324c ("ksmbd: fix out-of-bound read in parse_lease_state()")
6fe55c2799bc ("ksmbd: call putname after using the last component")
36322523dddb ("ksmbd: fix UAF issue from opinfo->conn")
df14afeed2e6 ("ksmbd: fix uninitialized pointer read in smb2_create_link()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1c189c6cb8b0fb7b5ee549237d27889c40c2f8b Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 May 2024 10:07:50 +0900
Subject: [PATCH] ksmbd: use rwsem instead of rwlock for lease break

lease break wait for lease break acknowledgment.
rwsem is more suitable than unlock while traversing the list for parent
lease break in ->m_op_list.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 6fd8cb7064dc..c2abf109010d 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -207,9 +207,9 @@ static void opinfo_add(struct oplock_info *opinfo)
 {
 	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
 
-	write_lock(&ci->m_lock);
+	down_write(&ci->m_lock);
 	list_add_rcu(&opinfo->op_entry, &ci->m_op_list);
-	write_unlock(&ci->m_lock);
+	up_write(&ci->m_lock);
 }
 
 static void opinfo_del(struct oplock_info *opinfo)
@@ -221,9 +221,9 @@ static void opinfo_del(struct oplock_info *opinfo)
 		lease_del_list(opinfo);
 		write_unlock(&lease_list_lock);
 	}
-	write_lock(&ci->m_lock);
+	down_write(&ci->m_lock);
 	list_del_rcu(&opinfo->op_entry);
-	write_unlock(&ci->m_lock);
+	up_write(&ci->m_lock);
 }
 
 static unsigned long opinfo_count(struct ksmbd_file *fp)
@@ -526,21 +526,18 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 	 * Compare lease key and client_guid to know request from same owner
 	 * of same client
 	 */
-	read_lock(&ci->m_lock);
+	down_read(&ci->m_lock);
 	list_for_each_entry(opinfo, &ci->m_op_list, op_entry) {
 		if (!opinfo->is_lease || !opinfo->conn)
 			continue;
-		read_unlock(&ci->m_lock);
 		lease = opinfo->o_lease;
 
 		ret = compare_guid_key(opinfo, client_guid, lctx->lease_key);
 		if (ret) {
 			m_opinfo = opinfo;
 			/* skip upgrading lease about breaking lease */
-			if (atomic_read(&opinfo->breaking_cnt)) {
-				read_lock(&ci->m_lock);
+			if (atomic_read(&opinfo->breaking_cnt))
 				continue;
-			}
 
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
@@ -570,9 +567,8 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				lease_none_upgrade(opinfo, lctx->req_state);
 			}
 		}
-		read_lock(&ci->m_lock);
 	}
-	read_unlock(&ci->m_lock);
+	up_read(&ci->m_lock);
 
 	return m_opinfo;
 }
@@ -1114,7 +1110,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 	if (!p_ci)
 		return;
 
-	read_lock(&p_ci->m_lock);
+	down_read(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
 		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
@@ -1132,13 +1128,11 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				continue;
 			}
 
-			read_unlock(&p_ci->m_lock);
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
 			opinfo_conn_put(opinfo);
-			read_lock(&p_ci->m_lock);
 		}
 	}
-	read_unlock(&p_ci->m_lock);
+	up_read(&p_ci->m_lock);
 
 	ksmbd_inode_put(p_ci);
 }
@@ -1159,7 +1153,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 	if (!p_ci)
 		return;
 
-	read_lock(&p_ci->m_lock);
+	down_read(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
 		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
@@ -1173,13 +1167,11 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 				atomic_dec(&opinfo->conn->r_count);
 				continue;
 			}
-			read_unlock(&p_ci->m_lock);
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
 			opinfo_conn_put(opinfo);
-			read_lock(&p_ci->m_lock);
 		}
 	}
-	read_unlock(&p_ci->m_lock);
+	up_read(&p_ci->m_lock);
 
 	ksmbd_inode_put(p_ci);
 }
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 30229161b346..b6c5a8ea3887 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3376,9 +3376,9 @@ int smb2_open(struct ksmbd_work *work)
 	 * after daccess, saccess, attrib_only, and stream are
 	 * initialized.
 	 */
-	write_lock(&fp->f_ci->m_lock);
+	down_write(&fp->f_ci->m_lock);
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
-	write_unlock(&fp->f_ci->m_lock);
+	up_write(&fp->f_ci->m_lock);
 
 	/* Check delete pending among previous fp before oplock break */
 	if (ksmbd_inode_pending_delete(fp)) {
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index fcaf373cc008..474dadf6b7b8 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -646,7 +646,7 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 	 * Lookup fp in master fp list, and check desired access and
 	 * shared mode between previous open and current open.
 	 */
-	read_lock(&curr_fp->f_ci->m_lock);
+	down_read(&curr_fp->f_ci->m_lock);
 	list_for_each_entry(prev_fp, &curr_fp->f_ci->m_fp_list, node) {
 		if (file_inode(filp) != file_inode(prev_fp->filp))
 			continue;
@@ -722,7 +722,7 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 			break;
 		}
 	}
-	read_unlock(&curr_fp->f_ci->m_lock);
+	up_read(&curr_fp->f_ci->m_lock);
 
 	return rc;
 }
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 030f70700036..6cb599cd287e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -165,7 +165,7 @@ static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 	ci->m_fattr = 0;
 	INIT_LIST_HEAD(&ci->m_fp_list);
 	INIT_LIST_HEAD(&ci->m_op_list);
-	rwlock_init(&ci->m_lock);
+	init_rwsem(&ci->m_lock);
 	ci->m_de = fp->filp->f_path.dentry;
 	return 0;
 }
@@ -261,14 +261,14 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	}
 
 	if (atomic_dec_and_test(&ci->m_count)) {
-		write_lock(&ci->m_lock);
+		down_write(&ci->m_lock);
 		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
-			write_unlock(&ci->m_lock);
+			up_write(&ci->m_lock);
 			ksmbd_vfs_unlink(filp);
-			write_lock(&ci->m_lock);
+			down_write(&ci->m_lock);
 		}
-		write_unlock(&ci->m_lock);
+		up_write(&ci->m_lock);
 
 		ksmbd_inode_free(ci);
 	}
@@ -289,9 +289,9 @@ static void __ksmbd_remove_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp
 	if (!has_file_id(fp->volatile_id))
 		return;
 
-	write_lock(&fp->f_ci->m_lock);
+	down_write(&fp->f_ci->m_lock);
 	list_del_init(&fp->node);
-	write_unlock(&fp->f_ci->m_lock);
+	up_write(&fp->f_ci->m_lock);
 
 	write_lock(&ft->lock);
 	idr_remove(ft->idr, fp->volatile_id);
@@ -523,17 +523,17 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 	if (!ci)
 		return NULL;
 
-	read_lock(&ci->m_lock);
+	down_read(&ci->m_lock);
 	list_for_each_entry(lfp, &ci->m_fp_list, node) {
 		if (inode == file_inode(lfp->filp)) {
 			atomic_dec(&ci->m_count);
 			lfp = ksmbd_fp_get(lfp);
-			read_unlock(&ci->m_lock);
+			up_read(&ci->m_lock);
 			return lfp;
 		}
 	}
 	atomic_dec(&ci->m_count);
-	read_unlock(&ci->m_lock);
+	up_read(&ci->m_lock);
 	return NULL;
 }
 
@@ -705,13 +705,13 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 
 	conn = fp->conn;
 	ci = fp->f_ci;
-	write_lock(&ci->m_lock);
+	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
 		if (op->conn != conn)
 			continue;
 		op->conn = NULL;
 	}
-	write_unlock(&ci->m_lock);
+	up_write(&ci->m_lock);
 
 	fp->conn = NULL;
 	fp->tcon = NULL;
@@ -801,13 +801,13 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	fp->tcon = work->tcon;
 
 	ci = fp->f_ci;
-	write_lock(&ci->m_lock);
+	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
 		if (op->conn)
 			continue;
 		op->conn = fp->conn;
 	}
-	write_unlock(&ci->m_lock);
+	up_write(&ci->m_lock);
 
 	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
 	if (!has_file_id(fp->volatile_id)) {
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index ed44fb4e18e7..5a225e7055f1 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -47,7 +47,7 @@ struct stream {
 };
 
 struct ksmbd_inode {
-	rwlock_t			m_lock;
+	struct rw_semaphore		m_lock;
 	atomic_t			m_count;
 	atomic_t			op_count;
 	/* opinfo count for streams */


