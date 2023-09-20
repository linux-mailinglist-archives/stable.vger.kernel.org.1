Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABF7A7FB3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjITM3h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjITM3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:29:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA688F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:29:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C6C433C9;
        Wed, 20 Sep 2023 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212970;
        bh=ryvPawaK43NcFzCSDMGpTsT6eP/ikKqmOsH4iUY7ZNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT9eI8fZFy2zELSvtXSvJ9tRPqTdNzalSAKnv6OPacCFDzVM1LX+aM6xOQY6UCXmM
         AVqiHrjkqh9qD7JEZbBTt3wNvEbuvisEFRQZLOGKvG17NSgbuYHldPialePQQSkqeW
         p6+IMBZS6zWSwRp2h46SpdOCukM06n+gHpgrWIpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/367] ARM: dts: BCM53573: Add cells sizes to PCIe node
Date:   Wed, 20 Sep 2023 13:27:52 +0200
Message-ID: <20230920112901.003820286@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 3392ef368d9b04622fe758b1079b512664b6110a ]

This fixes:
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#address-cells' is a required property
        From schema: /lib/python3.10/site-packages/dtschema/schemas/pci/pci-bus.yaml
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#size-cells' is a required property
        From schema: /lib/python3.10/site-packages/dtschema/schemas/pci/pci-bus.yaml

Two properties that need to be added later are "device_type" and
"ranges". Adding "device_type" on its own causes a new warning and the
value of "ranges" needs to be determined yet.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230707114004.2740-3-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm53573.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 4af8e3293cff4..34bd72b5c9cda 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -127,6 +127,9 @@ uart0: serial@300 {
 
 		pcie0: pcie@2000 {
 			reg = <0x00002000 0x1000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
 		};
 
 		usb2: usb2@4000 {
-- 
2.40.1



