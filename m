Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE374F95C
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKUwR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKUwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4C6E74;
        Tue, 11 Jul 2023 13:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDD56133D;
        Tue, 11 Jul 2023 20:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877C5C433C8;
        Tue, 11 Jul 2023 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689108733;
        bh=2e3D4nEO0oazmItIIqJ4KsFxQqhU0nPH2CAqNnhQhD8=;
        h=From:To:Cc:Subject:Date:From;
        b=oWcGIIQygsQ6vxdjH5bouQVHaEfFsIkjvP72CF407S0n28HrUuqwrbTtzVB18hBzz
         yDy/hFRXC92ZJ+ceN9scu4PPVtXYVNhSlS58DuVVW4M/FUKJhy58bNaWglaQGUy3bB
         xHlhfYxcuTu4k1yn6zqq4I9idD7vuwTTkaZgmr5kzJXr+FhPZLBqE8rP2A24dEnvmH
         NH8Zzrkos/ZMUzv1C8uLrMy1V16LVPqSyd1ikbiSxtQM4rF0ZLH5Hk8cxVwmv6Xs9k
         bW4nkODMjwspsImYNgIcu5gyu2c22zP2QlfMuzzJTU0tWNBvxCRGC+vMYSHFTGC2KS
         PHcGur28dAq5A==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] arm64: dts: stratix10: fix incorrect I2C property for SCL signal
Date:   Tue, 11 Jul 2023 15:52:01 -0500
Message-Id: <20230711205201.595876-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The correct dts property for the SCL falling time is
"i2c-scl-falling-time-ns".

Fixes: c8da1d15b8a4 ("arm64: dts: stratix10: i2c clock running out of spec")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 38ae674f2f02..3037f58057c9 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -145,7 +145,7 @@ &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&i2c1_pmx_func>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index ede99dcc0558..f4cf30bac557 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -141,7 +141,7 @@ &i2c2 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
-- 
2.25.1

