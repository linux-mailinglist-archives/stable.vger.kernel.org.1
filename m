Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F1726B69
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjFGUZQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjFGUYu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410742705
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4496441B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F123EC433B3;
        Wed,  7 Jun 2023 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169458;
        bh=ii5rB67/oiLkIf0YpuN4Mx9GP1DSfTqlay2Ff8Roub8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH5G/ISthv2h+SjfezQA8izNhFMvHGxAM/MJjvSiSL5bWqHsYAj/kiiuiP7HsUt99
         j9bpnPJgL95h5LkxyrFyReUP5ScAXJzJNjfifqR9t5sS4uln6EZXe0u586r/e71Fws
         mqGERYA+CzASqN2q6OYLJqN8AXu/9oGU5bYtrXZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 088/286] drm/amd/display: fix memleak in aconnector->timing_requested
Date:   Wed,  7 Jun 2023 22:13:07 +0200
Message-ID: <20230607200925.942526003@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit 025ce392b5f213696ca0af3e07735d0fae020694 ]

[Why]
when amdgpu_dm_update_connector_after_detect is called
two times successively with valid sink, memory allocated of
aconnector->timing_requested for the first call is not free.
this causes memeleak.

[How]
allocate memory only when aconnector->timing_requested
is null.

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0695c7c3d489d..ce46f3a061c44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3095,9 +3095,12 @@ void amdgpu_dm_update_connector_after_detect(
 						    aconnector->edid);
 		}
 
-		aconnector->timing_requested = kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
-		if (!aconnector->timing_requested)
-			dm_error("%s: failed to create aconnector->requested_timing\n", __func__);
+		if (!aconnector->timing_requested) {
+			aconnector->timing_requested =
+				kzalloc(sizeof(struct dc_crtc_timing), GFP_KERNEL);
+			if (!aconnector->timing_requested)
+				dm_error("failed to create aconnector->requested_timing\n");
+		}
 
 		drm_connector_update_edid_property(connector, aconnector->edid);
 		amdgpu_dm_update_freesync_caps(connector, aconnector->edid);
-- 
2.39.2



