Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D192703930
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbjEORkI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbjEORjs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09716A44
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CBA62DFF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9943C433D2;
        Mon, 15 May 2023 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172226;
        bh=GRAp6G09t2sgX4GclXVAB9EEaG+zp8++UYu3MuIzjUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZkmOYI1QU568BDB12mC4LIQstCS1RxiibOiP9dt5N+12GkrErQ2uDMLketr91idX
         sjztYPFQBEHUp/H9Y7Hs2lZaI5TPK8Gy5OrARC1e+DZQJeRvuyCFdlYiOXa1VxGfVA
         nfKOflAy4H1Rwfc1xz9yVLblru3+oZrVnRKJzRe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 085/381] arm64: dts: qcom: msm8998: Fix the PCI I/O port range
Date:   Mon, 15 May 2023 18:25:36 +0200
Message-Id: <20230515161740.645472923@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 0ea4c9e7e1800..7c8d69ca91cf4 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -942,7 +942,7 @@
 			phys = <&pciephy>;
 			phy-names = "pciephy";
 
-			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x1b200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
 
 			#interrupt-cells = <1>;
-- 
2.39.2



