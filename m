Return-Path: <stable+bounces-148912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ACAACABD0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3430A17B120
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC551DFD8F;
	Mon,  2 Jun 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qb01/cPh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10D1754B
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857636; cv=none; b=Qh/OPRyba6w+gXrFNy2JmQIqdOEXhSoBuFllR65Ks1RBJsUEIBBhXYmUuAyZkWhKsuCCcyZ6SKslgF8DJxeKJrpd1XrfhQoCgsB0UK9VK9NJPw0v8qj/rHiJehP2qRICvXssX7jWT80YtmHLRg/dut0RFHzWMLfIkNZmPZwdxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857636; c=relaxed/simple;
	bh=rrLtYmCT4I0a+a9d7fFU2o8+ngQqbF0nZs1YWLnEr24=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZRxRcMBk7kWqLyhQVuVmL2vwpwoEMWGCcSH89XZbMmDdWAce67Uf1sLmsqVoNsJ+Mw5ro8U1UGCzOsJJ4wdIiHrdlAAphItI4FRkkzo3KqCzJRr6cDPKbkckolz2OAz2eZ9NmUk/XgmzoC00UIKIT0YHo/lwiLI9ZhzNNQWO+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qb01/cPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC67C4CEEB;
	Mon,  2 Jun 2025 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857635;
	bh=rrLtYmCT4I0a+a9d7fFU2o8+ngQqbF0nZs1YWLnEr24=;
	h=Subject:To:Cc:From:Date:From;
	b=qb01/cPhiPVjA/PDgkLN1bZYiX3fLv3rzLlTNVDq4v8ippEn2VIS93gdmN/UOlFML
	 C95Hmfxz/RhzzvWsGZGFUeoYVELrzryUtNjtVEKATcYAFrQ53s1GtaQ748N2vJl7mR
	 eOBNesYUrr+Dbv/lYP1BSuzMDCGAmKKFAz10Dmq0=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e80100: Add GPU cooling" failed to apply to 6.12-stable tree
To: stephan.gerhold@linaro.org,andersson@kernel.org,johan+linaro@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:47:12 +0200
Message-ID: <2025060212-chamomile-scorecard-ba20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5ba21fa11f473c9827f378ace8c9f983de9e0287
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060212-chamomile-scorecard-ba20@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ba21fa11f473c9827f378ace8c9f983de9e0287 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 19 Feb 2025 12:36:20 +0100
Subject: [PATCH] arm64: dts: qcom: x1e80100: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures. With certain high GPU loads it is possible to
reach the critical hardware shutdown temperature of 120°C, endangering the
hardware and making it impossible to run certain applications.

Set up GPU cooling similar to the ACPI tables, by throttling the GPU speed
when reaching 95°C and polling every 200ms.

Cc: stable@vger.kernel.org
Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250219-x1e80100-thermal-fixes-v1-3-d110e44ac3f9@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index e0ef5665f862..9382a2fce2f3 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -20,6 +20,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -9372,24 +9373,25 @@ nsp3-critical {
 		};
 
 		gpuss-0-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 5>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss0_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9398,24 +9400,25 @@ trip-point2 {
 		};
 
 		gpuss-1-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss1_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9424,24 +9427,25 @@ trip-point2 {
 		};
 
 		gpuss-2-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss2_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9450,24 +9454,25 @@ trip-point2 {
 		};
 
 		gpuss-3-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 8>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss3_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9476,24 +9481,25 @@ trip-point2 {
 		};
 
 		gpuss-4-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 9>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss4_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9502,24 +9508,25 @@ trip-point2 {
 		};
 
 		gpuss-5-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 10>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss5_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9528,24 +9535,25 @@ trip-point2 {
 		};
 
 		gpuss-6-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 11>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss6_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
@@ -9554,24 +9562,25 @@ trip-point2 {
 		};
 
 		gpuss-7-thermal {
-			polling-delay-passive = <10>;
+			polling-delay-passive = <200>;
 
 			thermal-sensors = <&tsens3 12>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <85000>;
+				gpuss7_alert0: trip-point0 {
+					temperature = <95000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				trip-point1 {
-					temperature = <90000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-
-				trip-point2 {
+				gpu-critical {
 					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";


