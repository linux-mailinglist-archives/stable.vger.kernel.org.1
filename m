Return-Path: <stable+bounces-134822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F2A95233
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5556E3ADB9A
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1326461D;
	Mon, 21 Apr 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qx8Q8E8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFEF510
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243901; cv=none; b=nP7xrWHlzW2g5/NFRVSlXw5NBZT5eU+oQj4/AwXbXUYVYWZ0oxj5O+5sOI5HUxiSgDzJxa5nGYI3OTb2HNNmZ8y1+2c7oOATInFBXrNQs4yy4T4WintPnIiG2g516CpAotVTJND2dOaD5pl30V7y3IfhyJsFnwoBJGUYsCaFrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243901; c=relaxed/simple;
	bh=bZFGoHFT5iWx/SxRpaykO6GsgUfFaipj8eBADU2l/mI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E203eXlUUo+lz/M44hmLDcoc5zzWtOMZxapszPEftMVJWX5mF3qdTcf/F1vyHwp6ZQolGIWj7oP/uIBvp3IKPOaPbr0MmXefDAzWlzQSMsGXEnmNvBs9nf7S+Ghq61k9NVL8a1zjd6ao5CA+4XP9mDCZ+Tde0gnXHuDG09MFV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qx8Q8E8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F3CC4CEE4;
	Mon, 21 Apr 2025 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243900;
	bh=bZFGoHFT5iWx/SxRpaykO6GsgUfFaipj8eBADU2l/mI=;
	h=Subject:To:Cc:From:Date:From;
	b=Qx8Q8E8sEDsKrzvJgBnJ+YyGPoPlWh7ZSVJ8nZd2w9WJXJPzx46fRvpdd0tlOl5TG
	 sFcP1/anggGVdvC2M4cllTly6jEGqpaeC06MjWvx9dbyqeVcUJ6n8sZGr7N8MUGTCK
	 KkvO5ZQVqEqyURLOGhM/uy9FnHUmOlQkyR70CIAE=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free in __smb2_lease_break_noti()" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:58:09 +0200
Message-ID: <2025042109-embroider-consoling-20d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 21a4e47578d44c6b37c4fc4aba8ed7cc8dbb13de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042109-embroider-consoling-20d9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21a4e47578d44c6b37c4fc4aba8ed7cc8dbb13de Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 11 Apr 2025 15:19:46 +0900
Subject: [PATCH] ksmbd: fix use-after-free in __smb2_lease_break_noti()

Move tcp_transport free to ksmbd_conn_free. If ksmbd connection is
referenced when ksmbd server thread terminates, It will not be freed,
but conn->tcp_transport is freed. __smb2_lease_break_noti can be performed
asynchronously when the connection is disconnected. __smb2_lease_break_noti
calls ksmbd_conn_write, which can cause use-after-free
when conn->ksmbd_transport is already freed.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index c1f22c129111..83764c230e9d 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,8 +39,10 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
-	if (atomic_dec_and_test(&conn->refcnt))
+	if (atomic_dec_and_test(&conn->refcnt)) {
+		ksmbd_free_transport(conn->transport);
 		kfree(conn);
+	}
 }
 
 /**
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7f38a3c3f5bd..abedf510899a 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -93,15 +93,19 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	return t;
 }
 
+void ksmbd_free_transport(struct ksmbd_transport *kt)
+{
+	struct tcp_transport *t = TCP_TRANS(kt);
+
+	sock_release(t->sock);
+	kfree(t->iov);
+	kfree(t);
+}
+
 static void free_transport(struct tcp_transport *t)
 {
 	kernel_sock_shutdown(t->sock, SHUT_RDWR);
-	sock_release(t->sock);
-	t->sock = NULL;
-
 	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
-	kfree(t->iov);
-	kfree(t);
 }
 
 /**
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index 8c9aa624cfe3..1e51675ee1b2 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -8,6 +8,7 @@
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
 struct interface *ksmbd_find_netdev_name_iface_list(char *netdev_name);
+void ksmbd_free_transport(struct ksmbd_transport *kt);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 


