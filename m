Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BA6FA71A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjEHK1w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjEHK1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC910C9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2798F6262C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E8C4339B;
        Mon,  8 May 2023 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541606;
        bh=bi83siI7yC3mkFA8Ai+aJsMLONLFE9zNMMtWWw6fJA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6wOZClfk+NO8GpO3mcg6HrWoF6gVAPgNz05YphzyQtaMISuO/vlmTwSP8SjTDjOr
         ouOhwfuDb59aNR3S5fkujdclxXKr2JOtyR7w9Ta3vSUX1zeOSLL/NwcwnvXROZJ95h
         HpcAhOLJjBwTBPuXVPOcXqwYX+Gu603fcieJzNU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 137/663] drm/amdgpu: register a vga_switcheroo client for MacBooks with apple-gmux
Date:   Mon,  8 May 2023 11:39:23 +0200
Message-Id: <20230508094432.973758631@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Orlando Chamberlain <orlandoch.dev@gmail.com>

[ Upstream commit d37a3929ca0363ed1dce02b2772cd5bc547ca66d ]

Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
vga_switcheroo") made amdgpu only register a vga_switcheroo client for
GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
register, but don't have PX. Instead of AMD's PX, they use apple-gmux.

Use apple_gmux_detect() to identify these gpus, and
pci_is_thunderbolt_attached() to ensure eGPUs connected to Dual GPU
Macbooks don't register with vga_switcheroo.

Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
Link: https://lore.kernel.org/amd-gfx/20230210044826.9834-10-orlandoch.dev@gmail.com/
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3dac1e139c5f3..533263d442657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -35,6 +35,7 @@
 #include <linux/devcoredump.h>
 #include <generated/utsrelease.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/apple-gmux.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -3952,12 +3953,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_px(ddev)) {
-		px = true;
+	px = amdgpu_device_supports_px(ddev);
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_register_client(adev->pdev,
 					       &amdgpu_switcheroo_ops, px);
+
+	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
-	}
 
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
@@ -4063,6 +4067,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
+	bool px;
 
 	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
@@ -4082,10 +4087,16 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	kfree(adev->bios);
 	adev->bios = NULL;
-	if (amdgpu_device_supports_px(adev_to_drm(adev))) {
+
+	px = amdgpu_device_supports_px(adev_to_drm(adev));
+
+	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_unregister_client(adev->pdev);
+
+	if (px)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	}
+
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-- 
2.39.2



