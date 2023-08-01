Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8603C76AE0A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjHAJfu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjHAJf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54B1B7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43CF6614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50006C433C8;
        Tue,  1 Aug 2023 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882396;
        bh=FKETtIGiRZMkTO/5Th+CynsEyIVqlGHnWV2RWNTMr4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlfnRBJVLe7Nafg9uB2dbYXB4h64+6RMA5ZAotNXDxMnlzKgF5E5zGBLuX59rI/Hn
         xVU54cKYqmHT5Z+ZvQLNJxBHoAs7v3GKCWNuK/VvYfs0RXwx5Q+jBgONqFZ398n9rp
         e8F1KojFwQGCwVB0u7eEVgf+/Gem6H5zMRkE0KV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/228] phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()
Date:   Tue,  1 Aug 2023 11:19:09 +0200
Message-ID: <20230801091926.137236751@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 13c088cf3657d70893d75cf116be937f1509cc0f ]

The size of array 'priv->ports[]' is INNO_PHY_PORT_NUM.

In the for loop, 'i' is used as the index for array 'priv->ports[]'
with a check (i > INNO_PHY_PORT_NUM) which indicates that
INNO_PHY_PORT_NUM is allowed value for 'i' in the same loop.

This > comparison needs to be changed to >=, otherwise it potentially leads
to an out of bounds write on the next iteration through the loop

Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Link: https://lore.kernel.org/r/20230721090558.3588613-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index b133ae06757ab..a922fb11a1092 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -158,7 +158,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			of_node_put(child);
 			break;
-- 
2.39.2



