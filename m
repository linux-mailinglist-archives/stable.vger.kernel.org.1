Return-Path: <stable+bounces-116659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97678A39290
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 06:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34BF3B4281
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 05:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E91B042A;
	Tue, 18 Feb 2025 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cc5/0kro"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC11AF0C0;
	Tue, 18 Feb 2025 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856204; cv=none; b=cJp7xOspFhGxL3kRUW1CEAyrBGHXjS9O4qstoSzVgEJ9Dt9iLpzao002VsuEgvomwkpvotAHkjHAcjFtbJjOXWjvUhq2aaJzScy492n9r6b9/NXg7BPl30n+pFeR6hGc77k4svw//7YTpz+fKMuIW8VOm1EfaYCv9B+8FW5Nviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856204; c=relaxed/simple;
	bh=77tZbCXU0gOTWWDTG0Q2sa76sq1j0rrk/C0uaK6xB5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLfRXfXY+eXPqTBhHT2RRUo8HcDLkN1s+Pnigw0MGK2CENOPzVwgvZ71AiMPj7q+RpQLrEnwJPgdJamG+Ara9D62VLi+twBRfPxBw07oJ2mligF1SYuayfD5vnPNn+B+Fcth5N2GKC6weMiGEr/RcSzp2mVO6tVR11dAxvFt4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cc5/0kro; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I5N5Q1647929
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Feb 2025 23:23:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739856185;
	bh=5/r3Cd3a5F8RDl+gpGHajtVIDh7k0BuAfKXauxlaFPE=;
	h=From:To:CC:Subject:Date;
	b=Cc5/0krozeeWVCsdf1M4B+5WhdBjTJbBb5QQErFBuYQ7t9e0NLAKdPLAnAxUqFtsn
	 ftrUba56WmO2YUpjDnT1M/DNaiGbgCEi3vsWVZvtK6KbivB/fFQ+p7k1oIp0wW5zNq
	 w9ajz8QEF44/DO+UH4Woe/vWolZQwUkGC14LVf0g=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I5N5Cg079664;
	Mon, 17 Feb 2025 23:23:05 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 23:23:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 23:23:04 -0600
Received: from ubuntu.myguest.virtualbox.org (ltpw09g681.dhcp.ti.com [172.24.29.106])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I5N0Zb109957;
	Mon, 17 Feb 2025 23:23:01 -0600
From: Keerthy <j-keerthy@ti.com>
To: <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <conor+dt@kernel.org>, <kristo@kernel.org>, <krzk+dt@kernel.org>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Correct the GICD size
Date: Tue, 18 Feb 2025 10:52:48 +0530
Message-ID: <20250218052248.4734-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Currently we get the warning:

"GICv3: [Firmware Bug]: GICR region 0x0000000001900000 has
overlapping address"

As per TRM GICD is 64 KB. Fix it by correcting the size of GICD.

Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: stable@vger.kernel.org
---

Changes in V2:

	* Added the fixes tag
	* Cc: stable

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 83bbf94b58d1..3b72fca158ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -193,7 +193,7 @@
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
+		reg = <0x00 0x01800000 0x00 0x10000>, /* GICD */
 		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
 		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
 		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
-- 
2.17.1


