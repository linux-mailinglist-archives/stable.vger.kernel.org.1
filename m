Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD9726D4F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjFGUlG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjFGUlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C226BB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0BEF645F4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42D1C433D2;
        Wed,  7 Jun 2023 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170443;
        bh=hJyVyGCU7wIAYmcwDLC3ZvjCP8WMBVdP+40UBv+eN0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkDJUVZRgf4jF42QRQbtfGQlpqAb9SWTC8v6tpFo/ZAnaHv9ZodWjudeCszsgXJZZ
         ZZD6vzA8894ZDOfUo5UqHxcAG9C83f9XxGOm2N4XvIRPMGT9uz3fUKpWhZU51Y2iTG
         FFPBgUQxZZMjOWwz49x9sUYaaT5go+LFOFDRU9QI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/225] mptcp: consolidate passive msk socket initialization
Date:   Wed,  7 Jun 2023 22:14:10 +0200
Message-ID: <20230607200916.219042439@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

[ Upstream commit 7e8b88ec35eef363040e08d99536d2bebef83774 ]

When the msk socket is cloned at MPC handshake time, a few
fields are initialized in a racy way outside mptcp_sk_clone()
and the msk socket lock.

The above is due historical reasons: before commit a88d0092b24b
("mptcp: simplify subflow_syn_recv_sock()") as the first subflow socket
carrying all the needed date was not available yet at msk creation
time

We can now refactor the code moving the missing initialization bit
under the socket lock, removing the init race and avoiding some
code duplication.

This will also simplify the next patch, as all msk->first write
access are now under the msk socket lock.

Fixes: 0397c6d85f9c ("mptcp: keep unaccepted MPC subflow into join list")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 35 ++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  8 ++++----
 net/mptcp/subflow.c  | 28 +---------------------------
 3 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index efe372ff389d4..6f6b65d3eed1a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3017,7 +3017,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sock_put(sk);
 }
 
-void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
+static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	const struct ipv6_pinfo *ssk6 = inet6_sk(ssk);
@@ -3093,9 +3093,10 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 }
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req)
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
@@ -3137,10 +3138,30 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	}
 
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
-	/* will be fully established after successful MPC subflow creation */
-	inet_sk_state_store(nsk, TCP_SYN_RECV);
-
 	security_inet_csk_clone(nsk, req);
+
+	/* this can't race with mptcp_close(), as the msk is
+	 * not yet exposted to user-space
+	 */
+	inet_sk_state_store(nsk, TCP_ESTABLISHED);
+
+	/* The msk maintain a ref to each subflow in the connections list */
+	WRITE_ONCE(msk->first, ssk);
+	list_add(&mptcp_subflow_ctx(ssk)->node, &msk->conn_list);
+	sock_hold(ssk);
+
+	/* new mpc subflow takes ownership of the newly
+	 * created mptcp socket
+	 */
+	mptcp_token_accept(subflow_req, msk);
+
+	/* set msk addresses early to ensure mptcp_pm_get_local_id()
+	 * uses the correct data
+	 */
+	mptcp_copy_inaddrs(nsk, ssk);
+	mptcp_propagate_sndbuf(nsk, ssk);
+
+	mptcp_rcv_space_init(msk, ssk);
 	bh_unlock_sock(nsk);
 
 	/* note: the newly allocated socket refcount is 2 now */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 822fd749f5690..4a2f6e29211a1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -606,7 +606,6 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
-void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
@@ -675,9 +674,10 @@ void __init mptcp_proto_init(void);
 int __init mptcp_proto_v6_init(void);
 #endif
 
-struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct mptcp_options_received *mp_opt,
-			    struct request_sock *req);
+struct sock *mptcp_sk_clone_init(const struct sock *sk,
+				 const struct mptcp_options_received *mp_opt,
+				 struct sock *ssk,
+				 struct request_sock *req);
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 276e62003631e..336878f8a222a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -751,38 +751,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			ctx->conn = mptcp_sk_clone(listener->conn, &mp_opt, req);
+			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
 			if (!ctx->conn)
 				goto fallback;
 
 			owner = mptcp_sk(ctx->conn);
-
-			/* this can't race with mptcp_close(), as the msk is
-			 * not yet exposted to user-space
-			 */
-			inet_sk_state_store(ctx->conn, TCP_ESTABLISHED);
-
-			/* record the newly created socket as the first msk
-			 * subflow, but don't link it yet into conn_list
-			 */
-			WRITE_ONCE(owner->first, child);
-
-			/* new mpc subflow takes ownership of the newly
-			 * created mptcp socket
-			 */
-			owner->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(owner, child, 1);
-			mptcp_token_accept(subflow_req, owner);
-
-			/* set msk addresses early to ensure mptcp_pm_get_local_id()
-			 * uses the correct data
-			 */
-			mptcp_copy_inaddrs(ctx->conn, child);
-			mptcp_propagate_sndbuf(ctx->conn, child);
-
-			mptcp_rcv_space_init(owner, child);
-			list_add(&ctx->node, &owner->conn_list);
-			sock_hold(child);
 
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
-- 
2.39.2



