Return-Path: <stable+bounces-134821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62974A95230
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988D0173232
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800BF265633;
	Mon, 21 Apr 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQQuFxvX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA28266B4A
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243892; cv=none; b=TJchYxBvvsHsgCjQKzq8aIFLEpJykgkmYJgpao9Tr9TZAUjxf48JqWb/Hym9wb0lmtdMOtPKRbhUOiWrkA1wyg0pa7j9uzfgfE7gCgQFZYnsTJYK7uzZvpT6n7Ol/ErlawERK8xufaY+k7+0CN/plh9kCgHjQBdJMGlfSrNYIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243892; c=relaxed/simple;
	bh=SaaKR6qrs0cAY9pabo9p3y0artvIk2vANpBPRh00n08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eBmCwgVX/o+R7ZABhLcndO5fEr5g86E80LoRXBZF/zeMaiHaWJZarNa5vCya0whLOIHbzfhxPbLv+BReXDhK8jACImX1koi2LA9/aY7ouaO+LKU5Dsoip1Vc5C9jrM5AUnZtD5kJs91xLXbaUw1zsbiKeGyaEH4GoY3zSOes64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQQuFxvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98659C4CEEA;
	Mon, 21 Apr 2025 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243892;
	bh=SaaKR6qrs0cAY9pabo9p3y0artvIk2vANpBPRh00n08=;
	h=Subject:To:Cc:From:Date:From;
	b=yQQuFxvXAbLvE7datHyXCD89gq58i+6GKuH6nX7XoJkVavJFfBTUyqmSaLN1qnAk2
	 rQXgUXDUhQfBlRkuemr9L7peB1YWTY2yh/AiLqenxVNgF0u72k+XTIXLF9RF7LoOs/
	 1CfzzZG2tJMUafGWyhIjevSYqze6zkNx1ISYxY+E=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free in __smb2_lease_break_noti()" failed to apply to 6.12-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:58:09 +0200
Message-ID: <2025042109-uncurled-pebble-1681@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 21a4e47578d44c6b37c4fc4aba8ed7cc8dbb13de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042109-uncurled-pebble-1681@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


