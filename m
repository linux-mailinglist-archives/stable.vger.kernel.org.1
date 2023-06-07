Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7FF726B62
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjFGUZN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjFGUY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9426B9
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F4364400
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E30FC433D2;
        Wed,  7 Jun 2023 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169436;
        bh=DmlP9kP5gKkiQwxm20JKx5+nL2zsAjWj/4GcVEpEK5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mze4jMrOYVGSkE9lJmfKQt6BWfc5FOhhlDjD1jRlL3ce2umGRxmivX5romzdrb7EB
         rFzo8BKVzrDiTgQzlWwkVHRtpmjFnAkSPIQrJR4qJpwNeLO+cuE6ImgtskGrQ6Wqqz
         OmAm8eUn+dduAIr3x6LzLxrap8mH7REDdmiczEEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 081/286] mptcp: simplify subflow_syn_recv_sock()
Date:   Wed,  7 Jun 2023 22:13:00 +0200
Message-ID: <20230607200925.721968828@linuxfoundation.org>
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

[ Upstream commit a88d0092b24b8cddce57fe0e88e60a9e29e0b515 ]

Postpone the msk cloning to the child process creation
so that we can avoid a bunch of conditionals.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/61
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 7e8b88ec35ee ("mptcp: consolidate passive msk socket initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8a6bd2782dc97..3b8abd79bfbd5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -695,14 +695,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
 }
 
-static void mptcp_force_close(struct sock *sk)
-{
-	/* the msk is not yet exposed to user-space, and refcount is 2 */
-	inet_sk_state_store(sk, TCP_CLOSE);
-	sk_common_release(sk);
-	sock_put(sk);
-}
-
 static void subflow_ulp_fallback(struct sock *sk,
 				 struct mptcp_subflow_context *old_ctx)
 {
@@ -757,7 +749,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_subflow_request_sock *subflow_req;
 	struct mptcp_options_received mp_opt;
 	bool fallback, fallback_is_fatal;
-	struct sock *new_msk = NULL;
 	struct mptcp_sock *owner;
 	struct sock *child;
 
@@ -786,14 +777,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC)) {
+		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPC))
 			fallback = true;
-			goto create_child;
-		}
 
-		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
-		if (!new_msk)
-			fallback = true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
@@ -822,21 +808,23 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
-
-			mptcp_subflow_drop_ctx(child);
-			goto out;
+			goto fallback;
 		}
 
 		/* ssk inherits options of listener sk */
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			owner = mptcp_sk(new_msk);
+			ctx->conn = mptcp_sk_clone(listener->conn, &mp_opt, req);
+			if (!ctx->conn)
+				goto fallback;
+
+			owner = mptcp_sk(ctx->conn);
 
 			/* this can't race with mptcp_close(), as the msk is
 			 * not yet exposted to user-space
 			 */
-			inet_sk_state_store((void *)new_msk, TCP_ESTABLISHED);
+			inet_sk_state_store(ctx->conn, TCP_ESTABLISHED);
 
 			/* record the newly created socket as the first msk
 			 * subflow, but don't link it yet into conn_list
@@ -846,11 +834,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
+			owner->setsockopt_seq = ctx->setsockopt_seq;
 			mptcp_pm_new_connection(owner, child, 1);
 			mptcp_token_accept(subflow_req, owner);
-			ctx->conn = new_msk;
-			new_msk = NULL;
 
 			/* set msk addresses early to ensure mptcp_pm_get_local_id()
 			 * uses the correct data
@@ -900,11 +886,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		}
 	}
 
-out:
-	/* dispose of the left over mptcp master, if any */
-	if (unlikely(new_msk))
-		mptcp_force_close(new_msk);
-
 	/* check for expected invariant - should never trigger, just help
 	 * catching eariler subtle bugs
 	 */
@@ -922,6 +903,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	/* The last child reference will be released by the caller */
 	return child;
+
+fallback:
+	mptcp_subflow_drop_ctx(child);
+	return child;
 }
 
 static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
-- 
2.39.2



