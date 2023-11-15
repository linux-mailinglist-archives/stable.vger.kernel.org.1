Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20CE7ED3FB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjKOU4I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbjKOU4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C2B0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C0C4E777;
        Wed, 15 Nov 2023 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081765;
        bh=4v9Z5btqAzk9UqNkDCDofsDcQoNfKP7XzognErNt04w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKB6gP7MCP1S7v8ubtaBFiv6D6waQCpVHxCNqB12+RTmxIDbCyXgxWB+SGA5iVI9+
         41SrVZQL0lds2SguHxklN7p3CwVC4AOUrDoKj9Eoc6EjQR2LmGv+Shel6p1wU8GP0z
         KStQyspYqz4Ziczaog7VoVIG7AreUUSi57hV7hnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 103/191] ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe
Date:   Wed, 15 Nov 2023 15:46:18 -0500
Message-ID: <20231115204650.760542474@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 9e630efb5a4af56fdb15aa10405f5cfd3f5f5b83 ]

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context. We fix it by calling
pm_runtime_disable when error returns.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_C0D62E6D89818179A02A04A0C248F0DDC40A@qq.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_easrc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 3cf1f40e68924..acd500c3b9d04 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1971,17 +1971,21 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 					      &fsl_easrc_dai, 1);
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_asrc_component,
 					      NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC platform\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int fsl_easrc_remove(struct platform_device *pdev)
-- 
2.42.0



