Return-Path: <stable+bounces-5783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABF80D6E4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA251C219B5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494951C2A;
	Mon, 11 Dec 2023 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ueJGaAuy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825AFBE1;
	Mon, 11 Dec 2023 18:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF9FC433CC;
	Mon, 11 Dec 2023 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319651;
	bh=f4k8oNYr1BOX6BlZ2iDFPlmtZGDeDSvOT91ngqnDsp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueJGaAuyYgGUqh/1ls1d4mM/Q3H4BV7fys/dPB3XU/c3GcfX6MDlRvXGXiLc5+lic
	 YhBy4JCxm2uTG7KEc3K28GXjuwnK0ePAd5gZNhosh15MJ/LDLteDqkNCVak3eUDDTp
	 Jgez92G+Lj9FLKafL/TnUDkeo/EG+jWOgRRfAdls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.6 185/244] arm64: dts: mediatek: mt8183: Move thermal-zones to the root node
Date: Mon, 11 Dec 2023 19:21:18 +0100
Message-ID: <20231211182054.234290128@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

commit 5a60d63439694590cd5ab1f998fc917ff7ba1c1d upstream.

The thermal zones are not a soc bus device: move it to the root
node to solve simple_bus_reg warnings.

Cc: stable@vger.kernel.org
Fixes: b325ce39785b ("arm64: dts: mt8183: add thermal zone node")
Link: https://lore.kernel.org/r/20231025093816.44327-9-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  242 +++++++++++++++----------------
 1 file changed, 121 insertions(+), 121 deletions(-)

--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1210,127 +1210,6 @@
 			nvmem-cell-names = "calibration-data";
 		};
 
-		thermal_zones: thermal-zones {
-			cpu_thermal: cpu-thermal {
-				polling-delay-passive = <100>;
-				polling-delay = <500>;
-				thermal-sensors = <&thermal 0>;
-				sustainable-power = <5000>;
-
-				trips {
-					threshold: trip-point0 {
-						temperature = <68000>;
-						hysteresis = <2000>;
-						type = "passive";
-					};
-
-					target: trip-point1 {
-						temperature = <80000>;
-						hysteresis = <2000>;
-						type = "passive";
-					};
-
-					cpu_crit: cpu-crit {
-						temperature = <115000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-
-				cooling-maps {
-					map0 {
-						trip = <&target>;
-						cooling-device = <&cpu0
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu1
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu2
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu3
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-						contribution = <3072>;
-					};
-					map1 {
-						trip = <&target>;
-						cooling-device = <&cpu4
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu5
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu6
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu7
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-						contribution = <1024>;
-					};
-				};
-			};
-
-			/* The tzts1 ~ tzts6 don't need to polling */
-			/* The tzts1 ~ tzts6 don't need to thermal throttle */
-
-			tzts1: tzts1 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 1>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts2: tzts2 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 2>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts3: tzts3 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 3>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts4: tzts4 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 4>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts5: tzts5 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 5>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tztsABB: tztsABB {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 6>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-		};
-
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -2105,4 +1984,125 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_CAM>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <500>;
+			thermal-sensors = <&thermal 0>;
+			sustainable-power = <5000>;
+
+			trips {
+				threshold: trip-point0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point1 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu1
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu2
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu3
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <3072>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&cpu4
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu5
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu6
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu7
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* The tzts1 ~ tzts6 don't need to polling */
+		/* The tzts1 ~ tzts6 don't need to thermal throttle */
+
+		tzts1: tzts1 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 1>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts2: tzts2 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 2>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts3: tzts3 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 3>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts4: tzts4 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 4>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts5: tzts5 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 5>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tztsABB: tztsABB {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 6>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+	};
 };



