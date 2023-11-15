Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395A7ECCD1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjKOTco (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjKOTco (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0788130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEF8C433C7;
        Wed, 15 Nov 2023 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076760;
        bh=dw2FJ0BVn9Id0q1V5EhBJ+K03ibyNCB7WJtGcGwPPPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXI+kfdB6K2oWX7KCqWf4rq84r1DVAxBwirp/Br0oOAskIhCx6Bu5NzDHMK3yxJA9
         A7PRkD3BkpnZvvHZBFGskdZlOu39YMJYzJLr7mWuEA1ItZewRidT11GA2Onra7yoP7
         6/Bhc56hmek7/0jc/o83gUQ14TB/BxQaLxdlzdqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 413/550] interconnect: qcom: sdm670: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:37 -0500
Message-ID: <20231115191629.390159636@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 7b85ea8b9300be5c2818e1f61a274ff2c4c063ee ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 7e438e18874e ("interconnect: qcom: add sdm670 interconnects")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-6-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sdm670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index 0bcf4767b053d..d77ad3d11ba97 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -133,6 +133,7 @@ DEFINE_QNODE(xs_sys_tcu_cfg, SDM670_SLAVE_TCU, 1, 8);
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },
-- 
2.42.0



