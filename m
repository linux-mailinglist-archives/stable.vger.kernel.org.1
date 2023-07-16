Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8675522D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGPUEp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGPUEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25AE9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5851860EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EECC433C8;
        Sun, 16 Jul 2023 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537882;
        bh=4dfYZu7lTbQS+MEGQvxf2A32+YSh6k4CTYYUB3cM0QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcPooRlr/TlNVFcpmJJvBmCi32PKNnoUAmMX9ab9Bl8pev6vyjxdhgdZI41YfREM8
         Yurkvumya3etQiuE2uutm26Uy1PyLHC+vQwz5jvpKq8dL8CHGrgZbsXQWpP+cSqmw7
         c+KSkbjpZFHnb8/X8NxuBe1dgi169ka7tGhPACB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 255/800] ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name
Date:   Sun, 16 Jul 2023 21:41:48 +0200
Message-ID: <20230716194955.018786097@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Trevor Wu <trevor.wu@mediatek.com>

[ Upstream commit 1e4fe75e9746be8e40c57132bb3fba1ce3dd24af ]

The original clock names are different from the list in driver code.
Correct the mismatched binding names in the patch.

Because no mt8188 upstream dts exists, it doesn't affect the existing
dts file.

Fixes: 692d25b67e10 ("ASoC: dt-bindings: mediatek,mt8188-afe: add audio afe document")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org
Link: https://lore.kernel.org/r/20230510035526.18137-9-trevor.wu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/sound/mediatek,mt8188-afe.yaml   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
index 82ccb32f08f27..9e877f0d19fbb 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
@@ -63,15 +63,15 @@ properties:
       - const: apll12_div2
       - const: apll12_div3
       - const: apll12_div9
-      - const: a1sys_hp_sel
-      - const: aud_intbus_sel
-      - const: audio_h_sel
-      - const: audio_local_bus_sel
-      - const: dptx_m_sel
-      - const: i2so1_m_sel
-      - const: i2so2_m_sel
-      - const: i2si1_m_sel
-      - const: i2si2_m_sel
+      - const: top_a1sys_hp
+      - const: top_aud_intbus
+      - const: top_audio_h
+      - const: top_audio_local_bus
+      - const: top_dptx
+      - const: top_i2so1
+      - const: top_i2so2
+      - const: top_i2si1
+      - const: top_i2si2
       - const: adsp_audio_26m
 
   mediatek,etdm-in1-cowork-source:
@@ -193,15 +193,15 @@ examples:
                       "apll12_div2",
                       "apll12_div3",
                       "apll12_div9",
-                      "a1sys_hp_sel",
-                      "aud_intbus_sel",
-                      "audio_h_sel",
-                      "audio_local_bus_sel",
-                      "dptx_m_sel",
-                      "i2so1_m_sel",
-                      "i2so2_m_sel",
-                      "i2si1_m_sel",
-                      "i2si2_m_sel",
+                      "top_a1sys_hp",
+                      "top_aud_intbus",
+                      "top_audio_h",
+                      "top_audio_local_bus",
+                      "top_dptx",
+                      "top_i2so1",
+                      "top_i2so2",
+                      "top_i2si1",
+                      "top_i2si2",
                       "adsp_audio_26m";
     };
 
-- 
2.39.2



