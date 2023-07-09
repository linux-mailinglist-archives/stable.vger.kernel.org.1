Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823E74C354
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjGILbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjGILbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37AC19A
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714B160BA4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B6C433C8;
        Sun,  9 Jul 2023 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902257;
        bh=ZIVyV963u3kn0Im2/rkRyvuBkOpSwj+nLqynglcwuv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rInNBZzNC/nvyjzj0pzGn1e0F7OGb1nN9xOy81Qpj8TEz9HvcXH+8vCYRyQIIegxx
         ZWdE6ZOAWKBl8Gti+y8kR8rOcADNhuSzGw33zte0JG7d3gwdvGO/m/oPRVAM4NromR
         vUb5kQmevv+1QpYRW2sSqZU9tKKnKr4+5gWp7/8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 312/431] drm/msm/dp: Free resources after unregistering them
Date:   Sun,  9 Jul 2023 13:14:20 +0200
Message-ID: <20230709111458.478290053@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit fa0048a4b1fa7a50c8b0e514f5b428abdf69a6f8 ]

The DP component's unbind operation walks through the submodules to
unregister and clean things up. But if the unbind happens because the DP
controller itself is being removed, all the memory for those submodules
has just been freed.

Change the order of these operations to avoid the many use-after-free
that otherwise happens in this code path.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/542166/
Link: https://lore.kernel.org/r/20230612220259.1884381-1-quic_bjorande@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 97776f5e12524..22967cf6a79d3 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1354,9 +1354,9 @@ static int dp_display_remove(struct platform_device *pdev)
 {
 	struct dp_display_private *dp = dev_get_dp_display_private(&pdev->dev);
 
+	component_del(&pdev->dev, &dp_display_comp_ops);
 	dp_display_deinit_sub_modules(dp);
 
-	component_del(&pdev->dev, &dp_display_comp_ops);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.39.2



