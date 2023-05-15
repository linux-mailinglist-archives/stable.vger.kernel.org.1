Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81A70371B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjEORQ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbjEORQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA6D876
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A22D62BD5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61475C433EF;
        Mon, 15 May 2023 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170921;
        bh=y1OoO1JxQZYli/Db7UQi/zrERtly5GFjUhpdPADO2pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaWTsTtLS2hGespVPt7NyZa0C/JrpF6apL5laSxCfyze5Hmb5OC55IgFZ1P6c6sno
         RmbSkGJB1tLHcMasGDtwmOCeAp7v1o3zUZoHDOnXmJbGNC3fSxKSXh2vLQCdqbGjYL
         GI3QuNWq6vKd1MeREhc1iHmYZ/LYCUemfUdy8qkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerry Zuo <Jerry.Zuo@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Ryan Lin <tsung-hua.lin@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 014/242] drm/amd/display: Ext displays with dock cant recognized after resume
Date:   Mon, 15 May 2023 18:25:40 +0200
Message-Id: <20230515161722.250726436@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Ryan Lin <tsung-hua.lin@amd.com>

[ Upstream commit 1e5d4d8eb8c0f15d90c50e7abd686c980e54e42e ]

[Why]
Needs to set the default value of the LTTPR timeout after resume.

[How]
Set the default (3.2ms) timeout at resuming if the sink supports
LTTPR

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 422909d1f352b..58fdd39f5bde9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -39,6 +39,7 @@
 #include "dc/dc_edid_parser.h"
 #include "dc/dc_stat.h"
 #include "amdgpu_dm_trace.h"
+#include "dc/inc/dc_link_ddc.h"
 
 #include "vid.h"
 #include "amdgpu.h"
@@ -2262,6 +2263,14 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
+			/* if extended timeout is supported in hardware,
+			 * default to LTTPR timeout (3.2ms) first as a W/A for DP link layer
+			 * CTS 4.2.1.1 regression introduced by CTS specs requirement update.
+			 */
+			dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
+			if (!dp_is_lttpr_present(aconnector->dc_link))
+				dc_link_aux_try_to_configure_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
-- 
2.39.2



