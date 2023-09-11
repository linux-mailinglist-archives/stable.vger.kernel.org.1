Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F479AE60
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353821AbjIKVuq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjIKOrG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ADA125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:47:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE6C433C9;
        Mon, 11 Sep 2023 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443622;
        bh=X2HFYFZBr6hfqjYuk6ZkDGk54TTCmhJNMtBKulp82DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBuBQNbUMxRh5lqbLQdZEvut5RNVlf4VeP5OlEEy53q/n9izpf+xdFhUfDIbhqo4G
         gN+MBZSemqoAb7zJELVZFbphQ/+B4CCwmSafJGJjrZuOhg/jVlklb9IFbAa4BXVorZ
         KXprPRMMIPmxfOL4QRCyQYbrO/FrYX6iJQFKMfVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imran Shaik <quic_imrashai@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 442/737] dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Mon, 11 Sep 2023 15:45:01 +0200
Message-ID: <20230911134702.944900721@linuxfoundation.org>
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

From: Imran Shaik <quic_imrashai@quicinc.com>

[ Upstream commit df873243b2398a082d34a006bebe0e0ed7538f5c ]

Add support for GCC_GPLL1_OUT_EVEN and GCC_DDRSS_ECPRI_GSI_CLK clock
bindings for QDU1000 and QRU1000 SoCs. While at it, update the
maintainers list.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230803105741.2292309-2-quic_imrashai@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 06d71fa10f2e ("clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
 include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
index 767a9d03aa327..d712b1a87e25f 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
 
 maintainers:
-  - Melody Olvera <quic_molvera@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Imran Shaik <quic_imrashai@quicinc.com>
 
 description: |
   Qualcomm global clock control module which supports the clocks, resets and
diff --git a/include/dt-bindings/clock/qcom,qdu1000-gcc.h b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
index ddbc6b825e80c..2fd36cbfddbb2 100644
--- a/include/dt-bindings/clock/qcom,qdu1000-gcc.h
+++ b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
 /*
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
@@ -138,6 +138,8 @@
 #define GCC_AGGRE_NOC_ECPRI_GSI_CLK			128
 #define GCC_PCIE_0_PIPE_CLK_SRC				129
 #define GCC_PCIE_0_PHY_AUX_CLK_SRC			130
+#define GCC_GPLL1_OUT_EVEN				131
+#define GCC_DDRSS_ECPRI_GSI_CLK				132
 
 /* GCC resets */
 #define GCC_ECPRI_CC_BCR				0
-- 
2.40.1



