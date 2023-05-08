Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51F6FA44C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEHJ5m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjEHJ5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721435A4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C886226F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3494C433EF;
        Mon,  8 May 2023 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539857;
        bh=kVBw/zZ8C9iHNPF/WQe1E6V3diM3CMgaeUcy5tDLeUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rhwhTMCD2Mp0T3XvbqcsQNAfR3h/u35MmZdzNg+olHsk4hoj/jEXPURYsrcGulDq
         m2Qkh9LlQc2wMb3eMPo2/UtnOXYEUEeahFJAbj2w+xJVrl53Fjg92IFS9oHL2CzzNA
         r+7MR8QUbpSgSWQbTmtGbIK5YZ6XYUKe1Io9/5O8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 159/611] arm64: dts: qcom: msm8998: Fix the PCI I/O port range
Date:   Mon,  8 May 2023 11:40:01 +0200
Message-Id: <20230508094427.481628883@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit c30a27dcfe4545edbda1578b3a63ed6147519cdd ]

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI address
(0x1b200000) specified in the ranges property for I/O region.

Fixes: b84dfd175c09 ("arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230228164752.55682-3-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0d97c2368c158..29c60bb56ed5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -916,7 +916,7 @@
 			phy-names = "pciephy";
 			status = "disabled";
 
-			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x1b200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
 
 			#interrupt-cells = <1>;
-- 
2.39.2



