Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156CA7A7FC3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjITMaQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjITMaO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E97392
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4374C433C8;
        Wed, 20 Sep 2023 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213008;
        bh=wQVnXmrr8WNGwJrcebX2/6pwjC+PwV3S6A4APRZthaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZkcTcuF2L5i7HPXZwi1TfxMwyxDpsf6zbVU9CzbHB8QQzR6lbPMiEaelIA/286yB
         A+BEbD4FDlUWECRRrGr93Xvc9p7fo+6lrRyd/m22SOCGTg1qtw4HpsKqXabCtfPQph
         RGwPIOfyQvZ06esiQJrqem+QX2orpQE63efZ9daM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 099/367] ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410
Date:   Wed, 20 Sep 2023 13:27:56 +0200
Message-ID: <20230920112901.123321400@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 5911622eff5134c4bf1e16e4e1e2fd18c4f24889 ]

The SROM controller is modeled with a bus so align the device node name
with dtschema to fix warning:

  srom-cs1@18000000: $nodename:0: 'srom-cs1@18000000'
    does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20200907183313.29234-5-krzk@kernel.org
Stable-dep-of: cf0cb2af6a18 ("ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 75067dbcf7e83..285555b9ed943 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -42,7 +42,7 @@ xusbxti: oscillator-1 {
 		#clock-cells = <0>;
 	};
 
-	srom-cs1@18000000 {
+	srom-cs1-bus@18000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.40.1



