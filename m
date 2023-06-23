Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411E73B3A0
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjFWJb4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWJbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C89D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E4F619B0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675C9C433C0;
        Fri, 23 Jun 2023 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512693;
        bh=Fmy8coR5Q5CjNMUq9K0tRmG69qXlF7MDRtM3pWQDPyg=;
        h=Subject:To:Cc:From:Date:From;
        b=GyyDQBImJkbZNhhLQTK6BSOGSUdOeSTbx2Yare+2TBTrHcV3dPNukrbdyMEJrDLgW
         pxf4f822sbIELvm+DUQaDQB5B32W0b3mSsDwpaAog4J2g846gRL7Luuw9ZC+6EdBnA
         sMMnZRq8gYSqnlLSEiIGFMEnX+t/3Ig71LrkXTyo=
Subject: FAILED: patch "[PATCH] mptcp: ensure listener is unhashed before updating the sk" failed to apply to 6.1-stable tree
To:     pabeni@redhat.com, cpaasch@apple.com, kuba@kernel.org,
        matthieu.baerts@tessares.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:31:31 +0200
Message-ID: <2023062330-scrawny-capture-257c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 57fc0f1ceaa4016354cf6f88533e20b56190e41a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062330-scrawny-capture-257c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57fc0f1ceaa4016354cf6f88533e20b56190e41a Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Jun 2023 18:24:23 +0200
Subject: [PATCH] mptcp: ensure listener is unhashed before updating the sk
 status

The MPTCP protocol access the listener subflow in a lockless
manner in a couple of places (poll, diag). That works only if
the msk itself leaves the listener status only after that the
subflow itself has been closed/disconnected. Otherwise we risk
deadlock in diag, as reported by Christoph.

Address the issue ensuring that the first subflow (the listener
one) is always disconnected before updating the msk socket status.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/407
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 59f8f3124855..1224dfca5bf3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1047,6 +1047,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err)
 		return err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a66ec341485e..a6c7f2d24909 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2368,13 +2368,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2902,10 +2895,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-static void mptcp_listen_inuse_dec(struct sock *sk)
+static void mptcp_check_listen_stop(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) == TCP_LISTEN)
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
 }
 
 bool __mptcp_close(struct sock *sk, long timeout)
@@ -2918,7 +2925,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		mptcp_listen_inuse_dec(sk);
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3035,7 +3042,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;
 
-	mptcp_listen_inuse_dec(sk);
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);

