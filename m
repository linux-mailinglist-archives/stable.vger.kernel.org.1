Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C17354CF
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjFSK7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjFSK6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936221BE7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 310F360B78
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46905C433C0;
        Mon, 19 Jun 2023 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172241;
        bh=Y6MBSY97SJc6gArE0pDXarPoM4AXlqY9EeogjInlCE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYpCiYk66mBTFUtFgHfLJ/TIqDF0pVH1/PvuP21CjLXYqCEkUxojByd2FkQcpH6/C
         1kiyYPAlCjeQ290yK2mPIwT9VkAhQSlX85ITIWNyjB2zEBbqXmRTcdwoxzq8Y82LY+
         HmG3TaxO/8mmJCyRBZyyYOZBgvoBzHr8p7efdpTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 62/89] ipvlan: fix bound dev checking for IPv6 l3s mode
Date:   Mon, 19 Jun 2023 12:30:50 +0200
Message-ID: <20230619102141.084348275@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit ce57adc222aba32431c42632b396e9213d0eb0b8 ]

The commit 59a0b022aa24 ("ipvlan: Make skb->skb_iif track skb->dev for l3s
mode") fixed ipvlan bonded dev checking by updating skb skb_iif. This fix
works for IPv4, as in raw_v4_input() the dif is from inet_iif(skb), which
is skb->skb_iif when there is no route.

But for IPv6, the fix is not enough, because in ipv6_raw_deliver() ->
raw_v6_match(), the dif is inet6_iif(skb), which is returns IP6CB(skb)->iif
instead of skb->skb_iif if it's not a l3_slave. To fix the IPv6 part
issue. Let's set IP6CB(skb)->iif to correct ifindex.

BTW, ipvlan handles NS/NA specifically. Since it works fine, I will not
reset IP6CB(skb)->iif when addr->atype is IPVL_ICMPV6.

Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2196710
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipvlan/ipvlan_l3s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index 71712ea25403d..d5b05e8032199 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -102,6 +102,10 @@ static unsigned int ipvlan_nf_input(void *priv, struct sk_buff *skb,
 
 	skb->dev = addr->master->dev;
 	skb->skb_iif = skb->dev->ifindex;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (addr->atype == IPVL_IPV6)
+		IP6CB(skb)->iif = skb->dev->ifindex;
+#endif
 	len = skb->len + ETH_HLEN;
 	ipvlan_count_rx(addr->master, len, true, false);
 out:
-- 
2.39.2



