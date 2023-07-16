Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1E755561
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGPUkR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGPUkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A09120
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4912460EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FFFC433C8;
        Sun, 16 Jul 2023 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540014;
        bh=oqG3WaVgXPlKAi5K6uWLXUw3xmDxvPwaMfHC2xWB11M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhYATQbwhnFohvPPosFoZpuepd0qSILKxsy4LoDzIDh7dpfMbeHNUPZtF6u28TMRx
         FxE5QJxWGVKPVnnRnsN337gFIXxkLuwNM1qmMXy5+c/utjQxGLbUInMmoHnRZ/t475
         PIu9UlD6KC4sA4F5NUKsrM7xQF7XmiWKZqQMnwxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 212/591] arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui
Date:   Sun, 16 Jul 2023 21:45:51 +0200
Message-ID: <20230716194929.353590596@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 42127f578ebde652d1373e0233356fbd351675c4 ]

Firmware shipped on mt8183 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230515131353.v2.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index b4b86bb1f1a7d..632fd89e75969 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -297,6 +297,10 @@ dsi_out: endpoint {
 	};
 };
 
+&gic {
+	mediatek,broken-save-restore-fw;
+};
+
 &gpu {
 	mali-supply = <&mt6358_vgpu_reg>;
 	sram-supply = <&mt6358_vsram_gpu_reg>;
-- 
2.39.2



