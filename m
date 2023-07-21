Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6D75D261
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGUS7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGUS7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6730E7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7927161D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA05C433C7;
        Fri, 21 Jul 2023 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965935;
        bh=O4mZPwiSeatEmG+fnIeo4SKqNoNH1/GXruhu+Rd5/DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMu4l+zY2UfYthSOtnOvc+x9cRej3W7YB1yxTR1wQjxZdkNdb/oIrSx5wzUPBPg2C
         6sINyE1O8DpajJPm67/YWjf2UGDKkHnPf2HzrgYvtJInEm4q+2JyPyaUxLRxhYPxUB
         6gRZ6jqheBCh7oovZPDVyFmmVqqo5bX+jQ+UfrAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/532] arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
Date:   Fri, 21 Jul 2023 18:00:42 +0200
Message-ID: <20230721160621.946024551@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 5500f823db38db073d30557af159b77fb1f2bf26 ]

The 96Boards specification expects a 1.8V power rail on the low-speed
expansion connector that is able to provide at least 0.18W / 100 mA.
According to the DB410c hardware user manual this is done by connecting
both L15 and L16 in parallel with up to 55mA each (for 110 mA total) [1].

Unfortunately the current regulator setup in the DB410c device tree
does not implement the specification correctly and only provides 5 mA:

  - Only L15 is marked always-on, so L16 is never enabled.
  - Without specifying a load the regulator is put into LPM where
    it can only provide 5 mA.

Fix this by:

  - Adding proper voltage constraints for L16.
  - Making L16 always-on.
  - Adding regulator-system-load for both L15 and L16. 100 mA should be
    available in total, so specify 50 mA for each. (The regulator
    hardware can only be in normal (55 mA) or low-power mode (5 mA) so
    this will actually result in the expected 110 mA total...)

[1]: https://www.96boards.org/documentation/consumer/dragonboard/dragonboard410c/hardware-docs/hardware-user-manual.md.html#power-supplies

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 828dd5d66f0f ("arm64: dts: apq8016-sbc: make 1.8v available on LS expansion")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230510-msm8916-regulators-v1-2-54d4960a05fc@gerhold.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 528138af24f09..c6e8bf18defc6 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -519,19 +519,27 @@ l14 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	/**
-	 * 1.8v required on LS expansion
-	 * for mezzanine boards
+	/*
+	 * The 96Boards specification expects a 1.8V power rail on the low-speed
+	 * expansion connector that is able to provide at least 0.18W / 100 mA.
+	 * L15/L16 are connected in parallel to provide 55 mA each. A minimum load
+	 * must be specified to ensure the regulators are not put in LPM where they
+	 * would only provide 5 mA.
 	 */
 	l15 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
 		regulator-always-on;
 	};
 
 	l16 {
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
+		regulator-always-on;
 	};
 
 	l17 {
-- 
2.39.2



