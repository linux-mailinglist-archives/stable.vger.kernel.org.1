Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A476FAA7D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjEHLDT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjEHLCq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DAC4486
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1E362A48
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C76C433D2;
        Mon,  8 May 2023 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543708;
        bh=LVOjEFI63TDCa+H6RehajV3mSb3+qUqefeYeby0skB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO6N89AUusIGkWTZ8AkD7pbDT7wySW88wsocqbch0/qx9A1oal787KAkX0o3+mqAI
         2yPZK3YYraaqH6Vedsi4wyCt7yWFk/9Fj9LLrEcHDXJxPAp/ohur2QEyeLccT2HL1L
         LM3ObQnzXTAypeNlKKRGqMWyOodFhIbG+Cbf5yD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jayesh Choudhary <j-choudhary@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 174/694] arm64: dts: ti: k3-j784s4-*: Add ti,sci-dev-id for NAVSS nodes
Date:   Mon,  8 May 2023 11:40:09 +0200
Message-Id: <20230508094438.052511308@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Jayesh Choudhary <j-choudhary@ti.com>

[ Upstream commit 436b288687176bf4d2c1cd25b86173e5a1649a60 ]

TISCI device ID for main_navss and mcu_navss nodes are missing in
the device tree. Add them.

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
Link: https://lore.kernel.org/r/20230314152611.140969-2-j-choudhary@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 1 +
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 7edf324ac159b..80a1b08c51a84 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -398,6 +398,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
+		ti,sci-dev-id = <280>;
 		dma-coherent;
 		dma-ranges;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 93952af618f65..64bd3dee14aa6 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -209,6 +209,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
+		ti,sci-dev-id = <323>;
 		dma-coherent;
 		dma-ranges;
 
-- 
2.39.2



