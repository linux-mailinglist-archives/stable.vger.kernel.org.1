Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5247D3132
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjJWLGs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjJWLGr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D5D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FFFC433C7;
        Mon, 23 Oct 2023 11:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059203;
        bh=sgleSi+07cTmH/o8QLRv8vOimVh2tTK542lCYcoCU5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0J6QjeBXo2yfCgKb+CtE4VKQUbFQ3A9OjRi4XEB06ASaX4KP4qHQS7LTvy6M3x4qz
         TD46znE+nnIKucpJ8EL03ICoN0CBVZ2U/TvWh0tkkVg5EDRyGY0JV6CdGeUBZ/DLKA
         lBDskGdjXM8sDg9uKEc1NJb6g0FoMcXNH8HFrTHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 099/241] arm64: dts: mediatek: Fix "mediatek,merge-mute" and "mediatek,merge-fifo-en" types
Date:   Mon, 23 Oct 2023 12:54:45 +0200
Message-ID: <20231023104836.317229023@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit 5f8456b1faefb06fcf6028dced9f37aa880c779d ]

"mediatek,merge-mute" and "mediatek,merge-fifo-en" properties are defined
and used as boolean properties which in DT have no value.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230830195650.704737-1-robh@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 43011bc41da77..54c674c45b49a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2958,7 +2958,7 @@ merge1: vpp-merge@1c10c000 {
 			clock-names = "merge","merge_async";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xc000 0x1000>;
-			mediatek,merge-mute = <1>;
+			mediatek,merge-mute;
 			resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE0_DL_ASYNC>;
 		};
 
@@ -2971,7 +2971,7 @@ merge2: vpp-merge@1c10d000 {
 			clock-names = "merge","merge_async";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xd000 0x1000>;
-			mediatek,merge-mute = <1>;
+			mediatek,merge-mute;
 			resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE1_DL_ASYNC>;
 		};
 
@@ -2984,7 +2984,7 @@ merge3: vpp-merge@1c10e000 {
 			clock-names = "merge","merge_async";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xe000 0x1000>;
-			mediatek,merge-mute = <1>;
+			mediatek,merge-mute;
 			resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE2_DL_ASYNC>;
 		};
 
@@ -2997,7 +2997,7 @@ merge4: vpp-merge@1c10f000 {
 			clock-names = "merge","merge_async";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0xf000 0x1000>;
-			mediatek,merge-mute = <1>;
+			mediatek,merge-mute;
 			resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE3_DL_ASYNC>;
 		};
 
@@ -3010,7 +3010,7 @@ merge5: vpp-merge@1c110000 {
 			clock-names = "merge","merge_async";
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c11XXXX 0x0000 0x1000>;
-			mediatek,merge-fifo-en = <1>;
+			mediatek,merge-fifo-en;
 			resets = <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC>;
 		};
 
-- 
2.40.1



