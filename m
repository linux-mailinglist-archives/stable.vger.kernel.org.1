Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A77037D9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbjEORYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjEORYQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DD100F7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFE362C52
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F68C433EF;
        Mon, 15 May 2023 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171385;
        bh=///zHZg4pXoJKgurYXlA50L1XGwpvcc8o1dla1oLyCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFdtsL4R7n8x5afKlVN47gL9LxfkSvCEAQDvoaw4sPHTLSJwPjw/rC67lpOIfylBv
         /A2+17g9g+u7yS/x7b0ktD547vMxBHgZ82ooWQJHkH7hHQ/70UoVzD8adlcNfTEjQ/
         0KrBnq+9+kemOLS4UlGZKFuYXn1ykGVaw4ceVrHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 192/242] drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v10_0_hw_fini
Date:   Mon, 15 May 2023 18:28:38 +0200
Message-Id: <20230515161727.709069097@linuxfoundation.org>
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
@@ -1145,7 +1145,6 @@ static int gmc_v10_0_hw_fini(void *handl
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;


