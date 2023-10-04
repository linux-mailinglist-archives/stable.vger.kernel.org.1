Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14D97B885A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbjJDSPQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbjJDSPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3B0A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83370C433C8;
        Wed,  4 Oct 2023 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443311;
        bh=OFqpLlgQUQK0vxLrPghQbJpQtwDQ+NX7zP/cTc+v6eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/q31yZzUekYgFsOkAoQLbiHKggP12G3oylVokynN06LX6KRM67KY1aqyGa+iFocs
         jfhWL4cpdFvHu87KC397vFXwHBRxXyOGvMf35IzL+Wj2++mx472ITnMnY0+u1zT1Me
         K5BEdjclYp6Gf+FqPu2sx7K6Vsoct707ke+q10sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/259] ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen
Date:   Wed,  4 Oct 2023 19:54:27 +0200
Message-ID: <20231004175221.654446728@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 43db69268149049540b1d2bbe8a69e59d5cb43b6 ]

There is no syna,f11-flip-x property, so assume intention was to use
touchscreen-inverted-x.

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b5..4abc85c181690 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -131,8 +131,8 @@
 
 		rmi-f11@11 {
 			reg = <0x11>;
-			syna,f11-flip-x = <1>;
 			syna,sensor-type = <1>;
+			touchscreen-inverted-x;
 		};
 	};
 };
-- 
2.40.1



