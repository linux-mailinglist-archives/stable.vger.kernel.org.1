Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A384703696
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbjEORLu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjEORLW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A072A5CA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E469462B34
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ECBC433D2;
        Mon, 15 May 2023 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170554;
        bh=DDT1M0jGiF4j4Ob2wAMG3YoF1AvWRzAlkn+KgNuBaR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qop0IgMoINq7VworcJ29MsYLZK7L4XSTMBSKLAxxvUqbsx+6gAWAw63WzESufjLlD
         nNjW1JHZXVUolat6RAf67wPQ2qFsYK3L+GEDux3pck8anOG78XAF9PNgGqp38HQONi
         ruXfxRUidCiswOKbt7KTbQHYmRKo2Pn7m2Yi5n9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 167/239] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini
Date:   Mon, 15 May 2023 18:27:10 +0200
Message-Id: <20230515161726.683830224@linuxfoundation.org>
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

From: Horatio Zhang <Hongkun.Zhang@amd.com>

commit 13af556104fa93b1945c70bbf8a0a62cd2c92879 upstream.

The gmc.ecc_irq is enabled by firmware per IFWI setting,
and the host driver is not privileged to enable/disable
the interrupt. So, it is meaningless to use the amdgpu_irq_put
function in gmc_v11_0_hw_fini, which also leads to the call
trace.

[  102.980303] Call Trace:
[  102.980303]  <TASK>
[  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu]
[  102.980357]  gmc_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.980409]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.980687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.980740]  process_one_work+0x21f/0x3f0
[  102.980741]  worker_thread+0x200/0x3e0
[  102.980742]  ? process_one_work+0x3f0/0x3f0
[  102.980743]  kthread+0xfd/0x130
[  102.980743]  ? kthread_complete_and_exit+0x20/0x20
[  102.980744]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Fixes: c8b5a95b5709 ("drm/amdgpu: Fix desktop freezed after gpu-reset")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -931,7 +931,6 @@ static int gmc_v11_0_hw_fini(void *handl
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v11_0_gart_disable(adev);
 


