Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1B7614A5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjGYLVX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjGYLVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0413B6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E55C6167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC23C433C9;
        Tue, 25 Jul 2023 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284079;
        bh=5w/SXJvSSN0lvDF8NdC5CubC4dBvV/ZW1pOyj+a4LPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVE064PNML7dJkFc97nMnnPg1I89WaZJCIWT7ECHYccjzISW8g/Kh0AWNNx1Kp5EE
         GfQ7yl0Y6zukrAfc2alP4lM/ypTzJhwbrx5D/+h7qgNnJtkxP+ScEwVXWSm7gasvVr
         uX15v9vqOaD9KK2ViJjUrRClP3xk3jqqwvfCijvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 228/509] clk: qcom: ipq6018: fix networking resets
Date:   Tue, 25 Jul 2023 12:42:47 +0200
Message-ID: <20230725104604.208490209@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

[ Upstream commit 349b5bed539b491b7894a5186a895751fd8ba6c7 ]

Networking resets in IPQ6018 all use bitmask as they require multiple
bits to be set and cleared instead of a single bit.

So, current networking resets have the same register and bit 0 set which
is clearly incorrect.

Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230526190855.2941291-2-robimarko@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq6018.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 5c5d1b04ea7af..cde62a11f5736 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -4517,24 +4517,24 @@ static const struct qcom_reset_map gcc_ipq6018_resets[] = {
 	[GCC_PCIE0_AHB_ARES] = { 0x75040, 5 },
 	[GCC_PCIE0_AXI_MASTER_STICKY_ARES] = { 0x75040, 6 },
 	[GCC_PCIE0_AXI_SLAVE_STICKY_ARES] = { 0x75040, 7 },
-	[GCC_PPE_FULL_RESET] = { 0x68014, 0 },
-	[GCC_UNIPHY0_SOFT_RESET] = { 0x56004, 0 },
+	[GCC_PPE_FULL_RESET] = { .reg = 0x68014, .bitmask = 0xf0000 },
+	[GCC_UNIPHY0_SOFT_RESET] = { .reg = 0x56004, .bitmask = 0x3ff2 },
 	[GCC_UNIPHY0_XPCS_RESET] = { 0x56004, 2 },
-	[GCC_UNIPHY1_SOFT_RESET] = { 0x56104, 0 },
+	[GCC_UNIPHY1_SOFT_RESET] = { .reg = 0x56104, .bitmask = 0x32 },
 	[GCC_UNIPHY1_XPCS_RESET] = { 0x56104, 2 },
-	[GCC_EDMA_HW_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT1_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT2_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT3_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT4_RESET] = { 0x68014, 0 },
-	[GCC_NSSPORT5_RESET] = { 0x68014, 0 },
-	[GCC_UNIPHY0_PORT1_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT2_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT3_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT4_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT5_ARES] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT_4_5_RESET] = { 0x56004, 0 },
-	[GCC_UNIPHY0_PORT_4_RESET] = { 0x56004, 0 },
+	[GCC_EDMA_HW_RESET] = { .reg = 0x68014, .bitmask = 0x300000 },
+	[GCC_NSSPORT1_RESET] = { .reg = 0x68014, .bitmask = 0x1000003 },
+	[GCC_NSSPORT2_RESET] = { .reg = 0x68014, .bitmask = 0x200000c },
+	[GCC_NSSPORT3_RESET] = { .reg = 0x68014, .bitmask = 0x4000030 },
+	[GCC_NSSPORT4_RESET] = { .reg = 0x68014, .bitmask = 0x8000300 },
+	[GCC_NSSPORT5_RESET] = { .reg = 0x68014, .bitmask = 0x10000c00 },
+	[GCC_UNIPHY0_PORT1_ARES] = { .reg = 0x56004, .bitmask = 0x30 },
+	[GCC_UNIPHY0_PORT2_ARES] = { .reg = 0x56004, .bitmask = 0xc0 },
+	[GCC_UNIPHY0_PORT3_ARES] = { .reg = 0x56004, .bitmask = 0x300 },
+	[GCC_UNIPHY0_PORT4_ARES] = { .reg = 0x56004, .bitmask = 0xc00 },
+	[GCC_UNIPHY0_PORT5_ARES] = { .reg = 0x56004, .bitmask = 0x3000 },
+	[GCC_UNIPHY0_PORT_4_5_RESET] = { .reg = 0x56004, .bitmask = 0x3c02 },
+	[GCC_UNIPHY0_PORT_4_RESET] = { .reg = 0x56004, .bitmask = 0xc02 },
 	[GCC_LPASS_BCR] = {0x1F000, 0},
 	[GCC_UBI32_TBU_BCR] = {0x65000, 0},
 	[GCC_LPASS_TBU_BCR] = {0x6C000, 0},
-- 
2.39.2



