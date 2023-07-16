Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21539755562
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjGPUk0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGPUkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC569F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDE060EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4EAC433C7;
        Sun, 16 Jul 2023 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540020;
        bh=oN5GZesW5DeVHv0zzJsWgM/T1GNoayPofxM/GylSqFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+qahXGllxZUZBneLVSiX+n46MJ76LHZTcrN4iqrtnWNQ5qmALx/AkjGMdgATI1AE
         OmeG6pCie8f9ylY+mcA7UnYXIJd6UuBedTBKxR1t5vb2cHGvRlrZQ5Go0RQoRvawXz
         3HQk7VR5SnfrgfmxCVYwx16OkTMyt7vnSm4CUX7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 214/591] memory: brcmstb_dpfe: fix testing array offset after use
Date:   Sun, 16 Jul 2023 21:45:53 +0200
Message-ID: <20230716194929.406512907@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 76c82e9c8fceb..9339f80b21c50 100644
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



