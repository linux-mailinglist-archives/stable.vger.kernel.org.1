Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB927CA2D3
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjJPIzR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjJPIzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:55:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7856BEE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:55:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AF9C433C8;
        Mon, 16 Oct 2023 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446515;
        bh=XyAbllP6/O4VNd8ukVd+SGwdH8iz9QMe+Rqk3Ga3nPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVSBj66tPAl3HIN9kCgX6fPOMVsCUdlVOphAvSGA9Onbxbiw12AL77NsmVx0iR1TM
         bILZCQLW0Cu+KTl3TuVv0lP2IthQ9rf9YTFyuSQM6UiQPcCBrTNYVu74dQwUz5RO0M
         q/+ktTrvN9c14v5djWikYwi67tgUzgY47ueXElM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/131] drm/msm/dsi: fix irq_of_parse_and_map() error checking
Date:   Mon, 16 Oct 2023 10:40:19 +0200
Message-ID: <20231016084000.964717459@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 6a1d4c7976dd1ee7c9f80bc8e62801ec7b1f2f58 ]

The irq_of_parse_and_map() function returns zero on error.  It
never returns negative error codes.  Fix the check.

Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/557715/
Link: https://lore.kernel.org/r/4f3c5c98-04f7-43f7-900f-5d7482c83eef@moroto.mountain
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 6c1ebeb9023eb..e20cd3dd2c6cc 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1972,10 +1972,9 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	}
 
 	msm_host->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (msm_host->irq < 0) {
-		ret = msm_host->irq;
-		dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
-		return ret;
+	if (!msm_host->irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -EINVAL;
 	}
 
 	/* do not autoenable, will be enabled later */
-- 
2.40.1



