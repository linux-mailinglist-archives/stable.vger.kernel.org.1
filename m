Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4F79B398
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbjIKUzS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbjIKOR6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:17:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:17:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA76C433C8;
        Mon, 11 Sep 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441874;
        bh=wo0BIkG5fh4GzTAWVzu6CELk9lbezNlEgH8k6mGTx2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8jqx3eThwoVQtsAgPdbURkw2+Um3qHTzcAsv50poXQgA3Tvze/ZhJ+rXwhyST8qn
         uzmHfTrqAWSFkOwaKEZSpl4STq6OfsGX5EXXz/LXCFr+RRmSwhDMDRQfFzWiIiqyKW
         cPytmWMS9i7q+jUUHZ1m1bKWwF1y0Bcon+rGca7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 567/739] interconnect: qcom: sm8450: Enable sync_state
Date:   Mon, 11 Sep 2023 15:46:06 +0200
Message-ID: <20230911134706.912097393@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 16862f1b2110eca6330e5be6d804e1a08e06a202 ]

Enable sync_state on sm8450 so that the interconnect votes actually mean
anything and aren't just pinned to INT_MAX.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20230811-topic-8450_syncstate-v1-1-69ae5552a18b@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sm8450.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index e64c214b40209..d6e582a02e628 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1886,6 +1886,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.40.1



