Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3C7ECFD5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjKOTvK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjKOTvH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B319E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDFAC433CA;
        Wed, 15 Nov 2023 19:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077864;
        bh=ndRUcdJ0f/b/jVg2NapBCsxY6JcyOJs0/TNvgzdvRKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iogHombBVH+E+YXWsFsCHQ50n9ZApEpdCVC1bq2JwSiUMZmn/IkY4liVRBVcSP6Z
         WsG6+c1K1la+EOB9rCl9EBZGyVh4QbVWxSCN8i6gW4U2Ie0a114MF09PB9J4O8ZRnx
         h7cV+YsPhlEtHBULl67M9G8PBvO2TcF241TNgt+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 542/603] hsr: Prevent use after free in prp_create_tagged_frame()
Date:   Wed, 15 Nov 2023 14:18:07 -0500
Message-ID: <20231115191649.310208464@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 876f8ab52363f649bcc74072157dfd7adfbabc0d ]

The prp_fill_rct() function can fail.  In that situation, it frees the
skb and returns NULL.  Meanwhile on the success path, it returns the
original skb.  So it's straight forward to fix bug by using the returned
value.

Fixes: 451d8123f897 ("net: prp: add packet handling support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b71dab630a873..80cdc6f6b34c9 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -342,9 +342,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 	skb = skb_copy_expand(frame->skb_std, 0,
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
-	prp_fill_rct(skb, frame, port);
-
-	return skb;
+	return prp_fill_rct(skb, frame, port);
 }
 
 static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
-- 
2.42.0



