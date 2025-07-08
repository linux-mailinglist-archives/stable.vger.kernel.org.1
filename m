Return-Path: <stable+bounces-160880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E7FAFD259
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A22F188CA06
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E221714B7;
	Tue,  8 Jul 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxfUazNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFF2E5418;
	Tue,  8 Jul 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992960; cv=none; b=YMb4SqVDeqis+qklw0T2s3h6IveQjOKryKa4skNUqHMih9tbDma+k8EZGrwzayPM1okCjlkVx66POHk8kRfc16ai5+Fd+cuP84LOq91Z8z0J4w9U2jZ4d4z0s/ab3SYU4FjuXicg/lphH0bsb03SJ8XSqpxZTXuVGuj6vg4BS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992960; c=relaxed/simple;
	bh=H18P/jzAAdQ21JzL0yPmAl1Ari/BXWUN0cTA3tj+pNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQ0/DX7mCM1wPB8ItoFbrxQLEj8KRwO4X6I6CK6q/4AnE9coLXuRRUUM7BsPsp6G/4Mr0O45aV2hxQhKQYsIIZfZY/CF0F/mwHFl99JeFZpRDAlMImwEMzDpE37IZoYh0D/UEmCOvzztcIrr2KCapdqssHIVRXWb984DLYGHt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxfUazNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0DBC4CEED;
	Tue,  8 Jul 2025 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992958;
	bh=H18P/jzAAdQ21JzL0yPmAl1Ari/BXWUN0cTA3tj+pNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxfUazNiofflG+XdN45RmKb0y5VWwBZi3n3ExaGUzKiDa/xx/binusx7dR0/7Jt7d
	 0yfcVbBjDMhl+KyK7Ug0Qos5nwjIHAaDV422BdIB2fYppdzll97Q5QZuF2kgqDS0uG
	 eJRh6xO8eTWbexEKOqkAcsl1bryfLYHby2eeCpXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 140/232] arm64: dts: renesas: Use interrupts-extended for Ethernet PHYs
Date: Tue,  8 Jul 2025 18:22:16 +0200
Message-ID: <20250708162245.106488095@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ba4d843a2ac646abc034b013c0722630f6ea1c90 ]

Use the more concise interrupts-extended property to fully describe the
interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # G2L family and G3S
Link: https://lore.kernel.org/e9db8758d275ec63b0d6ce086ac3d0ea62966865.1728045620.git.geert+renesas@glider.be
Stable-dep-of: 8ffec7d62c69 ("arm64: dts: renesas: white-hawk-single: Improve Ethernet TSN description")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi      | 3 +--
 arch/arm64/boot/dts/renesas/cat875.dtsi                  | 3 +--
 arch/arm64/boot/dts/renesas/condor-common.dtsi           | 3 +--
 arch/arm64/boot/dts/renesas/draak.dtsi                   | 3 +--
 arch/arm64/boot/dts/renesas/ebisu.dtsi                   | 3 +--
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi          | 3 +--
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts           | 3 +--
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts           | 3 +--
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts           | 3 +--
 arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts          | 3 +--
 .../arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi | 9 +++------
 arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts            | 6 ++----
 .../boot/dts/renesas/r8a779g2-white-hawk-single.dts      | 3 +--
 .../arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts | 3 +--
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi         | 6 ++----
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi        | 3 +--
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi        | 6 ++----
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi         | 6 ++----
 arch/arm64/boot/dts/renesas/salvator-common.dtsi         | 3 +--
 arch/arm64/boot/dts/renesas/ulcb.dtsi                    | 3 +--
 arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi   | 3 +--
 arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi     | 6 ++----
 22 files changed, 29 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index 68b04e56ae562..5a15a956702a6 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -62,8 +62,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index 8c9da8b4bd60b..191b051ecfd45 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -25,8 +25,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id001c.c915",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/condor-common.dtsi b/arch/arm64/boot/dts/renesas/condor-common.dtsi
