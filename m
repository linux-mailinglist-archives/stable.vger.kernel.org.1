Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2475C684
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGUMGR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGUMGQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EDB3A9F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0601C61A6A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A0C433C7;
        Fri, 21 Jul 2023 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689941141;
        bh=Mbj4Vo3DelIL8K0Em8z0ZvMdsHHUs3alGfGL+DGeeAY=;
        h=Subject:To:Cc:From:Date:From;
        b=yh5MU14vyTA8j7qu7PRlHn76B6GP/PBP2NZ9gT3knwB4gXg4Z3n3+c0cUKyx1h1nC
         TDa3m/aIBQXSNwUwRB5OjEzfbgoOqD/x8PH0ApowXFI1ZcRf25FdZwWpbNeSVB71j1
         q+EM1OveiUe+4hOxwaYjwlRSDdzNTmPS3hHY0u6I=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add monitor specific edid quirk" failed to apply to 5.10-stable tree
To:     aurabindo.pillai@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, rodrigo.siqueira@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 14:05:38 +0200
Message-ID: <2023072138-cobweb-bony-b0bb@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 613a7956deb3b1ffa2810c6d4c90ee9c3d743dbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072138-cobweb-bony-b0bb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

613a7956deb3 ("drm/amd/display: Add monitor specific edid quirk")
6803dfd3a69c ("Revert "drm/amd/display: Limit max DSC target bpp for specific monitors"")
55eea8ef9864 ("drm/amd/display: Limit max DSC target bpp for specific monitors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 613a7956deb3b1ffa2810c6d4c90ee9c3d743dbb Mon Sep 17 00:00:00 2001
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Date: Mon, 12 Jun 2023 12:44:00 -0400
Subject: [PATCH] drm/amd/display: Add monitor specific edid quirk

Disable FAMS on a Samsung Odyssey G9 monitor. Experiments show that this
monitor does not work well under some use cases, and is likely
implementation specific bug on the monitor's firmware.

Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cd20cfc04996..d9a482908380 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -44,6 +44,30 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
+static u32 edid_extract_panel_id(struct edid *edid)
+{
+	return (u32)edid->mfg_id[0] << 24   |
+	       (u32)edid->mfg_id[1] << 16   |
+	       (u32)EDID_PRODUCT_ID(edid);
+}
+
+static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
+{
+	uint32_t panel_id = edid_extract_panel_id(edid);
+
+	switch (panel_id) {
+	/* Workaround for some monitors which does not work well with FAMS */
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x71AC):
+		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_fams = true;
+		break;
+	default:
+		return;
+	}
+}
+
 /* dm_helpers_parse_edid_caps
  *
  * Parse edid caps
@@ -115,6 +139,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	kfree(sads);
 	kfree(sadb);
 

