Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432AC75D38B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGUTL5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGUTL4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FDB30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCC561D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81483C433C8;
        Fri, 21 Jul 2023 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966713;
        bh=feEk9RUajfOmMyi0Ajb8vn6sDl4jI+wspeGlIy80e+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4dz/Cfz/E7/A2upREMOsgAE7GkyorzlSu3gfFHdO0gUGz7uiAw+Gkwfq/6JiManl
         hX7fa4dQ3YsAsa91HXIjWVJq2wSQB7EaAET2azwafbENkqaSRL9eKzaOSjPba4el1G
         xiPu0xjxJTFyxxPrgG6Lb/l2zSTTdx5kfe7pI0WI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Amit Klein <aksecurity@gmail.com>,
        Eric Dumazet <edumazet@google.com>, Willy Tarreau <w@1wt.eu>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 413/532] udp6: fix udp6_ehashfn() typo
Date:   Fri, 21 Jul 2023 18:05:17 +0200
Message-ID: <20230721160636.859990659@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 51d03e2f2203e76ed02d33fb5ffbb5fc85ffaf54 ]

Amit Klein reported that udp6_ehash_secret was initialized but never used.

Fixes: 1bbdceef1e53 ("inet: convert inet_ehash_secret and ipv6_hash_secret to net_get_random_once")
Reported-by: Amit Klein <aksecurity@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/udp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5161e98f6fcfd..a746abbe81b5f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -88,7 +88,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
-- 
2.39.2



