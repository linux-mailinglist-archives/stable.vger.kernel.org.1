Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57C96FA8B9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjEHKo4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjEHKoU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951C2C3C2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D03761578
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A93C433EF;
        Mon,  8 May 2023 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542584;
        bh=v9afTyW3/It3xsLFqOYgFOVO16EMHGvQZU9rOkueRQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olzhJfAeskBOXHIGYL7sU3JNoLwpaSOcixFZesoT/Z3F5OZ5SaLcha8AktxU9rwam
         8SHmvypiRgp9736W9mVtE9NHWzxSKo7NdhhAobI1q8vyTf/jYVRwSSSUHSojB2reF3
         NvG0uZmTiKoXIOJIDlxvwlmnPED0SolIGZCShMes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liliang Ye <yll@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 481/663] ASoC: fsl_mqs: move of_node_put() to the correct location
Date:   Mon,  8 May 2023 11:45:07 +0200
Message-Id: <20230508094443.943157671@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liliang Ye <yll@hust.edu.cn>

[ Upstream commit 1c34890273a020d61d6127ade3f68ed1cb21c16a ]

of_node_put() should have been done directly after
mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
otherwise it creates a reference leak on the success path.

To fix this, of_node_put() is moved to the correct location, and change
all the gotos to direct returns.

Fixes: a9d273671440 ("ASoC: fsl_mqs: Fix error handling in probe")
Signed-off-by: Liliang Ye <yll@hust.edu.cn>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/20230403152647.17638-1-yll@hust.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_mqs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 4922e6795b73f..32d20d351bbf7 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -210,10 +210,10 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 		}
 
 		mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
+		of_node_put(gpr_np);
 		if (IS_ERR(mqs_priv->regmap)) {
 			dev_err(&pdev->dev, "failed to get gpr regmap\n");
-			ret = PTR_ERR(mqs_priv->regmap);
-			goto err_free_gpr_np;
+			return PTR_ERR(mqs_priv->regmap);
 		}
 	} else {
 		regs = devm_platform_ioremap_resource(pdev, 0);
@@ -242,8 +242,7 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	if (IS_ERR(mqs_priv->mclk)) {
 		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 			PTR_ERR(mqs_priv->mclk));
-		ret = PTR_ERR(mqs_priv->mclk);
-		goto err_free_gpr_np;
+		return PTR_ERR(mqs_priv->mclk);
 	}
 
 	dev_set_drvdata(&pdev->dev, mqs_priv);
@@ -252,13 +251,9 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
 			&fsl_mqs_dai, 1);
 	if (ret)
-		goto err_free_gpr_np;
-	return 0;
-
-err_free_gpr_np:
-	of_node_put(gpr_np);
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int fsl_mqs_remove(struct platform_device *pdev)
-- 
2.39.2



