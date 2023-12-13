Return-Path: <stable+bounces-6319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081F80DA09
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AA41F21C30
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2C524B2;
	Mon, 11 Dec 2023 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/yitFYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1F51C50;
	Mon, 11 Dec 2023 18:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFA6C433C7;
	Mon, 11 Dec 2023 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321108;
	bh=GchLH2zTqV7nMA7tqI6YDenz8MjmATT4FeM/EDAI5lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/yitFYCM8R4t1svspjNqQawiDDymtcy/ZSOXt6r29Y7+izCueMjGYpZuDzOsu3c2
	 YNj/XpAEn9k6U7ysZNyPYPP9Dr4dvBQ28WowIlqm72MskA+mgVZ7DVzMBjrxSFp2tk
	 zlhHaqUVU3kMP3h3AAVdOmhDZozGCIqj1YJGSwJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/141] arm64: dts: mediatek: mt8183: Move thermal-zones to the root node
Date: Mon, 11 Dec 2023 19:22:52 +0100
Message-ID: <20231211182031.448569809@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 5a60d63439694590cd5ab1f998fc917ff7ba1c1d ]

The thermal zones are not a soc bus device: move it to the root
node to solve simple_bus_reg warnings.

Cc: stable@vger.kernel.org
Fixes: b325ce39785b ("arm64: dts: mt8183: add thermal zone node")
Link: https://lore.kernel.org/r/20231025093816.44327-9-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 242 +++++++++++------------
 1 file changed, 121 insertions(+), 121 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index ac05284cce867..2d33f4a583b48 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -766,127 +766,6 @@ thermal: thermal@1100b000 {
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
@@ -1495,4 +1374,125 @@ larb3: larb@1a002000 {
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
-- 
2.42.0




