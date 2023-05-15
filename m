Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129A703534
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbjEOQ4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjEOQ4n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E67A89
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEB0629F5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A32C433D2;
        Mon, 15 May 2023 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169791;
        bh=kByVfQsR3gc9vFtXkrrCGyPvm2MWRKjpmXQ8aDrV2Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKuHanMPKTHkOBFzbXpLT5jojWkb9ButgAmbmpCQBaLmnCkzTIJHLZPSH+Bz69G7H
         W24O1NogbQeEgyjawNnnSp1K97g6Zc4JSMim70OJ68VGql+VT11Z2/5XqiyoFQF84P
         9S9j5SNbwaBwGG4Ct6e2PB4xbrXANqNOl332aYMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.3 171/246] drm/msm: fix NULL-deref on irq uninstall
Date:   Mon, 15 May 2023 18:26:23 +0200
Message-Id: <20230515161727.762249569@linuxfoundation.org>
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

commit cd459c005de3e2b855a8cc7768e633ce9d018e9f upstream.

In case of early initialisation errors and on platforms that do not use
the DPU controller, the deinitilisation code can be called with the kms
pointer set to NULL.

Fixes: f026e431cf86 ("drm/msm: Convert to Linux IRQ interfaces")
Cc: stable@vger.kernel.org	# 5.14
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525104/
Link: https://lore.kernel.org/r/20230306100722.28485-5-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -251,9 +251,11 @@ static int msm_drm_uninit(struct device
 		drm_bridge_remove(priv->bridges[i]);
 	priv->num_bridges = 0;
 
-	pm_runtime_get_sync(dev);
-	msm_irq_uninstall(ddev);
-	pm_runtime_put_sync(dev);
+	if (kms) {
+		pm_runtime_get_sync(dev);
+		msm_irq_uninstall(ddev);
+		pm_runtime_put_sync(dev);
+	}
 
 	if (kms && kms->funcs)
 		kms->funcs->destroy(kms);


