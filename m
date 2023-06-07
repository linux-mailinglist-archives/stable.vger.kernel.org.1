Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C44726C68
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjFGUdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFGUd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50781FE2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6433B64524
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FDC4339B;
        Wed,  7 Jun 2023 20:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170000;
        bh=ucAgBZYIJgs4s7Z+IiSF7TVuC0Bxxl74gAkSMWVdndE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZwFswGDekFEUvT0GNXCRXGfNK5lgnjP5auFTUFhvrvNzB4OXAR2vnw3Zx2Pbm8jT
         3O884/VXzeyTtlGVfOUOj2c4V0Y+wXwp1TQ056G364TAVbG6FuUGZS4ASFHUsi86dX
         Vuf9nvmDFSmC1W5DeEsD1ULud3ROdbec0xfq1rlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 257/286] mptcp: fix connect timeout handling
Date:   Wed,  7 Jun 2023 22:15:56 +0200
Message-ID: <20230607200931.710505824@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 786fc12457268cc9b555dde6c22ae7300d4b40e1 upstream.

Ondrej reported a functional issue WRT timeout handling on connect
with a nice reproducer.

The problem is that the current mptcp connect waits for both the
MPTCP socket level timeout, and the first subflow socket timeout.
The latter is not influenced/touched by the exposed setsockopt().

Overall the above makes the SO_SNDTIMEO a no-op on connect.

Since mptcp_connect is invoked via inet_stream_connect and the
latter properly handle the MPTCP level timeout, we can address the
issue making the nested subflow level connect always unblocking.

This also allow simplifying a bit the code, dropping an ugly hack
to handle the fastopen and custom proto_ops connect.

The issues predates the blamed commit below, but the current resolution
requires the infrastructure introduced there.

Fixes: 54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/399
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   29 +++++++----------------------
 net/mptcp/protocol.h |    1 -
 2 files changed, 7 insertions(+), 23 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1671,7 +1671,6 @@ static int mptcp_sendmsg_fastopen(struct
 
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
-	msk->connect_flags = O_NONBLOCK;
 	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
 	msk->fastopening = 0;
@@ -3610,9 +3609,9 @@ static int mptcp_connect(struct sock *sk
 	 * acquired the subflow socket lock, too.
 	 */
 	if (msk->fastopening)
-		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
+		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
 	else
-		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
+		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
 	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3625,12 +3624,10 @@ static int mptcp_connect(struct sock *sk
 
 	mptcp_copy_inaddrs(sk, ssock->sk);
 
-	/* unblocking connect, mptcp-level inet_stream_connect will error out
-	 * without changing the socket state, update it here.
+	/* silence EINPROGRESS and let the caller inet_stream_connect
+	 * handle the connection in progress
 	 */
-	if (err == -EINPROGRESS)
-		sk->sk_socket->state = ssock->state;
-	return err;
+	return 0;
 }
 
 static struct proto mptcp_prot = {
@@ -3689,18 +3686,6 @@ unlock:
 	return err;
 }
 
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
-				int addr_len, int flags)
-{
-	int ret;
-
-	lock_sock(sock->sk);
-	mptcp_sk(sock->sk)->connect_flags = flags;
-	ret = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
-	release_sock(sock->sk);
-	return ret;
-}
-
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
@@ -3857,7 +3842,7 @@ static const struct proto_ops mptcp_stre
 	.owner		   = THIS_MODULE,
 	.release	   = inet_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet_getname,
@@ -3952,7 +3937,7 @@ static const struct proto_ops mptcp_v6_s
 	.owner		   = THIS_MODULE,
 	.release	   = inet6_release,
 	.bind		   = mptcp_bind,
-	.connect	   = mptcp_stream_connect,
+	.connect	   = inet_stream_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = mptcp_stream_accept,
 	.getname	   = inet6_getname,
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -297,7 +297,6 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1;
-	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;


