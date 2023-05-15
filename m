Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89570703B03
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbjEOR6j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbjEOR6W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52EC1A386
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5D3621EB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF2CC433EF;
        Mon, 15 May 2023 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173293;
        bh=BG3VbXaaP09v2r5gAoMl/EaB3F5K05BetpdD9xNbNyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dj19aXXzM9S98uf4cYmQbB5AaX94HG9iVnsuJHnAU/QDlU+7S/t2+cVd7OOZMlkdk
         l/WR9crYRc+2yO94WDvi6Ys1uKkKOrBkHdd+u/mIhMTgEsmZKOQSScYwf4odAR8GJt
         ImaRcxrnQcQWH6Vq/nLYyY8MNcRUgPtJGZ7JjXQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/282] drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init, cleanup}
Date:   Mon, 15 May 2023 18:27:06 +0200
Message-Id: <20230515161723.699648622@linuxfoundation.org>
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

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 17e822f7591fb66162aca07685dc0b01468e5480 ]

adreno_gpu_init calls pm_runtime_enable, so adreno_gpu_cleanup needs to
call pm_runtime_disable.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: db7662d076c9 ("drm/msm/adreno: drop bogus pm_runtime_set_active()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3802ad38c519c..0d9404d2afe4e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -908,11 +908,14 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct msm_drm_private *priv = gpu->dev->dev_private;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	pm_runtime_disable(&priv->gpu_pdev->dev);
+
 	icc_put(gpu->icc_path);
 
 	msm_gpu_cleanup(&adreno_gpu->base);
-- 
2.39.2



