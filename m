Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4D79B924
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjIKVN7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbjIKOJ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:09:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80ACF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:09:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C361EC433C8;
        Mon, 11 Sep 2023 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441394;
        bh=QQLb70N59cXUcaqR840b3/jQpvp/ERFxdBd2873OCkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYjnPUidlvaTQ06Q/1bwQjzREModyzm8BK41McRtKZzDlhztDv/kiKmiLnE07fOq0
         r6Q51QoGi5H5ihV8g8uOPk35/gGQoAJlqaUzll56Lh9/UfTHtWqjWT20pj5FvD7aIq
         6JIHCaHS6h0XqEXfjEyQvLReY/PPmw4OQflYbTFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 397/739] clk: qcom: fix some Kconfig corner cases
Date:   Mon, 11 Sep 2023 15:43:16 +0200
Message-ID: <20230911134702.271016210@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b6bcd1c0c27e1f210228346e6d23a2ec0c263e8c ]

The SM_GCC_8550 symbol and others can only be built for ARM64 or when
compile testing, but it gets selected by other drivers that can also be
built for 32-bit ARCH_QCOM when not compile testing, which results in
a Kconfig warning:

WARNING: unmet direct dependencies detected for SM_GCC_8550
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
  Selected by [m]:
  - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
  - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]

Add further 'depends on' statements to tighten this in a way that
avoids the missing dependencies.

Fixes: fd0b5b106fcab ("clk: qcom: Introduce SM8350 VIDEOCC")
Fixes: 441fe711be384 ("clk: qcom: videocc-sm8450: Add video clock controller driver for SM8450")
Fixes: f53153a37969c ("clk: qcom: videocc-sm8550: Add video clock controller driver for SM8550")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230801105718.3658612-1-arnd@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 263e55d75e3f5..ed7dc3349e34e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -995,6 +995,7 @@ config SM_GPUCC_8450
 
 config SM_GPUCC_8550
 	tristate "SM8550 Graphics Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8550
 	help
 	  Support for the graphics clock controller on SM8550 devices.
@@ -1031,6 +1032,7 @@ config SM_VIDEOCC_8250
 
 config SM_VIDEOCC_8350
 	tristate "SM8350 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8350
 	select QCOM_GDSC
 	help
@@ -1040,6 +1042,7 @@ config SM_VIDEOCC_8350
 
 config SM_VIDEOCC_8550
 	tristate "SM8550 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8550
 	select QCOM_GDSC
 	help
@@ -1088,6 +1091,7 @@ config CLK_GFM_LPASS_SM8250
 
 config SM_VIDEOCC_8450
 	tristate "SM8450 Video Clock Controller"
+	depends on ARM64 || COMPILE_TEST
 	select SM_GCC_8450
 	select QCOM_GDSC
 	help
-- 
2.40.1



