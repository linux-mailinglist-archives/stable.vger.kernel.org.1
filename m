Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0F726D89
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjFGUnR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjFGUnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53326A4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F28864606
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6741CC433EF;
        Wed,  7 Jun 2023 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170555;
        bh=86r+xkKIRhYgUF7Bq+La4YvxxcG5eH8HiqlRcq7Fy5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZKTEemmyka3IEy+khnnJRLCEuLJSX3m4WGKhoniBjsBXoVXXbmAhB0R1AycSFE0S
         UGmseEehgiSw9WxnpKpt0kn4HpmBtGERAyz4cdxEeuCIHrlqGUiN7VEo67a8t+sfhF
         8JqbL1COV2/qqcbZxJlgvt+hSioNxGv4a8Qak+Iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/225] drm/amdgpu: skip disabling fence driver src_irqs when device is unplugged
Date:   Wed,  7 Jun 2023 22:15:23 +0200
Message-ID: <20230607200918.626270969@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit c1a322a7a4a96cd0a3dde32ce37af437a78bf8cd ]

When performing device unbind or halt, we have disabled all irqs at the
very begining like amdgpu_pci_remove or amdgpu_device_halt. So
amdgpu_irq_put for irqs stored in fence driver should not be called
any more, otherwise, below calltrace will arrive.

[  139.114088] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:616 amdgpu_irq_put+0xf6/0x110 [amdgpu]
[  139.114655] Call Trace:
[  139.114655]  <TASK>
[  139.114657]  amdgpu_fence_driver_hw_fini+0x93/0x130 [amdgpu]
[  139.114836]  amdgpu_device_fini_hw+0xb6/0x350 [amdgpu]
[  139.114955]  amdgpu_driver_unload_kms+0x51/0x70 [amdgpu]
[  139.115075]  amdgpu_pci_remove+0x63/0x160 [amdgpu]
[  139.115193]  ? __pm_runtime_resume+0x64/0x90
[  139.115195]  pci_device_remove+0x3a/0xb0
[  139.115197]  device_remove+0x43/0x70
[  139.115198]  device_release_driver_internal+0xbd/0x140

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3cc1929285fc0..ed6878d5b3ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -528,7 +528,8 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (r)
 			amdgpu_fence_driver_force_completion(ring);
 
-		if (ring->fence_drv.irq_src)
+		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
+		    ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
 
-- 
2.39.2



