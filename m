Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB37A37F1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbjIQT3D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbjIQT24 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:28:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19090DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:28:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C837C433C7;
        Sun, 17 Sep 2023 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978930;
        bh=mypTjekJ8JFdM//haH6b+cCK8gj14JIBQYS+vD6BwDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8xzQk2BDHYWtGxXLAmVS92mCleYdaYNedg3N6fC1npbsoEmkK1j/FcsCi1+7i6DA
         vxLKFQl60cVIUBor3d84l+PxKw6JEtrUHQYMnLKGkShhhNQKYP+U4y2LZN8uE1bDQA
         3/bUscyzoUfsgbet3OYZA44e0uqoIxSg42BFMROQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 140/406] ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
Date:   Sun, 17 Sep 2023 21:09:54 +0200
Message-ID: <20230917191104.856764020@linuxfoundation.org>
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

[ Upstream commit cf0cb2af6a18f28b84f9f1416bff50ca60d6e98a ]

The davicom,dm9000 Ethernet Controller accepts two reg addresses.

Fixes: a43736deb47d ("ARM: dts: Add dts file for S3C6410-based Mini6410 board")
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20230713152926.82884-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 17097da36f5ed..0b07b3c319604 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -51,7 +51,7 @@ srom-cs1-bus@18000000 {
 
 		ethernet@18000000 {
 			compatible = "davicom,dm9000";
-			reg = <0x18000000 0x2 0x18000004 0x2>;
+			reg = <0x18000000 0x2>, <0x18000004 0x2>;
 			interrupt-parent = <&gpn>;
 			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 			davicom,no-eeprom;
-- 
2.40.1



