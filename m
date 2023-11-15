Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518B7ECC39
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjKOT1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjKOT13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D921AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9F5C433CC;
        Wed, 15 Nov 2023 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076446;
        bh=JBCx6tkWAV0oVt+Klx9y+BDw0zC9cUhRtkNZcFl/GJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=po+iZQVJa2k27xycv6hsNaKNnr+EOSfirV7yrBjl7LFcKAtV70i7VJlRT7Leo5D/M
         edZwIoBEvBrhmt15L0MVIf8V7m+bVyZE7btwCnk1/mhSfhqctRj+vyxrgNPT8zKEM2
         8PnuMnaoqJpIZnY+deO3C4U0CMHa3FYJHkO4nHg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 276/550] riscv: dts: allwinner: remove address-cells from intc node
Date:   Wed, 15 Nov 2023 14:14:20 -0500
Message-ID: <20231115191619.884566345@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit 267860b10c67dd396c73a9e6e8103670d78a4c01 ]

A recent submission [1] from Rob has added additionalProperties: false
to the interrupt-controller child node of RISC-V cpus, highlighting that
the D1 DT has been incorrectly using #address-cells since its
introduction. It has no child nodes, so #address-cells is not needed.
Remove it.

Fixes: 077e5f4f5528 ("riscv: dts: allwinner: Add the D1/D1s SoC devicetree")
Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/r/20230916-saddling-dastardly-8cf6d1263c24@spud
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977d..b8684312593e5 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -30,7 +30,6 @@ cpu0: cpu@0 {
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
 				interrupt-controller;
-				#address-cells = <0>;
 				#interrupt-cells = <1>;
 			};
 		};
-- 
2.42.0



