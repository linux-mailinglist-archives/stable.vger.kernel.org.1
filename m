Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD147036A1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbjEORMI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbjEORLj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E161B6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2835D6230D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF3AC433EF;
        Mon, 15 May 2023 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170598;
        bh=x7DtbXgcXKV0svX2OgWksTLM2v19PVrF1W+u/MOrAPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAVkhxG6j8z4TkIB8O673wcy6l7DwBahPSQbX8HC9rq5bkuoQU8Bg8ffgxgTHXEZF
         iFKEAaCipKxlR3T08VjSk+3XxDzkDXmr1t4dnP6Wi+j7gelPILVm2tSkFKtlTa16W/
         2/lp8sJjZ3JcK0smFn8xQtDNxRuNBZwnf/gUpKxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6.1 152/239] drm/msm: fix drm device leak on bind errors
Date:   Mon, 15 May 2023 18:26:55 +0200
Message-Id: <20230515161726.241374406@linuxfoundation.org>
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
@@ -446,12 +446,12 @@ static int msm_drm_init(struct device *d
 
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
 
@@ -546,6 +546,12 @@ static int msm_drm_init(struct device *d
 
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
 


