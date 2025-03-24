Return-Path: <stable+bounces-125882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85EA6D8C6
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4216D3AD378
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502101A317E;
	Mon, 24 Mar 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mninbDkJ"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA010A3E;
	Mon, 24 Mar 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814053; cv=none; b=uB71R02DBEPyABSe2cEoEuNaMmCaqKPlPkhR0K43xdIstwFmJm0ss+KxfaP1AKkij/kIaS8MBTPT9Q+pkcnHK1VfTgXyNDRNEQgtPNTVIHzstOuAEdiW3lG2LuyZ5WQZc1KezXn12XY4KpVKEDLATWqgDK8Vwmz3nbveP73tdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814053; c=relaxed/simple;
	bh=dBLODITVg4xgq7yY5gLDq9AnZBGEPLBs0csATx5eMaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqUhIQyuUxPN5eig1RqOOKCuTTZOynmBiM/W2xP69J5ErXDILZhiXPtYVxOschK4DYYNcjMMCw+YacM+ogi3vbiiS51ZLrU1evN0zB6kwGJS+AjUg6vQABtx7DFWmWkkrj/zjYGAPhL1LztiN/aGupikB7PIL0ZGt5D2Z6yunn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mninbDkJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742814047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rHuROZnnYS52NtcI84OVTo9RCXp2wpkeXDDVlfPt4bY=;
	b=mninbDkJMZh1hKxGonj2VDg1jotY3Rbe7BbbAYgxm1amZz1zas26XyE1/2CfsgLVgqT2YT
	xII3MVh+AD0CxKqlSUNoiYIwONjWjt4vZqwLvReT+8HsgowpWv/9bhwpPvu+n4Lw/ZbeNL
	fqMyeLrS0Ypyem7rfeFKgf+c3MS5QzaWZBWO0k1uUk6dRr6DGL5Vy2e2H10ykRCCvj/J01
	mZWYgCNw+g+BNGNuMeDI5RflRISP7u6tfjSbaIEUor+H4Ofz2R6TfSClkJDfYQh3JeCC+z
	Gbz6+S9XzLdKSdcv+htFZt4+D41SW/SUJfIJUxPoP0UQjgUBPf0P6lOxbIVIjg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org,
	Alexey Charkov <alchark@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: Remove overdrive-mode OPPs from RK3588J SoC dtsi
Date: Mon, 24 Mar 2025 12:00:43 +0100
Message-Id: <eeec0d30d79b019d111b3f0aa2456e69896b2caa.1742813866.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

The differences in the vendor-approved CPU and GPU OPPs for the standard
Rockchip RK3588 variant [1] and the industrial Rockchip RK3588J variant [2]
come from the latter, presumably, supporting an extended temperature range
that's usually associated with industrial applications, despite the two SoC
variant datasheets specifying the same upper limit for the allowed ambient
temperature for both variants.  However, the lower temperature limit is
specified much lower for the RK3588J variant. [1][2]

To be on the safe side and to ensure maximum longevity of the RK3588J SoCs,
only the CPU and GPU OPPs that are declared by the vendor to be always safe
for this SoC variant may be provided.  As explained by the vendor [3] and
according to the RK3588J datasheet, [2] higher-frequency/higher-voltage
CPU and GPU OPPs can be used as well, but at the risk of reducing the SoC
lifetime expectancy.  Presumably, using the higher OPPs may be safe only
when not enjoying the assumed extended temperature range that the RK3588J,
as an SoC variant targeted specifically at higher-temperature, industrial
applications, is made (or binned) for.

Anyone able to keep their RK3588J-based board outside the above-presumed
extended temperature range at all times, and willing to take the associated
risk of possibly reducing the SoC lifetime expectancy, is free to apply
a DT overlay that adds the higher CPU and GPU OPPs.

With all this and the downstream RK3588(J) DT definitions [4][5] in mind,
let's delete the RK3588J CPU and GPU OPPs that are not considered belonging
to the normal operation mode for this SoC variant.  To quote the RK3588J
datasheet [2], "normal mode means the chipset works under safety voltage
and frequency;  for the industrial environment, highly recommend to keep in
normal mode, the lifetime is reasonably guaranteed", while "overdrive mode
brings higher frequency, and the voltage will increase accordingly;  under
the overdrive mode for a long time, the chipset may shorten the lifetime,
especially in high-temperature condition".

