Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC6735300
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjFSKlG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjFSKkX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812518C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5673160B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A984C433C8;
        Mon, 19 Jun 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171221;
        bh=6Omcazp4ERw0XeCK4FxAOQ7zDZ5HzxGDwzhDS7KwBuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7WhwKdrcoDMf+/NKCepGf/x8LqE0s6LJtIRq9vqN+0yfV2VEsr8Bz514BVqsPy9K
         zq7fyWhyuC2Hb3WF9rJ5YUB5KkFMFQGN4stoic4xBbL/XAG12h42f1eWLk1KfdulXQ
         oIeQJhqWUVGpolmsSOm3NiFS721UrFxr/+GVSy8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.3 184/187] arm64: dts: qcom: sm8550: Use the correct LLCC register scheme
Date:   Mon, 19 Jun 2023 12:30:02 +0200
Message-ID: <20230619102206.618457421@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

commit 661a4f089317c877aecd598fb70cd46510cc8d29 upstream.

During the ABI-breaking (for good reasons) conversion of the LLCC
register description, SM8550 was not taken into account, resulting
in LLCC being broken on any kernel containing the patch referenced
in the fixes tag.

Fix it by describing the regions properly.

Fixes: ee13b5008707 ("qcom: llcc/edac: Fix the base address used for accessing LLCC banks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230517-topic-kailua-llcc-v1-2-d57bd860c43e@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3423,9 +3423,16 @@
 
 		system-cache-controller@25000000 {
 			compatible = "qcom,sm8550-llcc";
-			reg = <0 0x25000000 0 0x800000>,
+			reg = <0 0x25000000 0 0x200000>,
+			      <0 0x25200000 0 0x200000>,
+			      <0 0x25400000 0 0x200000>,
+			      <0 0x25600000 0 0x200000>,
 			      <0 0x25800000 0 0x200000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base",
+				    "llcc1_base",
+				    "llcc2_base",
+				    "llcc3_base",
+				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 


