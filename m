Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB357551D7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGPUAr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjGPUAq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A0EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D58760E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C71C433C8;
        Sun, 16 Jul 2023 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537644;
        bh=mGSaPe0b0JgF6oBM+lFhaiwEm5jhd/lwQLVL4VJP9Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcCwXgy+Wyi2jjuh1Q9Ni0gxZIgRhf6kxAlmDXB3EGEECp8BO1kAbme6DspJsiBWm
         EpMige9MGpUNtb6IYl9O6lqUjkwxicegT8n/pRlFf+kM7elv2b+PySU/AEtRGJGcfx
         4Wagph3PQxd51O3Pz5uJ5g58de2oIaP4QwgeR7to=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ziyang Huang <hzyitc@outlook.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 169/800] wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
Date:   Sun, 16 Jul 2023 21:40:22 +0200
Message-ID: <20230716194953.034286691@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Ziyang Huang <hzyitc@outlook.com>

[ Upstream commit 469ddb20cae61cad9c4f208a4c8682305905a511 ]

Without this patch, the IPQ5018 WiFi will fail and print the following
logs:

	[   11.033179] ath11k c000000.wifi: unsupported device type 7
	[   11.033223] ath11k: probe of c000000.wifi failed with error -95

Fixes: 25edca7bb18a ("wifi: ath11k: add ipq5018 device support")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/TYZPR01MB5556D7AA10ABEDDDD2D8F39EC953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 5cbba9a8b6ba9..396548e57022f 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1127,6 +1127,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	switch (hw_rev) {
 	case ATH11K_HW_IPQ8074:
 	case ATH11K_HW_IPQ6018_HW10:
+	case ATH11K_HW_IPQ5018_HW10:
 		hif_ops = &ath11k_ahb_hif_ops_ipq8074;
 		pci_ops = NULL;
 		break;
-- 
2.39.2



