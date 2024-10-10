Return-Path: <stable+bounces-83329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42980998360
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FF61C2216A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FC1BE864;
	Thu, 10 Oct 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cAFRP0Ge"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B81BDA91;
	Thu, 10 Oct 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555604; cv=none; b=YLIJ/Qu3Kp9ydLt7kYzd3mcW1O00dANEyJVp3GSNJMb0XJiJllinH8OVZJpO3L6mC746BY45fifw4K79Db02ARS2mk9bphlCsT/2pU8aukYkmYMcqnxgaQW6BgXJvkI/PUwIFK1/Xo/fgVSCacci3kBglZA3cT94Yl2HlNayXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555604; c=relaxed/simple;
	bh=c/6seuK0LsZaqyvw8i37BiYlIfMZwD3oi1R0YzQZ/aU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ta/5xl19yj/GjUhq5Wif/9izhvLNxnS9hYpb/eoz4MSRlYl5OpU53vUvhJGG9tSlX/0XA7awK0dATVMTjBurxLnI3OkCLqKGtYiqK0yosTIQWH0nPZ3962DI0V/cmnjBsb4XBM/+BV+nsiIf4IuRl3XWD/6nF8qNrXGGOtuF+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cAFRP0Ge; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728555592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2t5G1nuRoT30uUHQhEAmI0rqUOvlejZIQbCf/G470I4=;
	b=cAFRP0Ge91jsRZUPc1Y7Hxml3ClssfPkL7iEl55YX+Q+8Y3kHzPGbMULWqpDCgf9QurS23
	dDQgM7dmZkIRc4a49nbje1QipkkHNUDafgSq7qeWW7Uc3n2B1bOzUgaVLYUUv47qlGnxuP
	a5Si+9OZX7RJpvg+9LYdKE4cjSaNqvVcDq/3ccT0s55e6Vg5e6tgnq7ynpnQntUqkKJe/6
	Msh+c3wL5PjhOKtYdeo1NFIRzSwoiHKp1iupO0EVCGNZ3T89X+H0k3Del8DOkseY41B8YU
	jg2AEk18OJmU8Ea83OT17kIzJT9nPPWLRIG3lioZyNc8OY8+AYGTPTwnLYPqYg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
Date: Thu, 10 Oct 2024 12:19:41 +0200
Message-Id: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Until the TSADC, thermal zones, thermal trips and cooling maps are defined
in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may be
enabled under any circumstances.  Allowing the DVFS to scale the CPU cores
up without even just the critical CPU thermal trip in place can rather easily
result in thermal runaways and damaged SoCs, which is bad.

Thus, leave only the lowest available CPU OPP enabled for now.

Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308 SOC")
Cc: stable@vger.kernel.org
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 31c25de2d689..a7698e1f6b9e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -120,16 +120,19 @@ opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <950000 950000 1340000>;
 			clock-latency-ns = <40000>;
+			status = "disabled";
 		};
 		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1025000 1025000 1340000>;
 			clock-latency-ns = <40000>;
+			status = "disabled";
 		};
 		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1125000 1125000 1340000>;
 			clock-latency-ns = <40000>;
+			status = "disabled";
 		};
 	};
 

