Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1337ED06D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjKOTy5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjKOTy5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF51B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDD7C433C8;
        Wed, 15 Nov 2023 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078093;
        bh=8AiF/XJNDtTP9l2B2nz3yVEDowKIg4BrS7Oa8qKXB3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw19OVt8ZUqJx4ObeH8qrj+DsoxvDeT8iuM+1ay3EXbo9r7RUOWpN4i+9N7sUc8VB
         ENJc04qe6p18X2MLxYm1so7XyeZNF+amWo9mB3xcDdOa0ees5HhZZBLBPbPWl3oEYz
         AJvWJMj/SJ8EITKqPjovXbVq9YLi/+wsM0W6kKo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/379] clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
Date:   Wed, 15 Nov 2023 14:23:00 -0500
Message-ID: <20231115192651.341148392@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varadarajan Narayanan <quic_varada@quicinc.com>

[ Upstream commit 6a15647d0adc686226045e8046369f34d6ab03ed ]

The config IPQ_APSS_6018 should depend on QCOM_SMEM, to
avoid the following error reported by 'kernel test robot'

	loongarch64-linux-ld: drivers/clk/qcom/apss-ipq6018.o: in function `apss_ipq6018_probe':
	>> apss-ipq6018.c:(.text+0xd0): undefined reference to `qcom_smem_get_soc_id'

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202310181650.g8THtfsm-lkp@intel.com/
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Link: https://lore.kernel.org/r/f4c4d65a7cb71e807d6d472c63c7718408c8f5f0.1697781921.git.quic_varada@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 76e6dee450d59..cbf55949c6493 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -127,6 +127,7 @@ config IPQ_APSS_6018
 	tristate "IPQ APSS Clock Controller"
 	select IPQ_APSS_PLL
 	depends on QCOM_APCS_IPC || COMPILE_TEST
+	depends on QCOM_SMEM
 	help
 	  Support for APSS clock controller on IPQ platforms. The
 	  APSS clock controller manages the Mux and enable block that feeds the
-- 
2.42.0



