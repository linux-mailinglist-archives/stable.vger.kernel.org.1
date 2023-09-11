Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00DC79C0AE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjIKVMC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbjIKPV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A0CC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DD0C433C7;
        Mon, 11 Sep 2023 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445682;
        bh=DqIqwfHTUuY+lMgxjQs4vaMEGH/P0hy4TfiI/eDVdo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVmoRbW5EMFDhnW2vDsG4F+yNgFJLZGzMqhIm2nKRamVpvOibTrHaTWk/4xSR4SPk
         gIWNG430Pd73lMVVFq6qrOuoDWKS0K4buvYbvyGDNSOTofonJeglH7cLYoUVIMRgmH
         c93udOJWoJM1hAmffT12WRjZpb9BakakPthJCDIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 435/600] interconnect: qcom: qcm2290: Enable sync state
Date:   Mon, 11 Sep 2023 15:47:48 +0200
Message-ID: <20230911134646.496191532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 4e048e9b7a160f7112069c0ec2947be15f3e8154 ]

Enable the generic .sync_state callback to ensure there are no
outstanding votes that would waste power.

Generally one would need a bunch of interface clocks to access the QoS
registers when trying to go over all possible nodes during sync_state,
but QCM2290 surprisingly does not seem to require any such handling.

Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230720-topic-qcm2290_icc-v2-2-a2ceb9d3e713@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/qcm2290.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index a29cdb4fac03f..82a2698ad66b1 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1355,6 +1355,7 @@ static struct platform_driver qcm2290_noc_driver = {
 	.driver = {
 		.name = "qnoc-qcm2290",
 		.of_match_table = qcm2290_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qcm2290_noc_driver);
-- 
2.40.1



