Return-Path: <stable+bounces-254126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMAEA/4nFGrfKAcAu9opvQ
	(envelope-from <stable+bounces-254126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD2F5C9546
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27F693032CF9
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06035E529;
	Mon, 25 May 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lwGLNMr9"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854523624C5;
	Mon, 25 May 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705720; cv=none; b=uvahKyiXobdukIAmSeBIxP6bejaWOP9gX5UhXrgnK6etJoqOhVCRmtzuvTKWM0pFym0aPyOfknx9BkqpXaFMyJ76t2oNwPGD/y5+W5YgfvQ65jD1qSXjyNeXy1oeT/J38TmWUS0fdkDkvuZ5ifT3yEWoKp/Gysv7xTIe1cATTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705720; c=relaxed/simple;
	bh=M+XidVCie+fT29eWkQJ0g4SYy3+t1C4EWRPltEyb4aA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=f9sVgWWHoMSKzWzFAvppsw0WdZwOetfbBOkD7sX5Fn758Ea1JosX1H5GBKRr7/+AwOGjEudXclI64OvBkD5CDuCz6S29kdR1qO3l3cZ22uOrCstm/1BzCs6e3IwgPVxoxHivvOb+nnWK5dEdbjE0UPSLHBXBmBU/KHPzineFAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lwGLNMr9; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779705707;
	bh=FB3vmd6W8iEhqSNTJFDy8+jEiKb0h+7FBUGQAACUw4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwGLNMr9gEGj1BPFw9sVToCcputwQoGPoVAre5woMlAMLsLuN7akemuZFLuYsnxEl
	 Y15g8IXgReelhVEYq0UJcdIUubJfaisN26ucEvlwd4fVmSikIx0LG5nneYKKlkTNdA
	 vuR3/sxOPSxN/6B3oa3o1lPymtr+w8pNNg8xFgKw=
Received: from China-team ([183.241.55.175])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A60AAA03; Mon, 25 May 2026 18:41:32 +0800
X-QQ-mid: xmsmtpt1779705704t8neoofi7
Message-ID: <tencent_88A30183B6BDC6E9A34612CF7A10071E4605@qq.com>
X-QQ-XMAILINFO: MvkQ4+1sQve7f7IzYTqc6WLgLH4LswlETIwG7+zdyWGk/GRPW7B+03vgu5aTFH
	 2B/kbqmBH6mW3bpc7Xc8yXJakhJQzI0rBgS4wGWU1DeJvVe0mSKkTX2zmeWMAxddSCy/cRnBfZG/
	 wxci0bdslJgjPUb6WvCXolVRNYjx/cqGiWWn2EAKUqIB/NGSkJLiMn/JZOjFlLKPUM6TYnZJIj4l
	 qrp+vgwqwR06y4LExPMDSFbYg/Xmym8c8e4wcdIdCghB0P3m3m6x6pcH7Za5dBH/qmz3qOgQfzka
	 9e3Lr6RbiZmx/JYGt871MI2+P9XXdl2p9R/yCw9VyOKy5CT7xIPWxWoN5KLRu6Nf31xVDVXpwiqh
	 ZJ/Sva7TS++N4tsQH4UK3rF8llFnRqz/Ozi1o9c/DE+tjGxnB3C0ACavzP/SPyI7aEwwqpUW2CIs
	 DoM511QQaDGr+ALeXpiX/8sH4Ir8zP9CR7KTBGnQsx7FPLAeruvRjEup/IDrFWJlIlROLDzTmn6v
	 1w3HdG5Fehw1j3acuUPsKMAS5p/HLmYT0TDImqiarsOjyN+ym5B8LKZwoxO4JlP1QZfSFEcpu8WJ
	 FtLjNodOKwLM4v1eX0/WQEhSUj0QOcQ2ZTMHVU/ZWLsNQBUNwXbTDi94RrzLauUHz2mQRtUPb3e9
	 RSinsFAUAPI8F+BRmNAKyBtDREU6b1peglrBzm1wnmfDrTIxc9uyrFwD3/9U6I1LPIZiPn/KTIZM
	 QhbvVGsrkoXSfq6Uisv1HgA3OpaxLRdvvzNpE7U42AspKWbrKoYEeWrc7253M3RrEbidoqyAzA5j
	 tRHur93Fc2CarE4sGxnNxSBXDKxA4yxjnbqTsO9/6N9Yu9O6HN7JdZI6bnDGQ+cHvuukWwqWn41q
	 YYgy8E3W5OArwSFZBdcQg0TtiJ3qqQpTO0etz7iMyP1cG+rhE2aGVF+M6Jh7a1OFEa1gcjGbNvp7
	 /nU6RgWOZuvdqX0U0OL5xnqBbH2EEm7ncs8XBozl9M0KOtSjp7kf9pj+45EBJ+/dSeDFMvdkeJWz
	 KCIAY8r3wtYN95UiGKVz1fIXTln/AHPXIbBysx8/gsWJHDWDRvRn6s7MedttRSCph4At7ReDc9Cy
	 THsdEM
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v2 2/3] ksmbd: add durable scavenger timer
Date: Mon, 25 May 2026 18:41:29 +0800
X-OQ-MSGID: <20260525104130.1252-2-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525104130.1252-1-alvalan9@foxmail.com>
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525104130.1252-1-alvalan9@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254126-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7BD2F5C9546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit d484d621d40f4a8b8959008802d79bef3609641b ]

