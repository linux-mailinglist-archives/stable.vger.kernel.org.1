Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DB7A7DC7
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjITMMO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjITMMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCEA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:12:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486B1C433C7;
        Wed, 20 Sep 2023 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211928;
        bh=8PzKCL58Z+yxLn3ajl9lu9YLV87/FYesg1IsW1KL5OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGWUnSDOCITBC9Fiw2mxirjlNuLV3EUCeDiRnzRLIdTSayj/1EvtNA2hR+BTQhSzZ
         lIDTdNUIwXFfy9iU1pB0Jyb+IoZtGWUSY1pV9xhmiPWvN8mIky/jklQdbaWZUH6WVZ
         Zl8NSg0l5pCrReu4MPGqGZa8+qCLc9rY4DLDc/ZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/273] ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410
Date:   Wed, 20 Sep 2023 13:28:47 +0200
Message-ID: <20230920112849.133302904@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



