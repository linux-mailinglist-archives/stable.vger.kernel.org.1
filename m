Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AB7A391A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjIQTpG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbjIQTom (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:44:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D5185
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:44:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBFBC433C9;
        Sun, 17 Sep 2023 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979874;
        bh=Ab8r9Nuna+lAskGZe9UQgHObvvgkNEh1LWL5wIuofMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYhoDRzZgTIaWKura0GtiSGP+MgzkW0q/hONH2SUZkMITCbmUNU6Id0wHFvlGEJde
         J8TlouCi6s84Do0lFTlqYCnhPhcVQcrdODBgrX8cClI2ucJ8jogDCAg5jrrx2Uinep
         k94boxYcs9aJxkja6rDv6+vDW8KqZIyg7UYGkqjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 031/285] ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode
Date:   Sun, 17 Sep 2023 21:10:31 +0200
Message-ID: <20230917191052.748664717@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 7c74379afdfee7b13f1cd8ff1ad6e0f986aec96c upstream.

There is no syna,nosleep property in Synaptics RMI4 touchscreen:

  qcom-msm8974pro-sony-xperia-shinano-castor.dtb: synaptics@2c: rmi4-f01@1: 'syna,nosleep' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-6-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -127,7 +127,7 @@
 
 		rmi4-f01@1 {
 			reg = <0x1>;
-			syna,nosleep = <1>;
+			syna,nosleep-mode = <1>;
 		};
 
 		rmi4-f11@11 {


