Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0C6FA447
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjEHJ5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjEHJ5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C832B164
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C316462263
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB465C4339B;
        Mon,  8 May 2023 09:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539841;
        bh=arSGbsljNxhHDyzmHnKgfA3F0oBCYFf4qFxqZDH0Po8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14+Efbm8hYKkrq7w8Alx+Rc7QZiB3bPLDS4e/lEIj1DEYdki55s5O9jGjUqg+/SpI
         UgoRfrmmYDnBN0QsGhyOWTc8kVmMJUcjCH9hK3a9ZSsyiLIYLxvQT5iMW84+kB+bdU
         8K/wfVFS6Igrg75sy2f3oknpaz1sGoSLT2gt53P0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 155/611] arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
Date:   Mon,  8 May 2023 11:39:57 +0200
Message-Id: <20230508094427.342279387@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit b5d08f08377218b1d2ab4026e427a7788b271c8e ]

The name stm-data-base comes from ancient (msm-3.10 or older)
downstream kernels. Upstream uses stm-stimulus-base instead. Fix it.

Fixes: 783abfa2249a ("arm64: dts: qcom: msm8998: Add Coresight support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230213210331.2106877-1-konrad.dybcio@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f05f16ac5cc18..0d97c2368c158 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1513,7 +1513,7 @@
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
-			reg-names = "stm-base", "stm-data-base";
+			reg-names = "stm-base", "stm-stimulus-base";
 			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
-- 
2.39.2



