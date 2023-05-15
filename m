Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6570368B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbjEORLO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbjEORK4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EC69EEA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9789E62B19
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CECC433D2;
        Mon, 15 May 2023 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170545;
        bh=PbZZuSH1PYVFxlTFOMPW56lB9p0Nk3XQKPBB3OSagGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2qbYOg3TVUsxEJkQQdOmF/Zv+Fp0edfSeDjaUyPLQ6NbpAa8VOEdL4SmMVhSBOH5
         pb1qUasqFo//wEo2jp3Yit9YiC0RSqRQgCq2LuEI519/m0KJydkjabEKvxEOFXxGui
         X++IPpW/ti1bISUHDyd0/1xB3BGhF8Xm+96LaiTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 165/239] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini
Date:   Mon, 15 May 2023 18:27:08 +0200
Message-Id: <20230515161726.625408478@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Horatio Zhang <Hongkun.Zhang@amd.com>

commit 08c677cb0b436a96a836792bb35a8ec5de4999c2 upstream.

The gmc.ecc_irq is enabled by firmware per IFWI setting,
and the host driver is not privileged to enable/disable
the interrupt. So, it is meaningless to use the amdgpu_irq_put
function in gmc_v10_0_hw_fini, which also leads to the call
trace.

[   82.340264] Call Trace:
[   82.340265]  <TASK>
[   82.340269]  gmc_v10_0_hw_fini+0x83/0xa0 [amdgpu]
[   82.340447]  gmc_v10_0_suspend+0xe/0x20 [amdgpu]
[   82.340623]  amdgpu_device_ip_suspend_phase2+0x127/0x1c0 [amdgpu]
[   82.340789]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[   82.340955]  amdgpu_device_pre_asic_reset+0xdd/0x2b0 [amdgpu]
[   82.341122]  amdgpu_device_gpu_recover.cold+0x4dd/0xbb2 [amdgpu]
[   82.341359]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[   82.341529]  process_one_work+0x21d/0x3f0
[   82.341535]  worker_thread+0x1fa/0x3c0
[   82.341538]  ? process_one_work+0x3f0/0x3f0
[   82.341540]  kthread+0xff/0x130
[   82.341544]  ? kthread_complete_and_exit+0x20/0x20
[   82.341547]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Fixes: c8b5a95b5709 ("drm/amdgpu: Fix desktop freezed after gpu-reset")
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1142,7 +1142,6 @@ static int gmc_v10_0_hw_fini(void *handl
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;


