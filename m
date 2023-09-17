Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F17A3AC1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbjIQUId (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbjIQUIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA660F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AD9C433CB;
        Sun, 17 Sep 2023 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981281;
        bh=filhF9FNRxf3M116g2dY73Mft83ZY/NnPIuoLwouxXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsqQ348z7sPHLdVPKLz/PaEmxg3xDOpImVn8ffS5X9fsq2loI6lpw+vtR68Cp8W2R
         qOyE7n8nnLglgWprZdQsTeNL+kJisN/mc84OBCPw6uLUJpk/1KssISrTBO/f9D910z
         K8xujgIRMeaj4icwuMq+RYrqK/ihnjok3JXaWCzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 099/219] mptcp: annotate data-races around msk->rmem_fwd_alloc
Date:   Sun, 17 Sep 2023 21:13:46 +0200
Message-ID: <20230917191044.552392703@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9531e4a83febc3fb47ac77e24cfb5ea97e50034d ]

msk->rmem_fwd_alloc can be read locklessly.

Add mptcp_rmem_fwd_alloc_add(), similar to sk_forward_alloc_add(),
and appropriate READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 573db9c2bc1cd..6dd880d6b0518 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -131,9 +131,15 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
+static void mptcp_rmem_fwd_alloc_add(struct sock *sk, int size)
+{
+	WRITE_ONCE(mptcp_sk(sk)->rmem_fwd_alloc,
+		   mptcp_sk(sk)->rmem_fwd_alloc + size);
+}
+
 static void mptcp_rmem_charge(struct sock *sk, int size)
 {
-	mptcp_sk(sk)->rmem_fwd_alloc -= size;
+	mptcp_rmem_fwd_alloc_add(sk, -size);
 }
 
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
@@ -174,7 +180,7 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
 {
 	amount >>= PAGE_SHIFT;
-	mptcp_sk(sk)->rmem_fwd_alloc -= amount << PAGE_SHIFT;
+	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
 	__sk_mem_reduce_allocated(sk, amount);
 }
 
@@ -183,7 +189,7 @@ static void mptcp_rmem_uncharge(struct sock *sk, int size)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int reclaimable;
 
-	msk->rmem_fwd_alloc += size;
+	mptcp_rmem_fwd_alloc_add(sk, size);
 	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
 
 	/* see sk_mem_uncharge() for the rationale behind the following schema */
@@ -338,7 +344,7 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
 		return false;
 
-	msk->rmem_fwd_alloc += amount;
+	mptcp_rmem_fwd_alloc_add(sk, amount);
 	return true;
 }
 
@@ -3279,7 +3285,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	 * inet_sock_destruct() will dispose it
 	 */
 	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	msk->rmem_fwd_alloc = 0;
+	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3562,7 +3568,8 @@ static void mptcp_shutdown(struct sock *sk, int how)
 
 static int mptcp_forward_alloc_get(const struct sock *sk)
 {
-	return READ_ONCE(sk->sk_forward_alloc) + mptcp_sk(sk)->rmem_fwd_alloc;
+	return READ_ONCE(sk->sk_forward_alloc) +
+	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
 }
 
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
-- 
2.40.1



