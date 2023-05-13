Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B99701507
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEMHkQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEMHkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCB59FD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0C861AAD
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814ADC433EF;
        Sat, 13 May 2023 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963613;
        bh=C9GHMUP3z8pbS7G3yxCoGmBrtnM6+QcDQKMcCg1Ai+k=;
        h=Subject:To:Cc:From:Date:From;
        b=P2Q4l/UMvyJLXSsZYYs/InfYxZn6Hk/zDC2E3uicJoI3anUIppmijrZQUa9AiwKz1
         AZQnVHxZ2H0Y+KdbfQ6eyXjfl1W3pJ0UETKWRlcp0RsEGUuDSUFtg8xH8xbaXo0l01
         oNR5hS72jlk/fbW/1rYbMxn11tzsl00i0gB687hs=
Subject: FAILED: patch "[PATCH] drm/amd/display: hpd rx irq not working with eDP interface" failed to apply to 6.2-stable tree
To:     robin.chen@amd.com, Wenjing.Liu@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:53 +0900
Message-ID: <2023051353-album-booth-d380@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x eeefe7c4820b6baa0462a8b723ea0a3b5846ccae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051353-album-booth-d380@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

eeefe7c4820b ("drm/amd/display: hpd rx irq not working with eDP interface")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")
8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
5ca38a18b5a4 ("drm/amd/display: move public dc link function implementation to dc_link_exports")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
e95afc1cf7c6 ("drm/amd/display: Enable AdaptiveSync in DC interface")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
2daeb74b7d66 ("drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
bd3149014dff ("drm/amd/display: Decrease messaging about DP alt mode state to debug")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eeefe7c4820b6baa0462a8b723ea0a3b5846ccae Mon Sep 17 00:00:00 2001
From: Robin Chen <robin.chen@amd.com>
Date: Fri, 17 Feb 2023 20:47:57 +0800
Subject: [PATCH] drm/amd/display: hpd rx irq not working with eDP interface

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

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4b47fa00610b..45ab48fe5d00 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1080,4 +1080,11 @@ struct dc_dpia_bw_alloc {
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
index 995032a341b3..3951d48118c4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -528,14 +528,18 @@ static bool construct_phy(struct dc_link *link,
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
@@ -543,6 +547,7 @@ static bool construct_phy(struct dc_link *link,
 					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			default:
+				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 				break;
 			}
 		}

