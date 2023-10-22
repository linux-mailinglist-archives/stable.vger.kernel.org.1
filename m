Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA557D2618
	for <lists+stable@lfdr.de>; Sun, 22 Oct 2023 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjJVVay (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjJVVay (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 17:30:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEBCE0
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 14:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094E8C433C7;
        Sun, 22 Oct 2023 21:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698010251;
        bh=cJKipLrselcpMdrSz/vmccEeuyxXEFH847h7gpLEAtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnXPq2pgTuN7S/CvKFFIUm9bLafivSZeP60vFRBLPkjXvLDqEEQX4hxVYvyIxMrEH
         QoSWfq8QhP0dLDhu4n3YUUeWipjNUjx5Qt+s8mtxhvV3oujoO3T4pSy/Zp+jDku2wM
         X9iVi3row0CBH6q6EFMR/rnrHMd/dTVOz8/BiiGc/5sI9l5pQCcLCF1akYqQMFgZ/8
         +UoyuDCJE8Xwziq4Vb0MfinOOdhR2o86xqUAaGE1ehSw8yfqztYbRtsLCVkRY/1AhY
         XG17PdLknGglVQXBgcBkRX7UtrylYEM1GFfvXgwDP1+ruTs1FsLHt+rxKJMCi+EFuF
         wN1WaN64jxCng==
From:   Matthieu Baerts <matttbe@kernel.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Geliang Tang <geliang.tang@suse.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: avoid sending RST when closing the initial subflow
Date:   Sun, 22 Oct 2023 23:30:13 +0200
Message-Id: <20231022213013.3391376-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102022-wrongness-buddhism-fcf4@gregkh>
References: <2023102022-wrongness-buddhism-fcf4@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; i=matttbe@kernel.org; h=from:subject; bh=3LmFOfhIncKJW+CCSaxy924+XH3LVK6xPojXs2JdxoU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNZRlJrBe7LsKV7N3Hh26He5w2fnKJdraNDKPl q5LkC4SZEKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTWUZQAKCRD2t4JPQmmg cyjxD/9OS+AK1qdvXZ3p+qMFqZnGfiFRdTuew84eFRljxR2bIwdcbcfgwa3Nxe/aaim0T4fFgbH kUnffz9fNgVnouZftYGtnrjgcFFMQullVY1MPpoyW7RgfMb7V9VneKnvKQCeMUzbn0qyr/WqLPJ ney4XMZqXl3ezVSAo2YWlI0qb3kYjtR84sJ0vGR4rGQzqd1w5lJ7JlSypf6bOxA82mSlgituqK5 pgXhMLpVuE6DhaRvBcgf3yORd2MZvUNeVreXB6+fSQ/Agp6m1JOZT5ex9bUa9rO1b5BvyPfXbV4 xWxdaaigMfKJzbIDLCijBsKFukSQ8CUkIdnE6/JkF5JcXbhGB5IXXQyd350PoXBa74Rex0u7rUp xstOuTElOb9LAn/kCuv8UhRjVkf0SGO6It3RM4Mq5oIqVGpACdMMCi2sesVQ8FEFlO+t9o99IZe PKVjanSBrGwhKNRaDPGDIusk9hL6UjolOj64Zfz6VK2i7/iiazObahL8MGo4ZfvadWob7kpA3pQ GSSsyVwCU0QMgPmM2+Qk2dPRN3rLki9hhzM6v/soAs9R2lhbIPdBsjMyz9AIznGUsdo4pluzYmR 9AoY28jQ4yriDJ2V1FjLB9fJ68MNnQob6b3ttcb+uygE5utUNW8+YrWpUTM6ODE+0rpL2nlDCm3 QszfbcwksQQdR/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

commit 14c56686a64c65ba716ff48f1f4b19c85f4cb2a9 upstream.

When closing the first subflow, the MPTCP protocol unconditionally
calls tcp_disconnect(), which in turn generates a reset if the subflow
is established.

That is unexpected and different from what MPTCP does with MPJ
subflows, where resets are generated only on FASTCLOSE and other edge
scenarios.

We can't reuse for the first subflow the same code in place for MPJ
subflows, as MPTCP clean them up completely via a tcp_close() call,
while must keep the first subflow socket alive for later re-usage, due
to implementation constraints.

This patch adds a new helper __mptcp_subflow_disconnect() that
encapsulates, a logic similar to tcp_close, issuing a reset only when
the MPTCP_CF_FASTCLOSE flag is set, and performing a clean shutdown
otherwise.

Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-4-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Backport notes:
  - One conflict due to 39880bd808ad ("mptcp: get rid of msk->subflow")
    introduced in v6.6. In previous versions, the socket state needs to
    be set to SS_UNCONNECTED.
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 881e05193ac9..0a66181b56cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2374,6 +2374,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 #define MPTCP_CF_PUSH		BIT(1)
 #define MPTCP_CF_FASTCLOSE	BIT(2)
 
+/* be sure to send a reset only if the caller asked for it, also
+ * clean completely the subflow status when the subflow reaches
+ * TCP_CLOSE state
+ */
+static void __mptcp_subflow_disconnect(struct sock *ssk,
+				       struct mptcp_subflow_context *subflow,
+				       unsigned int flags)
+{
+	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
+	    (flags & MPTCP_CF_FASTCLOSE)) {
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		mptcp_subflow_ctx_reset(subflow);
+	} else {
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+	}
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2411,7 +2431,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2421,12 +2441,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		/* The MPTCP code never wait on the subflow sockets, TCP-level
-		 * disconnect should never fail
-		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		__mptcp_subflow_disconnect(ssk, subflow, flags);
 		msk->subflow->state = SS_UNCONNECTED;
-		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
 
 		goto out;
-- 
2.40.1

