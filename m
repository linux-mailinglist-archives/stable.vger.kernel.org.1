Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A717A3ACE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjIQUJG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbjIQUIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99685F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCA0C433C7;
        Sun, 17 Sep 2023 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981313;
        bh=K8KrHRdsxFwL4pfgrjiSryfFCQfpWURuXwAiL6cb2aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ti5kUqVU27KRpqfTj1DQ6ujza7GOjVUFd10IFEH7bLIm2IXXQQBvVHEnnYHcjNZq3
         Q95+6cDnaUZbl4hVkzkBl+e+VmHXwanzYCrQ1Dvr9c3B1yLD1Wskv+cHeoyoz1i5HV
         Imt2kFI5Aw2J5Lz8dIaAWj4OLoX11TlKhgbo9sps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Bailey Forrest <bcf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Catherine Sullivan <csully@google.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 103/219] gve: fix frag_list chaining
Date:   Sun, 17 Sep 2023 21:13:50 +0200
Message-ID: <20230917191044.718469345@linuxfoundation.org>
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

[ Upstream commit 817c7cd2043a83a3d8147f40eea1505ac7300b62 ]

gve_rx_append_frags() is able to build skbs chained with frag_list,
like GRO engine.

Problem is that shinfo->frag_list should only be used
for the head of the chain.

All other links should use skb->next pointer.

Otherwise, built skbs are not valid and can cause crashes.

Equivalent code in GRO (skb_gro_receive()) is:

    if (NAPI_GRO_CB(p)->last == p)
        skb_shinfo(p)->frag_list = skb;
    else
        NAPI_GRO_CB(p)->last->next = skb;
    NAPI_GRO_CB(p)->last = skb;

Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Bailey Forrest <bcf@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Catherine Sullivan <csully@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 2e6461b0ea8bc..a9409e3721ad7 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -492,7 +492,10 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 		if (!skb)
 			return -1;
 
-		skb_shinfo(rx->ctx.skb_tail)->frag_list = skb;
+		if (rx->ctx.skb_tail == rx->ctx.skb_head)
+			skb_shinfo(rx->ctx.skb_head)->frag_list = skb;
+		else
+			rx->ctx.skb_tail->next = skb;
 		rx->ctx.skb_tail = skb;
 		num_frags = 0;
 	}
-- 
2.40.1



