Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28D79BCC7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbjIKVhD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbjIKOpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A358CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D680AC433C7;
        Mon, 11 Sep 2023 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443537;
        bh=CiI9TDewDjXMQ4njX4E9k++SCJ+WNde0c9EHxM50NRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/pUt5QByxoPdY8ylqXI6+Aiy0/KoX3aFXtUw9XzA/+tHcba5h77C8yHPM69wPhHL
         vNRiTUcb+IY1er+qLnLcJrYTbesqNMnfqe40fnplBGNi4ntInzWlKIig4RMn07k3Wt
         7da5SmXDmAWcy8CVvf0T7l4N4ydIgBNs2mMsnYpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 412/737] dt-bindings: clock: qcom,gcc-sc8280xp: Add missing GDSCs
Date:   Mon, 11 Sep 2023 15:44:31 +0200
Message-ID: <20230911134702.127768894@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 9eba4db02a88e7a810aabd70f7a6960f184f391f ]

There are 10 more GDSCs that we've not been caring about, and by extension
(and perhaps even more importantly), not putting to sleep. Add them.

Fixes: a66a82f2a55e ("dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20230620-topic-sc8280_gccgdsc-v2-2-562c1428c10d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
index 721105ea4fad8..8454915917849 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
@@ -494,5 +494,15 @@
 #define USB30_SEC_GDSC					11
 #define EMAC_0_GDSC					12
 #define EMAC_1_GDSC					13
+#define USB4_1_GDSC					14
+#define USB4_GDSC					15
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC		16
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC		17
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC		18
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF1_GDSC		19
+#define HLOS1_VOTE_TURING_MMU_TBU0_GDSC			20
+#define HLOS1_VOTE_TURING_MMU_TBU1_GDSC			21
+#define HLOS1_VOTE_TURING_MMU_TBU2_GDSC			22
+#define HLOS1_VOTE_TURING_MMU_TBU3_GDSC			23
 
 #endif
-- 
2.40.1



