Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48175D25C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGUS6t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGUS6t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7830CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B6F461D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B19C433C8;
        Fri, 21 Jul 2023 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965927;
        bh=4wa9dory63ytiRvMxlRHwQ25dV0eYXU7+bo9HAseS4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZW6apTrd0VI2ZK+CaEJqVeyLKWsd3lwgzXPKWyYuMPHInjoIkgNpTHEeB3XiFXTz
         QKGFTgvt0gUduAskvQ+VyJfX5zi2ORunawJkGH+j0YK0XXO/m1ggAjVWrg6HySIhBn
         eZPO2J1O7IYfySmi8UaV42ksofOf9yx3zoqjfOUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 135/532] arm64: dts: qcom: apq8016-sbc: fix mpps state names
Date:   Fri, 21 Jul 2023 18:00:39 +0200
Message-ID: <20230721160621.783895627@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit a4344427eadd6caf0dc9e5384b023083e567221d ]

The majority of device tree nodes for mpps use xxxx-state as pinctrl
nodes. Change names of mpps pinctrl nodes for the apq8016-sbc board to
follow that pattern.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20211008012524.481877-13-dmitry.baryshkov@linaro.org
Stable-dep-of: e27654df20d7 ("arm64: dts: qcom: apq8016-sbc: Fix regulator constraints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 0e4a1f0040211..1c097098f1e0f 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -821,7 +821,7 @@ &pm8916_mpps {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ls_exp_gpio_f>;
 
-	ls_exp_gpio_f: pm8916-mpp4 {
+	ls_exp_gpio_f: pm8916-mpp4-state {
 		pins = "mpp4";
 		function = "digital";
 
@@ -829,7 +829,7 @@ ls_exp_gpio_f: pm8916-mpp4 {
 		power-source = <PM8916_MPP_L5>;	// 1.8V
 	};
 
-	pm8916_mpps_leds: pm8916-mpps-leds {
+	pm8916_mpps_leds: pm8916-mpps-state {
 		pins = "mpp2", "mpp3";
 		function = "digital";
 
-- 
2.39.2



