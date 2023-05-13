Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA57014B2
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 08:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEMGoJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEMGoI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 02:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF92D48
        for <stable@vger.kernel.org>; Fri, 12 May 2023 23:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0297B60A36
        for <stable@vger.kernel.org>; Sat, 13 May 2023 06:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C4C433EF;
        Sat, 13 May 2023 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683960246;
        bh=nl+7aoJciw7cM83WOna6ekslKL5ubDRKwTq58qZ5GLc=;
        h=Subject:To:Cc:From:Date:From;
        b=ZVWoeLsksaSnNJA7IZeXhTvaQ7FxRpJH1ojsWzgk4DzLpRYdSCRy7xlsqWjiAbGBI
         j4AEHpx6qhfPW51ssa57/z1na/n+Aet2iFbQlQKK5lLfKW+Q31Gf9EUQLoO50sIF1C
         wZjlOYg9MdZpcYBFUKgKmt9hUcLkqIC+NaRu6O6E=
Subject: FAILED: patch "[PATCH] drm/msm: fix missing wq allocation error handling" failed to apply to 6.1-stable tree
To:     johan+linaro@kernel.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 15:43:56 +0900
Message-ID: <2023051356-rupture-negate-a5c5@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ca090c837b430752038b24e56dd182010d77f6f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051356-rupture-negate-a5c5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ca090c837b43 ("drm/msm: fix missing wq allocation error handling")
dfa70344d1b5 ("Revert "drm/msm: Add missing check and destroy for alloc_ordered_workqueue"")
643b7d0869cc ("drm/msm: Add missing check and destroy for alloc_ordered_workqueue")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca090c837b430752038b24e56dd182010d77f6f6 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 6 Mar 2023 11:07:19 +0100
Subject: [PATCH] drm/msm: fix missing wq allocation error handling

Add the missing sanity check to handle workqueue allocation failures.

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
Cc: stable@vger.kernel.org      # 3.12
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525102/
Link: https://lore.kernel.org/r/20230306100722.28485-8-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 4d85ca0ba0c1..2a9a363afe50 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -433,6 +433,10 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	priv->dev = ddev;
 
 	priv->wq = alloc_ordered_workqueue("msm", 0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
 
 	INIT_LIST_HEAD(&priv->objects);
 	mutex_init(&priv->obj_lock);

