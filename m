Return-Path: <stable+bounces-150635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C7ACBD5A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 00:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A44D7A7FFB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874C19CCEC;
	Mon,  2 Jun 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HvJrTvk7"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B7F9EC
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903497; cv=none; b=kGCMJaTxuF2B/DO127hotVTE28KJITPfLN7Z2JXIqOcf0Oxg8IYUXgO5sUrDT5W5bVcfhMDuH887mpvzEzgox1AbHMsX11Lkp/ptte4vT3xown89sNafpjKvaoFchTlkBxP/yERkHf4xMwuLPhXpSzkFk1cWvG8euqmRE1jZPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903497; c=relaxed/simple;
	bh=m5QKJWM1UWhgii5jOBcjDMYuwnbdUuo1gf7A0O1jIsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4WsRH0Su7hTVVp03JR3zt2EhHP63c+IirSo5cuq8c0R2O4v3KBkNL4G5fZqpaEtD6BqkPwOjqHVcTQwnL6d8eyFgNaq2hmS9Y/QjoTBsbWKo3/TRhQS+o5AH9rbv5QwAStOeZ/VJx47gqeoq6YpktQ42cLEZokfutyrATTtJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HvJrTvk7; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552MVXc43324050
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748903493;
	bh=llWw2PCnqCCXky7vJ6XKl7ohs+ntvp0oH0zyb/FJzKg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=HvJrTvk7Cx66oWOIyQVGY4LN+oeUVLsyUeGu1FdJwCxA9Mt5gD7ZpO7NacQ360Piz
	 BsHmM1LicvKaarJcQJUSDtoDneEaMmlskmxd6429YJyqS3VzoVd3tvl4SP0uWtWwA4
	 YKL7+JRfm7SvTSu1KgaswOkrbdF/HC7S3kTrrQrE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552MVXvv895499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:31:33 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 17:31:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 17:31:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552MVWfk3693110
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:31:32 -0500
From: Judith Mendez <jm@ti.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Mon, 2 Jun 2025 17:31:32 -0500
Message-ID: <20250602223132.87435-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060218-borrowing-cartload-20af@gregkh>
References: <2025060218-borrowing-cartload-20af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For am65x, add missing ITAPDLYSEL values for Default Speed and High
Speed SDR modes to sdhci0 node according to the device datasheet [0].

[0] https://www.ti.com/lit/gpn/am6548

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429173009.33994-1-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 83dd8993027a..637cd88078ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -273,6 +273,9 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
 		ti,otap-del-sel-hs400 = <0x0>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
+		ti,itap-del-sel-ddr52 = <0x0>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
 	};
-- 
2.49.0


