Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC97D31DE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjJWLOL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjJWLOK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:14:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BFDC1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:14:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC666C433C8;
        Mon, 23 Oct 2023 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059648;
        bh=96x2biZHWsbTd76hFHXsiqxIWC9GdYU6YTbm6sVxf8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oEdWDRaK4Heby5cEccdMwZfoFYIMRw43ZmODtdcEdymzahKiJ9D5QaRkWtdLNVXSs
         CEFg6sh6IELO2TUtSrqVDAxA99egkwEFDZ7Fx0TvI6wpFBWrJkJoJgzSkP9lDul8ga
         o0VXkbJA2pAnd5t0R2v/M7yvAP73wMda8zXc8Y14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 240/241] mptcp: avoid sending RST when closing the initial subflow
Date:   Mon, 23 Oct 2023 12:57:06 +0200
Message-ID: <20231023104839.726794315@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2336,6 +2336,26 @@ bool __mptcp_retransmit_pending_data(str
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
@@ -2373,7 +2393,7 @@ static void __mptcp_close_ssk(struct soc
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2383,12 +2403,8 @@ static void __mptcp_close_ssk(struct soc
 
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


