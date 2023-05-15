Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D67036AD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbjEORMl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbjEORMV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60310A10
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 324D062B5B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B5CC433EF;
        Mon, 15 May 2023 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170629;
        bh=OnBRjEozKjCSrrwX3jTJxJRZbcoyb3RCQBP/QrAzU4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nsk2zmMjqTgZYW6rHsKWq6x1vzFvVATnGLfh9dm1SqFYA/ntMqQ5aeaR2RlZxiH9z
         uf4uwtlAyIcGysDWVZXMh6Kr5fMXEs6ur1W9vPk30wrUzDBuaXeOTARLWri8pWG2po
         4Q52r05lJJnGu7csBFEbBL8Aj6UKyfp4wrP8kbc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 192/239] drm/msm: fix missing wq allocation error handling
Date:   Mon, 15 May 2023 18:27:35 +0200
Message-Id: <20230515161727.497023992@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit ca090c837b430752038b24e56dd182010d77f6f6 ]

Add the missing sanity check to handle workqueue allocation failures.

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
Cc: stable@vger.kernel.org      # 3.12
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525102/
Link: https://lore.kernel.org/r/20230306100722.28485-8-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5eeb4655fbf17..ac3d1d492a48c 100644
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
-- 
2.39.2



