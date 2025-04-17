Return-Path: <stable+bounces-133089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B02A91C53
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13126460446
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1224633C;
	Thu, 17 Apr 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FvbcK3Zh"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10692309AF;
	Thu, 17 Apr 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893190; cv=none; b=r/rQC5hPBt6d7dB8CT6vnGZCjKclHkfYKE4HRO0DQiQQz5OxyGn3uBCfHOTXidzO+YmebrNfc7n79d/MmU07cufRPZeabYUmxu7omPFRr3fM4C2k7waSrZ/v64pHe/vo60r/3D3TtN32To7IiOOXTuBfbbz6vlFCLvGhBE6i0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893190; c=relaxed/simple;
	bh=fiokmJMX81yTpZ8kVCSQGA34fNWnCGfiaroSj7xQ3AI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mlweb4W9/m8xd0yn+XDPbhKfLuPGMUPvmgdfqefeoJmND8FKEQb/nmFrsZZyip2OUthFK/eiVMPvw8PdRfVDAr2UHuVofHAQeRhMxXY1orqaFhTyjbHm+gpFj2jvxL7631gTCXfvbyPtda8Dluzch7vrtS8FQUrD1bDIZh4KXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FvbcK3Zh; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCX3Ql691249
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 07:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744893183;
	bh=YBl3TCu3gksd6v/dkukzfiaNZG7cMAnJ/y7g/B6EaEg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FvbcK3Zhgv+5kAV0xygXIadBex/l1m5RHWJVKNpggspuwgK5y/oRaenVZvRCpZIOA
	 JXl5Uad3L0c8fbq0XooF1J2r+woMlaA8De9bYj0RmLVVNt0RJrWNLyLybh3B3nOc+E
	 BGkkra4XTd+i+8EisG+F6FJ08/HjVdUNKT2NwznA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCX3mt094189
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 07:33:03 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 07:33:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 07:33:03 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HCWkMR038275;
	Thu, 17 Apr 2025 07:32:59 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 3/4] arm64: dts: ti: k3-j722s-main: don't disable serdes0 and serdes1
Date: Thu, 17 Apr 2025 18:02:45 +0530
Message-ID: <20250417123246.2733923-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417123246.2733923-1-s-vadapalli@ti.com>
References: <20250417123246.2733923-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since serdes0 and serdes1 are the child nodes of serdes_wiz0 and
serdes_wiz1 respectively, and, given that serdes_wiz0 and serdes_wiz1
are already disabled, it is not necessary to disable serdes0 and serdes1.

Moreover, having serdes_wiz0/serdes_wiz1 enabled and serdes0/serdes1
disabled is not a working configuration.

Hence, remove 'status = "disabled"' from the serdes0 and serdes1 nodes.

Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---

This patch doesn't have a v2 and has been newly introduced in this
series.

v1 of this patch is at:
https://lore.kernel.org/r/20250412052712.927626-2-s-vadapalli@ti.com/
Changes since v1:
- Collected Reviewed-by tags from Udit Kumar <u-kumar1@ti.com>.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index beda9e40e931..562dfbdf449d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -52,8 +52,6 @@ serdes0: serdes@f000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#clock-cells = <1>;
-
-			status = "disabled"; /* Needs lane config */
 		};
 	};
 
@@ -92,8 +90,6 @@ serdes1: serdes@f010000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#clock-cells = <1>;
-
-			status = "disabled"; /* Needs lane config */
 		};
 	};
 
-- 
2.34.1


