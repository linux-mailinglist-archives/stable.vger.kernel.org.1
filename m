Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF57CAC6D
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJPOyd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjJPOyc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B195
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6CC433C9;
        Mon, 16 Oct 2023 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468069;
        bh=EkKje32AL6Jzh8jfUZArxJsBusLYW0R59L3Zzihxi6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqWq1q763imXPP4/qS+9J8SLN5rl5I3pHJ+JuNUkhYw01RhIGL1d9Nj6xtnWuf4bj
         3vt/7o+4rRgoInk+qVdYb7YtJl6onHjRTRmerUTktHlKw2kqA9NlADJnRgP7d3nRzq
         cI1T2WSQTfHG+KH8Nx77LYsxI3gcxV4aXEDrkP1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.5 120/191] arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
Date:   Mon, 16 Oct 2023 10:41:45 +0200
Message-ID: <20231016084018.180336764@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit 25389c03c21c9587dd21c768d1cbfa514a3ca211 upstream.

The onboard dram of mt8195-demo board is 8GB.

Cc: stable@vger.kernel.org      # 6.1, 6.4, 6.5
Fixes: 6147314aeedc ("arm64: dts: mediatek: Add device-tree for MT8195 Demo board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230905034511.11232-1-macpaul.lin@mediatek.com
Link: https://lore.kernel.org/r/20231003-mediatek-fixes-v6-7-v1-2-dad7cd62a8ff@collabora.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -48,7 +48,7 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
+		reg = <0 0x40000000 0x2 0x00000000>;
 	};
 
 	reserved-memory {


