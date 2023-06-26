Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241C73E8D2
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjFZSaa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjFZS3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:29:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB613125
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59A1C60F1E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63027C433C0;
        Mon, 26 Jun 2023 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804150;
        bh=V5ipiWSx90hf5RW9m62pcRBzjA8w7Y2D3SsbHX9mYdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YY37yqozNURsJKZopWtACudfyZofbvt9JxvkH3f2hqwaaOppf+JP7WwOoxp4thLUT
         /v7NMVF9IE6HiIXt1PNLAO7yzcTYg1875cS4bmlPIoWq/OO/3gsqdR7xzemsd7PUfH
         FndF+c1c81oQDcYQNxFqN/Uolz2uLQfarMaLKf/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 059/170] mptcp: fix possible list corruption on passive MPJ
Date:   Mon, 26 Jun 2023 20:10:28 +0200
Message-ID: <20230626180803.236430324@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit 56a666c48b038e91b76471289e2cf60c79d326b9 upstream.

At passive MPJ time, if the msk socket lock is held by the user,
the new subflow is appended to the msk->join_list under the msk
data lock.

In mptcp_release_cb()/__mptcp_flush_join_list(), the subflows in
that list are moved from the join_list into the conn_list under the
msk socket lock.

Append and removal could race, possibly corrupting such list.
Address the issue splicing the join list into a temporary one while
still under the msk data lock.

Found by code inspection, the race itself should be almost impossible
to trigger in practice.

Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -846,12 +846,12 @@ static bool __mptcp_finish_join(struct m
 	return true;
 }
 
-static void __mptcp_flush_join_list(struct sock *sk)
+static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list)
 {
 	struct mptcp_subflow_context *tmp, *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+	list_for_each_entry_safe(subflow, tmp, join_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
@@ -3335,9 +3335,14 @@ static void mptcp_release_cb(struct sock
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
 				      msk->push_pending;
+		struct list_head join_list;
+
 		if (!flags)
 			break;
 
+		INIT_LIST_HEAD(&join_list);
+		list_splice_init(&msk->join_list, &join_list);
+
 		/* the following actions acquire the subflow socket lock
 		 *
 		 * 1) can't be invoked in atomic scope
@@ -3348,8 +3353,9 @@ static void mptcp_release_cb(struct sock
 		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
+
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
-			__mptcp_flush_join_list(sk);
+			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))