Launch ksmbd-durable-scavenger kernel thread to scan durable fps that
have not been reclaimed by a client within the configured time.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/smb/server/mgmt/user_session.c |   2 +
 fs/smb/server/server.c            |   1 +
 fs/smb/server/server.h            |   1 +
 fs/smb/server/smb2pdu.c           |   2 +-
 fs/smb/server/smb2pdu.h           |   2 +
 fs/smb/server/vfs_cache.c         | 163 +++++++++++++++++++++++++++++-
 fs/smb/server/vfs_cache.h         |   2 +
 7 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 6c7fbd589087..b4a1bd037b9e 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -164,6 +164,7 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 
 	ksmbd_tree_conn_session_logoff(sess);
 	ksmbd_destroy_file_table(&sess->file_table);
+	ksmbd_launch_ksmbd_durable_scavenger();
 	ksmbd_session_rpc_clear_list(sess);
 	free_channel_list(sess);
 	kfree(sess->Preauth_HashValue);
@@ -399,6 +400,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 	ksmbd_destroy_file_table(&prev_sess->file_table);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
+	ksmbd_launch_ksmbd_durable_scavenger();
 out:
 	up_write(&conn->session_lock);
 	up_write(&sessions_table_lock);
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 598601a4bf92..416b14267251 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -372,6 +372,7 @@ static void server_ctrl_handle_reset(struct server_ctrl_struct *ctrl)
 {
 	ksmbd_ipc_soft_reset();
 	ksmbd_conn_transport_destroy();
+	ksmbd_stop_durable_scavenger();
 	server_conf_free();
 	server_conf_init();
 	WRITE_ONCE(server_conf.state, SERVER_STATE_STARTING_UP);
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index 48bd203abb44..e3a0f6c9c2c3 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -47,6 +47,7 @@ struct ksmbd_server_config {
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
 	bool			bind_interfaces_only;
+	struct task_struct	*dh_task;
 };
 
 extern struct ksmbd_server_config server_conf;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d68fe617369e..66163a464c56 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3601,7 +3601,7 @@ int smb2_open(struct ksmbd_work *work)
 					SMB2_CREATE_GUID_SIZE);
 			if (dh_info.timeout)
 				fp->durable_timeout = min(dh_info.timeout,
-						300000);
+						DURABLE_HANDLE_MAX_TIMEOUT);
 			else
 				fp->durable_timeout = 60;
 		}
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 2821e6c8298f..ad02d0a37602 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -75,6 +75,8 @@ struct create_durable_req_v2 {
 	__u8 CreateGuid[16];
 } __packed;
 
