Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3A79BD8B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357830AbjIKWG1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbjIKPBS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71BE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F362C433C7;
        Mon, 11 Sep 2023 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444473;
        bh=ZOY9MBmSePNLvhOIfxw19I36B/wamDxKmCcgI6gJYZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDR7hXHISMnhzhS3b6lE0T/YQ7Jpm0s7n361jhOQqQJQ2f40/ZrZ/2m0/r816QaIH
         wX3oXg+D10iujFgS9lmOaKr8tfWdENJoYUB8u2+rdYxm10pxz1QNVL81pJZWIn66+8
         Bca5lg3t19WCNilyCoi9CqXSHfk7n5sz/+M3PBgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Lau <martin.lau@linux.dev>,
        Lorenz Bauer <lmb@isovalent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH 6.4 735/737] net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
Date:   Mon, 11 Sep 2023 15:49:54 +0200
Message-ID: <20230911134711.052555358@linuxfoundation.org>
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

commit 74bdfab4fd7c641e55f7fe9d1be9687eeb01df67 upstream.

There are already INDIRECT_CALLABLE_DECLARE in the hashtable
headers, no need to declare them again.

Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
Suggested-by: Martin Lau <martin.lau@linux.dev>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_hashtables.c  |    2 --
 net/ipv6/inet6_hashtables.c |    2 --
 2 files changed, 4 deletions(-)

--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -333,8 +333,6 @@ static inline int compute_score(struct s
 	return score;
 }
 
-INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
-
 struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
 				   struct sk_buff *skb, int doff,
 				   __be32 saddr, __be16 sport,
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -112,8 +112,6 @@ static inline int compute_score(struct s
 	return score;
 }
 
-INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
-
 struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
 				    struct sk_buff *skb, int doff,
 				    const struct in6_addr *saddr,


