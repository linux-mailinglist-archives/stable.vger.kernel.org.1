Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A574C2F9
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjGIL0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjGIL0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA618C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D468160BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17D0C433CA;
        Sun,  9 Jul 2023 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902004;
        bh=aSsbLDptjMAxHQ2hnMDCOjT9/vJIYc5h66rtS7YVgj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKu5SardJPdGbt6I9MG6rIrougqZgqm8FheY510hGJVKddgOfw3i2v1kuNCtaojyF
         Llr7+hLLAQTvFwHkxM2s2onxpJ+80cpQmlpl/OCqFMt/2UgSWaJjPvH3C5WEsLHG18
         pwmWSwopEZ7iU5IpoeWuKTbLglh5SQlXaUpz+EDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 222/431] ARM: dts: qcom: msm8974: do not use underscore in node name (again)
Date:   Sun,  9 Jul 2023 13:12:50 +0200
Message-ID: <20230709111456.365893827@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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
index 834ad95515b17..1c3d36701b8e5 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -300,7 +300,7 @@ rpm {
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-			rpm_requests: rpm_requests {
+			rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8974";
 				qcom,smd-channels = "rpm_requests";
 
-- 
2.39.2



