Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9937ECBC9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjKOTY3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjKOTY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:24:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C510130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98447C433C7;
        Wed, 15 Nov 2023 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076264;
        bh=SXqPKlk0YlExQ5F6iBkwuA/6fAQVQRIyzOADVtIC3qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyFscU/qyCqScGQ9De48PaH0E33H/aX+K/BWAEl1B41tyjA45mToBhQq7a4gD3vNc
         tYCccVRA8dhytU4vugjsZx5ZWfp6tInoVepYkwkLBmEKzBI55Lq4cna9Uv27avh/+Z
         NXtG/wbpSoeZxHbuQ0Y9Poon4GhNy18cmVWd3c64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 181/550] clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
Date:   Wed, 15 Nov 2023 14:12:45 -0500
Message-ID: <20231115191613.271887698@linuxfoundation.org>
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
index 92ef5314b59ce..9151f7b11833f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -131,6 +131,7 @@ config IPQ_APSS_6018
 	tristate "IPQ APSS Clock Controller"
 	select IPQ_APSS_PLL
 	depends on QCOM_APCS_IPC || COMPILE_TEST
+	depends on QCOM_SMEM
 	help
 	  Support for APSS clock controller on IPQ platforms. The
 	  APSS clock controller manages the Mux and enable block that feeds the
-- 
2.42.0



