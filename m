Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F067014BC
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEMGpe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5152D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9567361B3C
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F08C433EF;
        Sat, 13 May 2023 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683960331;
        bh=Gk+vAtuFE3Zx00/C/eVRpVW/UnKihBvv+djlax6qYx0=;
        h=Subject:To:Cc:From:Date:From;
        b=0mFYz836qgpmnkU6N23K9e/0QET03zvMqo2HFFoiqQBL/jqVOpKXqQ2GexUcVJN0M
         Z4jCDFolYKzTEQ1Ye6J/gv9XAS2fjLCM0/NS0jCMkjn2RLVIy5usyi0T1izdB+MUud
         mEjL1HVF/DAqh/AqoLlXqpjk5v9KGiXEq6NWFVkI=
Subject: FAILED: patch "[PATCH] drm/msm: fix workqueue leak on bind errors" failed to apply to 4.19-stable tree
To:     johan+linaro@kernel.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:44:36 +0900
Message-ID: <2023051336-breeder-shading-19c6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x a75b49db6529b2af049eafd938fae888451c3685
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051336-breeder-shading-19c6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

a75b49db6529 ("drm/msm: fix workqueue leak on bind errors")
60d476af9601 ("drm/msm: fix vram leak on bind errors")
214b09db6197 ("drm/msm: fix drm device leak on bind errors")
652eadfde810 ("Revert "drm/msm: Fix failure paths in msm_drm_init()"")
8636500300a0 ("drm/msm: Fix failure paths in msm_drm_init()")
2027e5b3413d ("drm/msm: Initialize MDSS irq domain at probe time")
ec919e6e7146 ("drm/msm: Allocate msm_drm_private early and pass it as driver data")
83b965d118cb ("Merge remote-tracking branch 'drm/drm-next' into msm-next-staging")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a75b49db6529b2af049eafd938fae888451c3685 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 6 Mar 2023 11:07:20 +0100
Subject: [PATCH] drm/msm: fix workqueue leak on bind errors

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

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 2a9a363afe50..1d0082ee255c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -459,7 +459,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	ret = msm_init_vram(ddev);
 	if (ret)
-		goto err_put_dev;
+		goto err_cleanup_mode_config;
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
@@ -564,6 +564,9 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 err_deinit_vram:
 	msm_deinit_vram(ddev);
+err_cleanup_mode_config:
+	drm_mode_config_cleanup(ddev);
+	destroy_workqueue(priv->wq);
 err_put_dev:
 	drm_dev_put(ddev);
 

