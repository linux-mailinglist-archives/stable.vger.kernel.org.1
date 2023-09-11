Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727179B03B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjIKWZz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbjIKOgh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B0DCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B926C433C7;
        Mon, 11 Sep 2023 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442991;
        bh=gJje5OPpFQ72i78WmS4cy7a4ywNTQw4HEzqjIQwQw8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3+0JgLIUciyOeyn8RwkMnmrkralL4MGJYw4ESVnNwKInKRglEceGbCYHaI4datCq
         sDd9MvQSkfQ898HVF8oFmb2HCaklp8Jcx4MVk5Tbn2uwtF0PU0qwJ3Nn6J5NHEk/Nv
         V5eyn/uJmkxiXcS9NW3moeArE+CEH/zJDfwPj+Bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Yan Zhai <yan@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 220/737] lwt: Check LWTUNNEL_XMIT_CONTINUE strictly
Date:   Mon, 11 Sep 2023 15:41:19 +0200
Message-ID: <20230911134656.732255241@linuxfoundation.org>
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

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit a171fbec88a2c730b108c7147ac5e7b2f5a02b47 ]

LWTUNNEL_XMIT_CONTINUE is implicitly assumed in ip(6)_finish_output2,
such that any positive return value from a xmit hook could cause
unexpected continue behavior, despite that related skb may have been
freed. This could be error-prone for future xmit hook ops. One of the
possible errors is to return statuses of dst_output directly.

To make the code safer, redefine LWTUNNEL_XMIT_CONTINUE value to
distinguish from dst_output statuses and check the continue
condition explicitly.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/96b939b85eda00e8df4f7c080f770970a4c5f698.1692326837.git.yan@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/lwtunnel.h | 5 ++++-
 net/ipv4/ip_output.c   | 2 +-
 net/ipv6/ip6_output.c  | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 6f15e6fa154e6..53bd2d02a4f0d 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -16,9 +16,12 @@
 #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
 #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
 
+/* LWTUNNEL_XMIT_CONTINUE should be distinguishable from dst_output return
+ * values (NET_XMIT_xxx and NETDEV_TX_xxx in linux/netdevice.h) for safety.
+ */
 enum {
 	LWTUNNEL_XMIT_DONE,
-	LWTUNNEL_XMIT_CONTINUE,
+	LWTUNNEL_XMIT_CONTINUE = 0x100,
 };
 
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6f6f63cf9224f..625da48741a4f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -216,7 +216,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4a27fab1d09a3..50f8d2ac4e246 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -113,7 +113,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
-- 
2.40.1



