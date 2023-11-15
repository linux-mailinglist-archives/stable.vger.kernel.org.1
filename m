Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CB7ED11F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjKOT7k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344035AbjKOT7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312BAF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ED5C433C8;
        Wed, 15 Nov 2023 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078376;
        bh=xjqM1xt+b74XgBWuuEXs23BTmo6GF8MIiEk6qCwphX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjheWthgvAIq9hupzz0HB1i1eIwH4TdvZGWEoWSfqMgl6gsO57Kp3Rujp4ey5hvFG
         drqkUvkzIPpwXR+ll7tEsPFzkeGwb7rJsKwBpsbGoGuURO3v17ny2kU3szV6jzDt5i
         cnsM37oIf9+ENULOR8HqkCsFmElUyAGrtbraT3pM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 286/379] interconnect: move ignore_list out of of_count_icc_providers()
Date:   Wed, 15 Nov 2023 14:26:01 -0500
Message-ID: <20231115192702.057406362@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 88387e21d224923eaa0074e3eef699a30f437e62 ]

Move the const ignore_list definition out of the
of_count_icc_providers() function. This prevents the following stack
frame size warnings if the list is expanded:

drivers/interconnect/core.c:1082:12: warning: stack frame size (1216) exceeds limit (1024) in 'of_count_icc_providers' [-Wframe-larger-than]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230109002935.244320-4-dmitry.baryshkov@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Stable-dep-of: 7ed42176406e ("interconnect: qcom: sm8150: Set ACV enable_mask")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e4b2d9ef61b4d..e970ee0fcb0a3 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1100,15 +1100,16 @@ void icc_provider_del(struct icc_provider *provider)
 }
 EXPORT_SYMBOL_GPL(icc_provider_del);
 
+static const struct of_device_id __maybe_unused ignore_list[] = {
+	{ .compatible = "qcom,sc7180-ipa-virt" },
+	{ .compatible = "qcom,sdx55-ipa-virt" },
+	{}
+};
+
 static int of_count_icc_providers(struct device_node *np)
 {
 	struct device_node *child;
 	int count = 0;
-	const struct of_device_id __maybe_unused ignore_list[] = {
-		{ .compatible = "qcom,sc7180-ipa-virt" },
-		{ .compatible = "qcom,sdx55-ipa-virt" },
-		{}
-	};
 
 	for_each_available_child_of_node(np, child) {
 		if (of_property_read_bool(child, "#interconnect-cells") &&
-- 
2.42.0



