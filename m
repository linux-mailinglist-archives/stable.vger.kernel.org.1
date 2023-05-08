Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578226FAB25
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEHLKV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjEHLJy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5971BC2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5366662B24
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567B7C4339B;
        Mon,  8 May 2023 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544175;
        bh=9vv6OlxppSJicEcKSps3rEBEbW0WFtP3253I5VxaCqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TS9JaDx9TgQJzpJY9u3tjevY/FrpzHZmpNe+W+4Mdyw/vZ/sca+mzRAprf8sF+wss
         c8CzIJBpEhJbqQ9x1k928BZ8JshpYVIUuuhtSJc2B2VWwyZOwWVY6E/o5zUWdqsl6b
         YW2uB1DRb6ptCA5XbWK2ISSdBzcGBRbHyA3PuErE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Jun Yu <junyuu@chromium.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 326/694] wifi: ath11k: Use platform_get_irq() to get the interrupt
Date:   Mon,  8 May 2023 11:42:41 +0200
Message-Id: <20230508094442.946076328@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit f117276638b7600b981b3fe28550823cfbe1ef23 ]

As of commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ
resource from DT core"), we need to use platform_get_irq() instead of
platform_get_resource() to get our IRQs because
platform_get_resource() simply won't get them anymore.

This was already fixed in several other Atheros WiFi drivers,
apparently in response to Zeal Robot reports. An example of another
fix is commit 9503a1fc123d ("ath9k: Use platform_get_irq() to get the
interrupt"). ath11k seems to have been missed in this effort, though.

Without this change, WiFi wasn't coming up on my Qualcomm sc7280-based
hardware. Specifically, "platform_get_resource(pdev, IORESOURCE_IRQ,
i)" was failing even for i=0.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Fixes: 00402f49d26f ("ath11k: Add support for WCN6750 device")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Jun Yu <junyuu@chromium.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230201084131.v2.1.I69cf3d56c97098287fe3a70084ee515098390b70@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index bad3946b44bf6..b549576d0b513 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -874,11 +874,11 @@ static int ath11k_ahb_setup_msi_resources(struct ath11k_base *ab)
 	ab->pci.msi.ep_base_data = int_prop + 32;
 
 	for (i = 0; i < ab->pci.msi.config->total_vectors; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res)
-			return -ENODEV;
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
 
-		ab->pci.msi.irqs[i] = res->start;
+		ab->pci.msi.irqs[i] = ret;
 	}
 
 	set_bit(ATH11K_FLAG_MULTI_MSI_VECTORS, &ab->dev_flags);
-- 
2.39.2



