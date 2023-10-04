Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE077B8E2F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjJDUi0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjJDUi0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 16:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FD2DD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 13:38:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D719C433C9;
        Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696451902;
        bh=7b3RC+RCCWMFJYgE0lgix2Ut1RLI3dKTkHCq236cmvw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=SErEAxL2/UStBJH3sdgd0ViHfFAN2t4MskNLkOIJlNNBc/H7LHeRM10n+ZHL26+xl
         kCVwUXlJWUhcHftxrVCMI88P0DKHqVfTFl3vJ3ttSUMN59fE+8GTUIXB8eOZICRwPJ
         oUmbszHgcaYkJF7ZvPbMQ/vXaXXNb5T3LNGlLoa+O9doEFR40QAvWGdyMf/29dxXaU
         jsASdxsfNB2SUZMwzJ5v24jTAiOdh0ponLIra3BrRxc8JefAVyuD57y0BifUI8s8BI
         y0UOkykPO3+wbBVNsIa6UM16K/C+jRiJw7BOJ/rCw+xVkwQxd3KwpFvSy16Vlse/T2
         ywzYQHEIo++yA==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 04 Oct 2023 13:38:11 -0700
Subject: [PATCH net 1/3] mptcp: fix delegated action races
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-send-net-20231004-v1-1-28de4ac663ae@kernel.org>
References: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
In-Reply-To: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Kishen Maloor <kishen.maloor@intel.com>,
        Florian Westphal <fw@strlen.de>,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The delegated action infrastructure is prone to the following
race: different CPUs can try to schedule different delegated
actions on the same subflow at the same time.

Each of them will check different bits via mptcp_subflow_delegate(),
and will try to schedule the action on the related per-cpu napi
instance.

Depending on the timing, both can observe an empty delegated list
node, causing the same entry to be added simultaneously on two different
lists.

The root cause is that the delegated actions infra does not provide
a single synchronization point. Address the issue reserving an additional
bit to mark the subflow as scheduled for delegation. Acquiring such bit
guarantee the caller to own the delegated list node, and being able to
safely schedule the subflow.

Clear such bit only when the subflow scheduling is completed, ensuring
proper barrier in place.

Additionally swap the meaning of the delegated_action bitmask, to allow
the usage of the existing helper to set multiple bit at once.

Fixes: bcd97734318d ("mptcp: use delegate action to schedule 3rd ack retrans")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 28 ++++++++++++++--------------
 net/mptcp/protocol.h | 35 ++++++++++++-----------------------
 net/mptcp/subflow.c  | 10 ++++++++--
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e252539b1e19..c3b83cb390d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3425,24 +3425,21 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
 }
 
-void mptcp_subflow_process_delegated(struct sock *ssk)
+void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
-	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
+	if (status & BIT(MPTCP_DELEGATE_SEND)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
 			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_SEND);
 	}
-	if (test_bit(MPTCP_DELEGATE_ACK, &subflow->delegated_status)) {
+	if (status & BIT(MPTCP_DELEGATE_ACK))
 		schedule_3rdack_retransmission(ssk);
-		mptcp_subflow_delegated_done(subflow, MPTCP_DELEGATE_ACK);
-	}
 }
 
 static int mptcp_hash(struct sock *sk)
@@ -3968,14 +3965,17 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		bh_lock_sock_nested(ssk);
-		if (!sock_owned_by_user(ssk) &&
-		    mptcp_subflow_has_delegated_action(subflow))
-			mptcp_subflow_process_delegated(ssk);
-		/* ... elsewhere tcp_release_cb_override already processed
-		 * the action or will do at next release_sock().
-		 * In both case must dequeue the subflow here - on the same
-		 * CPU that scheduled it.
-		 */
+		if (!sock_owned_by_user(ssk)) {
+			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
+		} else {
+			/* tcp_release_cb_override already processed
+			 * the action or will do at next release_sock().
+			 * In both case must dequeue the subflow here - on the same
+			 * CPU that scheduled it.
+			 */
+			smp_wmb();
+			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed61d6850cce..3612545fa62e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -444,9 +444,11 @@ struct mptcp_delegated_action {
 
 DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 
-#define MPTCP_DELEGATE_SEND		0
-#define MPTCP_DELEGATE_ACK		1
+#define MPTCP_DELEGATE_SCHEDULED	0
+#define MPTCP_DELEGATE_SEND		1
+#define MPTCP_DELEGATE_ACK		2
 
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -564,23 +566,24 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
 
-void mptcp_subflow_process_delegated(struct sock *ssk);
+void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
 {
+	long old, set_bits = BIT(MPTCP_DELEGATE_SCHEDULED) | BIT(action);
 	struct mptcp_delegated_action *delegated;
 	bool schedule;
 
 	/* the caller held the subflow bh socket lock */
 	lockdep_assert_in_softirq();
 
-	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
-	 * ensures the below list check sees list updates done prior to status
-	 * bit changes
+	/* The implied barrier pairs with tcp_release_cb_override()
+	 * mptcp_napi_poll(), and ensures the below list check sees list
+	 * updates done prior to delegated status bits changes
 	 */
-	if (!test_and_set_bit(action, &subflow->delegated_status)) {
-		/* still on delegated list from previous scheduling */
-		if (!list_empty(&subflow->delegated_node))
+	old = set_mask_bits(&subflow->delegated_status, 0, set_bits);
+	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED))) {
+		if (WARN_ON_ONCE(!list_empty(&subflow->delegated_node)))
 			return;
 
 		delegated = this_cpu_ptr(&mptcp_delegated_actions);
@@ -605,20 +608,6 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
-static inline bool mptcp_subflow_has_delegated_action(const struct mptcp_subflow_context *subflow)
-{
-	return !!READ_ONCE(subflow->delegated_status);
-}
-
-static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *subflow, int action)
-{
-	/* pairs with mptcp_subflow_delegate, ensures delegate_node is updated before
-	 * touching the status bit
-	 */
-	smp_wmb();
-	clear_bit(action, &subflow->delegated_status);
-}
-
 int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 918c1a235790..9c1f8d1d63d2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1956,9 +1956,15 @@ static void subflow_ulp_clone(const struct request_sock *req,
 static void tcp_release_cb_override(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	long status;
 
-	if (mptcp_subflow_has_delegated_action(subflow))
-		mptcp_subflow_process_delegated(ssk);
+	/* process and clear all the pending actions, but leave the subflow into
+	 * the napi queue. To respect locking, only the same CPU that originated
+	 * the action can touch the list. mptcp_napi_poll will take care of it.
+	 */
+	status = set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE_ACTIONS_MASK, 0);
+	if (status)
+		mptcp_subflow_process_delegated(ssk, status);
 
 	tcp_release_cb(ssk);
 }

-- 
2.41.0

