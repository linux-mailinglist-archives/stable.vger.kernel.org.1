Return-Path: <stable+bounces-133090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F25A91C5B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0362216F35E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF5248885;
	Thu, 17 Apr 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rUjTaU6/"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D52475CB;
	Thu, 17 Apr 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893194; cv=none; b=rkZ5OdHJtrpZbVyO2czLOSuBiVp0no7GJa3yKRYrTU9BM7MaoAjeaA5s5IBUmVvt0//AoOdBLLsdQCzk1tCbMdTUaSl9neyEDeBO93dP4+8wFwx5XWWfslrt2fsZqZGc99ttihGTfWcJeBYThq+8pbVi6BVNxkhpz0GjgsKAuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893194; c=relaxed/simple;
	bh=X6223YWHrMIEQso4u+WKnZ8K13FEUMYwm+Nrt+W0btc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9rklBlqlxIzA3io0i4ZErws5SRRdgmJ0+pclDTKh+KiFdl/H9C4IqVWtm1YhLXtFd/5JdyuSd0aCJIOmNKFJOTslkXdfHkeHNOlGJJwdITbmrNt7s4lMgp8qzbdeDJTwtLn5LJsVkPVc5WHNyPGU2wRxVDv414qddsMPKW0yig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rUjTaU6/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCX720012825
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 07:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744893187;
	bh=Xekzjocdp1MXjxXlVQ4pboSffMwk3za4212Kt6FsTKs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rUjTaU6/Tlqmug8e6VhP/FwzKQhdunlEhqq/t3ZPkIFCfcZ/wVqPTkLs9XXgjSk+3
	 VQj34lDQlG5hTryikrKP7Xda0+NEr9AaA4AzoYxT2RbTQkWvbmzQmUYp3TNpo0ScYL
	 Oyps/6g0mZ30mwj4yUBip4jNep7IwPQUMdoXOBe8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCX77v094247
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 07:33:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 07:33:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 07:33:07 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HCWkMS038275;
	Thu, 17 Apr 2025 07:33:03 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-j722s-evm: drop redundant status within serdes0/serdes1
Date: Thu, 17 Apr 2025 18:02:46 +0530
Message-ID: <20250417123246.2733923-5-s-vadapalli@ti.com>
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

Since serdes0 and serdes1 are now enabled by default within the SoC
file, it is no longer necessary to enable them in the board file.

Hence, remove the redundant 'status = "okay"' within the serdes0 and
serdes1 device-tree nodes.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---

This patch doesn't have a v2 and has been newly introduced in this
series.

v1 of this patch is at:
https://lore.kernel.org/r/20250412052712.927626-3-s-vadapalli@ti.com/
Changes since v1:
- Collected Reviewed-by tags from Udit Kumar <u-kumar1@ti.com>.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 0bf2e1821662..34b9d190800e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -848,7 +848,6 @@ &serdes_wiz0 {
 };
 
 &serdes0 {
-	status = "okay";
 	serdes0_usb_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
@@ -863,7 +862,6 @@ &serdes_wiz1 {
 };
 
 &serdes1 {
-	status = "okay";
 	serdes1_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
-- 
2.34.1


