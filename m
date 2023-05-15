Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C33703819
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbjEOR1X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbjEOR1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197713285
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA7762CEB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF043C433D2;
        Mon, 15 May 2023 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171532;
        bh=TifXGaWGBWlm68FOaLPEkkCtywDrgJcuZ+MEP8HwFis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AivxRLC95WMoUgUuPXcZIzYG//l9rozsfZp84gf15uQnqB5Yp93qPHnf/FHz7IStA
         m2rML0l8GGUR09IvT52rf5zKd/tuYNtLQvZNoO3q/1lrBf56Jbbu+RBbafhDHWnoJR
         RMZR71DbVG1NbSkP8mTAVwLOnb3KZ+I+8cKzwdOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 200/242] drm/amd/pm: parse pp_handle under appropriate conditions
Date:   Mon, 15 May 2023 18:28:46 +0200
Message-Id: <20230515161727.943827582@linuxfoundation.org>
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

From: Guchun Chen <guchun.chen@amd.com>

commit 58d9b9a14b47c2a3da6effcbb01607ad7edc0275 upstream.

amdgpu_dpm_is_overdrive_supported is a common API across all
asics, so we should cast pp_handle into correct structure
under different power frameworks.

v2: using return directly to simplify code
v3: SI asic does not carry od_enabled member in pp_handle, and update Fixes tag

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
Fixes: eb4900aa4c49 ("drm/amdgpu: Fix kernel NULL pointer dereference in dpm functions")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1414,15 +1414,21 @@ int amdgpu_dpm_get_smu_prv_buf_details(s
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
 
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+		return (smu->od_enabled || smu->is_apu);
+	} else {
+		struct pp_hwmgr *hwmgr;
 
-	return false;
+		/* SI asic does not carry od_enabled */
+		if (adev->family == AMDGPU_FAMILY_SI)
+			return false;
+
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,


