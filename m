Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC276AF51
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjHAJpE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjHAJou (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C9B4698
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E53614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C88C433C8;
        Tue,  1 Aug 2023 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882941;
        bh=P/civ6XNJrhtPRBxZ6s0TL04LScZyh6k5LLPhp3P6h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuugHrgE/LKZnm18vmc3Jr7COpcvTx0MnCUAEBSjF3XGu79eKmaLDV+XALXBSbTyD
         eJvcjS9dVbDNFBTehAMQEEg8c2jRKU1Zb/nfBNaL10MIE7D1wBVQIGevYRiTcPHazt
         /rvu3cp1G0N4soIETvMFG81oYO9VsB/CuF8SkVZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 057/239] soundwire: amd: Fix a check for errors in probe()
Date:   Tue,  1 Aug 2023 11:18:41 +0200
Message-ID: <20230801091927.587431667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 7891d0a5ce6f627132d3068ba925cf86f29008b1 ]

This code has two problems:
1) The devm_ioremap() function returns NULL, not error pointers.
2) It's checking the wrong variable.  ->mmio instead of ->acp_mmio.

Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
Suggested-by: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/9863b2bf-0de2-4bf8-8f09-fe24dc5c63ff@moroto.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/amd_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 9fb7f91ca1827..21c638e38c51f 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -910,9 +910,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
-	if (IS_ERR(amd_manager->mmio)) {
+	if (!amd_manager->acp_mmio) {
 		dev_err(dev, "mmio not found\n");
-		return PTR_ERR(amd_manager->mmio);
+		return -ENOMEM;
 	}
 	amd_manager->instance = pdata->instance;
 	amd_manager->mmio = amd_manager->acp_mmio +
-- 
2.39.2



