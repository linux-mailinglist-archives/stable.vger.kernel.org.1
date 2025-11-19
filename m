Return-Path: <stable+bounces-195146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F0C6C9B5
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 04:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B0C4F296B
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74702F12CC;
	Wed, 19 Nov 2025 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKyTW60e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FB2F0670
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522663; cv=none; b=qX283//4Z9ckD/cHFVOAtpbhaLDSbJ4Ngs7kib3jVxaAnr858KChXLhT7C46bqtBzHEXaaiB6oDgz+RlpKHWoWp8X5QwYwBgLUd6uN/bjBP7SOwd615Zz9zFppHf7kT2ThIXInonP5FOb2W/KdZ2cbWLg1PFJyBkFDrjHvXZvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522663; c=relaxed/simple;
	bh=9/7bq9luoqLDcDUnVvlQXoeCaJrGyG3fDdPs9hoZ8j0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C+N/ZwQmT79SJjDAfNmfYpit6LAeODEYqMrqqiOTdOq3sl8IAR6ApWc2C/rjubFXfwl+c0cM0CgTuizuSPNoo2EL/efX9DlaNXmnbj5oHYZ46xL71iINNyW7aTJ8GNu65q+CDFrTOdUmGuZ69QRIkfxHR3pLAacdmOcOe4tVJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=ecsmtp-altera.sc.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKyTW60e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecsmtp-altera.sc.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522658; x=1795058658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/7bq9luoqLDcDUnVvlQXoeCaJrGyG3fDdPs9hoZ8j0=;
  b=XKyTW60esPF5pdaPZRm43Xs2usd+KdkdkXrGVytr24irHa0sMkvJZWMm
   Fr/Bqs8+2qAKf7qc8EwASqPqIJDmAKuQdszsxIg+AoHm6CNGNLb91qyze
   4/3dGznndFmwcDHRxmQeTgkEMPQ7K19sOOO1+bo1xRd/UIKD5jCqEGH4F
   8OYBDOg4RfVCt6aetQiJ+4BuPs3eQX65Qvh8QN+L7jEUqkO1g09ICwmZH
   g4VWn0KAskG+vAtcifW5HhcBQBUIXkJFfSqZ65UOUvaaN7USGZqUhkBmj
   IIpol27bs/xOHnln5Ph/l9Sll8JBUCxYNYeZAgNkp7NEBwIN9JXFKcQOo
   w==;
X-CSE-ConnectionGUID: tnm5FQsxTZKtuU+nea+zMg==
X-CSE-MsgGUID: LygVLmNBTeyDKdOSKEsn3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83182875"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="83182875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:24:17 -0800
X-CSE-ConnectionGUID: 7FkpZ7puRtO2vxwvDZMDGQ==
X-CSE-MsgGUID: P449Q5uUTXWhtUUFtDZYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190203927"
Received: from ascyv00016.sc.altera.com ([10.244.1.41])
  by orviesa010.jf.intel.com with ESMTP; 18 Nov 2025 19:24:17 -0800
Received: from localhost (asccc04073707.sc.altera.com [10.220.195.83])
	by ascyv00016.sc.altera.com (Postfix) with ESMTP id B5ED118008C0;
	Tue, 18 Nov 2025 19:24:16 -0800 (PST)
Received: by localhost (Postfix, from userid 11976865)
	id B1769200446; Tue, 18 Nov 2025 19:24:16 -0800 (PST)
From: MUHAMMAD AMIRUL ASYRAF MOHAMAD JAMIAN <muhammad.amirul.asyraf.mohamad.jamian@intel.com>
To: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: muhamm120 <muhammad.amirul.asyraf.mohamad.jamian@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: intel: agilex5: Add fallback compatible for XGMAC
Date: Tue, 18 Nov 2025 19:24:13 -0800
Message-Id: <c75a1061c0ef016406f73c05f1254b3c7dea79e4.1763520303.git.muhammad.amirul.asyraf.mohamad.jamian@altera.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: muhamm120 <muhammad.amirul.asyraf.mohamad.jamian@intel.com>

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
asyraf.mohamad.jamian@altera.com>
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


