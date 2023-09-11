Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2579ADB5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjIKUxD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241708AbjIKPM3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAB7FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87EBC433C7;
        Mon, 11 Sep 2023 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445145;
        bh=PO2ffL1Z53w8zCXZ9bX9ktfK3HkUQbhBVIdktQX692M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZ31aSh8AfYaQr8HR9eVp120nzR4cU44/G/LHTCbNBbwUN+y1gTtpdHHBsrORwbn/
         9gFCnhE8gbHenJjRiiaW5tqpqLwfOdXVrSXQq0fJEgNqyblGjsi9u2VSUi8wDRW/um
         mFkgT5WPcmf+O5Oc34ksTtI7XsMftC6XLJjKiHNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 242/600] ARM: dts: stm32: YAML validation fails for Argon Boards
Date:   Mon, 11 Sep 2023 15:44:35 +0200
Message-ID: <20230911134640.742211032@linuxfoundation.org>
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

[ Upstream commit fc8d2b21bc5d5d7a6eadaa8c2a5d2e6856689480 ]

"make dtbs_check" gives following output :
stm32mp157c-emstamp-argon.dtb: gpu@59000000: 'contiguous-area' does not match
any of the regexes: 'pinctrl-[0-9]+'
>From schema: Documentation/devicetree/bindings/gpu/vivante,gc.yaml

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Stable-dep-of: 0ee0ef38aa9f ("ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
index 7d11c50b9e408..b01470a9a3d53 100644
--- a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
@@ -68,11 +68,6 @@ retram: retram@38000000 {
 			reg = <0x38000000 0x10000>;
 			no-map;
 		};
-
-		gpu_reserved: gpu@dc000000 {
-			reg = <0xdc000000 0x4000000>;
-			no-map;
-		};
 	};
 
 	led: gpio_leds {
@@ -183,10 +178,6 @@ phy0: ethernet-phy@0 {
 	};
 };
 
-&gpu {
-	contiguous-area = <&gpu_reserved>;
-};
-
 &hash1 {
 	status = "okay";
 };
-- 
2.40.1



