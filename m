Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6370396A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbjEORmX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244542AbjEORlq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8032FD8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E21062E0A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12802C433D2;
        Mon, 15 May 2023 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172362;
        bh=zk9Jyo8/fRwSURC+qwqYC3LUIM9U8e0I1+C/EqnAThc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRIQ8xzX65l1EF1O+9cbI/Ia9DR7VSGGMzb/ivIuiEXPkv6SDEu8312JddJP2a9wL
         9phrhkoXl+smdPq06iTV+YyvTGDSPFyNnamETV0xFXlgGhcniS+aowE1Ou5POQOta1
         XPOFjswTYDCTtgxKyArWHSWLH8yNu69v7x7uKinQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 101/381] ARM: dts: gta04: fix excess dma channel usage
Date:   Mon, 15 May 2023 18:25:52 +0200
Message-Id: <20230515161741.363996644@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: H. Nikolaus Schaller <hns@goldelico.com>

[ Upstream commit a622310f7f0185da02e42cdb06475f533efaae60 ]

OMAP processors support 32 channels but there is no check or
inspect this except booting a device and looking at dmesg reports
of not available channels.

Recently some more subsystems with DMA (aes1+2) were added filling
the list of dma channels beyond the limit of 32 (even if other
parameters indicate 96 or 128 channels). This leads to random
subsystem failures i(e.g. mcbsp for audio) after boot or boot
messages that DMA can not be initialized.

Another symptom is that

/sys/kernel/debug/dmaengine/summary

has 32 entries and does not show all required channels.

Fix by disabling unused (on the GTA04 hardware) mcspi1...4.
Each SPI channel allocates 4 DMA channels rapidly filling
the available ones.

Disabling unused SPI modules on the OMAP3 SoC may also save
some energy (has not been checked).

Fixes: c312f066314e ("ARM: dts: omap3: Migrate AES from hwmods to sysc-omap2")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
[re-enabled aes2, improved commit subject line]
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Message-Id: <20230113211151.2314874-1-andreas@kemnade.info>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index cc8a378dd076e..e61e5ddbf2027 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -609,6 +609,22 @@
 	clock-frequency = <100000>;
 };
 
+&mcspi1 {
+	status = "disabled";
+};
+
+&mcspi2 {
+	status = "disabled";
+};
+
+&mcspi3 {
+	status = "disabled";
+};
+
+&mcspi4 {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
-- 
2.39.2



