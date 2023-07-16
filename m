Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5A75544B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGPU2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGPU2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C6BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEDD160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48CDC433C8;
        Sun, 16 Jul 2023 20:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539327;
        bh=t0q7hWDDmB95pLpmNdBJHani2wC1DX8DURrk7cL5Va8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9fJm2LvXNWfAE4XvSNqTkpHkwf4kLw7jvpY0FzIgDrqHLHXsT/aQ4OKw9ZCYHimV
         E0TycvV57VKbwvKpVnR7R5gNxukuy3BRm7lW9J/Karqo2p4suKFTy0tuHdEi8osm7C
         2byhRz8NDPCVeTJoHwJcs+Yueq4QahGJyC77x7GI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.4 769/800] ARM: dts: qcom: msm8660: Fix regulator node names
Date:   Sun, 16 Jul 2023 21:50:22 +0200
Message-ID: <20230716195007.011667697@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

commit a0f19091d4f5bbe97485592257b88007eb5b1998 upstream.

commit 04715461abf7 altered the node names in a DTSI file
used by qcom-apq8060-dragonboard.dts breaking the board.
Align the node names in the DTS file and the board boots
again.

Cc: stable@vger.kernel.org
Fixes: 85055a1eecc1 ("ARM: dts: qcom-msm8660: align RPM regulators node name with bindings")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230414135747.34994-1-linus.walleij@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -451,7 +451,7 @@
 	 * PM8901 supplies "preliminary regulators" whatever
 	 * that means
 	 */
-	pm8901-regulators {
+	regulators-0 {
 		vdd_l0-supply = <&pm8901_s4>;
 		vdd_l1-supply = <&vph>;
 		vdd_l2-supply = <&vph>;
@@ -537,7 +537,7 @@
 
 	};
 
-	pm8058-regulators {
+	regulators-1 {
 		vdd_l0_l1_lvs-supply = <&pm8058_s3>;
 		vdd_l2_l11_l12-supply = <&vph>;
 		vdd_l3_l4_l5-supply = <&vph>;


