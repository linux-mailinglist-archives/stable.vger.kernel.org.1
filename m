Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0147C7ECF75
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjKOTsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjKOTsf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE3AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D4DC433C8;
        Wed, 15 Nov 2023 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077711;
        bh=Jhd0M8XmUxOCC93A+4B82PXZhddgCKQZ6OOiiFPBU/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVf1RYOKTR1rnt2qzw5ERNV2utqrG7JsYeei7Fz6La4Aswofgo74xBHtYRiHKHDYj
         gqWVZfazX2dl2Nr5bifnkq/qA4A2w344bGjoSwCOnDt/4Lt0BQ9lZIyPEk0s8H16eP
         tUWCj4Fb3vDnfLcl1r7FhLgpXbZm1vm72y6+K70c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 450/603] interconnect: qcom: sc8180x: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:35 -0500
Message-ID: <20231115191643.849664937@linuxfoundation.org>
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

[ Upstream commit 0fcaaed3ff4b99e5b688b799f48989f1e4bb8a8b ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 9c8c6bac1ae8 ("interconnect: qcom: Add SC8180x providers")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-4-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sc8180x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 0fb4898dabcfe..bdd3471d4ac89 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1345,6 +1345,7 @@ static struct qcom_icc_node slv_qup_core_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };
-- 
2.42.0



