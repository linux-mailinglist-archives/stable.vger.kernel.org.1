Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC17D31BD
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjJWLMf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjJWLMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38527D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E87C433C7;
        Mon, 23 Oct 2023 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059551;
        bh=TfQR8TfVFtgz6Rt+gDGxLks7BsjJ5XCx3NecZxRjems=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lk4D9q4SXBwT1AF9qiS1jB1C8I5kg/6p0D9uHerLejt+QFEacLMaJ3vKebnrgKNAG
         DUg1wA6i72w0pedBWbEKzK/F2hdlQPZ6oSaCmGLpMeRJ/xuQyalZMruhlF5zMkGSwa
         BdRSzWtrKAuOE3pA3HeMs+KtGijAy4eBBrXkqtCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 216/241] ASoC: pxa: fix a memory leak in probe()
Date:   Mon, 23 Oct 2023 12:56:42 +0200
Message-ID: <20231023104839.117537853@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit aa6464edbd51af4a2f8db43df866a7642b244b5f ]

Free the "priv" pointer before returning the error code.

Fixes: 90eb6b59d311 ("ASoC: pxa-ssp: add support for an external clock in devicetree")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/84ac2313-1420-471a-b2cb-3269a2e12a7c@moroto.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 430dd446321e5..452f0caf415b9 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -779,7 +779,7 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		if (IS_ERR(priv->extclk)) {
 			ret = PTR_ERR(priv->extclk);
 			if (ret == -EPROBE_DEFER)
-				return ret;
+				goto err_priv;
 
 			priv->extclk = NULL;
 		}
-- 
2.42.0



