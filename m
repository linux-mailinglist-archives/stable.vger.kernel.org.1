Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC470C6F1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjEVTYS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjEVTYQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C9189
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67BE6285C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC7BC433D2;
        Mon, 22 May 2023 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783444;
        bh=kuoQL1HY2LD3bKJMWHWCejjBFOetvE7NvzGWv+hoJtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGdOPhZEW4UGc5WHysky0F/9DBqVvsib6Fmo8uxZcN73ci29mu/z/JDCc0eLoPdIF
         mmCvdG7I4hBDf1DxeouNmBsitVuMNjxXPDDzCleQkTk4ndFfbdvmvYRWVZrZ/PfI/h
         5bcOkwBPxvcYPjwnz3fOPf3Y23tJ0k6LxidCqqZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 045/292] drm/amd/display: Enable HostVM based on rIOMMU active
Date:   Mon, 22 May 2023 20:06:42 +0100
Message-Id: <20230522190407.033925852@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Gabe Teeger <gabe.teeger@amd.com>

[ Upstream commit 97fa4dfa66fdd52ad3d0c9fadeaaa1e87605bac7 ]

[Why]
There is underflow and flickering occuring. The
underflow stops when hostvm is forced to active.
According to policy, hostvm should be enabled if riommu
is active, but this is not taken into account when
deciding whether to enable hostvm.

[What]
For DCN314, set hostvm to true if riommu is active.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 4f91e64754239..bf77e56c3f3ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -310,6 +310,10 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
 			upscaled = true;
 
+		/* Apply HostVM policy - either based on hypervisor globally enabled, or rIOMMU active */
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
+			pipes[i].pipe.src.hostvm = dc->vm_pa_config.is_hvm_enabled || dc->res_pool->hubbub->riommu_active;
+
 		/*
 		 * Immediate flip can be set dynamically after enabling the plane.
 		 * We need to require support for immediate flip or underflow can be
-- 
2.39.2



