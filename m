Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EB7ECF60
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjKOTsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjKOTsC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2BAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69C7C433CA;
        Wed, 15 Nov 2023 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077679;
        bh=58oIcx8tvylvRYqpFGUSVxlcTdXMnJfkt9I3hvH5Trc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5Pc8GBAzZHMQDJeflBMV7aFCV9+C6/m6nBe7DP3Gw30nfOaMkWAV7LhFSo7DWnNW
         oxEUC5+PgEV+nAHEt4p5W4Q8sGOku2Jp0gM5A5At+6pu3Z8aSM/YgjA62+f/UmAzeD
         v4sqZDSkEbD9mwV5G73RlKcHujmRKYFutgqfy6M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 451/603] interconnect: qcom: sc8280xp: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:36 -0500
Message-ID: <20231115191643.910704694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 688ffb3dcf85fc4b7ea82af842493013747a9e2c ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: f29dabda7917 ("interconnect: qcom: Add SC8280XP interconnect provider")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-5-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index b82c5493cbb56..0270f6c64481a 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -1712,6 +1712,7 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
-- 
2.42.0



