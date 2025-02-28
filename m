Return-Path: <stable+bounces-119892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0DA49107
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D9E3B85FA
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7311C2304;
	Fri, 28 Feb 2025 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BAX1HV36"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1501C07D6;
	Fri, 28 Feb 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721145; cv=none; b=XxKKMUGMxOvmc9Eo/FrhICMlnzQ2VmqUzxDj4lAK+59eZQlaF5uMJ4SyulbHuAN1vGfRx5nq+Cq1E/5bBqZb4V5O1AYgYh3azxLSkDIkNLpmCWbsZCrQNrVf+DVxnctaxe58hRwzNX8ZFEX0GaVPuZZUTxU6tEA/p7NdKk+QRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721145; c=relaxed/simple;
	bh=Pc4vUc8NvWi7KWlVGghppAbArgMPbSoRA8/uS1chpVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sKsGIUL0TpgavKJekWUoBMo3MEhx3xCyIO/f3sgAkuU4hbziwALej293zhWdRc4jAKFW7OpA1sUD5qt7kEbWzgc74nzYfxU3MQ1SFDxGbu8mcrl3WRaXe3wM2C5iLk4Of1682Lhj8jvPTTT4DX2HTX/THZQVcA5g3a70zCyClB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BAX1HV36; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51S5ctO22053571
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 23:38:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740721135;
	bh=d7KhCEgKt4lKw1RXr/94pX4KcBbaQ04sudkH0db8aKY=;
	h=From:To:CC:Subject:Date;
	b=BAX1HV36AQ1CQtUmrWX2HBA/kv5VwraflzuKAxSgMt/tCLfToMfAt1rqVDVs7lJTj
	 yyrPJVchhBLTye027lf8DjWe6154zu11XAI+KZCMXo8ilDMH39zk3kzRpb6BUmLXUa
	 +o/xguLrcIOY2Jm8SjbmHt+xHH3SuB7rmzmGAeKM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51S5ctJL083031
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 23:38:55 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 23:38:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 23:38:55 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S5cowW068576;
	Thu, 27 Feb 2025 23:38:51 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <j-choudhary@ti.com>,
        <rogerq@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks
Date: Fri, 28 Feb 2025 11:08:50 +0530
Message-ID: <20250228053850.506028-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Commit under Fixes added the 'idle-states' property for SERDES4 lane muxes
without defining the corresponding register offsets and masks for it in the
'mux-reg-masks' property within the 'serdes_ln_ctrl' node.

Fix this.

Fixes: 7287d423f138 ("arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Patch is based on commit
76544811c850 Merge tag 'drm-fixes-2025-02-28' of https://gitlab.freedesktop.org/drm/kernel
of the master branch of Mainline Linux.

v1:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250227061643.144026-1-s-vadapalli@ti.com/
Changes since v1:
- Updated offsets to begin from 0x40 instead of 0x30. This is because
  SERDES3 is not present in J784S4.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 83bbf94b58d1..51cb8f3fd1c8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -84,7 +84,9 @@ serdes_ln_ctrl: mux-controller@4080 {
 					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
 					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
 					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
-					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
+					<0x28 0x3>, <0x2c 0x3>, /* SERDES2 lane2/3 select */
+					<0x40 0x3>, <0x44 0x3>, /* SERDES4 lane0/1 select */
+					<0x48 0x3>, <0x4c 0x3>; /* SERDES4 lane2/3 select */
 			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
 				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
-- 
2.34.1


