Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2EA7036A6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbjEORMQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbjEORMA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE7A5B88
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E0746230D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E63BC4339B;
        Mon, 15 May 2023 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170614;
        bh=ZjGJnrsQOBRnvi2od35x2ihN9KRPXfLa2dOw0BLSXYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrVTgJBETFAhwr7YiowXzvcsOJc+Lk6YvkVPvNdfcbw+k9vlaq25eYHgRgtaExI7J
         s584puYxZpDUTczKcarDdI7m6fof4Q4f1j73flf0Sz+ncWi0yeeghyVYOqRl2gkAdR
         1F51nrW4DRR426DqcrBmhLDAbABz/Lhtq0le9l08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 179/239] drm/amd: Use `amdgpu_ucode_*` helpers for MES
Date:   Mon, 15 May 2023 18:27:22 +0200
Message-Id: <20230515161727.037220396@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 11e0b0067ec0707e8e598a5f9a547ab618ae7982 upstream.

The `amdgpu_ucode_request` helper will ensure that the return code for
missing firmware is -ENODEV so that early_init can fail.

The `amdgpu_ucode_release` helper provides symmetry for releasing firmware.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   10 ++--------
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  |   10 +---------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |   10 +---------
 3 files changed, 4 insertions(+), 26 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1438,11 +1438,7 @@ int amdgpu_mes_init_microcode(struct amd
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
 		ucode_prefix,
 		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
-	r = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
-	if (r)
-		goto out;
-
-	r = amdgpu_ucode_validate(adev->mes.fw[pipe]);
+	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
 	if (r)
 		goto out;
 
@@ -1482,9 +1478,7 @@ int amdgpu_mes_init_microcode(struct amd
 	}
 
 	return 0;
-
 out:
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
+	amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	return r;
 }
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -375,13 +375,6 @@ static const struct amdgpu_mes_funcs mes
 	.resume_gang = mes_v10_1_resume_gang,
 };
 
-static void mes_v10_1_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v10_1_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -975,8 +968,7 @@ static int mes_v10_1_sw_fini(void *handl
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v10_1_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -453,13 +453,6 @@ static const struct amdgpu_mes_funcs mes
 	.misc_op = mes_v11_0_misc_op,
 };
 
-static void mes_v11_0_free_microcode(struct amdgpu_device *adev,
-				     enum admgpu_mes_pipe pipe)
-{
-	release_firmware(adev->mes.fw[pipe]);
-	adev->mes.fw[pipe] = NULL;
-}
-
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
 					   enum admgpu_mes_pipe pipe)
 {
@@ -1063,8 +1056,7 @@ static int mes_v11_0_sw_fini(void *handl
 		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
-
-		mes_v11_0_free_microcode(adev, pipe);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
 	}
 
 	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,


