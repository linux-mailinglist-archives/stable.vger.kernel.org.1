Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85868761453
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjGYLSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjGYLSE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C371A6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5E2C615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C407BC433C8;
        Tue, 25 Jul 2023 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283880;
        bh=MjXEplh2LFxNdvNusWXTVeXmi8yf7fmkiBIvsSos5zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWsm7yBFiiUD/l54aq+m7s0ryIiio2oUf1bp/cj5WfslJrxCD6rKvqw7K8Ge1AY3z
         /R9VpwbAaD9vjpTR/kxom7KrfW2ofL6gQ+OcNDN/LTTFvG0A75bZ9xtRirKRzIpuJk
         gn4fw9lbM39mmi/ObWQfM2UsWxghjLhICRWWVJN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 126/509] arm64: dts: qcom: apq8096: fix fixed regulator name property
Date:   Tue, 25 Jul 2023 12:41:05 +0200
Message-ID: <20230725104559.463370855@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c77612a07d18d4425fd8ddd532a8a9b8e1970c53 ]

Correct the typo in 'regulator-name' property.

  apq8096-ifc6640.dtb: v1p05-regulator: 'regulator-name' is a required property
  apq8096-ifc6640.dtb: v1p05-regulator: Unevaluated properties are not allowed ('reglator-name' was unexpected)

Fixes: 6cbdec2d3ca6 ("arm64: dts: qcom: msm8996: Introduce IFC6640")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230507174516.264936-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index f6ddf17ada81b..861b356a982b7 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -26,7 +26,7 @@ chosen {
 
 	v1p05: v1p05-regulator {
 		compatible = "regulator-fixed";
-		reglator-name = "v1p05";
+		regulator-name = "v1p05";
 		regulator-always-on;
 		regulator-boot-on;
 
@@ -38,7 +38,7 @@ v1p05: v1p05-regulator {
 
 	v12_poe: v12-poe-regulator {
 		compatible = "regulator-fixed";
-		reglator-name = "v12_poe";
+		regulator-name = "v12_poe";
 		regulator-always-on;
 		regulator-boot-on;
 
-- 
2.39.2



