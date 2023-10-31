Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03E7DD50D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbjJaRqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376371AbjJaRqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1311A
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:46:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E227C433CA;
        Tue, 31 Oct 2023 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774406;
        bh=cI8zQ6YRUPsjMVJwj+WVO7xrUXidVrNwtS1EXSavP08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3XElaUzIRUfMLaYeGHdrBXZS0gyxLc2V0iukelMzte8ihB/Bshe8KC77DbdAX72S
         YOsAq3n8bF+4JCyAJzX/EeuLUSuCxGfWUFkam+T0po2qR3U3hCnqXcU4WvaonGmmnH
         31MYWHmN8HDVTWRTET7+CqH92hl+Ouwp2xhydjAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Bee <knaerzche@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.5 036/112] ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
Date:   Tue, 31 Oct 2023 18:00:37 +0100
Message-ID: <20231031165902.453959245@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Bee <knaerzche@gmail.com>

commit 7e3be9ea299927e6d65242c247eca0a21bc26a58 upstream.

The Cortex-A7 timer has 4 interrupts.
Add the missing one.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
Link: https://lore.kernel.org/r/20230829203721.281455-8-knaerzche@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 2e345097b9bd..bf55d4575311 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -64,7 +64,8 @@ timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		arm,cpu-registers-not-fw-configured;
 		clock-frequency = <24000000>;
 	};
-- 
2.42.0



