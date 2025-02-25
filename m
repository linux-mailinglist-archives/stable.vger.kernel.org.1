Return-Path: <stable+bounces-119505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F0A4413E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CDF163700
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82869269896;
	Tue, 25 Feb 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPVryRjn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676310A1F;
	Tue, 25 Feb 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490984; cv=none; b=c5M50qyPLBzS+6X8NWYyCpYW/RQYTXMvZzzBs1MoG0ov3GF+1lCEMe0Ng1M8hBoTaL+vu3i7WEEHlS4ci0+Wd3+Qr4DVo8AgPyM98TPZkZZJ9Ho3Bsfyi137qhh1qzvVBZXN3qS9xBVFlyty9KyQpBSR1954wcRsEvkjP7lf1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490984; c=relaxed/simple;
	bh=OVlSr9TTVKbfm0Bm43NuK4bn/qbhZ1XT6FUhxrm7yfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxNzLtdO73XUHKTTamM+iXwc0O+CuYiPS5wxUFmUJNyAZkjxjgEqt+Ze1wcLb/p5Q3flXDT3EDC4otDbRpDkt7S3YAJD9owwW5gtLyp9qwjSLxatvsye3zHcq8bONB4dZi9qlAqZkH0IuRu6IEIK/IQmoP1lJRoNojEwZFMjyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPVryRjn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740490982; x=1772026982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVlSr9TTVKbfm0Bm43NuK4bn/qbhZ1XT6FUhxrm7yfM=;
  b=gPVryRjnCHZ2JB8CWb9fW/8uqexcqX/lgKhJRhjE/nPSBOIYqWyT1nhV
   xt0JXbYgr2ZkGGvFJPjtp8smMU/28bqqQ2kDx5jyJMvWQYx/CmzjM9uhR
   Qb4NR5zDtxKmLB3o4rJpZeIaFghKsscPKRD7YrK1t8rWZCLlLlOVYMYd0
   hVEv4mR7Z6gvJfFX6kEkWG6+04PFCehWoDFO8fyebDF95qeQVvDkQ3r2Y
   fV+XjY70uYSrUNeXPgQ/qq7CJC0WSSAOf6Ief70c1Px0DJXfQ9Z3ZJbru
   NqLq6knqrfvm2G4MKJoyEzmKayqEacTeloSXTb6V9X+5MDPuc8+5Tgaa4
   Q==;
X-CSE-ConnectionGUID: lO1gEWivQXK6RfciHnlhTw==
X-CSE-MsgGUID: zTunTWbqRP6OYDCzeiY1sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="40481740"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="40481740"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 05:43:01 -0800
X-CSE-ConnectionGUID: CArEIRulTeSH62qTCm6yDA==
X-CSE-MsgGUID: D2wzeHMyQbuik53TiYByuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116409321"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2025 05:42:59 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel id for spi
Date: Tue, 25 Feb 2025 21:39:19 +0800
Message-Id: <20250225133919.4128252-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add DMA channel ids for spi0 and spi1 nodes in device tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 1235ba5a9865..616259447c6f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -457,6 +457,8 @@ spi0: spi@ffda4000 {
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
+			dmas = <&pdma 16>, <&pdma 17>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -471,6 +473,8 @@ spi1: spi@ffda5000 {
 			reg-io-width = <4>;
 			num-cs = <4>;
 			clocks = <&clkmgr AGILEX_L4_MAIN_CLK>;
+			dmas = <&pdma 20>, <&pdma 21>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.25.1


