Return-Path: <stable+bounces-150636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A27ACBD6E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 00:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AA77A4520
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FD205AB9;
	Mon,  2 Jun 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="htG5jjzR"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510392C3254
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748904148; cv=none; b=oouxrg7dW9iICWoET6qw+733JKrvxnPx0pdWBBvefNjPddXisc2e134WQ/N0mkzee1mR0KxHmDDUVSkoS88WKzonYu0/vliSeLQHsqB8U7tEP+m8NpfI3TOV0kkDL1/cBE1++vtPW+j1DdIDhDWf5wGLwSQdsMwl+K55GxvKv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748904148; c=relaxed/simple;
	bh=9v6GIRddM4Oe5YydD3VsB2r+nmCN6YSSxf7PVat6fwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akCXRBTH3K+hz+LSr7cfGxaXOpDQ9Mxyw856SvA79UAJsJpw6KUkoWiDT0ZLK8095LM6uUVZZoKoyv8ZosWCf2XHrbae9+gALgDBVxXRlsXzjXAbC7CfFwkcVxbnWLXBkZFBAjTXYXJt4qHkAHNSKgTuCCR25ZG5rXhdfP/+54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=htG5jjzR; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552MgPDU356153
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748904145;
	bh=dFjHW1VFI+SeDKTSL/EbQxZjW7o9DAGFFRcLEQGBb9Y=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=htG5jjzREAn7UknzuiyplfflO9QtoSM/KNNXgkn0CGXXcbBVAoRpxje1rir8YuySw
	 ieg9foIUd5C/Ioe3ACm4VWOAGY9UQ6F9NsPkESCKapcUGBa6s0iiYmpq74z2uJ4X4f
	 v8Jd02tUoJogb8bDV56XM2qPWV8zwUeD8U3gTY1U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552MgPga900072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <stable@vger.kernel.org>; Mon, 2 Jun 2025 17:42:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 17:42:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 17:42:24 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552MgOZN3619575;
	Mon, 2 Jun 2025 17:42:24 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH 5.10.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Mon, 2 Jun 2025 17:42:24 -0500
Message-ID: <20250602224224.92221-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060219-slicing-gargle-f481@gregkh>
References: <2025060219-slicing-gargle-f481@gregkh>
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
index a3538279d710..ae2284bd5f32 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -279,6 +279,9 @@ sdhci0: sdhci@4f80000 {
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


