Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1075D246
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGUS6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGUS6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB73A8E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE21761D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB14C433C8;
        Fri, 21 Jul 2023 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965867;
        bh=/zozPttlSbLTRnrUj+5VfRZaVaDnvxjL4jrMe1l3sp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLFOsi2uQiEhzzvrIotEy3XHjdBH5qP7uu9WOvyovAB6m9YHO+hT1pYtUyfTDEruW
         ICC2hDv8/MxGiK/DJbKSC7ibCOkF8obudOsoW+TRxGMHmShFi9SVHPtxT7JaPVInwK
         Fvw5Qq4o9mYmi1mP9Th1hItXFCBeD0+oXRzHWjjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/532] arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui
Date:   Fri, 21 Jul 2023 18:00:47 +0200
Message-ID: <20230721160622.205400128@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 8e9cf36a9a41a..6529962edd4e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -281,6 +281,10 @@ dsi_out: endpoint {
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