+#define DURABLE_HANDLE_MAX_TIMEOUT	300000
+
 struct create_durable_reconn_req {
 	struct create_context_hdr ccontext;
 	__u8   Name[8];
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 729758697c12..913c2a8d2b0e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -8,6 +8,8 @@
 #include <linux/filelock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include "glob.h"
 #include "vfs_cache.h"
@@ -17,6 +19,7 @@
 #include "mgmt/tree_connect.h"
 #include "mgmt/user_session.h"
 #include "smb_common.h"
+#include "server.h"
 
 #define S_DEL_PENDING			1
 #define S_DEL_ON_CLS			2
@@ -31,6 +34,10 @@ static struct ksmbd_file_table global_ft;
 static atomic_long_t fd_limit;
 static struct kmem_cache *filp_cache;
 
+static bool durable_scavenger_running;
+static DEFINE_MUTEX(durable_scavenger_lock);
+static wait_queue_head_t dh_wq;
+
 void ksmbd_set_fd_limit(unsigned long limit)
 {
 	limit = min(limit, get_max_files());
@@ -316,9 +323,16 @@ static void __ksmbd_remove_durable_fd(struct ksmbd_file *fp)
 	if (!has_file_id(fp->persistent_id))
 		return;
 
-	write_lock(&global_ft.lock);
 	idr_remove(global_ft.idr, fp->persistent_id);
+}
+
+static void ksmbd_remove_durable_fd(struct ksmbd_file *fp)
+{
+	write_lock(&global_ft.lock);
+	__ksmbd_remove_durable_fd(fp);
 	write_unlock(&global_ft.lock);
+	if (waitqueue_active(&dh_wq))
+		wake_up(&dh_wq);
 }
 
 static void __ksmbd_remove_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
@@ -341,7 +355,7 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	struct ksmbd_lock *smb_lock, *tmp_lock;
 
 	fd_limit_close();
-	__ksmbd_remove_durable_fd(fp);
+	ksmbd_remove_durable_fd(fp);
 	if (ft)
 		__ksmbd_remove_fd(ft, fp);
 
@@ -754,6 +768,142 @@ static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 	return fp->tcon != tcon;
 }
 
