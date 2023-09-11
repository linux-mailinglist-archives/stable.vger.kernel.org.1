Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36B79B937
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358210AbjIKWIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbjIKPYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4FBD8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE40C433CD;
        Mon, 11 Sep 2023 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445869;
        bh=fiZwzahtWLV5s9LXsFez11UsJt2aJ85w2vBmX4N3DsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkupRfRjQSulMZSQIaUyPAj9O/68FutxmCGQnyEPLREMACl5DXMFrhK3eZLH6zAH1
         wMwY4mauOgWbk1lbnFgMH20uD218OWjQsq7yaBGd7frQRhzi817L5rcDkJA7TlZmnR
         ZP60TtnGbt/vgC1JKO+ewgtKrHjLS11xYsi76qF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 483/600] interconnect: qcom: sm8450: Enable sync_state
Date:   Mon, 11 Sep 2023 15:48:36 +0200
Message-ID: <20230911134647.900514255@linuxfoundation.org>
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



