Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BFB761405
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjGYLP7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjGYLPf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4430ED
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B67F3615A3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB46BC433C7;
        Tue, 25 Jul 2023 11:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283696;
        bh=H9OmMpBErT2Gl4fLi1Rtj80DVab04AVwEVjebRsCOEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIg1hHJMTRdOUl7llGpoeye7xQYDMqFx5bf5lXw4hiJPUunhxI/c+CfYM+bNoEuto
         mic1TgMX1vm8tdp05asijn3nFg8Eb9XFQG7ABdGXLWeHuxpd2Gvg+l/uCQU5ti7yU7
         NC+ZM58mBAX2m52iz2dgzn4sMwvOiULEoXNDNoMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 061/509] wl3501_cs: use eth_hw_addr_set()
Date:   Tue, 25 Jul 2023 12:40:00 +0200
Message-ID: <20230725104556.487489200@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 18774612246d036c04ce9fee7f67192f96f48725 ]

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it got through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211018235021.1279697-15-kuba@kernel.org
Stable-dep-of: 391af06a02e7 ("wifi: wl3501_cs: Fix an error handling path in wl3501_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index cb71b73853f4e..7351a2c127adc 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1945,8 +1945,7 @@ static int wl3501_config(struct pcmcia_device *link)
 		goto failed;
 	}
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = ((char *)&this->mac_addr)[i];
+	eth_hw_addr_set(dev, this->mac_addr);
 
 	/* print probe information */
 	printk(KERN_INFO "%s: wl3501 @ 0x%3.3x, IRQ %d, "
-- 
2.39.2



