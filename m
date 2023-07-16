Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3536C75525A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGPUG7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGPUG7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631E10FB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A98B60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C1C433C7;
        Sun, 16 Jul 2023 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538005;
        bh=eyZ+ca6UjsjUkv/EF9WRoDccA1vXAWQz/i7CLnkCDzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht5Qb03/NNjPZYEBUfZFctezpKFwkQ1dMucO5xLJElIvU+jiaCDH7WXST3h7odEYb
         uy7IzMKhjCfQQUNP9OmHHCvNgOYpkKnnMSTGLILV8G2+BGfzS1pUCmQN4d1LBbReyx
         alWlped1UED3rDZN759GNgLQt1jqzaRxl5j90z7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 298/800] ARM: dts: qcom: msm8974: do not use underscore in node name (again)
Date:   Sun, 16 Jul 2023 21:42:31 +0200
Message-ID: <20230716194956.002298243@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 311bbc884b2edcf584b67d331be85ce43b27586f ]

Align RPM requests node with DT schema by using hyphen instead of
underscore.

Fixes: f300826d27be ("ARM: dts: qcom-msm8974: Sort and clean up nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230410175232.22317-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 7ed0d925a4e99..a22616491dc0e 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -301,7 +301,7 @@ rpm {
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests: rpm_requests {
+			rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
-- 
2.39.2



