Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AE703535
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbjEOQ4s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243236AbjEOQ4p (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2370D76BF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C5362A0F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2504C433EF;
        Mon, 15 May 2023 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169794;
        bh=Q4464aGlbcxMQSexsH+bryee+2gThdIxH3Vf1J/lEp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCXJRcTTp9txox4g74EWYPRT6mneNTyMHc174ESIifNMs33ABN0siu6GZaw2T927S
         RsZIPnclIg1CvyYNJI6N1hb+3rKZUyJiJHqTwtOC60CJzHRNwq38FOUYFLPBr+vTa7
         0XY/UOkPvtPnOAF/b86iD4JRehHkcF3MorUYMmK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6.3 172/246] drm/msm: fix drm device leak on bind errors
Date:   Mon, 15 May 2023 18:26:24 +0200
Message-Id: <20230515161727.792562793@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 214b09db61978497df24efcb3959616814bca46b upstream.

Make sure to free the DRM device also in case of early errors during
bind().

Fixes: 2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
Cc: stable@vger.kernel.org      # 5.17
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525097/
Link: https://lore.kernel.org/r/20230306100722.28485-6-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -444,12 +444,12 @@ static int msm_drm_init(struct device *d
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
@@ -544,6 +544,12 @@ static int msm_drm_init(struct device *d
 
 err_msm_uninit:
 	msm_drm_uninit(dev);
+
+	return ret;
+
+err_put_dev:
+	drm_dev_put(ddev);
+
 	return ret;
 }
 


