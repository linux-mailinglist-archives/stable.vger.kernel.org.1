Return-Path: <stable+bounces-115040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A6A3232C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B65D3A20EA
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36962206F3F;
	Wed, 12 Feb 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOCDolO0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AE2066FA;
	Wed, 12 Feb 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354714; cv=none; b=Coj5weQwgGhPe6FbwQY+0e1ysSABhiISHycGFQ/i8e9EYnjOv3jjLlYDYL0pq25/B3ntOZd7zuLvLHV6wL86N0mD3mxDeFlzG2LAHI2lOUBnJyV2eOHN1mpE03hQsLQuht8S1gfQdM4JG48KPomCH8RPdU5/XkopIhRN4VpxNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354714; c=relaxed/simple;
	bh=E49MearhCWQAl0JeKNyAQ1d0vfOm7rpIo89lLibkdVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dPvSBKNgG0MHGIUG2/StSp/AQLQXFGkBkenuDaWTvPBdC8wmYMczB9w74XdbiiXYTr7o/74ASMLAC+2SJ7a/9MeAx5ecK1lRzzhzN3QurmXRipp3tiJ6PVLoAkjnRAAZCwQQZPOTgwwJHthX6NC9UEnHdr+t3sh/1pO2cis2OJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOCDolO0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739354712; x=1770890712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E49MearhCWQAl0JeKNyAQ1d0vfOm7rpIo89lLibkdVM=;
  b=WOCDolO0WeEfFC9G3aZGCcuNJE0p1TwM313t8N9K0CmzqOpjvsoiqHau
   21xBLjlPk3J7oEOGlqxf/uj+BqJJ2MjvrQj1fQenHfjKpDvceJda6ZXXr
   Mi69BgyBaxaqeCfDD4eTUSfI/qsstnOkfRUz8jgYk6fP+bsE6UcMpnOdk
   WQXPaqE7f52OHTPEzkSSfAFxcqyB0cedDj82fqfaXPnMjgmCDaiAoHjeY
   rhUcmDoBFZUb9UIPUnVQLrAFleYHpMoOpR3YVrK/Tm+5X3IF20X3y0irC
   XnBCW78eSdslSdgO+c8sI1cGF2Bk4M2P9B8nA1sA3hBjKgNrZT9Qw8y5m
   Q==;
X-CSE-ConnectionGUID: fV9lWE25RA60aBh27YA/vQ==
X-CSE-MsgGUID: LFYruDamR8WSQv8qtu/dEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57537829"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57537829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:05:11 -0800
X-CSE-ConnectionGUID: ng1uiUhoSru3NGd7NB4iQA==
X-CSE-MsgGUID: zPR1TcnETaC+BG2XkiXj+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117957606"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2025 02:05:09 -0800
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
Subject: [PATCH] arm64: dts: socfpga: agilex5: fix gpio0 address
Date: Wed, 12 Feb 2025 18:01:31 +0800
Message-Id: <20250212100131.2668403-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Fix gpio0 controller address for Agilex5.

Fixes: 3f7c869e143a ("arm64: dts: socfpga: agilex5: Add gpio0 node and spi dma handshake id")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..9e4ef24c8318 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -222,7 +222,7 @@ i3c1: i3c@10da1000 {
 			status = "disabled";
 		};
 
-		gpio0: gpio@ffc03200 {
+		gpio0: gpio@10c03200 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xffc03200 0x100>;
 			#address-cells = <1>;
-- 
2.25.1


