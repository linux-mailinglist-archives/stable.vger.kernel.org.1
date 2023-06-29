Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0B742C1E
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjF2Spq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjF2Spo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADC2D55
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731D0615DC
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8832CC433C8;
        Thu, 29 Jun 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064340;
        bh=TxhtcA1zsQ8zjXDSDK52qjCg4Y+jlD4LBuDNlZ5N0MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA5LpY4FGspBcv8E0H2I1HSR4dxymg5rcD1/tQrqGqncgsjNPFTW541cIV+lBxIMK
         GA70sXVkNZuxba6+d6e+OjoiVnv4n6K8Xr/O7FpFWBC2YOZAM9EU8WJnilvrulPb9w
         fRSosaMSbmj45efpn/4pVaRiiuaGdqj8eud2clww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 03/30] mptcp: ensure listener is unhashed before updating the sk status
Date:   Thu, 29 Jun 2023 20:43:22 +0200
Message-ID: <20230629184151.798150717@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 57fc0f1ceaa4016354cf6f88533e20b56190e41a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    1 +
 net/mptcp/protocol.c   |   26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1039,6 +1039,7 @@ static int mptcp_pm_nl_create_listen_soc
 		return err;
 	}
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2400,12 +2400,6 @@ static void __mptcp_close_ssk(struct soc
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2939,6 +2933,24 @@ static __poll_t mptcp_check_readable(str
 	return EPOLLIN | EPOLLRDNORM;
 }
 
+static void mptcp_check_listen_stop(struct sock *sk)
+{
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2949,6 +2961,7 @@ bool __mptcp_close(struct sock *sk, long
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3062,6 +3075,7 @@ static int mptcp_disconnect(struct sock
 	if (msk->fastopening)
 		return -EBUSY;
 
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);


