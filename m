Return-Path: <stable+bounces-254266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDfcJaJTFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:02:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38785D22FF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8F5130578D5
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3393BAD9F;
	Tue, 26 May 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pBFs+CTo"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170D379981;
	Tue, 26 May 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782357; cv=none; b=iAyfsivVHVyvvpWgnemAAEjhq3rUG+zitUj/GggOQpnZpFNwPEHfNZiGzAobPHqzkXk3v+TDwH65EdccuiLFJJCbiEiOwP8wrdxWLmM0+e5egIT8bAeery96G1TQN2oQPrzEx8KRoIfX6+uNqaSXYFVyAa5XoMPZl5zYhkBVlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782357; c=relaxed/simple;
	bh=M+XidVCie+fT29eWkQJ0g4SYy3+t1C4EWRPltEyb4aA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mRZQ3t1arBkAVFUkwpZQGnlhaPjzfn5RGrOtHs14M4EZeplUwCV7jaqmFyG9Ot39AFyKpRbGcsUU097JO3KhL6QtmiSrZK7ZdLU8CkXd5a8d8L6ARDkqE3cVCZSSbWyWNwvVrX7Xy10upivRKu3PSCiCn9O6OSPCuEIbymiQHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pBFs+CTo; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779782344;
	bh=FB3vmd6W8iEhqSNTJFDy8+jEiKb0h+7FBUGQAACUw4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pBFs+CToGzgidM2/GcVLSqr+mO8TVsRr9GKvnqGBk5SCfKkuHH9xkgtW7TEsRb3nL
	 IUYrts+sIoQPdl0tUn7dINtQzp67Qk0uXTeuhhjJOaYvHAYKkG9nCM1TVOytBdEO7L
	 1fC3AacrwWednCO5Zpkr7F6lBHEv7EupK0L8jY7s=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id EB912EE0; Tue, 26 May 2026 15:58:57 +0800
X-QQ-mid: xmsmtpt1779782341tz6z6k1b8
Message-ID: <tencent_C400388430540D93B436357C1FA1924FD608@qq.com>
X-QQ-XMAILINFO: NcAdPGlpF/v/nTbuO6KhlpV1FK/+n6XFqWueDDFhK0+TykhFyKsItwjAgMfrQr
	 yznu5ojs1A6Sn3aNdbXU0+xwpyk844kEZLwTdOvkeLEqfuu4EzW1YIjGb6pDPU6NAb38LZ7eU0oH
	 bbkjl8DebfGlR/wPQmFQakRmVTc/9KtvxruSVU2UWTLQHC2VI2RsLM4E5ncOVur4H0ix8MlLO2tS
	 Rpph31+z8RsTbGlpWcC9rhObclx7qKyjK5rWTqGYErDJTVmu/WGXrdDI4437rOOFI+eHqJdETw7D
	 t/QHOo9+KTuZqCj3GbXApWqS4XviIGVcLj1qILHceUqoIhsDYbLLqhRJuqWGUQhQjXMveRDcxElp
	 XB2xtuL/0Bc/HkpbTwkAp6igQhuuzwK+TxKVqLewgehhxbqtJ0cGcsMUQj0F5suBefqclrz5asdG
	 eYNTK0bidLTUbC2ONztsz6Oa+xjWWKN2oAiEGwuPUdJcEl5uqY9/aHdUAhocvHfbjCAtUAwLzy5r
	 qLyj3U9mI3hcQn0mvBIIiaGWR/WPNB7BhV+v4QC/uOnHGrP5Hels0GCp3dcESXGNq6jc5GSc7FOX
	 tMH+HMZg2uKBTz59l7h6Qr+EUlWjjkkImTaPVusjafboEfXG6BnjHpt+jQsOsECPQz3zLL3bCxvY
	 p+iFhm2KXHtoZqLmAWHhOspEUvR1ntTsYlR4kkbP97HBK4awk0TkhFuvIviAnXV9G3XZdPPIu7p7
	 uSQ7TVi8MuvcUENhMr3mHGO5Y4dDmIo12bgRcawkBMWEk6S7C0wnycwVdP1uPMfcZ+gW89xW0fzR
	 FzAqco9vrowjqDg3ChzPP4EiF74z21INDnD3muUZK/UgSFcETk0GrgTOVO6yzVv/AfpXI/m/bjp8
	 CCPzMEEGiddP4bh3oxV5vhqjjGJwtIqdqLnbKRITDk0VBm4CBAEqkTNPi/sO71I5rchRkuBNSZI9
	 4NWnBEsJEfKzj6+Twhki2iiqnSCFeh47f5gxBGhAoGR5v6sFWN1gPFmUYAhPR3KLqcNmJ5rsDA81
	 vcP++eFMcjtYGDvI3JONdU0EIrClaWDUdc6VCJkvMWHZ6bx/0JLP0OVwu02dC3K+yEAMBjXMp+B8
	 QagMG9Ww1m4KxMMNc=
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
	charsyam@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v3 2/4] ksmbd: add durable scavenger timer
Date: Tue, 26 May 2026 15:58:40 +0800
X-OQ-MSGID: <20260526075843.50277-2-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526075843.50277-1-alvalan9@foxmail.com>
References: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
 <20260526075843.50277-1-alvalan9@foxmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254266-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: F38785D22FF
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


