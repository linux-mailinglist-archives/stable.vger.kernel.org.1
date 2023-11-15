Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347467ECEF5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjKOTpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjKOTpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311161A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5412C433CC;
        Wed, 15 Nov 2023 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077517;
        bh=iKgbKtLGFZvc15XD7W5o05V96XyM2x49ySwDajLlrwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ozk0agOEjHdsCfMSeM8UXvEdMxAWRwwNEbc0Qa4Es/xCk8qmzJnPpG9HCASuneFzU
         vHPAwMTWJ79IRNRIOoA++dMT0K5sRnY4rUFidPPvMYjj1ww/K5RMxeu3ixsxjwPURW
         su/aEtYrpnuooOPJ/K0HmbioqtwTvD4xoe+nNL/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 326/603] ARM: dts: BCM5301X: Explicitly disable unused switch CPU ports
Date:   Wed, 15 Nov 2023 14:14:31 -0500
Message-ID: <20231115191636.068131516@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 473baeab929444295b0530f8766e4becb6a08973 ]

When redescribing ports I assumed that missing "label" (like "cpu")
means switch port isn't used. That was incorrect and I realized my
change made Linux always use the first (5) CPU port (there are 3 of
them).

While above should technically be possible it often isn't correct:
1. Non-default switch ports are often connected to Ethernet interfaces
   not fully covered by vendor setup (they may miss MACs)
2. On some devices non-default ports require specifying fixed link

This fixes network connectivity for some devices. It was reported &
tested for Netgear R8000. It also affects Linksys EA9200 with its
downstream DTS.

Fixes: ba4aebce23b2 ("ARM: dts: BCM5301X: Describe switch ports in the main DTS")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20231013103314.10306-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi  | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts     | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts     | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts      | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts    | 8 ++++++++
 .../boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts      | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts    | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts       | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts       | 8 ++++++++
 arch/arm/boot/dts/broadcom/bcm953012er.dts                | 8 ++++++++
 20 files changed, 160 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi
index 42bcbf10957c4..9f9084269ef58 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi
@@ -181,5 +181,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts
index e04d2e5ea51aa..72e960c888ac8 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts
@@ -85,5 +85,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts
index a399800139d9c..750e17482371c 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts
@@ -88,5 +88,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts
index fad3473810a2e..2bdbc7d18b0eb 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts
@@ -122,5 +122,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts
index 5b2b7b8b3b123..b226bef3369cf 100644
--- a/arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts
@@ -145,6 +145,14 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts
index d0a26b643b82f..192b8db5a89c3 100644
--- a/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts
@@ -145,5 +145,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts
index 9f21d6d6d35b7..0198b5f9e4a75 100644
--- a/arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts
@@ -81,5 +81,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts
index 2561072917021..73ff1694a4a0b 100644
--- a/arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts
@@ -148,5 +148,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
index 707c561703ed8..55fc9f44cbc7f 100644
--- a/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts
@@ -227,6 +227,14 @@ port@4 {
 			label = "wan";
 		};
 
+		port@5 {
+			status = "disabled";
+		};
+
+		port@7 {
+			status = "disabled";
+		};
+
 		port@8 {
 			label = "cpu";
 		};
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts
index c914569ddd5ec..e6d26987865d0 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts
@@ -144,6 +144,14 @@ port@4 {
 			label = "wan";
 		};
 
+		port@5 {
+			status = "disabled";
+		};
+
+		port@7 {
+			status = "disabled";
+		};
+
 		port@8 {
 			label = "cpu";
 		};
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts
index f050acbea0b20..3124dfd01b944 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts
@@ -192,6 +192,14 @@ port@4 {
 			label = "wan";
 		};
 
+		port@5 {
+			status = "disabled";
+		};
+
+		port@7 {
+			status = "disabled";
+		};
+
 		port@8 {
 			label = "cpu";
 			phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts
index e8991d4e248ce..e374062eb5b76 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts
@@ -107,5 +107,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts
index afc635c8cdebb..badafa024d24c 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts
@@ -120,5 +120,13 @@ port@1 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts
index 7cfa4607ef311..cf95af9db1e66 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts
@@ -107,5 +107,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts
index d55e10095eae7..992c19e1cfa17 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts
@@ -75,5 +75,13 @@ port@0 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts
index ccf031c0e276d..4d0ba315a2049 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts
@@ -147,5 +147,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
index e28f7a3501179..83c429afc2974 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts
@@ -158,5 +158,13 @@ port@4 {
 		port@5 {
 			label = "cpu";
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts b/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
index 03ad614e6b721..0bf5106f7012c 100644
--- a/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
+++ b/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
@@ -124,6 +124,14 @@ fixed-link {
 				full-duplex;
 			};
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts
index 26c12bfb0bdd4..25eeacf6a2484 100644
--- a/arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts
@@ -185,6 +185,14 @@ fixed-link {
 				full-duplex;
 			};
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/broadcom/bcm953012er.dts b/arch/arm/boot/dts/broadcom/bcm953012er.dts
index 4fe3b36533767..d939ec9f4a9e7 100644
--- a/arch/arm/boot/dts/broadcom/bcm953012er.dts
+++ b/arch/arm/boot/dts/broadcom/bcm953012er.dts
@@ -84,6 +84,14 @@ port@5 {
 			label = "cpu";
 			ethernet = <&gmac0>;
 		};
+
+		port@7 {
+			status = "disabled";
+		};
+
+		port@8 {
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.42.0



