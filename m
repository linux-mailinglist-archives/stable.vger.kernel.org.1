Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB98A6FAD5A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjEHLeF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjEHLdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929C3D230
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CC362CCF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0870C433D2;
        Mon,  8 May 2023 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545580;
        bh=8Pu85LHb6gwQsv5qZ557RDqqttgjHxQBfNY6cUccObc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOn0uNjZQ7fbGfm77vCo9XUIAJ06vkvfZ7q2ZgB0b9hyIyGFr73QIhJMSZbLleB78
         VPamurkOcasXMmOmXFeo8JrvVBy6QESon+Oaze3w9zHFaXgWtQbBjMlgyVb3QPi/hA
         n15d0RLXUlgGGrAgZAw7qAgiVlELFGk3UHwl0snI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 086/371] arm64: dts: broadcom: bcm4908: add DT for Netgear RAXE500
Date:   Mon,  8 May 2023 11:44:47 +0200
Message-Id: <20230508094815.505707559@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit d0e68d354f345873e15876a7b35be1baaf5e3ec9 ]

It's a home router based on BCM4908 SoC. It has: 1 GiB of RAM, 512 MiB
NAND flash, 6 Ethernet ports and 3 x BCM43684 (WiFi). One of Ethernet
ports is "2.5 G Multi-Gig port" that isn't described yet (it isn't known
how it's wired up).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 5cca02449490 ("arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcm4908/Makefile |  1 +
 .../bcm4908/bcm4908-netgear-raxe500.dts       | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
index cc75854519ac3..6e364e304d4fd 100644
--- a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
@@ -2,3 +2,4 @@
 dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-netgear-r8000p.dtb
 dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-tplink-archer-c2300-v1.dtb
 dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-asus-gt-ac5300.dtb
+dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-netgear-raxe500.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
new file mode 100644
index 0000000000000..3c2cf2d238b6f
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "bcm4908.dtsi"
+
+/ {
+	compatible = "netgear,raxe500", "brcm,bcm4908";
+	model = "Netgear RAXE500";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x40000000>;
+	};
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan4";
+	};
+
+	port@1 {
+		label = "lan3";
+	};
+
+	port@2 {
+		label = "lan2";
+	};
+
+	port@3 {
+		label = "lan1";
+	};
+
+	port@7 {
+		reg = <7>;
+		phy-mode = "internal";
+		phy-handle = <&phy12>;
+		label = "wan";
+	};
+};
-- 
2.39.2