To sum the RK3588J datasheet [2] and the vendor-provided DTs up, [4][5]
the maximum allowed CPU core, GPU and NPU frequencies are as follows:

   IP core    | Normal mode | Overdrive mode
  ------------+-------------+----------------
   Cortex-A55 |   1,296 MHz |      1,704 MHz
   Cortex-A76 |   1,608 MHz |      2,016 MHz
   GPU        |     700 MHz |        850 MHz
   NPU        |     800 MHz |        950 MHz

Unfortunately, when it comes to the actual voltages for the RK3588J CPU and
GPU OPPs, there's a discrepancy between the RK3588J datasheet [2] and the
downstream kernel code. [4][5]  The RK3588J datasheet states that "the max.
working voltage of CPU/GPU/NPU is 0.75 V under the normal mode", while the
downstream kernel code actually allows voltage ranges that go up to 0.95 V,
which is still within the voltage range allowed by the datasheet.  However,
the RK3588J datasheet also tells us to "strictly refer to the software
configuration of SDK and the hardware reference design", so let's embrace
the voltage ranges provided by the downstream kernel code, which also
prevents the undesirable theoretical outcome of ending up with no usable
OPPs on a particular board, as a result of the board's voltage regulator(s)
being unable to deliver the exact voltages, for whatever reason.

The above-described voltage ranges for the RK3588J CPU OPPs remain taken
from the downstream kernel code [4][5] by picking the highest, worst-bin
values, which ensure that all RK3588J bins will work reliably.  Yes, with
some power inevitably wasted as unnecessarily generated heat, but the
reliability is paramount, together with the longevity.  This deficiency
may be revisited separately at some point in the future.

The provided RK3588J CPU OPPs follow the slightly debatable "provide only
the highest-frequency OPP from the same-voltage group" approach that's been
established earlier, [6] as a result of the "same-voltage, lower-frequency"
OPPs being considered inefficient from the IPA governor's standpoint, which
may also be revisited separately at some point in the future.

[1] https://wiki.friendlyelec.com/wiki/images/e/ee/Rockchip_RK3588_Datasheet_V1.6-20231016.pdf
[2] https://wmsc.lcsc.com/wmsc/upload/file/pdf/v2/lcsc/2403201054_Rockchip-RK3588J_C22364189.pdf
[3] https://lore.kernel.org/linux-rockchip/e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de/T/#u
[4] https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
[5] https://raw.githubusercontent.com/rockchip-linux/kernel/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
[6] https://lore.kernel.org/all/20240229-rk-dts-additions-v3-5-6afe8473a631@gmail.com/

Fixes: 667885a68658 ("arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j")
Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j")
Cc: stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>
Helped-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Reworded and expanded the patch description a bit, to include some
        more information and to make it more clear what are the implied
        speculations and assumptions, and what are the available official
        statements from Rockchip, as suggested by Quentin [7]
      - Collected Reviewed-by tag from Quentin [7]
    
    Link to v1: https://lore.kernel.org/linux-rockchip/f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org/T/#u
    
    [7] https://lore.kernel.org/linux-rockchip/71b7c81b-6a4e-442b-a661-04d63639962a@cherry.de/

 arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 53 ++++++++---------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index bce72bac4503..3045cb3bd68c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -11,74 +11,59 @@ cluster0_opp_table: opp-table-cluster0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-1416000000 {
-			opp-hz = /bits/ 64 <1416000000>;
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <750000 750000 950000>;
 			clock-latency-ns = <40000>;
 			opp-suspend;
 		};
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <887500 887500 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-1704000000 {
-			opp-hz = /bits/ 64 <1704000000>;
-			opp-microvolt = <937500 937500 950000>;
+		opp-1296000000 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-microvolt = <775000 775000 950000>;
 			clock-latency-ns = <40000>;
 		};
 	};
 
 	cluster1_opp_table: opp-table-cluster1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-1200000000{
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <750000 750000 950000>;
+			opp-microvolt = <762500 762500 950000>;
 			clock-latency-ns = <40000>;
 		};
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <787500 787500 950000>;
 			clock-latency-ns = <40000>;
 		};
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <875000 875000 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-2016000000 {
-			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	cluster2_opp_table: opp-table-cluster2 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-1200000000{
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <750000 750000 950000>;
+			opp-microvolt = <762500 762500 950000>;
 			clock-latency-ns = <40000>;
 		};
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <787500 787500 950000>;
 			clock-latency-ns = <40000>;
 		};
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <875000 875000 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-2016000000 {
-			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	gpu_opp_table: opp-table {
@@ -104,10 +89,6 @@ opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <750000 750000 850000>;
 		};
-		opp-850000000 {
-			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <787500 787500 850000>;
-		};
 	};
 };
 

