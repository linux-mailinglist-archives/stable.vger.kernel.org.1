Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E28775DA2
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjHILjk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjHILjj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E051FF5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16907635F8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C67C433C8;
        Wed,  9 Aug 2023 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581176;
        bh=wy+5osNJQMe9QBfwVoB5QDYWjRw1Lc5XJM2gmh7IYJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yyzz68yiCR7yA8WSeYEpe7D1GrelaAc7WlYSCqsNTEcCZ2keutP25DhNfi3WZRfpL
         rRsxbqFDVM/Y57aZjO0PaJhlLwYXyCP/aYWq90/pyfqe423dhlDmf+AStuU3rviP94
         SbeOI1YTdD2CKt8vO06sqAmMkb+wliGXEHdfK/o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/201] net: dsa: fix value check in bcm_sf2_sw_probe()
Date:   Wed,  9 Aug 2023 12:42:15 +0200
Message-ID: <20230809103648.183395836@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit dadc5b86cc9459581f37fe755b431adc399ea393 ]

in bcm_sf2_sw_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20230726170506.16547-1-ruc_gongyuanjun@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c6563d212476a..f2f890e559f3a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1301,7 +1301,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	priv->clk_mdiv = devm_clk_get_optional(&pdev->dev, "sw_switch_mdiv");
 	if (IS_ERR(priv->clk_mdiv)) {
@@ -1309,7 +1311,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	clk_prepare_enable(priv->clk_mdiv);
+	ret = clk_prepare_enable(priv->clk_mdiv);
+	if (ret)
+		goto out_clk;
 
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
-- 
2.40.1



