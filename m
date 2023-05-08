Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FDE6FAABA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjEHLGJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjEHLFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16192FA02
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3879E62A6A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38935C433D2;
        Mon,  8 May 2023 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543865;
        bh=xcXUJfwMrQMQ7fqEy/OekkIlPnQl6iJpjJyys8ASBGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9ytFG9tWB84PyT0CWZ7H/6JKacCHN9UK6uBsbEaOAb4m/HH4gymmDu2SUPXmXDE0
         1zohQCuLylXQwYewyZNDYErrJPSEPHxLPMJNuE7KnSH3uNYQZHRR1eYhnBDznOaBxt
         CcvFsgbasHhSuJanwIqCeZOA0zWo82vpBvLzZzgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 227/694] ARM: dts: gta04: fix excess dma channel usage
Date:   Mon,  8 May 2023 11:41:02 +0200
Message-Id: <20230508094439.726129830@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index 87e0ab1bbe957..e0be0fb23f80f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -612,6 +612,22 @@
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



