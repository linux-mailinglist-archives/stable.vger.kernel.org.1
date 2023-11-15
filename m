Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4B7ECF5D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjKOTsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjKOTsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776912C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79BAC433C9;
        Wed, 15 Nov 2023 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077683;
        bh=w3m7b+vgfQqmUbNkM0eAeXLqK07lahDInis2FHzs56w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMvsibijr07Cl0Ej4Akj+pL5VMWPV+46r6CN3NFLUeOdy5jYxHeQk+nmnTwTEgKhA
         iKmW0moPL2JC8jHf0+kxP5+hbUZHVf/TszWOdo1ToyMTVkHtMYBDx80dqcKKhvq5w8
         LYJ2rX/s7hhmw4QnuOFdviquxyf8JwnsTn5NF6jI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 454/603] interconnect: qcom: sm6350: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:39 -0500
Message-ID: <20231115191644.088055335@linuxfoundation.org>
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

[ Upstream commit fe7a3abf4111992af3de51d22383a8e8a0affe1e ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 6a6eff73a954 ("interconnect: qcom: Add SM6350 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-8-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sm6350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 49aed492e9b80..f41d7e19ba269 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1164,6 +1164,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },
-- 
2.42.0



