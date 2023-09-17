Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10137A3BB4
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbjIQUVY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbjIQUVA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:21:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601E10B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DFFC433C7;
        Sun, 17 Sep 2023 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982054;
        bh=p/L8CC7oO5FkzZbuPJWCjLq5yOslQKgPJugYNVbH3Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwCeaC4KE4+AYEU+UlYiRTLJ1s06g6xh3xRQTGwl/nFNFaK5EKaDNeBhVrbAVCwcA
         AzZSQoNcUsWEHbCHGIhUFjCbBWc9i8JlLhbiZSqQ+MORdj8XF3FS6ZIig/Q8q41z4c
         gv/QsbwTMRADP4PWTuB2f2pkJFj/rw7SXxkPU1fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 144/511] arm64: dts: qcom: pmi8998: Add node for WLED
Date:   Sun, 17 Sep 2023 21:09:31 +0200
Message-ID: <20230917191117.335283336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

[ Upstream commit 17d32c10a2880ae7702d8e56128a542d9c6e9c75 ]

The PMI8998 PMIC has a WLED backlight controller, which is used on
most MSM8998 and SDM845 based devices: add a base configuration for
it and keep it disabled.

This contains only the PMIC specific configuration that does not
change across boards; parameters like number of strings, OVP and
current limits are product specific and shall be specified in the
product DT in order to achieve functionality.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20210909123628.365968-1-angelogioacchino.delregno@somainline.org
Stable-dep-of: 9a4ac09db3c7 ("arm64: dts: qcom: pm660l: Add missing short interrupt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index d230c510d4b7d..0fef5f113f05e 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -41,5 +41,17 @@ lab: lab {
 				interrupt-names = "sc-err", "ocp";
 			};
 		};
+
+		pmi8998_wled: leds@d800 {
+			compatible = "qcom,pmi8998-wled";
+			reg = <0xd800 0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
+			label = "backlight";
+
+			status = "disabled";
+		};
+
 	};
 };
-- 
2.40.1



