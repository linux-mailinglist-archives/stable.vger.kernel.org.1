Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021887551FA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGPUCW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGPUCV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637F9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E66060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCCBC433C7;
        Sun, 16 Jul 2023 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537739;
        bh=XBRhrk8JeRrPF1eugWkcGJUA2TmGlz/r/0Uwkwttq2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exNzFzJIQdhIBltHCvFOf5gkFir6wZGAqA/d/nvVcPf3YWI5XJhW/Tkqw15iOQXe2
         ZrrOKQ1DIIWA5JaFGOp76atDq0iOPu43G2WDtTThv456yFw5mcrLzXg/tgxkzTpAVU
         gjZT/1ZE7iKG6kfL6z1fDclAvExOJC0GvbjfYs94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Jiri Pirko <jiri@nvidia.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 203/800] net: stmmac: fix double serdes powerdown
Date:   Sun, 16 Jul 2023 21:40:56 +0200
Message-ID: <20230716194953.814140119@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit c4fc88ad2a765224a648db8ab35f125e120fe41b ]

Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
stmmac_open/release") correctly added a call to the serdes_powerdown()
callback to stmmac_release() but did not remove the one from
stmmac_remove() which leads to a doubled call to serdes_powerdown().

This can lead to all kinds of problems: in the case of the qcom ethqos
driver, it caused an unbalanced regulator disable splat.

Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Junxiao Chang <junxiao.chang@intel.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20230621135537.376649-1-brgl@bgdev.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 87510951f4e80..b74946bbee3c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7457,12 +7457,6 @@ void stmmac_dvr_remove(struct device *dev)
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
-	/* Serdes power down needs to happen after VLAN filter
-	 * is deleted that is triggered by unregister_netdev().
-	 */
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
-
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
 #endif
-- 
2.39.2



