Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6529703C18
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbjEOSJX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbjEOSJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04805FE1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DDA63073
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF19AC433D2;
        Mon, 15 May 2023 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684174011;
        bh=ozVFxMTcjPnP/6ddWjX0ymZpYxL/xiDu09fW9Yvg+c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwwp6kbkOwp4mnCWUw2Z0kzTSP8mIBejCQLzhosEEc/FhmU3WYxlG0IRyIB+RZcMb
         dvJ3NbylOEG+cRjO3q24Nwc2xIbktZXt5pKEgGczWKEgv0/b+YRLsmbcRbpGsDmLIs
         57XMY969icdjZeSeGHZpMfTfsBZpVOUUC9zge6zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 5.4 279/282] drm/msm/adreno: Fix null ptr access in adreno_gpu_cleanup()
Date:   Mon, 15 May 2023 18:30:57 +0200
Message-Id: <20230515161730.738391273@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Akhil P Oommen <quic_akhilpo@quicinc.com>

commit dbeedbcb268d055d8895aceca427f897e12c2b50 upstream.

Fix the below kernel panic due to null pointer access:
[   18.504431] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
[   18.513464] Mem abort info:
[   18.516346]   ESR = 0x0000000096000005
[   18.520204]   EC = 0x25: DABT (current EL), IL = 32 bits
[   18.525706]   SET = 0, FnV = 0
[   18.528878]   EA = 0, S1PTW = 0
[   18.532117]   FSC = 0x05: level 1 translation fault
[   18.537138] Data abort info:
[   18.540110]   ISV = 0, ISS = 0x00000005
[   18.544060]   CM = 0, WnR = 0
[   18.547109] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000112826000
[   18.553738] [0000000000000048] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[   18.562690] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
**Snip**
[   18.696758] Call trace:
[   18.699278]  adreno_gpu_cleanup+0x30/0x88
[   18.703396]  a6xx_destroy+0xc0/0x130
[   18.707066]  a6xx_gpu_init+0x308/0x424
[   18.710921]  adreno_bind+0x178/0x288
[   18.714590]  component_bind_all+0xe0/0x214
[   18.718797]  msm_drm_bind+0x1d4/0x614
[   18.722566]  try_to_bring_up_aggregate_device+0x16c/0x1b8
[   18.728105]  __component_add+0xa0/0x158
[   18.732048]  component_add+0x20/0x2c
[   18.735719]  adreno_probe+0x40/0xc0
[   18.739300]  platform_probe+0xb4/0xd4
[   18.743068]  really_probe+0xfc/0x284
[   18.746738]  __driver_probe_device+0xc0/0xec
[   18.751129]  driver_probe_device+0x48/0x110
[   18.755421]  __device_attach_driver+0xa8/0xd0
[   18.759900]  bus_for_each_drv+0x90/0xdc
[   18.763843]  __device_attach+0xfc/0x174
[   18.767786]  device_initial_probe+0x20/0x2c
[   18.772090]  bus_probe_device+0x40/0xa0
[   18.776032]  deferred_probe_work_func+0x94/0xd0
[   18.780686]  process_one_work+0x190/0x3d0
[   18.784805]  worker_thread+0x280/0x3d4
[   18.788659]  kthread+0x104/0x1c0
[   18.791981]  ret_from_fork+0x10/0x20
[   18.795654] Code: f9400408 aa0003f3 aa1f03f4 91142015 (f9402516)
[   18.801913] ---[ end trace 0000000000000000 ]---
[   18.809039] Kernel panic - not syncing: Oops: Fatal exception

Fixes: 17e822f7591f ("drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}")
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/515605/
Link: https://lore.kernel.org/r/20221221203925.v2.1.Ib978de92c4bd000b515486aad72e96c2481f84d0@changeid
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -907,13 +907,13 @@ int adreno_gpu_init(struct drm_device *d
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
 	struct msm_gpu *gpu = &adreno_gpu->base;
-	struct msm_drm_private *priv = gpu->dev->dev_private;
+	struct msm_drm_private *priv = gpu->dev ? gpu->dev->dev_private : NULL;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
-	if (pm_runtime_enabled(&priv->gpu_pdev->dev))
+	if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
 		pm_runtime_disable(&priv->gpu_pdev->dev);
 
 	icc_put(gpu->icc_path);


