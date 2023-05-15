Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3D7037E4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbjEORZB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbjEORYh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C611B56
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D6F62BF9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF09BC433D2;
        Mon, 15 May 2023 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171413;
        bh=Pyqsw5IXrPmyOBnapPVlztltsAHgDZ2SFc8qaCQf+fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uv8cSkXVo1MhI9LMWiDP0v9TQlZj2d/LjzXxZLGekhZJJIw7TryII3fe7o0Tsxi/Q
         WenXIOVsc+IxRC2PQ8UwDA3DGBz6tl5i4c3KSeyCn2pnOJsAujx4e1SBMjn0JYIstb
         mKnHpE6332IDEQXckNa5oZmwPYXNvR7hsxTmkAR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 6.2 171/242] drm/msm: fix NULL-deref on snapshot tear down
Date:   Mon, 15 May 2023 18:28:17 +0200
Message-Id: <20230515161727.009032843@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

commit a465353b9250802f87b97123e33a17f51277f0b1 upstream.

In case of early initialisation errors and on platforms that do not use
the DPU controller, the deinitilisation code can be called with the kms
pointer set to NULL.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Cc: stable@vger.kernel.org      # 5.14
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/525099/
Link: https://lore.kernel.org/r/20230306100722.28485-4-johan+linaro@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -241,7 +241,8 @@ static int msm_drm_uninit(struct device
 		msm_fbdev_free(ddev);
 #endif
 
-	msm_disp_snapshot_destroy(ddev);
+	if (kms)
+		msm_disp_snapshot_destroy(ddev);
 
 	drm_mode_config_cleanup(ddev);
 