+static bool ksmbd_durable_scavenger_alive(void)
+{
+	mutex_lock(&durable_scavenger_lock);
+	if (!durable_scavenger_running) {
+		mutex_unlock(&durable_scavenger_lock);
+		return false;
+	}
+	mutex_unlock(&durable_scavenger_lock);
+
+	if (kthread_should_stop())
+		return false;
+
+	if (idr_is_empty(global_ft.idr))
+		return false;
+
+	return true;
+}
+
+static void ksmbd_scavenger_dispose_dh(struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct ksmbd_file *fp;
+
+		fp = list_first_entry(head, struct ksmbd_file, node);
+		list_del_init(&fp->node);
+		__ksmbd_close_fd(NULL, fp);
+	}
+}
+
+static int ksmbd_durable_scavenger(void *dummy)
+{
+	struct ksmbd_file *fp = NULL;
+	unsigned int id;
+	unsigned int min_timeout = 1;
+	bool found_fp_timeout;
+	LIST_HEAD(scavenger_list);
+	unsigned long remaining_jiffies;
+
+	__module_get(THIS_MODULE);
+
+	set_freezable();
+	while (ksmbd_durable_scavenger_alive()) {
+		if (try_to_freeze())
+			continue;
+
+		found_fp_timeout = false;
+
+		remaining_jiffies = wait_event_timeout(dh_wq,
+				   ksmbd_durable_scavenger_alive() == false,
+				   __msecs_to_jiffies(min_timeout));
+		if (remaining_jiffies)
+			min_timeout = jiffies_to_msecs(remaining_jiffies);
+		else
+			min_timeout = DURABLE_HANDLE_MAX_TIMEOUT;
+
+		write_lock(&global_ft.lock);
+		idr_for_each_entry(global_ft.idr, fp, id) {
+			if (!fp->durable_timeout)
+				continue;
+
+			if (atomic_read(&fp->refcount) > 1 ||
+			    fp->conn)
+				continue;
+
+			found_fp_timeout = true;
+			if (fp->durable_scavenger_timeout <=
+			    jiffies_to_msecs(jiffies)) {
+				__ksmbd_remove_durable_fd(fp);
+				list_add(&fp->node, &scavenger_list);
+			} else {
+				unsigned long durable_timeout;
+
+				durable_timeout =
+					fp->durable_scavenger_timeout -
+						jiffies_to_msecs(jiffies);
+
+				if (min_timeout > durable_timeout)
+					min_timeout = durable_timeout;
+			}
+		}
+		write_unlock(&global_ft.lock);
+
+		ksmbd_scavenger_dispose_dh(&scavenger_list);
+
+		if (found_fp_timeout == false)
+			break;
+	}
+
+	mutex_lock(&durable_scavenger_lock);
+	durable_scavenger_running = false;
+	mutex_unlock(&durable_scavenger_lock);
+
+	module_put(THIS_MODULE);
+
+	return 0;
+}
+
+void ksmbd_launch_ksmbd_durable_scavenger(void)
+{
+	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE))
+		return;
+
+	mutex_lock(&durable_scavenger_lock);
+	if (durable_scavenger_running == true) {
+		mutex_unlock(&durable_scavenger_lock);
+		return;
+	}
+
+	durable_scavenger_running = true;
+
+	server_conf.dh_task = kthread_run(ksmbd_durable_scavenger,
+				     (void *)NULL, "ksmbd-durable-scavenger");
+	if (IS_ERR(server_conf.dh_task))
+		pr_err("cannot start conn thread, err : %ld\n",
+		       PTR_ERR(server_conf.dh_task));
+	mutex_unlock(&durable_scavenger_lock);
+}
+
+void ksmbd_stop_durable_scavenger(void)
+{
+	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE))
+		return;
+
+	mutex_lock(&durable_scavenger_lock);
+	if (!durable_scavenger_running) {
+		mutex_unlock(&durable_scavenger_lock);
+		return;
+	}
+
+	durable_scavenger_running = false;
+	if (waitqueue_active(&dh_wq))
+		wake_up(&dh_wq);
+	mutex_unlock(&durable_scavenger_lock);
+	kthread_stop(server_conf.dh_task);
+}
+
 static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 			     struct ksmbd_file *fp)
 {
@@ -823,11 +973,12 @@ void ksmbd_free_global_file_table(void)
 	unsigned int		id;
 
 	idr_for_each_entry(global_ft.idr, fp, id) {
-		__ksmbd_remove_durable_fd(fp);
-		kmem_cache_free(filp_cache, fp);
+		ksmbd_remove_durable_fd(fp);
+		__ksmbd_close_fd(NULL, fp);
 	}
 
-	ksmbd_destroy_file_table(&global_ft);
+	idr_destroy(global_ft.idr);
+	kfree(global_ft.idr);
 }
 
 int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
@@ -934,6 +1085,8 @@ int ksmbd_init_file_cache(void)
 	if (!filp_cache)
 		goto out;
 
+	init_waitqueue_head(&dh_wq);
+
 	return 0;
 
 out:
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index f2ab1514e81a..b0f6d0f94cb8 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -153,6 +153,8 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
+void ksmbd_launch_ksmbd_durable_scavenger(void);
+void ksmbd_stop_durable_scavenger(void);
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
 void ksmbd_close_session_fds(struct ksmbd_work *work);
 int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
-- 
2.43.0


