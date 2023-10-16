Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F27CA329
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjJPJCA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjJPJBq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164F18A
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:01:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E075CC433C7;
        Mon, 16 Oct 2023 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446890;
        bh=8I90SkiCNzumoPYATTYlLi0NTXjM98SdmoF76kFqJjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlLOB1lMLygjwfRWVDt+PAODiaicpIMRHe4tBUtTnSaMlukp2XRTr9SyWD2ESs+/a
         gKiHs4dxNCZI1tqZ5ufqUhKKuaza0EljOb1iTlfEPFasDlFn9or8A/q42L4VFxklLG
         hOEbjaZuHgDl1S2GpD40cJdvVHdXoiQSzbK+pDbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.1 088/131] arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
Date:   Mon, 16 Oct 2023 10:41:11 +0200
Message-ID: <20231016084002.245846143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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


