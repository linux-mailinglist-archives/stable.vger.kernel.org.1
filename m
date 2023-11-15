Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED77ECC42
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjKOT1l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjKOT1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F21130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5A1C433CB;
        Wed, 15 Nov 2023 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076456;
        bh=qHv3ExV1uXwqmSWjzgi4ENo6mWmbfUne9dWNeSc4ig0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKWm5QHdTqQKjg51paonmDBXnvadaE6UHncLUh7W3/YLxfIqhzPQTLxgwo8r6AaBC
         U6GWQvl27sYYA0ucvwktmctYvKNLtrtNeimKn1IFK+/RNUF53GUlmIr7yPIheV9EYF
         0STUMOYpT7/rsueQYPcZ3FuB9r/fhdUWbAwL8WFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 278/550] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor
Date:   Wed, 15 Nov 2023 14:14:22 -0500
Message-ID: <20231115191620.023308804@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

[ Upstream commit 0b73519790d29e4bc71afc4882a9aa9ea649bcf7 ]

Fix hall sensor GPIO polarity and also allow disabling the sensor.
Remove unneeded interrupt.

Fixes: f15623bda1dc ("ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)")
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20230922011211.115234-1-matti.lehtimaki@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index 884d99297d4cf..f516e0426bb9e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -45,11 +45,11 @@ gpio-hall-sensor {
 
 		event-hall-sensor {
 			label = "Hall Effect Sensor";
-			gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
-			interrupts = <&tlmm 110 IRQ_TYPE_EDGE_FALLING>;
+			gpios = <&tlmm 110 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			debounce-interval = <15>;
+			linux,can-disable;
 			wakeup-source;
 		};
 	};
-- 
2.42.0



