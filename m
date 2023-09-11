Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CFF79B557
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbjIKWAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjIKPMi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152CFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB4C433C8;
        Mon, 11 Sep 2023 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445153;
        bh=7q9vkQ0N4NgdtAXEbYEoAgi/5ERczHGZER5bm/BScXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVyWpPXSElComLH9Sh9CpnlBAcmmJbNqrJHXJSjJ5nhscC56K4ryrjFoYJMwab/Eo
         IeHeKPm8glS0zq1+LNhGdQRvAAoXxT6XTZXMbUgn4igpwdsvKR4gZiuyKxcRr2jEQS
         1AGkbt83emy/ou1fHUBJCDjwA6nisWz5MzEc+EhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 245/600] ARM: dts: stm32: YAML validation fails for Odyssey Boards
Date:   Mon, 11 Sep 2023 15:44:38 +0200
Message-ID: <20230911134640.828519577@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>

[ Upstream commit 84a34e1862aae43e4dcdfb743a7dd3ade1fe4a3c ]

"make dtbs_check" gives following output :
stm32mp157c-odyssey.dt.yaml: gpu@59000000: 'contiguous-area' does not match
any of the regexes: 'pinctrl-[0-9]+'
>From schema: Documentation/devicetree/bindings/gpu/vivante,gc.yaml

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Stable-dep-of: 966f04a89d77 ("ARM: dts: stm32: Add missing detach mailbox for Odyssey SoM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
index 2d9461006810c..e22871dc580c8 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
@@ -62,11 +62,6 @@ retram: retram@38000000 {
 			reg = <0x38000000 0x10000>;
 			no-map;
 		};
-
-		gpu_reserved: gpu@d4000000 {
-			reg = <0xd4000000 0x4000000>;
-			no-map;
-		};
 	};
 
 	led {
@@ -80,11 +75,6 @@ led-blue {
 	};
 };
 
-&gpu {
-	contiguous-area = <&gpu_reserved>;
-	status = "okay";
-};
-
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
-- 
2.40.1



