Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D46FA476
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjEHJ7m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEHJ7l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6802CD0D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7F50622A1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96CDC433D2;
        Mon,  8 May 2023 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539979;
        bh=15RMTC+ZN1QytF2d7EaMMDUeqoxF3Gg6R/lbc1gyPqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoNqItQRakZ2oTJVoWmRwrrxWP2y5gqOtdXrgm+Yq3H8s0LHeotZTS6BeQx4OMcdu
         hi6zvhJgOK7yR8DtLO/XeAf1L3ucONwQsXyuPuCeGad5pj5t6rk+T0TcEaLJ7dd4Xm
         sjdtMWxYxfgQ50f+aaXgURhxu4ib8gbGGAT5v51U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/611] arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu
Date:   Mon,  8 May 2023 11:40:41 +0200
Message-Id: <20230508094428.838297703@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit ff4c868ba8df9dcd144ab4943a50adca1cf33ba2 ]

The MT8192 SoC specifies a maximum voltage for the GPU's digital supply
of 0.88V and the GPU OPPs are declaring a maximum voltage of 0.80V.

In order to keep the GPU voltage in the safe range, change the maximum
voltage for mt6315@7's vbuck1 to 0.80V as sending, for any mistake,
1.193V would be catastrophic.

Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20230301095523.428461-12-angelogioacchino.delregno@collabora.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 4b314435f8fd6..50367da93cd79 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -935,7 +935,7 @@
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <606250>;
-				regulator-max-microvolt = <1193750>;
+				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
 			};
-- 
2.39.2



