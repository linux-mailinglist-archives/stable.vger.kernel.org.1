Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38D079B865
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbjIKWYb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjIKOMM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:12:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1DCE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:12:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F49C433C9;
        Mon, 11 Sep 2023 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441527;
        bh=RNTRAJ+oO9ZwMceK7tD6sQD6re5V2d8HREPn+uMCRb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdPl0v1Ly+ElKV6ENHNTKFKHnNf2blsFNduWDJjc7c+ZdaTk3Pw/UhXBuxaCodvQp
         4bXQQBZkHmSp1JxhXg8xsLNfud3ipdLpL4UNPWqbX/Kc95Vbj2c3GiRztppbpKxA6d
         lwLPlsmO7HjzaMaN0v1xS8havwxzwujdoikA+dx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 445/739] clk: qcom: Fix SM_GPUCC_8450 dependencies
Date:   Mon, 11 Sep 2023 15:44:04 +0200
Message-ID: <20230911134703.594502272@linuxfoundation.org>
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 75d1d3a433f0a0748a89eb074830e9b635a19fd2 ]

CONFIG_SM_GCC_8450 depends on ARM64 but it is selected by
CONFIG_SM_GPUCC_8450, which can be selected on ARM, resulting in a
Kconfig warning.

WARNING: unmet direct dependencies detected for SM_GCC_8450
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
  Selected by [y]:
  - SM_GPUCC_8450 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]

Add the same dependencies to CONFIG_SM_GPUCC_8450 to resolve the
warning.

Fixes: 728692d49edc ("clk: qcom: Add support for SM8450 GPUCC")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230829-fix-sm_gpucc_8550-deps-v1-1-d751f6cd35b2@kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ed7dc3349e34e..92ef5314b59ce 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -987,6 +987,7 @@ config SM_GPUCC_8350
 
 config SM_GPUCC_8450
 	tristate "SM8450 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8450
 	help
 	  Support for the graphics clock controller on SM8450 devices.
-- 
2.40.1



