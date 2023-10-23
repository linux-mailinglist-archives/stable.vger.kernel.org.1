Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4277D3254
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjJWLTA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJWLS7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:18:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D013DD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E036C433CB;
        Mon, 23 Oct 2023 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059937;
        bh=3xGQejU8P9g4hb+itDihJzUWynKfrWNKIVCdYd7W+zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbIJzHHvxHejoXxnk29vHnbj+6/NTvg883Bkfqh4wioNXeVAABYZb8FfJ9xVe80hw
         J5s7NEFkaJV2D6MGeEtJqDXIpv3nkn/MSNVA64AQb0rmHq83D3wdcyMa9X0JITvGtv
         Yy3ItX5YPJqMw9SQgCauv7jj6fO80lTCAuzrPB8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 94/98] ASoC: pxa: fix a memory leak in probe()
Date:   Mon, 23 Oct 2023 12:57:23 +0200
Message-ID: <20231023104816.840699945@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 69033e1a84e6a..49481dadb9230 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -795,7 +795,7 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		if (IS_ERR(priv->extclk)) {
 			ret = PTR_ERR(priv->extclk);
 			if (ret == -EPROBE_DEFER)
-				return ret;
+				goto err_priv;
 
 			priv->extclk = NULL;
 		}
-- 
2.42.0



