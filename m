Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6081703972
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbjEORmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244445AbjEORmN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DA1436F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F33E762E24
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFA9C433EF;
        Mon, 15 May 2023 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172387;
        bh=tMvaJayk0pDyZE6NfK/mC365QWqIusj13MEH/ewxCKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1M33+LnPwHGXOjUA8i0OgOjeXCadBNvmOD9vhJ7G0FVVDqYwV46Ht/tD1gl+ZseX
         BIgINDULwZ7CIh7Qij6hyDvPz/UwgxWqFb/DoOm/w9qQ013iosFgfdubYdiLrRGEqA
         rRFvohfosBVB1qJaHYXamjqZmSMUai8Pw9AbS+BE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/381] drm: msm: adreno: Disable preemption on Adreno 510
Date:   Mon, 15 May 2023 18:25:49 +0200
Message-Id: <20230515161741.237101320@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Adam Skladowski <a39.skl@gmail.com>

[ Upstream commit 010c8bbad2cb8c33c47963e29f051f1e917e45a5 ]

Downstream driver appears to not support preemption on A510 target,
trying to use one make device slow and fill log with rings related errors.
Set num_rings to 1 to disable preemption.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: e20c9284c8f2 ("drm/msm/adreno: Add support for Adreno 510 GPU")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/526898/
Link: https://lore.kernel.org/r/20230314221757.13096-1-a39.skl@gmail.com
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 6f84db97e20e8..0fcba2bc26b8e 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1569,6 +1569,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
+	unsigned int nr_rings;
 	int ret;
 
 	if (!pdev) {
@@ -1589,7 +1590,12 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	check_speed_bin(&pdev->dev);
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 4);
+	nr_rings = 4;
+
+	if (adreno_is_a510(adreno_gpu))
+		nr_rings = 1;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
 		return ERR_PTR(ret);
-- 
2.39.2



