Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16CA6FAD7B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjEHLfL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEHLe7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275113C1FC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F449631F1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039E1C433EF;
        Mon,  8 May 2023 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545592;
        bh=kJyaHs26vV7b10N/2jLFniZqgqmXHWG7MJkSTdHBs3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Akb28onVxs4M8JcfBj4P5n+a+SQcE5MetA6Tj0Pv2WvUidipgzyzpv6g6ymIs/jKF
         prbQ9TVPV90JR/1VEJQWC1G/+ydINcakwGolT4s3mBAs+hpNEDonFfuRhwMaSUFwqn
         Imt7OlxmDw9tSlzsTtlzPqP/hreKTr6q2PFadeP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 090/371] arm64: dts: Add base DTS file for bcmbca device Asus GT-AX6000
Date:   Mon,  8 May 2023 11:44:51 +0200
Message-Id: <20230508094815.648714839@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit f3f575c4bef95384e68de552c7b29938fd0d9201 ]

It's a home router with 1 GiB of RAM, 6 Ethernet ports, 2 USB ports.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: William Zhang <william.zhang@broadcom.com>
Link: https://lore.kernel.org/r/20220713200351.28526-2-zajec5@gmail.com
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 5cca02449490 ("arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |  4 +++-
 .../bcmbca/bcm4912-asus-gt-ax6000.dts         | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index 4161d557b1329..fd60418478696 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCMBCA) += bcm94912.dtb \
+dtb-$(CONFIG_ARCH_BCMBCA) += \
+				bcm4912-asus-gt-ax6000.dtb \
+				bcm94912.dtb \
 				bcm963158.dtb \
 				bcm96858.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts
new file mode 100644
index 0000000000000..ed554666e95ea
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+/dts-v1/;
+
+#include "bcm4912.dtsi"
+
+/ {
+	compatible = "asus,gt-ax6000", "brcm,bcm4912", "brcm,bcmbca";
+	model = "Asus GT-AX6000";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.39.2



