Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9075538E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGPUUT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGPUUS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B190
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B292F60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8402C433C8;
        Sun, 16 Jul 2023 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538817;
        bh=Edsc25BMcaWS01hYPIuOaKiT/RzDr54mTOc+Cwt3HIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc7BECvb9h6KiotSWoOBcPPFcjN4s71PPolTP6fhiiCOns29+l/Z+0gHnwik8Eyo8
         cwEj3r+z5BpIfFQhEAo1KesUW9uXdezyfQCfuwukcoRrgKazO/b06TohBIse4xyu6V
         ixbCTJjyndLnQmxFgH95kRRAkuj/6lrnsd+uwLKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 586/800] soundwire: qcom: fix unbalanced pm_runtime_put()
Date:   Sun, 16 Jul 2023 21:47:19 +0200
Message-ID: <20230716195002.710635729@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 9f9914b178a7935d2d94ee3e1bf55f2b42b18528 ]

This reverts commit 57ed510b0547 ("soundwire: qcom: use
pm_runtime_resume_and_get()") which introduced unbalanced
pm_runtime_put(), when device did not have runtime PM enabled.

If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
execution and finally called pm_runtime_put_autosuspend().  Since
pm_runtime_resume_and_get() drops the usage counter on every error, this
lead to double decrement of that counter visible in certain debugfs
actions on unattached devices (still in reset state):

  $ cat /sys/kernel/debug/soundwire/master-0-0/sdw:0:0217:f001:00:0/registers
  qcom-soundwire 3210000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
  soundwire sdw-master-0: trf on Slave 1 failed:-5 read addr e36 count 1
  soundwire sdw:0:0217:f001:00:0: Runtime PM usage count underflow!

Fixes: 57ed510b0547 ("soundwire: qcom: use pm_runtime_resume_and_get()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230517163750.997629-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/qcom.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7c75c6e3fab54..bd39e78788590 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -535,11 +535,12 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
 	struct qcom_swrm_ctrl *ctrl = dev_id;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(ctrl->dev);
+	ret = pm_runtime_get_sync(ctrl->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(ctrl->dev,
-				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
+		pm_runtime_put_noidle(ctrl->dev);
 		return ret;
 	}
 
@@ -1090,11 +1091,12 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
-	ret = pm_runtime_resume_and_get(ctrl->dev);
+	ret = pm_runtime_get_sync(ctrl->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(ctrl->dev,
-				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
+		pm_runtime_put_noidle(ctrl->dev);
 		return ret;
 	}
 
@@ -1295,11 +1297,12 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
 	struct qcom_swrm_ctrl *ctrl = s_file->private;
 	int reg, reg_val, ret;
 
-	ret = pm_runtime_resume_and_get(ctrl->dev);
+	ret = pm_runtime_get_sync(ctrl->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(ctrl->dev,
-				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
 				    __func__, ret);
+		pm_runtime_put_noidle(ctrl->dev);
 		return ret;
 	}
 
-- 
2.39.2



