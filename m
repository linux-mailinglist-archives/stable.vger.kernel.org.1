Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A97035CB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbjEORCt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbjEORCZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666B9019
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F8C162A6C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13305C433EF;
        Mon, 15 May 2023 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170008;
        bh=C9NqJ/XM3DvZ12PBA5SStdrYT+fZS8XNvP0Acs9n2gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jP3QDxIrcdCicLvLYkpYafvMpYGElz3eutsyfoiZ4E6Zx4Wq4IpYzVfIAZ2ityw0e
         1waGW0NJEzJJq/HFPPh/dVz1Thov1AIkMfGQNkfiRwfnjAhq9yqpxgNQYzsNQzJFiM
         AiZ7kchzau06vzF0ryFQF5cIv5h3ICzUhEW23WkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Robin Chen <robin.chen@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 216/246] drm/amd/display: hpd rx irq not working with eDP interface
Date:   Mon, 15 May 2023 18:27:08 +0200
Message-Id: <20230515161729.076296251@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Robin Chen <robin.chen@amd.com>

[ Upstream commit eeefe7c4820b6baa0462a8b723ea0a3b5846ccae ]

[Why]
This is the fix for the defect of commit ab144f0b4ad6
("drm/amd/display: Allow individual control of eDP hotplug support").

[How]
To revise the default eDP hotplug setting and use the enum to git rid
of the magic number for different options.

Fixes: ab144f0b4ad6 ("drm/amd/display: Allow individual control of eDP hotplug support")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h          | 7 +++++++
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f28b8597cc1e6..cba65766ef47b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1086,4 +1086,11 @@ struct dc_dpia_bw_alloc {
 };
 
 #define MAX_SINKS_PER_LINK 4
+
+enum dc_hpd_enable_select {
+	HPD_EN_FOR_ALL_EDP = 0,
+	HPD_EN_FOR_PRIMARY_EDP_ONLY,
+	HPD_EN_FOR_SECONDARY_EDP_ONLY,
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index aeb26a4d539e9..8aaf14afa4271 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -274,14 +274,18 @@ static bool dc_link_construct_phy(struct dc_link *link,
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 
 			switch (link->dc->config.allow_edp_hotplug_detection) {
-			case 1: // only the 1st eDP handles hotplug
+			case HPD_EN_FOR_ALL_EDP:
+				link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				break;
+			case HPD_EN_FOR_PRIMARY_EDP_ONLY:
 				if (link->link_index == 0)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
 				else
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
-			case 2: // only the 2nd eDP handles hotplug
+			case HPD_EN_FOR_SECONDARY_EDP_ONLY:
 				if (link->link_index == 1)
 					link->irq_source_hpd_rx =
 						dal_irq_get_rx_source(link->hpd_gpio);
@@ -289,6 +293,7 @@ static bool dc_link_construct_phy(struct dc_link *link,
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			default:
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			}
 		}
-- 
2.39.2



