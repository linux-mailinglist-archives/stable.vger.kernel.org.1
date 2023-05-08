Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3316C6FAC8F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjEHLZ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjEHLZm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC263B799
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16D8962D76
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A83C433D2;
        Mon,  8 May 2023 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545125;
        bh=zG9MeqbJTsQ9obRu8LgDv1uZHuNc2xNmsYSRLxWUzS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=voEA8pvM8xGyikTdxgRyfSf4siagIkgHCOlaSE8fsvoMg4E7NT3cbauhONbRbG3pj
         vLnHLbTvi0iVBXDHkjJ4tfY0/6g0HoNlu4xtkcwZMreF7B0Jc3Ti4CmTl2SrSgz32U
         b0mXqOUwFem1iQG/T4RA09L1WQKRLu8Txnre2+pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 632/694] rtc: jz4740: Make sure clock provider gets removed
Date:   Mon,  8 May 2023 11:47:47 +0200
Message-Id: <20230508094456.158098408@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit c7a639dac8e4d7e63450bef2f3a19fb331566fb1 ]

The jz4740 RTC driver registers a clock provider, but never removes it.
This leaves a stale clock provider behind that references freed clocks when
the device is unbound.

Use the managed `devm_of_clk_add_hw_provider()` instead of
`of_clk_add_hw_provider()` to make sure the provider gets automatically
removed on unbind.

Fixes: 5ddfa148de8c ("rtc: jz4740: Register clock provider for the CLK32K pin")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/r/20230409162544.16155-1-lars@metafoo.de
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-jz4740.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 59d279e3e6f5b..36453b008139b 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -414,7 +414,8 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, ret,
 					     "Unable to register clk32k clock\n");
 
-		ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &rtc->clk32k);
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						  &rtc->clk32k);
 		if (ret)
 			return dev_err_probe(dev, ret,
 					     "Unable to register clk32k clock provider\n");
-- 
2.39.2



