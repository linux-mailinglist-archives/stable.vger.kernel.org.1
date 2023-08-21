Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A57832ED
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHUT75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHUT74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630B195
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B29DF64750
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9F9C433C7;
        Mon, 21 Aug 2023 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647990;
        bh=XsE2xXDYa9Py1/k39AvFo5ZYDkvyg/Fuhnz7kt4Mu68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkxlBmbQPX44qfJgGP4IlVC+wDTzGzVcVI8tv15d1k5h7l16Kak5mUl4LtBPC72/9
         eDOXqQc9yyTMolbX0k1WdR2w932/XKNFkNoqgRw/fq/HmZexLhErsZmv4vg+c8iwLa
         5FFfTHexyOnRvmyhsRS+rDmBPZQBKDITi8SYx5qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 016/234] arm64: dts: qcom: ipq5332: add QFPROM node
Date:   Mon, 21 Aug 2023 21:39:39 +0200
Message-ID: <20230821194129.470362420@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kathiravan T <quic_kathirav@quicinc.com>

[ Upstream commit 2f34a2aa4c88f4882e3c5df8c9b78f8bbd3f564f ]

IPQ5332 has efuse region to determine the various HW quirks. Lets
add the initial support and the individual fuses will be added as they
are required.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230526125305.19626-3-quic_kathirav@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index af4d97143bcf5..c2d6cc65a323a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -135,6 +135,13 @@ soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		qfprom: efuse@a4000 {
+			compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x721>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		rng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
-- 
2.40.1



