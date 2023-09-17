Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1C7A3981
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjIQTuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjIQTuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C770BC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:49:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3E1C433C8;
        Sun, 17 Sep 2023 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980198;
        bh=Zc1E5USIoYv3YIV5vITGlbGWv+ShvLavgiurbjplLSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZMT2kmqnW1Zp0MFeQwyeKOAtKu6kywDVadQ86NYw0NQibYP8/AKvmqkKhPc0dSUP
         y/+EvM/9+dJ9tFvwKTr8z/uHMhW4TooN2w5JAZD86ddG7zpsMvdfm9AbuLTSncgKMZ
         +f3gFxn91D0202Zi2HDc+sYtyVTHB9Hbo5o9cSS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 121/285] mptcp: annotate data-races around msk->rmem_fwd_alloc
Date:   Sun, 17 Sep 2023 21:12:01 +0200
Message-ID: <20230917191055.855885466@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 996e031dff78a..40258d9f8c799 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -136,9 +136,15 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
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
@@ -179,7 +185,7 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
 {
 	amount >>= PAGE_SHIFT;
-	mptcp_sk(sk)->rmem_fwd_alloc -= amount << PAGE_SHIFT;
+	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
 	__sk_mem_reduce_allocated(sk, amount);
 }
 
@@ -188,7 +194,7 @@ static void mptcp_rmem_uncharge(struct sock *sk, int size)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int reclaimable;
 
-	msk->rmem_fwd_alloc += size;
+	mptcp_rmem_fwd_alloc_add(sk, size);
 	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
 
 	/* see sk_mem_uncharge() for the rationale behind the following schema */
@@ -343,7 +349,7 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
 		return false;
 
-	msk->rmem_fwd_alloc += amount;
+	mptcp_rmem_fwd_alloc_add(sk, amount);
 	return true;
 }
 
@@ -3243,7 +3249,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	 * inet_sock_destruct() will dispose it
 	 */
 	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	msk->rmem_fwd_alloc = 0;
+	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3513,7 +3519,8 @@ static void mptcp_shutdown(struct sock *sk, int how)
 
 static int mptcp_forward_alloc_get(const struct sock *sk)
 {
-	return READ_ONCE(sk->sk_forward_alloc) + mptcp_sk(sk)->rmem_fwd_alloc;
+	return READ_ONCE(sk->sk_forward_alloc) +
+	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
 }
 
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
-- 
2.40.1



