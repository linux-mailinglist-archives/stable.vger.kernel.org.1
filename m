Return-Path: <stable+bounces-185866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FABE0E7F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784D81A2112F
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1E3054F9;
	Wed, 15 Oct 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC8vIE/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABED2652A4
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566133; cv=none; b=elMf+VEuafEIUij5NDR+keM2YpsKLOy3S9gsnFvVAzc906w0vzA/LrDQbjXUqO8ogb+MgYgDx3xLllP+OJ1h5Nd/ui9DczqDP+i9l88wfGG4fxKdGzxJkcIWspaDXxmtfMzHaEb5frq4GNQTZ2o88Ej2GtJuWdyPvitR0RmNFLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566133; c=relaxed/simple;
	bh=/e5N0oPgNEBYYI0KzJej4HkgshpuklhpTjV9lqIxZSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCZ5bD0x9kpXEQ0QzF6FTa9EG8rc5DK2cyMUY3NSQ1Tf/9DMNdL/X1VWvK7kYaRCTJ6nHRbq3sSspZTLcGAfUyjpMoOb4e12gP3KznvE8P1TrEgusKjzkutbX25LI0uZUtc/8rLww+S5/qZ47+xHQHsyrRLd1AD29rG666Z0o40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC8vIE/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1EAC4CEFE;
	Wed, 15 Oct 2025 22:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760566133;
	bh=/e5N0oPgNEBYYI0KzJej4HkgshpuklhpTjV9lqIxZSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZC8vIE/JIfeRN9OUg2huUoZGLiS2rFyEHEL33ROAuM88IxJSStncAFE1QJBG6cTz0
	 arMTX/zUV9AzymixtycqdEOChrJVcRXP0TbHP8vyWMRdc35zLsoHFh9vxMOzwiWz2P
	 DQY2Bq+RHJFklfjXAlAeJz6wLjlEX+PWhYlCMq8PkCDESiw2MKVEpx6S633mHjdTIW
	 xGolWU0L+dzIx5z4LOPLV9UHY9/gb9a1xiiH/7SdCuJan9HNaXPk5mCCbQuhF8e3l5
	 z2XlLK/Efigoa/xMefEdsqYzxadulJQRXBaYDloyfNZVwx41BPw9L7CxbCNYDrBsw+
	 am0vn1PIm86sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] nfsd: unregister with rpcbind when deleting a transport
Date: Wed, 15 Oct 2025 18:08:46 -0400
Message-ID: <20251015220846.1531878-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015220846.1531878-1-sashal@kernel.org>
References: <2025101547-demeanor-rectify-27be@gregkh>
 <20251015220846.1531878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 898374fdd7f06fa4c4a66e8be3135efeae6128d5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h |  3 +++
 net/sunrpc/svc_xprt.c           | 13 +++++++++++++
 net/sunrpc/svcsock.c            |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 7064ebbd550b5..72d1a08f48282 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -103,6 +103,9 @@ enum {
 				 * it has access to.  It is NOT counted
 				 * in ->sv_tmpcnt.
 				 */
+	XPT_RPCB_UNREG,		/* transport that needs unregistering
+				 * with rpcbind (TCP, UDP) on destroy
+				 */
 };
 
 static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index dbd96b295dfa0..67474470320cb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1028,6 +1028,19 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
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
index e61e945760582..443d8390ebf1c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -837,6 +837,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
+	set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 
 	/* make sure we get destination address info */
 	switch (svsk->sk_sk->sk_family) {
@@ -1357,6 +1358,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	if (sk->sk_state == TCP_LISTEN) {
 		strcpy(svsk->sk_xprt.xpt_remotebuf, "listener");
 		set_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags);
+		set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
-- 
2.51.0


