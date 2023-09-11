Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFE79B293
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbjIKU6K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbjIKOhg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A8F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9307C433C8;
        Mon, 11 Sep 2023 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443051;
        bh=Uac+h3IUadKszFfDBRXAhQZlQUwVGbyfI6sC6kbe7cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKTUXCrKzv7qJBanrtfkd+qUGZfL+o9nl/FRmASI0xfjYD+JAYkfddd0yFWJIikAL
         6t3a9EG9t/50PlBZYhvRkI56e12TI5m0BFiNacQZ4KPWTXZLHs2V+QicoKfz9nv+Ul
         BlIB3CsFqE89MGruL6zYCyNAqhDFIKFoF5y7QSjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenz Bauer <lmb@isovalent.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 211/737] net: Fix slab-out-of-bounds in inet[6]_steal_sock
Date:   Mon, 11 Sep 2023 15:41:10 +0200
Message-ID: <20230911134656.487284915@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenz Bauer <lmb@isovalent.com>

[ Upstream commit 8897562f67b3e61ad736cd5c9f307447d33280e4 ]

Kumar reported a KASAN splat in tcp_v6_rcv:

  bash-5.2# ./test_progs -t btf_skc_cls_ingress
  ...
  [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
  [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226

The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
accounting for request or timewait sockets. To fix this we can't just
check sock_common->skc_reuseport since that flag is present on timewait
sockets.

Instead, add a fullsock check to avoid the out of bands access of sk_protocol.

Fixes: 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Link: https://lore.kernel.org/r/20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet6_hashtables.h | 2 +-
 include/net/inet_hashtables.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 475e672b4facc..12780b8fb5630 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -107,7 +107,7 @@ struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched)
+	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP) {
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index a1b8eb147ce73..9414cb4e6e624 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -455,7 +455,7 @@ struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int doff,
 	if (!sk)
 		return NULL;
 
-	if (!prefetched)
+	if (!prefetched || !sk_fullsock(sk))
 		return sk;
 
 	if (sk->sk_protocol == IPPROTO_TCP) {
-- 
2.40.1



