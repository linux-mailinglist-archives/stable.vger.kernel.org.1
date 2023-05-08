Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0D6FA559
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEHKIb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjEHKIa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A76C32926
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01D5962383
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B46C433EF;
        Mon,  8 May 2023 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540508;
        bh=ohtPrPbBx1teYiN+2X59fO06LCtZZNKB4bWuzUze5No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX6xLtOuKWSdcBfjz+HVymCSTMbDsPgbrgwj/xJvxw9tVZWH/nHWV4eyWbTi/i+do
         06xERNiXxOY1SnrMrTIKAwGWfkOVMbpRRrmhWWDKh/9ZEam0QhUrZuDH90e7HCJShK
         m8M8/Vl3zD5q5PTL/VQnF9pdglTMKjn7kW5DhJGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Willem de Bruijn <willemb@google.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 392/611] ipv4: Fix potential uninit variable access bug in __ip_make_skb()
Date:   Mon,  8 May 2023 11:43:54 +0200
Message-Id: <20230508094435.024476270@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit 99e5acae193e369b71217efe6f1dad42f3f18815 ]

Like commit ea30388baebc ("ipv6: Fix an uninit variable access bug in
__ip6_make_skb()"). icmphdr does not in skb linear region under the
scenario of SOCK_RAW socket. Access icmp_hdr(skb)->type directly will
trigger the uninit variable access bug.

Use a local variable icmp_type to carry the correct value in different
scenarios.

Fixes: 96793b482540 ("[IPV4]: Add ICMPMsgStats MIB (RFC 4293)")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 922c87ef1ab58..2a07588265c70 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1570,9 +1570,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	cork->dst = NULL;
 	skb_dst_set(skb, &rt->dst);
 
-	if (iph->protocol == IPPROTO_ICMP)
-		icmp_out_count(net, ((struct icmphdr *)
-			skb_transport_header(skb))->type);
+	if (iph->protocol == IPPROTO_ICMP) {
+		u8 icmp_type;
+
+		/* For such sockets, transhdrlen is zero when do ip_append_data(),
+		 * so icmphdr does not in skb linear region and can not get icmp_type
+		 * by icmp_hdr(skb)->type.
+		 */
+		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+			icmp_type = fl4->fl4_icmp_type;
+		else
+			icmp_type = icmp_hdr(skb)->type;
+		icmp_out_count(net, icmp_type);
+	}
 
 	ip_cork_release(cork);
 out:
-- 
2.39.2



