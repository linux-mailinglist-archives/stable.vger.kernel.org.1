Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF177AC8B
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjHMVeW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjHMVeW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B310F2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF62462C4B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D4EC433C8;
        Sun, 13 Aug 2023 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962459;
        bh=Olt41A8yjwAEtLveMGp9jIChwphHAUDSbDRn/vrLb1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxcLqzoMuxP3we7MQmxAuL1wtdhYyUyPxPnxelvVmkGcPycktLI5RKUayYBSs/3DH
         MeOD6J9pAYT+ns4Ef9gbNC0tfkgJxnSyA4TN3jANv7GvAt7j6cNdQ4F3NP4iPsbrMZ
         Xbd8LuPMrpYHAvBauopRSnM+bvLleIl8KWM5NCIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 037/149] drm/amd/pm: fulfill swsmu peak profiling mode shader/memory clock settings
Date:   Sun, 13 Aug 2023 23:18:02 +0200
Message-ID: <20230813211719.918778033@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

commit 975b4b1d90ccf83da252907108f4090fb61b816e upstream

Enable peak profiling mode shader/memory clocks reporting for swsmu
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |    2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |    8 ++++++++
 2 files changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -139,6 +139,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MIN_FAN_RPM,
 	AMDGPU_PP_SENSOR_MAX_FAN_RPM,
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
 };
 
 enum amd_pp_task {
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2520,6 +2520,14 @@ static int smu_read_sensor(void *handle,
 		*((uint32_t *)data) = pstate_table->uclk_pstate.standard * 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK:
+		*((uint32_t *)data) = pstate_table->gfxclk_pstate.peak * 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK:
+		*((uint32_t *)data) = pstate_table->uclk_pstate.peak * 100;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
 		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
 		*size = 8;


