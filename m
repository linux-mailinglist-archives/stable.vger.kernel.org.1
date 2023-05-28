Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E056713D3B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjE1TXN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjE1TXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882EC9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B57B61B89
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E16C433EF;
        Sun, 28 May 2023 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301789;
        bh=vPUzbQAxH/P9rpavETm+S3nJcP9oJadBYPq1HoBE+lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeqD+jxbFZfyXNKrnmpJlt57zN/Hld/NJedVW4rG77gsMXOnVrnz45IYjBUTZElT6
         5oYXJ3p6NL45p5Hyp2LYNbvfjhKQZPEtJN2R2pBxluFx16cR51P+3QobRJq+c5zTZx
         k/nHbxZ3VwtglFZ4n8ItisiwiB2h5ZEyASHIc91M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Menglong Dong <dong.menglong@zte.com.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/161] net: tap: check vlan with eth_type_vlan() method
Date:   Sun, 28 May 2023 20:08:53 +0100
Message-Id: <20230528190837.388919170@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

[ Upstream commit b69df2608281b71575fbb3b9f426dbcc4be8a700 ]

Replace some checks for ETH_P_8021Q and ETH_P_8021AD in
drivers/net/tap.c with eth_type_vlan.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
Link: https://lore.kernel.org/r/20210115023238.4681-1-dong.menglong@zte.com.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 4063384ef762 ("net: add vlan_get_protocol_and_depth() helper")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index a522d1673fa87..ffdf0e165930c 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -715,8 +715,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	skb_probe_transport_header(skb);
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if ((skb->protocol == htons(ETH_P_8021Q) ||
-	     skb->protocol == htons(ETH_P_8021AD)) &&
+	if (eth_type_vlan(skb->protocol) &&
 	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
@@ -1177,8 +1176,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	}
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if ((skb->protocol == htons(ETH_P_8021Q) ||
-	     skb->protocol == htons(ETH_P_8021AD)) &&
+	if (eth_type_vlan(skb->protocol) &&
 	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-- 
2.39.2



