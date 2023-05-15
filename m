Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED973703703
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbjEORQB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbjEORPd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B7DC5D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61D662B9D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA075C433EF;
        Mon, 15 May 2023 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170865;
        bh=IklGXwQ+QJmxQIBDYl7m1zus3zXQsMX+ouWyA8WQFns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeEuGKOPTt324XMh8HHAVOaQjzxfApZgMatrCAH9pfAojMhLLF7o4BOoM8+tRFC2N
         bRQGJTdQP8ZjnugaZ9N8HYsBCfoNktE8vbBwq4aS1pNgyc6lEJAwsT7Z5dLGAY7f5x
         35yGrm/mxIA5G62wiefwcLtlUE18wgiWBZDZUngc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 026/242] drm/amd/display: Return error code on DSC atomic check failure
Date:   Mon, 15 May 2023 18:25:52 +0200
Message-Id: <20230515161722.713818103@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit dd24662d9dfbad281bbf030f06d68c7938fa0c66 ]

[Why&How]
We were not returning -EINVAL on DSC atomic check fail. Add it.

Fixes: 71be4b16d39a ("drm/amd/display: dsc validate fail not pass to atomic check")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 58fdd39f5bde9..324cfaeb744cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9859,6 +9859,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		ret = compute_mst_dsc_configs_for_state(state, dm_state->context, vars);
 		if (ret) {
 			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
+			ret = -EINVAL;
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 60dd88666437d..994a37003217d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1375,6 +1375,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	ret = pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars);
 	if (ret != 0) {
 		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
+		ret = -EINVAL;
 		goto clean_exit;
 	}
 
-- 
2.39.2



