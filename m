Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41C07036B5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbjEORNC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbjEORMr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4D7D99
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B276A62B5C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FA2C433EF;
        Mon, 15 May 2023 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170661;
        bh=XyTnWezu4Wzp2XNXIbDjPpvShOHaObxFKdHQfyq6PM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oR4VQy+9g+C1rHMooJlgZD2LOgkk34lxD2WxEGnrb9/9yXd//HHEcq1d8SEewi044
         Q2h0S7bl7bsEtOS5m2g5Atu882dgHgcBiSAn4tM8sQUbvQz1Jskh3gMJb3J2fGv6Xq
         uKKdYncrt0C4NHE9RN9BHgMroQLCSKwO9TzIIltY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robin Chen <robin.chen@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/239] drm/amd/display: Add debug option to skip PSR CRTC disable
Date:   Mon, 15 May 2023 18:27:44 +0200
Message-Id: <20230515161727.761444706@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 00812bfc7bcb02faf127ee05f6ac27a5581eb701 ]

[Why]
It's currently tied to Z10 support, and is required for Z10, but
we can still support Z10 display off without PSR.

We currently need to skip the PSR CRTC disable to prevent stuttering
and underflow from occuring during PSR-SU.

[How]
Add a debug option to allow specifying this separately.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: d893f39320e1 ("drm/amd/display: Lowering min Z8 residency time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bf7fcd268cb47..6299130663a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3381,7 +3381,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		case FAMILY_YELLOW_CARP:
 		case AMDGPU_FAMILY_GC_10_3_6:
 		case AMDGPU_FAMILY_GC_11_0_1:
-			if (dc->debug.disable_z10)
+			if (dc->debug.disable_z10 || dc->debug.psr_skip_crtc_disable)
 				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d64d3b0dc211..e038a180b941d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -829,6 +829,7 @@ struct dc_debug_options {
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
 	bool enable_z9_disable_interface;
+	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
 	bool disable_fixed_vs_aux_timeout_wa;
 	bool force_disable_subvp;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 94a90c8f3abbe..58931df853f1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -884,6 +884,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
+	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
 	.timing_trace = false,
-- 
2.39.2



