Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635F78AB87
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjH1Kbv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjH1KbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC3CC0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD44361B3B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30BAC433C7;
        Mon, 28 Aug 2023 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218662;
        bh=j3Jq+SCBqLM9dzdgvwyf73LBEzPbSHMlIPJJXvQI4so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZnLT7ogN7NnFB/2WZMobq/qEMdapQVggn7HCAIIohRPPqCkXgteql0s7wa3orXx3
         DJfEhO2W2F5RCdvd5dmRtcFGd8D65vNGnoGDHne/0i/JpXEIIH755kcI0dquZG0WFH
         i4YyDDp756UGuY2YBFIVMN8ungKSt9uVycL4r3GA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/122] net: bgmac: Fix return value check for fixed_phy_register()
Date:   Mon, 28 Aug 2023 12:12:33 +0200
Message-ID: <20230828101157.676349235@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit 23a14488ea5882dea5851b65c9fce2127ee8fcad ]

The fixed_phy_register() function returns error pointers and never
returns NULL. Update the checks accordingly.

Fixes: c25b23b8a387 ("bgmac: register fixed PHY for ARM BCM470X / BCM5301X chipsets")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 10c7c232cc4ec..52ee3751187a2 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	int err;
 
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-	if (!phy_dev || IS_ERR(phy_dev)) {
+	if (IS_ERR(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
 		return -ENODEV;
 	}
-- 
2.40.1



