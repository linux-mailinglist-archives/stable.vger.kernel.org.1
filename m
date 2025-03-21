Return-Path: <stable+bounces-125730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C9A6B356
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 04:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C3D3B8538
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E571E5B7A;
	Fri, 21 Mar 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="efsqqC+I"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AED78F5B;
	Fri, 21 Mar 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527744; cv=none; b=FvXDyIbzWeClD4lLg1e2jU5x0y5auNncrbIfRpcTUIVB51jwJTK2Ap4sZKEqlWgnIKYc0UlV8X/hydCoPyzydlSEqaa/WljSTOaeDMHl9jJTLWWy+5QnRscpYUGkPffXIqjZ5VKa/RqiC/J6q4zvPUkeW972BPr36P0f0ZS6KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527744; c=relaxed/simple;
	bh=VLdzNTb4ENqsioNfG08wfvdE6JVwxPuGTnBZHq6pp5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbwqzEZul0icRR34EXHtg+fZL2u+UXtdEsYTQa1y0Yu159BtJfzddHq/zJs9mPrreAL7fkHOHTa6+cRofHB0PJqBKF03ZJakeea7rAqDlOhNxmYakpZmzR77HFApTnHl85kLiQQbMKVGWEcPYbh6wki5QNYeHsDad0iatrz4HJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=efsqqC+I; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742527737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TvimR6SKo0jtW7eTJ4niI635OpzUmByoQ1ePS3vCVMo=;
	b=efsqqC+In51YqG17swWvtDJmtXPw/VfdVPNwfuCEPtWye0J0e3juf/qxyhpq6e38T9cmjx
	psIlggfq4gYjKmDY12xsnKMfzBUyPvcDgPbzZboB5JpXzv6VValNa6hnK/5DCCsVU2Boag
	+h3tq7LhyDyoFJSwTul01XrJ0ObfKkm1Nr4PP2YotgGcwntmOZdfNzN3J6aOX3vW0w0aEI
	i0ONlST1c908yXV9jfKeBqHf/YKasM6poA8P3cSmzKLFzXB88OY2M6uVKETwFQCdTM6zx8
	Yf3ZOuWUiCj4TujmlOBAdtgCmBsH4i6Sgojwu2rCOe5EOa239fQvs6/KIaSi9w==
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
Subject: [PATCH] arm64: dts: rockchip: Remove overdrive-mode OPPs from RK3588J SoC dtsi
Date: Fri, 21 Mar 2025 04:28:49 +0100
Message-Id: <f929da061de35925ea591c969f985430e23c4a7e.1742526811.git.dsimic@manjaro.org>
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
according to its datasheet, [2] the RK3588J variant can actually run safely
at higher CPU and GPU OPPs as well, but only when not enjoying the assumed
extended temperature range that the RK3588J, as an SoC variant targeted
specifically at industrial applications, is made (or binned) for.

Thus, only the CPU and GPU OPPs that are specified by the vendor to be safe
throughout the entire RK3588J's extended temperature range may be provided,
while anyone who actually can ensure that their RK3588J-based board is
never going to run within the extended temperature range, may probably
safely apply a DT overlay that adds the higher CPU and GPU OPPs.  As we
obviously can't know what will be the runtime temperature conditions for
a particular board, we may provide only the always-safe OPPs.

With all this and the downstream RK3588(J) DT definitions [4][5] in mind,
let's delete the RK3588J CPU and GPU OPPs that are not considered belonging
to the normal operation mode for this SoC variant.  To quote the RK3588J
datasheet [2], "normal mode means the chipset works under safety voltage
and frequency;  for the industrial environment, highly recommend to keep in
normal mode, the lifetime is reasonably guaranteed", while "overdrive mode
brings higher frequency, and the voltage will increase accordingly;  under
the overdrive mode for a long time, the chipset may shorten the lifetime,
especially in high temperature condition".

To sum up the RK3588J datasheet [2] and the vendor-provided DTs, [4][5]
the maximum allowed CPU core and GPU frequencies are as follows:

   IP core    | Normal mode | Overdrive mode
  ------------+-------------+----------------
   Cortex-A55 |   1,296 MHz |      1,704 MHz
   Cortex-A76 |   1,608 MHz |      2,016 MHz
   GPU        |     700 MHz |        850 MHz

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
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
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
 

