Return-Path: <stable+bounces-115120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCAFA33D07
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5353A746D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9A2135A6;
	Thu, 13 Feb 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdUv/MpA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420A2080D4;
	Thu, 13 Feb 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444056; cv=none; b=nICtqrLy+MoPNvdmsIRxkmj2lG7MktUj7+0MR7oQn/oGM12X00WmBLPIwaQNh3ua2pg3kToPpvIWDlPgcboTvWDY8WbvK7Gn+PQ8QGcWyWlCWwCRvRiC8gcIvW5zt8fKxCjGvsmmcdc1h8woKtKlJgwO0lUSrAxDpcETgRlewUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444056; c=relaxed/simple;
	bh=9OPAesnOCUzi4Km5CRU+TtzIORFDBAW74zMoy8WINR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jmj6F+A1F4rf2rZTRAWBAksTtaSGllGBZ7JhELPag2jscCkKmCO4W6bKJVTA2dgKulklyEAaFwnEkyxoAGg1ll9faLYLWxF0B/rxAuMyk1argxELffI7s5rBw5Qx1iNvv1ldJIMiIeOieF69f92wrvvg/YDLYzy7sJC8cV+EyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdUv/MpA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739444054; x=1770980054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9OPAesnOCUzi4Km5CRU+TtzIORFDBAW74zMoy8WINR8=;
  b=TdUv/MpAgQaS7/vmuG9M8vDNOaOnSpZ3XRIkGoKhop560wc9E27be+lK
   LgeTXNU6BI4WxOEKsnbRgVwtpozuLTFr5YQ05NS9zGrflmO//YJ5IyXuD
   1frdzGIO360i5u1zMOLKkszkRP2W6+yEaQ9uCkWG3cxMAScL5k4FKNXPl
   z+zZTYk8UZgbZhx6b6Ou75R2KzFqAsrCJeczYvJqELXF4/MzUeVeb0D30
   tpz7BBxrOfnqPyFGlUYINHoWutYl35+pFWlVscTocByKupeYTmNJCo3aR
   4lcuG+L3gim/hBzw2WHftJ8kpjxjgIPlx4w+YWW1FTaBOvND0vi5aOISV
   g==;
X-CSE-ConnectionGUID: Wm7Z1C6iTEeINbmWMm1B6w==
X-CSE-MsgGUID: Mo05yCPFQ42Cc4dvDOCwCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="57673388"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57673388"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:54:14 -0800
X-CSE-ConnectionGUID: lO0KYberQwC7NkEJfamVAQ==
X-CSE-MsgGUID: Ou446Z8VR4mkejzBDNBgsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112974167"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa006.fm.intel.com with ESMTP; 13 Feb 2025 02:54:11 -0800
From: niravkumar.l.rabara@intel.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	niravkumar.l.rabara@intel.com,
	nirav.rabara@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: socfpga: agilex5: fix gpio0 address
Date: Thu, 13 Feb 2025 18:50:36 +0800
Message-Id: <20250213105036.3170943-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Use the correct gpio0 address for Agilex5.

Fixes: 3f7c869e143a ("arm64: dts: socfpga: agilex5: Add gpio0 node and spi dma handshake id")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---

changes in v2:
  * Fix dtbs_check warning and update commit message for better
    clarity. 

link to v1:
 - https://lore.kernel.org/all/20250212100131.2668403-1-niravkumar.l.rabara@intel.com/

 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..7d9394a04302 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -222,9 +222,9 @@ i3c1: i3c@10da1000 {
 			status = "disabled";
 		};
 
-		gpio0: gpio@ffc03200 {
+		gpio0: gpio@10c03200 {
 			compatible = "snps,dw-apb-gpio";
-			reg = <0xffc03200 0x100>;
+			reg = <0x10c03200 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			resets = <&rst GPIO0_RESET>;
-- 
2.25.1


