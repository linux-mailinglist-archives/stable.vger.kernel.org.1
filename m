Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB827ED461
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344641AbjKOU5z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbjKOU5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A85D79
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216FC43215;
        Wed, 15 Nov 2023 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081261;
        bh=mvGiVC4+p13OZ/4e1dHqzsFZ5fbQeP8dnz1dRI4o6gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqqD68KdxY6+Hu6P4pfBNPgEGggo5Axd8tOHtZZohXCmDjVW4i+xUrvGpYQoZSLll
         GQSz5dGMNhc0WSZt/x2MQUU7vF9VSqiHtabwz9rFZF9kJmriktiZUH3hggGVpvgdu4
         WDg6o3g7I9HERaL0ev5CU4cVULRhrUyIMvWsQQkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Geoff Levand <geoff@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 022/244] net: spider_net: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 15:33:34 -0500
Message-ID: <20231115203549.696352973@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 0201409079b975e46cc40e8bdff4bd61329ee10f ]

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/toshiba/spider_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 66d4e024d11e9..f62fbb1087a9e 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2332,7 +2332,7 @@ spider_net_alloc_card(void)
 	struct spider_net_card *card;
 
 	netdev = alloc_etherdev(struct_size(card, darray,
-					    tx_descriptors + rx_descriptors));
+					    size_add(tx_descriptors, rx_descriptors)));
 	if (!netdev)
 		return NULL;
 
-- 
2.42.0



