Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CA718A49
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEaTha (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 15:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaTh3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 15:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9083194
        for <stable@vger.kernel.org>; Wed, 31 May 2023 12:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C480639C1
        for <stable@vger.kernel.org>; Wed, 31 May 2023 19:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C1C433D2;
        Wed, 31 May 2023 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685561838;
        bh=eMhN4xxNMlQU6PkbhzwTVXENtyni6r0Q9UeRaOCqmVE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=G1pV8Ywn8P/kOE109DImsOOVMPEvaggcIcSNIS7vUwBP8qO7cWb8PCLqohhpZBXxW
         kXVrNo3iZgBjyqj38LukupQxK2rmaUUzZbaeF9hJoec+S0Ud4fs35LhH1b1JRAf39y
         z2myDDVle3xAqOcZ5ikN2zHQNN5JJK++I4JxkahKHcNsv7OJNcaJQyn5dfP7Cc20j3
         8gAXCgPJRZEJESqzEyHFJMG2r/EDdhI4ovGMc2j7Sb2U/ppVBKUDlmAGM9kw9Eqo2f
         4i/I3TMCEZNlj6v2uUcKDvWKxm3LA9CkfgC5rhS3qsFj0BpFFb+4tMU7L/lQLGmpIN
         dLfeD+y+IBMRw==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 31 May 2023 12:37:08 -0700
Subject: [PATCH net 6/6] mptcp: fix active subflow finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-send-net-20230531-v1-6-47750c420571@kernel.org>
References: <20230531-send-net-20230531-v1-0-47750c420571@kernel.org>
In-Reply-To: <20230531-send-net-20230531-v1-0-47750c420571@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Active subflow are inserted into the connection list at creation time.
When the MPJ handshake completes successfully, a new subflow creation
netlink event is generated correctly, but the current code wrongly
avoid initializing a couple of subflow data.

The above will cause misbehavior on a few exceptional events: unneeded
mptcp-level retransmission on msk-level sequence wrap-around and infinite
mapping fallback even when a MPJ socket is present.

Address the issue factoring out the needed initialization in a new helper
and invoking the latter from __mptcp_finish_join() time for passive
subflow and from mptcp_finish_join() for active ones.

Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/protocol.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index af54a878ac27..67311e7d5b21 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -825,6 +825,13 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
+static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
+{
+	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
+}
+
 static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -839,6 +846,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 		mptcp_sock_graft(ssk, sk->sk_socket);
 
 	mptcp_sockopt_sync_locked(msk, ssk);
+	mptcp_subflow_joined(msk, ssk);
 	return true;
 }
 
@@ -3485,14 +3493,16 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	if (!list_empty(&subflow->node))
-		goto out;
+	/* active subflow, already present inside the conn_list */
+	if (!list_empty(&subflow->node)) {
+		mptcp_subflow_joined(msk, ssk);
+		return true;
+	}
 
 	if (!mptcp_pm_allow_new_subflow(msk))
 		goto err_prohibited;
 
-	/* active connections are already on conn_list.
-	 * If we can't acquire msk socket lock here, let the release callback
+	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
 	 */
 	mptcp_data_lock(parent);
@@ -3515,11 +3525,6 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
-
-out:
-	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
 }
 

-- 
2.40.1