index 8b7c0c34eadce..b2d99dfaa0cdf 100644
--- a/arch/arm64/boot/dts/renesas/condor-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/condor-common.dtsi
@@ -166,8 +166,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/draak.dtsi b/arch/arm64/boot/dts/renesas/draak.dtsi
index 6f133f54ded54..402112a37d75a 100644
--- a/arch/arm64/boot/dts/renesas/draak.dtsi
+++ b/arch/arm64/boot/dts/renesas/draak.dtsi
@@ -247,8 +247,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio5 19 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio5 18 GPIO_ACTIVE_LOW>;
 		/*
 		 * TX clock internal delay mode is required for reliable
diff --git a/arch/arm64/boot/dts/renesas/ebisu.dtsi b/arch/arm64/boot/dts/renesas/ebisu.dtsi
index cba2fde9dd368..1aedd093fb41b 100644
--- a/arch/arm64/boot/dts/renesas/ebisu.dtsi
+++ b/arch/arm64/boot/dts/renesas/ebisu.dtsi
@@ -314,8 +314,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 		/*
 		 * TX clock internal delay mode is required for reliable
diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index ad898c6db4e62..4113710d55226 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -27,8 +27,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id001c.c915",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index 0608dce92e405..7dd9e13cf0074 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -111,8 +111,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio1 17 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index e36999e91af53..0a103f93b14d7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -117,8 +117,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio1 17 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index 77d22df25fffa..a8a20c748ffcd 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -124,8 +124,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts b/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
index 63db822e5f466..6bd580737f25d 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
@@ -31,8 +31,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 16 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
index 33c1015e9ab38..5d38669ed1ec3 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
@@ -60,8 +60,7 @@ mdio {
 				u101: ethernet-phy@1 {
 					reg = <1>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 10 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -78,8 +77,7 @@ mdio {
 				u201: ethernet-phy@2 {
 					reg = <2>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 11 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -96,8 +94,7 @@ mdio {
 				u301: ethernet-phy@3 {
 					reg = <3>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 9 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts b/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
index fa910b85859e9..5d71d52f9c654 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
@@ -197,8 +197,7 @@ mdio {
 				ic99: ethernet-phy@1 {
 					reg = <1>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 10 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -216,8 +215,7 @@ mdio {
 				ic102: ethernet-phy@2 {
 					reg = <2>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 11 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
index 50a428572d9bd..0062362b0ba06 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
@@ -70,8 +70,7 @@ phy3: ethernet-phy@0 {
 			compatible = "ethernet-phy-id002b.0980",
 				     "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
-			interrupt-parent = <&gpio4>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio4 3 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
index 9a1917b87f613..f4d721a7f505c 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
@@ -175,8 +175,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio7>;
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio7 5 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 83f5642d0d35c..502d9f17bf16d 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -102,8 +102,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -130,8 +129,7 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index b4ef5ea8a9e34..de39311a77dc2 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -82,8 +82,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ0 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 79443fb3f5810..1a6fd58bd3682 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -78,8 +78,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -107,8 +106,7 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 612cdc7efabbc..d2d367c09abd4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -98,8 +98,7 @@ &eth0 {
 
 	phy0: ethernet-phy@7 {
 		reg = <7>;
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pinctrl RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
 		rxc-skew-psec = <0>;
 		txc-skew-psec = <0>;
 		rxdv-skew-psec = <0>;
@@ -124,8 +123,7 @@ &eth1 {
 
 	phy1: ethernet-phy@7 {
 		reg = <7>;
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pinctrl RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
 		rxc-skew-psec = <0>;
 		txc-skew-psec = <0>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 1eb4883b32197..c5035232956a8 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -353,8 +353,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index a2f66f9160484..4cf141a701c06 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -150,8 +150,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi b/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
index 3845b413bd24c..69e4fddebd4e4 100644
--- a/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
@@ -167,8 +167,7 @@ avb0_phy: ethernet-phy@0 {
 				     "ethernet-phy-ieee802.3-c22";
 			rxc-skew-ps = <1500>;
 			reg = <0>;
-			interrupt-parent = <&gpio7>;
-			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio7 5 IRQ_TYPE_LEVEL_LOW>;
 			reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi b/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
index 595ec4ff4cdd0..ad94bf3f5e6c4 100644
--- a/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
+++ b/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
@@ -29,8 +29,7 @@ mdio {
 		avb1_phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c45";
 			reg = <0>;
-			interrupt-parent = <&gpio6>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio6 3 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
@@ -51,8 +50,7 @@ mdio {
 		avb2_phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c45";
 			reg = <0>;
-			interrupt-parent = <&gpio5>;
-			interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio5 4 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
-- 
2.39.5




