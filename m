Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C71970C9ED
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjEVTxP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEVTxJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99E184
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8633A62B48
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803AEC4339B;
        Mon, 22 May 2023 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785186;
        bh=QlfIdNZ+otplmfHtuOTG8NO4faYRsePp6yzb1jtIVbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4WuZU35IakDx/zhxc2dALuFMyj/vovG97pnmA+tdQgtTKXrmzXHB6tAcFMsiup2w
         I0VeQq05SCjgyfRUNWAYcVrYoWH+luB1NLRKi4OiC5b+0mcHPyZYSaL3A5yJzD+Pfe
         U8S+PqsZL3LZuZe55RivSXTsg5BSfuD0GVQEbCcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sunil Khatri <sunil.khatri@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 338/364] drm/amdgpu/gmc11: implement get_vbios_fb_size()
Date:   Mon, 22 May 2023 20:10:43 +0100
Message-Id: <20230522190421.223889736@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit 68518294d00da6a2433357af75a63abc6030676e upstream.

Implement get_vbios_fb_size() so we can properly reserve
the vbios splash screen to avoid potential artifacts on the
screen during the transition from the pre-OS console to the
OS console.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -31,6 +31,8 @@
 #include "umc_v8_10.h"
 #include "athub/athub_3_0_0_sh_mask.h"
 #include "athub/athub_3_0_0_offset.h"
+#include "dcn/dcn_3_2_0_offset.h"
+#include "dcn/dcn_3_2_0_sh_mask.h"
 #include "oss/osssys_6_0_0_offset.h"
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
 #include "navi10_enum.h"
@@ -542,7 +544,24 @@ static void gmc_v11_0_get_vm_pte(struct
 
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
-	return 0;
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
+	unsigned size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
 }
 
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {


