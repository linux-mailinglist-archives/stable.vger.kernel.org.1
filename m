Return-Path: <stable+bounces-195141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB49DC6C63B
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A57902BA2E
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE13286D4D;
	Wed, 19 Nov 2025 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REYuMUKQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA186287259
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519494; cv=none; b=E4gvYVlpe35P2iTDWePXDn2J8kHg5enaQLKlg44hB4HpvRy+I3C4buNFbCmjJCvqVfNiCxlWmSdk99Y+4SWn9JeJH1JGlgY96V9ateeUnJOm8RG0XoPsPGmbdUiubLO9csMhy9bXUSBvQto8lh4wPp6yXJNPq9/8TB/7lS4n+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519494; c=relaxed/simple;
	bh=qamBZKWpeejs9CfMXQCSPfzfpSwNBp6++9XT8Hg0bOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkUZsdIObfW0wnM1Q2ASKQFSuiP6HAoricZ36OLaKROW4EfOybB9eEM0r0zWAzhn0RntB9DS3y4E48ErxJ6cHm9yrsy2Ymbkxm8n799gnSBvb7vlE6J97lm6WbKm4J+LoZ9jOo2mXTZwE3wTqIZXzQ6xD4iExh3vtK83Tg4Cgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=ecsmtp-altera.png.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REYuMUKQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecsmtp-altera.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763519493; x=1795055493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qamBZKWpeejs9CfMXQCSPfzfpSwNBp6++9XT8Hg0bOU=;
  b=REYuMUKQ9aSOx0Zt7OVDzKZGTsjrBH5QHNx7A03ZiUsqgwSEYyj3RYAB
   9aIX8y1D/ah3VhSYVsNrrybXG6FXeruiYQKIqnRQxBfykETR60g3Aawgg
   Bz5ZaMW/AY5ax4LuaZ5IrLFjQNQwqqMqJNsk8Ws7xCVf3d4Lwc9YPeqLv
   AazP+BYMpQBdOduhOvh5WFuvUKzNINgq9nsHLhpDaFsn94JwA0k4Plpdy
   36gCIUK8Ia7zxjFRWN84Kmx0jHh6Z6lIaSvkEthdzYAEB6cm+HcLbv5lJ
   /sOj67/87iHgt9XR85ukVBagCE+pwMJ30Cc4NvDopltT+lPkl0g0Fz9Rr
   Q==;
X-CSE-ConnectionGUID: yFVS7z02QV2BcJ97HeSepg==
X-CSE-MsgGUID: gAqXkL1MRxyKiX/MZd4LWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="64558066"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64558066"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:31:32 -0800
X-CSE-ConnectionGUID: QDPvcecgRc2+vREbw4PKPQ==
X-CSE-MsgGUID: xUMVh/uoS/iGlmEzjBa2Pw==
X-ExtLoop1: 1
Received: from apgyv00016.png.altera.com ([10.244.64.52])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 18:31:31 -0800
Received: from apgcp0d551102.png.altera.com (apgcp0d551102.png.altera.com [10.244.77.40])
	by apgyv00016.png.altera.com (Postfix) with ESMTP id 55B6C18008C0;
	Wed, 19 Nov 2025 10:31:30 +0800 (+08)
Received: by apgcp0d551102.png.altera.com (Postfix, from userid 11976865)
	id 508601600143; Wed, 19 Nov 2025 10:31:30 +0800 (+08)
From: muhamm120 <muhammad.amirul.asyraf.mohamad.jamian@intel.com>
To: linux-drivers-review@altera.com,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: muhamm120 <muhammad.amirul.asyraf.mohamad.jamian@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: intel: agilex5: Add fallback compatible for XGMAC
Date: Wed, 19 Nov 2025 10:31:25 +0800
Message-ID: <0d94be5ebcf03e7b1107065456d1ad649ed52990.1763519418.git.muhammad.amirul.asyraf.mohamad.jamian@intel.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwxgmac" as fallback compatible string to all three gmac
nodes (gmac0, gmac1, gmac2) in Agilex5 DTSI.

With the fallback present, the generic dwmac driver can properly
initialize the XGMAC2 hardware, allowing ethernet to function correctly.

This fixes ethernet regression test failures on Agilex3/Agilex5 SOCDK
platforms.

Fixes: 343ea11a2fe3 ("arm64: dts: Agilex5 Add gmac nodes to DTSI
for Agilex5")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.
asyraf.mohamad.jamian@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a5c2025a616e..942773e96d02 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -544,7 +544,8 @@ qspi: spi@108d2000 {
 
 		gmac0: ethernet@10810000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10810000 0x3500>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -656,7 +657,8 @@ queue7 {
 
 		gmac1: ethernet@10820000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10820000 0x3500>;
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -768,7 +770,8 @@ queue7 {
 
 		gmac2: ethernet@10830000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
-				     "snps,dwxgmac-2.10";
+				     "snps,dwxgmac-2.10",
+				     "snps,dwxgmac";
 			reg = <0x10830000 0x3500>;
 			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.43.7


