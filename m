Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C987D150E
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjJTRmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377950AbjJTRmg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:42:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C24D71
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:42:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B202DC433C8;
        Fri, 20 Oct 2023 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823753;
        bh=/dbE62so9CbI8WsDC7OD1x0gs1mrXmZYQ/kQ/EefUDc=;
        h=Subject:To:Cc:From:Date:From;
        b=l1kW+jqaiskS1+deS/55ngCdGwh6lPWzBd9VD7IFZdRezWOww1tudsVo4PAUiaDSq
         1vWce+uhL/pSu8Uvpq4pF78JN3Pn/5A39uzWJ7yi0gsSCWVm2MgbA+pXtKdvaTMAcY
         CAmh9NzBtnzKRPaadIkAMxdpBu2P+E62nK/c2XH8=
Subject: FAILED: patch "[PATCH] mptcp: avoid sending RST when closing the initial subflow" failed to apply to 6.1-stable tree
To:     geliang.tang@suse.com, kuba@kernel.org, martineau@kernel.org,
        matttbe@kernel.org, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:42:22 +0200
Message-ID: <2023102022-wrongness-buddhism-fcf4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 14c56686a64c65ba716ff48f1f4b19c85f4cb2a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102022-wrongness-buddhism-fcf4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14c56686a64c65ba716ff48f1f4b19c85f4cb2a9 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang.tang@suse.com>
Date: Wed, 18 Oct 2023 11:23:55 -0700
Subject: [PATCH] mptcp: avoid sending RST when closing the initial subflow

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e30e5ba3795..886ab689a8ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2348,6 +2348,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
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
@@ -2385,7 +2405,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2395,11 +2415,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		/* The MPTCP code never wait on the subflow sockets, TCP-level
-		 * disconnect should never fail
-		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		mptcp_subflow_ctx_reset(subflow);
+		__mptcp_subflow_disconnect(ssk, subflow, flags);
 		release_sock(ssk);
 
 		goto out;

