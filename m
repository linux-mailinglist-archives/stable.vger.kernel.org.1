Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE357039D3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbjEORqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244635AbjEORp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316531434F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0E462E91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C923CC433D2;
        Mon, 15 May 2023 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172629;
        bh=jXVTlRAo5QAICqR3+s5jU5mN3lolD1B2OqvVMKqujVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlCzUY+CC0modeM4qRYAOe/XA3j09AwlNOe8VReufb0kqHuxqMPSbs9jAIp0dZygn
         ZrTdr5m8KLKrCARKOuMuEqtI8twHB2moFyVvOx6SuB9qX0TYTEuROyak97WJgzfIVe
         lRVRYh9Rwmz6WV2yIexeXO4E1Ihi6XTZS1JSpEMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liliang Ye <yll@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 215/381] ASoC: fsl_mqs: move of_node_put() to the correct location
Date:   Mon, 15 May 2023 18:27:46 +0200
Message-Id: <20230515161746.486372758@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 0d4efbed41dab..c33439650823b 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -204,10 +204,10 @@ static int fsl_mqs_probe(struct platform_device *pdev)
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
@@ -236,8 +236,7 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	if (IS_ERR(mqs_priv->mclk)) {
 		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 			PTR_ERR(mqs_priv->mclk));
-		ret = PTR_ERR(mqs_priv->mclk);
-		goto err_free_gpr_np;
+		return PTR_ERR(mqs_priv->mclk);
 	}
 
 	dev_set_drvdata(&pdev->dev, mqs_priv);
@@ -246,13 +245,9 @@ static int fsl_mqs_probe(struct platform_device *pdev)
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



