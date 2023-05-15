Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196CD703538
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbjEOQ45 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbjEOQ44 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4B6A75
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06001629F5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED73AC433D2;
        Mon, 15 May 2023 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169803;
        bh=6CNXxosw1Kz4qW3768C9KcGrQA+Lc0zboJFmkeSd0yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ0RYtQCE8B6qoAU0gchyFx1FefbNU++rmMI2ERd/O7iSxT38xpsJljXqfI6Eb0c5
         8IhDDDCLJk2N8eVTOz2Ffb5rpLXtCUSiOx2r9KETqiYaGq7ZP2IK6KGN2CHekx93Fv
         zWKrW0wYolmJFySuIlEcLvAfv4QkG1qfbD2dJ0jE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.3 175/246] drm/msm: fix workqueue leak on bind errors
Date:   Mon, 15 May 2023 18:26:27 +0200
Message-Id: <20230515161727.882925188@linuxfoundation.org>
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

commit a75b49db6529b2af049eafd938fae888451c3685 upstream.

Make sure to destroy the workqueue also in case of early errors during
bind (e.g. a subcomponent failing to bind).

Since commit c3b790ea07a1 ("drm: Manage drm_mode_config_init with
drmm_") the mode config will be freed when the drm device is released
also when using the legacy interface, but add an explicit cleanup for
consistency and to facilitate backporting.

Fixes: 060530f1ea67 ("drm/msm: use componentised device support")
Cc: stable@vger.kernel.org      # 3.15
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525093/
Link: https://lore.kernel.org/r/20230306100722.28485-9-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -458,7 +458,7 @@ static int msm_drm_init(struct device *d
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		goto err_put_dev;
+		goto err_cleanup_mode_config;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
@@ -563,6 +563,9 @@ err_msm_uninit:
 
 err_deinit_vram:
 	msm_deinit_vram(ddev);
+err_cleanup_mode_config:
+	drm_mode_config_cleanup(ddev);
+	destroy_workqueue(priv->wq);
 err_put_dev:
 	drm_dev_put(ddev);
 


