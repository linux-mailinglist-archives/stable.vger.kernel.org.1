Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3C6FAD79
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbjEHLfI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjEHLe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B83DC8B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E0F161E2D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2AC433D2;
        Mon,  8 May 2023 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545595;
        bh=0TztSDO5Z6xQsL3XWqMBwQmz9L+fw2baZqZ/140Bci4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSoqyLxFiTgLglMNHSkXZo3OuovN2aTQxZHKAIy/7WsqbHx2e1nPuXmCKSFw0zGi2
         zt5J5bvmx67PCsYh1p1gZGsN1dX31WclFp8JKxP9vXJNephXtBxO2euWLUAUHEA4Pf
         bDrRM6EjMyMVFWr1dsWbbQCl5PhgOhffTFUtq1EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/371] arm64: dts: Move BCM4908 dts to bcmbca folder
Date:   Mon,  8 May 2023 11:44:52 +0200
Message-Id: <20230508094815.679283238@linuxfoundation.org>
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

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit ded8f22945899f4e87dd6d952bbc4abce6e64b7e ]

As part of ARCH_BCM4908 to ARCH_BCMBCA migration, move the BCM4908 dts
files to bcmbca folder and use CONFIG_ARCH_BCMBCA to build all the
BCM4908 board dts. Delete bcm4908 folder and its makefile as well.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Link: https://lore.kernel.org/r/20220803175455.47638-5-william.zhang@broadcom.com
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 5cca02449490 ("arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/Makefile                        | 1 -
 arch/arm64/boot/dts/broadcom/bcm4908/Makefile                | 5 -----
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile                 | 4 ++++
 .../broadcom/{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts  | 0
 .../{bcm4908 => bcmbca}/bcm4906-tplink-archer-c2300-v1.dts   | 0
 .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi | 0
 .../broadcom/{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts  | 0
 .../broadcom/{bcm4908 => bcmbca}/bcm4908-netgear-raxe500.dts | 0
 .../arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi | 0
 9 files changed, 4 insertions(+), 6 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/broadcom/bcm4908/Makefile
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906-netgear-r8000p.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906-tplink-archer-c2300-v1.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4906.dtsi (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908-asus-gt-ac5300.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908-netgear-raxe500.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{bcm4908 => bcmbca}/bcm4908.dtsi (100%)

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 9a0ea4b97ef23..bce0a12554539 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -6,7 +6,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
-subdir-y	+= bcm4908
 subdir-y	+= bcmbca
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
deleted file mode 100644
index 6e364e304d4fd..0000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-netgear-r8000p.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-tplink-archer-c2300-v1.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-asus-gt-ac5300.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-netgear-raxe500.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index fd60418478696..dc68357849a9b 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCMBCA) += \
+				bcm4906-netgear-r8000p.dtb \
+				bcm4906-tplink-archer-c2300-v1.dtb \
+				bcm4908-asus-gt-ac5300.dtb \
+				bcm4908-netgear-raxe500.dtb \
 				bcm4912-asus-gt-ax6000.dtb \
 				bcm94912.dtb \
 				bcm963158.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
rename to arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
-- 
2.39.2



