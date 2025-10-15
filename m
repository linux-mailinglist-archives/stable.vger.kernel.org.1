Return-Path: <stable+bounces-185798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FABDE33B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D9E48583D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64B1A9FB4;
	Wed, 15 Oct 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uE71QG/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB13217F56
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526051; cv=none; b=JgWlb/2Qr83kRnZjxMc0LOPqVzLt6OBEWEOSQrRTHtpBebaC63q36sq+HwEm/mqBY9JOOlDBHf4SfDh0c5UGoh7pwvR0iJiXDt8ZoOtGCHrYuPEL9SYEy/82HsuHZMKQ49PWMF7bCalKghMqtupp8CRETemMWkVUpKRJiN64i5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526051; c=relaxed/simple;
	bh=NuMAQkdtnjTbeeAkY6oWw7B62SDmQ1SQL1c4fQsObJE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ho6iTZph2hkMRNML45pZSPgI5BkTv4lcAY+LpbnNLzpNnfXNAh+IrrTwU0cZ1udZjj2cEhwI3HoFG9x7/0nZTZXb1MSp1VyCiaM9mwh61lxas7osqIFqzzw3sWdwq3eXFewZ7Ad5z8B8jd2X6u7tmuIue2EJgMAhS5w1fxNhyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uE71QG/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183D3C116B1;
	Wed, 15 Oct 2025 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760526050;
	bh=NuMAQkdtnjTbeeAkY6oWw7B62SDmQ1SQL1c4fQsObJE=;
	h=Subject:To:Cc:From:Date:From;
	b=uE71QG/hRqQik/OwuajFy/fM1qIhU5d66BvsUkxtjkqxp+uHr6qNhuAULjqW0tdY/
	 hs4Hoe5hBCAxQTjrZtDvSQMl1BQPO3kXYtnXuBrgA/d9WE2siieUb9pStB+dIcaS+6
	 BC7/mCGI8I7VmVuaBHii5vdeXjjc5vbJhHifxHoU=
Subject: FAILED: patch "[PATCH] nfsd: unregister with rpcbind when deleting a transport" failed to apply to 6.12-stable tree
To: okorniev@redhat.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 13:00:47 +0200
Message-ID: <2025101547-demeanor-rectify-27be@gregkh>
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
git cherry-pick -x 898374fdd7f06fa4c4a66e8be3135efeae6128d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101547-demeanor-rectify-27be@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 898374fdd7f06fa4c4a66e8be3135efeae6128d5 Mon Sep 17 00:00:00 2001
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Tue, 19 Aug 2025 14:04:02 -0400
Subject: [PATCH] nfsd: unregister with rpcbind when deleting a transport

When a listener is added, a part of creation of transport also registers
program/port with rpcbind. However, when the listener is removed,
while transport goes away, rpcbind still has the entry for that
port/type.

When deleting the transport, unregister with rpcbind when appropriate.

---v2 created a new xpt_flag XPT_RPCB_UNREG to mark TCP and UDP
transport and at xprt destroy send rpcbind unregister if flag set.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: d093c9089260 ("nfsd: fix management of listener transports")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 369a89aea186..2b886f7eb295 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -104,6 +104,9 @@ enum {
 				 * it has access to.  It is NOT counted
 				 * in ->sv_tmpcnt.
 				 */
+	XPT_RPCB_UNREG,		/* transport that needs unregistering
+				 * with rpcbind (TCP, UDP) on destroy
+				 */
 };
 
 /*
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..b800d704d807 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1014,6 +1014,19 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	struct svc_serv	*serv = xprt->xpt_server;
 	struct svc_deferred_req *dr;
 
+	/* unregister with rpcbind for when transport type is TCP or UDP.
+	 */
+	if (test_bit(XPT_RPCB_UNREG, &xprt->xpt_flags)) {
+		struct svc_sock *svsk = container_of(xprt, struct svc_sock,
+						     sk_xprt);
+		struct socket *sock = svsk->sk_sock;
+
+		if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
+				 sock->sk->sk_protocol, 0) < 0)
+			pr_warn("failed to unregister %s with rpcbind\n",
+				xprt->xpt_class->xcl_name);
+	}
+
 	if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
 		return;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index c0d5a27ba674..7b90abc5cf0e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -836,6 +836,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
+	set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 
 	/* make sure we get destination address info */
 	switch (svsk->sk_sk->sk_family) {
@@ -1350,6 +1351,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	if (sk->sk_state == TCP_LISTEN) {
 		strcpy(svsk->sk_xprt.xpt_remotebuf, "listener");
 		set_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags);
+		set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {


