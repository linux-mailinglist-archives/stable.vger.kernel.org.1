Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CE7A37F7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjIQT3e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjIQT3D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73DD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:28:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF8C433C8;
        Sun, 17 Sep 2023 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978937;
        bh=wySRDyCH0m4g9fmdSC+RnQEutCJw/NjjdwTQUpr8yFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs1eO3O01jTOCC7OT1HTe0bFu85Rn4VYfZOXtNUEd+AxDAubcr5NHbxKuz90WNVFd
         kX91H6vT4BEEJkGzJauFSmAAl9s7mXAlqYuNaaoavqxKGdbUpVqNxZE1HnPs1/ZSr3
         FYYzMCPi1TRQL8seWKPSp9X58/Ph4fNkJ85YDedk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 142/406] ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
Date:   Sun, 17 Sep 2023 21:09:56 +0200
Message-ID: <20230917191104.908372532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b77904ba177a9c67b6dbc3637fdf1faa22df6e5c ]

Backlight is supplied by DC5V regulator.  The DTS has no PMIC node, so
just add a regulator-fixed to solve it and fix dtbs_check warning:

  s5pv210-smdkv210.dtb: backlight: 'power-supply' is a required property

Link: https://lore.kernel.org/r/20230421095721.31857-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Stable-dep-of: 982655cb0e7f ("ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index fbae768d65e27..6e26c67e0a26e 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -55,6 +55,14 @@ backlight {
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_out>;
+		power-supply = <&dc5v_reg>;
+	};
+
+	dc5v_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "DC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
-- 
2.40.1



