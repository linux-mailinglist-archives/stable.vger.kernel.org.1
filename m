Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE4675D248
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGUS6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGUS6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADA3588
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A25461D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AEFC433C9;
        Fri, 21 Jul 2023 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965872;
        bh=ycfWqGIDkqmQERhZGc4d7/AYQlc58oue8ZpL19/+eTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWOIMc3e6XOAJcJJAb8jl2ADIeyEJuWNtjSNWTeWvU5S7IPsFNVkHI9BAhZ63kVu2
         O6CtTjdbaBj6VVgTDzzTWveXUwNCrgs8eAJKfXwX7BKcndfX9mtFM+IZmZs0BlXrln
         /3ZqPpD1UB5UwnKGNeZk73NoAkx/9cvTXnWwIqSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 145/532] memory: brcmstb_dpfe: fix testing array offset after use
Date:   Fri, 21 Jul 2023 18:00:49 +0200
Message-ID: <20230721160622.311481506@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 1d9e93fad549bc38f593147479ee063f2872c170 ]

Code should first check for valid value of array offset, then use it as
the index.  Fixes smatch warning:

  drivers/memory/brcmstb_dpfe.c:443 __send_command() error: testing array offset 'cmd' after use.

Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Acked-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20230513112931.176066-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/brcmstb_dpfe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f43ba69fbb3e3..2daae2e0cb19e 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -434,15 +434,17 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 			  u32 result[])
 {
-	const u32 *msg = priv->dpfe_api->command[cmd];
 	void __iomem *regs = priv->regs;
 	unsigned int i, chksum, chksum_idx;
+	const u32 *msg;
 	int ret = 0;
 	u32 resp;
 
 	if (cmd >= DPFE_CMD_MAX)
 		return -1;
 
+	msg = priv->dpfe_api->command[cmd];
+
 	mutex_lock(&priv->lock);
 
 	/* Wait for DCPU to become ready */
-- 
2.39.2



