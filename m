Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE58B7BDF53
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377039AbjJIN2u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbjJIN2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:28:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F45C6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:28:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BBEC433CB;
        Mon,  9 Oct 2023 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858122;
        bh=wmEY0wH7Na7AHPGM5Lq31apKdbDq9YrFo1+RBc2IVKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPcZnemvIU7PaY+Td3prZuEsaiPoI+7Vvbmdhiw1eiieNtfpaX6a8CooIbEp+gjjd
         pBEVbH2IMzXGEhCYmOGd+jZWAuSZLRwKqeUhLia7D5oZrH5NVxQb7V3MjofwSvvic4
         Pws/gncfEq4eb55iBrUNK1ZWC40dcWsbfgfqvc+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Ahern <dsahern@kernel.org>,
        Kyle Zeng <zengyhkyle@gmail.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 023/131] ipv4: fix null-deref in ipv4_link_failure
Date:   Mon,  9 Oct 2023 15:01:03 +0200
Message-ID: <20231009130117.018605773@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Zeng <zengyhkyle@gmail.com>

[ Upstream commit 0113d9c9d1ccc07f5a3710dac4aa24b6d711278c ]

Currently, we assume the skb is associated with a device before calling
__ip_options_compile, which is not always the case if it is re-routed by
ipvs.
When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
This patch adds a check for the edge case and switch to use the net_device
from the rtable when skb->dev is NULL.

Fixes: ed0de45a1008 ("ipv4: recompile ip options in ipv4_link_failure")
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Cc: Vadim Fedorenko <vfedorenko@novek.ru>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7004e379c325f..f82d456afd0ed 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1221,6 +1221,7 @@ static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie)
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1238,7 +1239,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
-- 
2.40.1



