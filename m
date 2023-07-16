Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD6755473
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGPUa3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGPUaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3BDBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A43960E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A77C433C8;
        Sun, 16 Jul 2023 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539422;
        bh=MaIhxKLDEnn4NixZz6+oRo1EhlcedNSnvMtp67GtGRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wd6dvv2vdvK3/Nbk19nFbO+XpLG1PQF326DrlG+9yLrtFK34ldLahMjlzBiJJWFzl
         BYmnVqOn1MwGBWuw8cCCIt5uqmN2KtEMVPpaY2DM40Z7Hmn0TvT3uGdvtV10l7h6+9
         fqI0FPY13EUUUbVPgtw+kjFNMZWHFKOtpwwk7620=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 790/800] drm/amd/pm: revise the ASPM settings for thunderbolt attached scenario
Date:   Sun, 16 Jul 2023 21:50:43 +0200
Message-ID: <20230716195007.498937088@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Evan Quan <evan.quan@amd.com>

commit fd21987274463a439c074b8f3c93d3b132e4c031 upstream

Also, correct the comment for NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT
as 0x0000000E stands for 400ms instead of 4ms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -346,7 +346,7 @@ static void nbio_v2_3_init_registers(str
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
 #define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
-#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 4ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 400ms
 
 static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 				  bool enable)
@@ -479,9 +479,12 @@ static void nbio_v2_3_program_aspm(struc
 		WREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP5, data);
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
-	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
-	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	if (pci_is_thunderbolt_attached(adev->pdev))
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	else
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
 	if (def != data)
 		WREG32_PCIE(smnPCIE_LC_CNTL, data);
 


