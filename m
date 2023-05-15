Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC756703565
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbjEOQ6f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbjEOQ6a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72E5B88
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37CD162A39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28821C4339B;
        Mon, 15 May 2023 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169905;
        bh=RRCHnRLvmXe8vFF6MWW3DzFpgyYCrh1f8rtPxmOFv2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNwxtmv4HbCZIyInFY9N5J7AXTrav4XY0jaLWhaXpjsFJn4TlQkkkOAd1gIuXU39t
         kbXhf4/4FRpDC3Mq2E2gGLHsTPQoMS9Pg1o/znjTfjLXfMBRw2MjywJu8Q57vuJ3xt
         ubcIIfeYIgeTiFhHNZ1c9sWu9H0HP6oYjjyHI2Zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 208/246] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Date:   Mon, 15 May 2023 18:27:00 +0200
Message-Id: <20230515161728.842814535@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Guchun Chen <guchun.chen@amd.com>

commit 5247f05eadf1081a74b2233f291cee2efed25e3a upstream.

Prevent further dpm casting on legacy asics without od_enabled in
amdgpu_dpm_is_overdrive_supported. This can avoid UBSAN complain
in init sequence.

v2: add a macro to check legacy dpm instead of checking asic family/type
v3: refine macro name for naming consistency

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -36,6 +36,8 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
+#define amdgpu_dpm_is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
+
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1439,8 +1441,11 @@ int amdgpu_dpm_is_overdrive_supported(st
 	} else {
 		struct pp_hwmgr *hwmgr;
 
-		/* SI asic does not carry od_enabled */
-		if (adev->family == AMDGPU_FAMILY_SI)
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (amdgpu_dpm_is_legacy_dpm(adev))
 			return false;
 
 		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;


