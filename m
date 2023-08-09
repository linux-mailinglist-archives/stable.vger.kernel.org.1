Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11EF775763
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjHIKpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjHIKpZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1410F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA24B6283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC327C433C8;
        Wed,  9 Aug 2023 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577923;
        bh=ZuyOmiYij5xC3a6HX90W7ItMYe7QSxKV6ddJBoSIejQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaDHsKzYdSVGLvhknnwwGa9HwX7L9itMmbNnzdmLdOOpewKS4xy1RHxc+v8PgE2VD
         4yXN6EpV7SM1U58kzm6NaXx1zJnLJKrAGUpGurzgRYZyk28HRbWQjg6ISmTPdNJmU0
         snCiEflfWFt8WQCCGkkIF+DrntECAR3KEFeVSMIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 043/165] net: dsa: fix value check in bcm_sf2_sw_probe()
Date:   Wed,  9 Aug 2023 12:39:34 +0200
Message-ID: <20230809103644.233619203@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index cde253d27bd08..72374b066f64a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1436,7 +1436,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	priv->clk_mdiv = devm_clk_get_optional(&pdev->dev, "sw_switch_mdiv");
 	if (IS_ERR(priv->clk_mdiv)) {
@@ -1444,7 +1446,9 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
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



