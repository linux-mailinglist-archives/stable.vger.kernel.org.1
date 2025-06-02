Return-Path: <stable+bounces-148911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CBACABCF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC117B0E0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577B1DFD8F;
	Mon,  2 Jun 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H94Yhewh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3B1DA63D
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857625; cv=none; b=YZYQsIrLDLdMAgazJCAIrdX4vwJQORfVRDLaZQH07hfed9S3EIH9L1vcQ3v5kOwm3HqRkXBWaWg6xAcWGr+4QEaYac2UlRjjsYyVkpPAU5fwHOL19NczixFymiH+GfdGfuQX5wlk9rWG7JdKaVu1iLNg10aq5Pl1LeWp3Llr/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857625; c=relaxed/simple;
	bh=d4MeVZhLYG4QRJDjNtlqAIKALrh4zydVE4qNVr5UAv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=swMQnYsbTqHurGeBrcc0Nz3qm9kUv11WcLd85FjAqt0QwZd2BdIuG8eNt8DOiKaN+Y4YknuVemKkLtOrefBHide44sG6m3CWxuP6AzaeOFbzB1xkLWXW7q6AKCB9zoSHdXV2d6PswXkPlO/PjksezuTkrAioQ3gBnl0ljyK6UAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H94Yhewh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B11C4CEEB;
	Mon,  2 Jun 2025 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857624;
	bh=d4MeVZhLYG4QRJDjNtlqAIKALrh4zydVE4qNVr5UAv8=;
	h=Subject:To:Cc:From:Date:From;
	b=H94YhewhNuXZ64/8SPB+13rxwaHyB9hDxh/qbnMwsp7aeW+8C7olX6vETxLHB9Pbs
	 yJcM9dMgr0OsQQxXJ0KI8SpRDwgUAX+ZP2JkGObmQGfIiJODVsCaFvFc80bhdjZt0I
	 oNvn0zx+aCfa+0jtPhBhm+N/vO2Gf6jUuaQ7zT2g=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e80100: Apply consistent critical thermal" failed to apply to 6.12-stable tree
To: stephan.gerhold@linaro.org,andersson@kernel.org,johan+linaro@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:47:01 +0200
Message-ID: <2025060201-critter-racoon-92e9@gregkh>
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
git cherry-pick -x 03f2b8eed73418269a158ccebad5d8d8f2f6daa1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060201-critter-racoon-92e9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03f2b8eed73418269a158ccebad5d8d8f2f6daa1 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 19 Feb 2025 12:36:19 +0100
Subject: [PATCH] arm64: dts: qcom: x1e80100: Apply consistent critical thermal
 shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The firmware configures the TSENS controller with a maximum temperature of
120°C. When reaching that temperature, the hardware automatically triggers
a reset of the entire platform. Some of the thermal zones in x1e80100.dtsi
use a critical trip point of 125°C. It's impossible to reach those.

It's preferable to shut down the system cleanly before reaching the
hardware trip point. Make the critical temperature trip points consistent
by setting all of them to 115°C and apply a consistent hysteresis.
The ACPI tables also specify 115°C as critical shutdown temperature.

Cc: stable@vger.kernel.org
Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250219-x1e80100-thermal-fixes-v1-2-d110e44ac3f9@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 7d750a899e80..e0ef5665f862 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -8470,8 +8470,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8496,7 +8496,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8522,7 +8522,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8548,7 +8548,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8574,7 +8574,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8600,7 +8600,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8626,7 +8626,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8652,7 +8652,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8678,7 +8678,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8696,8 +8696,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8714,8 +8714,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8732,7 +8732,7 @@ trip-point0 {
 				};
 
 				mem-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -8750,7 +8750,7 @@ trip-point0 {
 				};
 
 				video-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8768,8 +8768,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8794,7 +8794,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8820,7 +8820,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8846,7 +8846,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8872,7 +8872,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8898,7 +8898,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8924,7 +8924,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8950,7 +8950,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8976,7 +8976,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8994,8 +8994,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9012,8 +9012,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9030,8 +9030,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9056,7 +9056,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9082,7 +9082,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9108,7 +9108,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9134,7 +9134,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9160,7 +9160,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9186,7 +9186,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9212,7 +9212,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9238,7 +9238,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9256,8 +9256,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9274,8 +9274,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9292,8 +9292,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9310,8 +9310,8 @@ trip-point0 {
 				};
 
 				nsp0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9328,8 +9328,8 @@ trip-point0 {
 				};
 
 				nsp1-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9346,8 +9346,8 @@ trip-point0 {
 				};
 
 				nsp2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9364,8 +9364,8 @@ trip-point0 {
 				};
 
 				nsp3-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9390,7 +9390,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9416,7 +9416,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9442,7 +9442,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9468,7 +9468,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9494,7 +9494,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9520,7 +9520,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9546,7 +9546,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9572,7 +9572,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9591,7 +9591,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9609,7 +9609,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};


