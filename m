Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560B701506
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEMHkI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEMHkG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3C35B5
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2EFD609EB
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8BDC433EF;
        Sat, 13 May 2023 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963604;
        bh=5kLTmNMvBB9luFkq69Dm0boCztlsfKvBmLnv03bmpnM=;
        h=Subject:To:Cc:From:Date:From;
        b=dWTk6zT2EJJIp1HbGUIoCpzxT1pQLY77dsujtBY+rJgy3DbHqrFCduigYM3SWmypG
         1PloyMvex15sHN2+ewpmyg57uU2AVGMUQvF4RnZIm6Y0qeo+9IC9POC9GR+TSs5pdj
         ocmbrLB29yG2RygGYRod6zyWDI6lM88y37aIU3Yg=
Subject: FAILED: patch "[PATCH] drm/amd/display: hpd rx irq not working with eDP interface" failed to apply to 6.3-stable tree
To:     robin.chen@amd.com, Wenjing.Liu@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        qingqing.zhuo@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:50 +0900
Message-ID: <2023051350-ruckus-chemist-caf3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x eeefe7c4820b6baa0462a8b723ea0a3b5846ccae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051350-ruckus-chemist-caf3@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

eeefe7c4820b ("drm/amd/display: hpd rx irq not working with eDP interface")
7ae1dbe6547c ("drm/amd/display: merge dc_link.h into dc.h and dc_types.h")

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

