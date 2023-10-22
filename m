Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FF7D24B9
	for <lists+stable@lfdr.de>; Sun, 22 Oct 2023 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjJVRDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVRDt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 13:03:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A83EE
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 10:03:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482F0C433C8;
        Sun, 22 Oct 2023 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994227;
        bh=ASmwY7XEktZn06QAjZRktEYJPd220w54PNdcSEgJbjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1vLPzR6mSiTVbb13ipjwcRkTJwr4oTf+XdFLQszrEfPZ8S0qo6KqNXAjA4wz0tgo
         agxRGVu4JpoUWRMjGWWCqyG7oUtCsITvOCc2hnKlsvz3q7tZeWKhY2xkiPkZHNxmCP
         W89v0C7YYJuToa85Ak515O7R1sH49Dr5ZuqfEEYxDTdwUZ8aGEXuhLwk3V52gUA4It
         s1yStHnxCeLcyysiPGrSjF/Xh8BWMa36errFU1Qwxs0L8gO0xkFarkga81Qbtcqxu9
         JWYcH+ib6pfI04XTxxCziojpo2+eGYoekT1fiWiIerxA9ij+pFYdpodNm4NErfGz0+
         z+hMZw6Wfr3ZA==
From:   Matthieu Baerts <matttbe@kernel.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Geliang Tang <geliang.tang@suse.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5.y] mptcp: avoid sending RST when closing the initial subflow
Date:   Sun, 22 Oct 2023 19:03:12 +0200
Message-Id: <20231022170312.2806040-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102021-unawake-celibate-46c9@gregkh>
References: <2023102021-unawake-celibate-46c9@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3650; i=matttbe@kernel.org; h=from:subject; bh=OxoEL9JK5W7UwjkuM9ecSkMvPAXIfJK7/IP8ekAuuRw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNVXQxL/mTqocoHvl/b/gtTttpmufJlWnwrSbZ wPOR1id296JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTVV0AAKCRD2t4JPQmmg cyAMEACv7suDSh1Ydr8eDNk9eUvoqCyMdFUT38DXESnFRuTCv+i4/e+tUA/UbzkKv0qWf3O+ZGz YiRTRTVvqnSGt8zb2frCl/Mlq7MLjmALWh3GCTRKUO6oJehIjo8PqpbWKRkw70XdaEp4SPAqKmR NzWdycrtUFhuj4D4BrACtcbdW6JWgR5WuwxFXPXHZwq03fPMV7hMWkIEJnEITXT/6weaMCNpjI8 FL8AnowDK0ey72Qp9j9TaQD8AmHIA3ohgMo/ZO3Zo50s0mXi00GtLDT4+ou3cEjSXalgGEVXkv/ 8EZJSa4mUSYyWg3qYEWtBEpq0YIy4J7xXRyEL/4IemP+Ope+lA4oJbg5mBk57f1zMQMngB1SoWp 7F4ZpXMlTzXjhEaEN4a7a4TEtAvVuyBui5CNeFUSUwj87g+GhHCedxVxKBozCWt4MEJqk7uNdqO kL6PL0o+omlQxZJdoaCHr8fXmes+7XINogeuThmJvsOglw0eefBjkOBfulG4jMXWx/LdJkHIXY+ 2lNuXJGAYUUZwdLLgzfHnR7QmZeKDg/yAwwAPkN8MkxfyVxFd9gPtxR7vNomUg0fz10+pyfXRgo Y90LTpFcFAE/JHQeWhrSRSfNDRlEqpBdIeRAxLWgBbNmU1Yr6OVNZdrlaRdglzg7x6TzaXDDuKj 1KujfTsWBZMjIoA==
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
index 679c2732b5d0..fc3621bbbe7e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2342,6 +2342,26 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
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
@@ -2379,7 +2399,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
 	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_disconnect() path,
+		/* be sure to force the tcp_close path
 		 * to generate the egress reset
 		 */
 		ssk->sk_lingertime = 0;
@@ -2389,12 +2409,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
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

