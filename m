Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34B17037DC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbjEORYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbjEORY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3525DDA5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7944A60B9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A39C433EF;
        Mon, 15 May 2023 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171394;
        bh=Ju7e178sOtBRAO2y1aDdKAo7sOcEGoyUpMVi8dpuPXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQRC4xHPRDKF/aHBu0rYPrppGg8TVRHfT0EJ+aQ9yg7PbbONrk54WTn6LC220AM97
         3HocoVbsqt9YGyhh0a2Qn4tUePyBfvtZqSPUn73TLbgC5D8reGb2vCDVsF1BVN+pIx
         sretnD+VS60Hpzk/Y9RAww3GYgSt/h8RRXCE/h9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 195/242] drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras
Date:   Mon, 15 May 2023 18:28:41 +0200
Message-Id: <20230515161727.797026033@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

commit 4a76680311330aefe5074bed8f06afa354b85c48 upstream.

gfx9 cp_ecc_error_irq is only enabled when legacy gfx ras is assert.
So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq
should be executed under such condition, otherwise, an amdgpu_irq_put
calltrace will occur.

[ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.170964] RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246
[ 7283.170967] RAX: ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000
[ 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI: ffff98d89da20000
[ 7283.170971] RBP: ffff98d89da20000 R08: ffff98d89da2ca18 R09: 0000000000000006
[ 7283.170973] R10: ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050
[ 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.170978] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.170981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.170983] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.170986] Call Trace:
[ 7283.170988]  <TASK>
[ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu]
[ 7283.171655]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.172245]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.172823]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.173412]  pci_pm_freeze+0x54/0xc0
[ 7283.173419]  ? __pfx_pci_pm_freeze+0x10/0x10
[ 7283.173425]  dpm_run_callback+0x98/0x200
[ 7283.173430]  __device_suspend+0x164/0x5f0

v2: drop gfx11 as it's fixed in a different solution by retiring cp_ecc_irq funcs(Hawking)

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3845,7 +3845,8 @@ static int gfx_v9_0_hw_fini(void *handle
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 


