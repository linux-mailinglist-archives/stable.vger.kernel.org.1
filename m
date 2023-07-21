Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6875BF96
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGUHXg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGUHXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C3189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202D96112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9E8C433C8;
        Fri, 21 Jul 2023 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924208;
        bh=iygF/lPEh3GAKybaih7XzNhDDKqZlIeE6A+SQsxTbQM=;
        h=Subject:To:Cc:From:Date:From;
        b=h42tg1ch8wtu690tTBae9+pKFe/808aSdF6nr1xzAvtjaa3hKeFLA9An/6+ikBtLj
         j7bq/H5ximwqO0jibiLOZGn8NoIiVnu6Qfujv3+Zje5WfLHaIoHxuJy6CmJ5O+Dn+N
         7/UckLmJDCJZ93UiI66dJKjr+6MoKvx4W18c6H7g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Keep disable aux-i delay as 0" failed to apply to 6.1-stable tree
To:     michael.strauss@amd.com, Aric.Cyr@amd.com, George.Shen@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:23:25 +0200
Message-ID: <2023072125-quotation-duplicity-661f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5a096b73c8fed3a9987ba15378285df360e2284b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072125-quotation-duplicity-661f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5a096b73c8fe ("drm/amd/display: Keep disable aux-i delay as 0")
9fa8cc0c4445 ("drm/amd/display: Convert Delaying Aux-I Disable To Monitor Patch")
7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS link training at DP1 rates")
80c6d6804f31 ("drm/amd/display: disable SubVP + DRR to prevent underflow")
54618888d1ea ("drm/amd/display: break down dc_link.c")
71d7e8904d54 ("drm/amd/display: Add HDMI manufacturer OUI and device id read")
65a4cfb45e0e ("drm/amdgpu/display: remove duplicate include header in files")
e322843e5e33 ("drm/amd/display: fix linux dp link lost handled only one time")
0c2bfcc338eb ("drm/amd/display: Add Function declaration in dc_link")
6ca7415f11af ("drm/amd/display: merge dc_link_dp into dc_link")
de3fb390175b ("drm/amd/display: move dp cts functions from dc_link_dp to link_dp_cts")
c5a31f178e35 ("drm/amd/display: move dp irq handler functions from dc_link_dp to link_dp_irq_handler")
0078c924e733 ("drm/amd/display: move eDP panel control logic to link_edp_panel_control")
bc33f5e5f05b ("drm/amd/display: create accessories, hwss and protocols sub folders in link")
2daeb74b7d66 ("drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD")
028c4ccfb812 ("drm/amd/display: force connector state when bpc changes during compliance")
603a521ec279 ("drm/amd/display: remove duplicate included header files")
bd3149014dff ("drm/amd/display: Decrease messaging about DP alt mode state to debug")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a096b73c8fed3a9987ba15378285df360e2284b Mon Sep 17 00:00:00 2001
From: Michael Strauss <michael.strauss@amd.com>
Date: Tue, 11 Apr 2023 12:44:54 -0400
Subject: [PATCH] drm/amd/display: Keep disable aux-i delay as 0

[WHY]
Current Aux-I sequence checks for local_sink which isn't populated on
MST links

[HOW]
Leave disable aux-i delay as 0 for MST cases

Cc: stable@vger.kernel.org
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fb6c938c6dab..15faaf645b14 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -233,8 +233,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
 	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
-	uint32_t pre_disable_intercept_delay_ms =
-			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
@@ -245,6 +244,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
+	if (link->local_sink)
+		pre_disable_intercept_delay_ms =
+				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
@@ -595,10 +598,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	const uint8_t vendor_lttpr_write_data_adicora_eq3[4] = {0x1, 0x55, 0x63, 0x68};
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
-	uint32_t pre_disable_intercept_delay_ms =
-			link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
-
-
+	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
@@ -607,6 +607,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	uint8_t toggle_rate;
 	uint8_t rate;
 
+	if (link->local_sink)
+		pre_disable_intercept_delay_ms =
+				link->local_sink->edid_caps.panel_patch.delay_disable_aux_intercept_ms;
+
 	/* Only 8b/10b is supported */
 	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);

