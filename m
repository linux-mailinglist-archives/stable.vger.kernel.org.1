Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447E16FABFD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjEHLTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjEHLTf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE6387C3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1F662C5B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D19C433D2;
        Mon,  8 May 2023 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544768;
        bh=UWzd+PXQ9vZVbZ35H8xPB+Bn2ZnPmIq5lDFlLZQZ1XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWnewiA/Kc4ggfGs6NTKh9Rlp5U4AbUAf9mdn5ldhPAmofi2t2EjMYw+Udp1utEov
         +x5yJyzbTlBkQSbUkzyznewMWhU4rZo5d/i57HMc3U16fb6crBnViUAteuoVJ6gLTA
         k8N6WuVHuaKfbTYQv+aljzTdRLnBYaprA3K/h8ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 510/694] interconnect: qcom: rpm: drop bogus pm domain attach
Date:   Mon,  8 May 2023 11:45:45 +0200
Message-Id: <20230508094450.708412091@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit 72b2720c18ecde92e6a36c4ac897dd5848e3f379 ]

Any power domain would already have been attached by the platform bus
code so drop the bogus power domain attach which always succeeds from
probe.

This effectively reverts commit 7de109c0abe9 ("interconnect: icc-rpm:
Add support for bus power domain").

Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
Cc: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # MSM8996 Sony Kagura
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230313084953.24088-3-johan+linaro@kernel.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 7 -------
 drivers/interconnect/qcom/icc-rpm.h | 1 -
 drivers/interconnect/qcom/msm8996.c | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 4180a06681b2b..c80819557923e 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -11,7 +11,6 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -496,12 +495,6 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (desc->has_bus_pd) {
-		ret = dev_pm_domain_attach(dev, true);
-		if (ret)
-			return ret;
-	}
-
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index a49af844ab13e..02257b0d3d5c6 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -91,7 +91,6 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	const char * const *clocks;
 	size_t num_clocks;
-	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 25a1a32bc611f..14efd2761b7ab 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1823,7 +1823,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.clocks = bus_a0noc_clocks,
 	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
-	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
-- 
2.39.2



