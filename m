Return-Path: <stable+bounces-77755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3B986E21
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6070283CEC
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4218EFC6;
	Thu, 26 Sep 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nzB3GlX4"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53E18E37A;
	Thu, 26 Sep 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336977; cv=none; b=pwa4FKDUQvjBkI6m39d9cRZL8IK7aPHdm+ok3QL0sz+zOAAKIaKFd1AjgfeKRchrhk0TLeHqfcdIgCWOeF46HKwvG2Dggu47qbXXt9d7nv+DcuzO47T/xlycsAkineeJCh/WcjZLKZNh+pDjU57xwDrgFm8AkUYz2SCDklRwSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336977; c=relaxed/simple;
	bh=o+CHpCjIYOUmUT4z8xkv0BNu0fP9M1NlZ7YHOM6fvNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAq8b1q4+BM8iB7aSBEhehhIDzdaqd6ismcirhygQfx505j49ArPjE93dt+8GKp+QGdIQDkWoXjwmiAzNCkkdpN6VOO0u4ezD66ergHZ1LB/beUjxkcG2c4btIh8KUNQplr9syeYvbhkXc4tJ89rCLbreMdq9L54rfiBiJL3/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nzB3GlX4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727336965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4p8z2L8jrWV5lUcHwvhgC9S3U+XsVqsS61+6JO+Ug0=;
	b=nzB3GlX4509mBvlajAspZW5HkN9N2/9VFLibpkhCwJJ1IIjK56wCw2OEfDXmeTpSB/hZiT
	FzYxYFoHw+BJDXzvEohnXgLUfUZxkMGHNfOiJOoxIuq5v189fr8Y2eXX2PpSHVHGMIG8Ux
	Mnm+v+HGjfj6tQ35fQoNMb87P8v/46omPQK1sp4vA3RmJNx8cdVXjqV+zfLCppHiBsOcws
	mtALiH2Gkno8h2cCpJGZ6irFCGwvvfNCNlYRnvOWpIHBXDdTobEXpRj7CnzE2Pnm+2uewB
	vnIqWS/LDc3E4/qQeYZLfU1CQnTjBUuba/OhwXJofQuESAHCv7QE7d8vJD2kWA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x SoC dtsi
Date: Thu, 26 Sep 2024 09:49:18 +0200
Message-Id: <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the "l3_cache" node under the "cpus" node in the dtsi file for Rockchip
RK356x SoCs.  There's no need for this cache node to be at the higher level.

Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to the SoC dtsi for RK356x")
Cc: stable@vger.kernel.org
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 4690be841a1c..9f7136e5d553 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -113,19 +113,19 @@ cpu3: cpu@300 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l3_cache>;
 		};
-	};
 
-	/*
-	 * There are no private per-core L2 caches, but only the
-	 * L3 cache that appears to the CPU cores as L2 caches
-	 */
-	l3_cache: l3-cache {
-		compatible = "cache";
-		cache-level = <2>;
-		cache-unified;
-		cache-size = <0x80000>;
-		cache-line-size = <64>;
-		cache-sets = <512>;
+		/*
+		 * There are no private per-core L2 caches, but only the
+		 * L3 cache that appears to the CPU cores as L2 caches
+		 */
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
 	};
 
 	cpu0_opp_table: opp-table-0 {

