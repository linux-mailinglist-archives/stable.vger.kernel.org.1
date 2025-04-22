Return-Path: <stable+bounces-135200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E5A979F5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8091B600AC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A22BF3EB;
	Tue, 22 Apr 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DyI8XAi1"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492692BD58C;
	Tue, 22 Apr 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359531; cv=none; b=oKmjU2A592VrkIXLvqtVMWS9hxv426Eg68jIRE3B5U+U4ysIUt8SW5BDP9W8TM9syRbiGY8ljQG7/PkonbXZQ+EjnrlHm9hyfTFwNgQRN4zpIN4C0gPMKTYz5/BKpAAZOIroVKYXj+MhqF82t2oapCPO2K1OyUYehUSuz5vt3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359531; c=relaxed/simple;
	bh=mY9GoG/UUugjJ18v5+GeCwpFlCvI5e4W/WJHx2Hfo2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdmuESTAMQo6z+HMx8VHBkmlwFKR8+zf++dpxk7+yb1GCGE4UpYM1tJ9vJTLfoWFCmtMxqfsNulAP6zieMGktdQ/mXBgCqhMCb5V6hMEC856tf8gyF1guPk2y0Nss6obuVMk6Ffd00RXapAR1FRWNdt2mxulBPGVC41P81aREvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DyI8XAi1; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5DdF1337961
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 17:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745359513;
	bh=3W5pH2V1gyiEOmWsKa66R87bP2YeuD/Oj8gx8MCibcM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DyI8XAi1phnkKYoqwloERIFC1u+isT1WfT8OvtCBOAF1eEXeq2ZgoB7kfjjDeADiY
	 zb1ZDk++JcsLdyYcxKeX+QyH5wLPV5RvAjzD32CmZNw/ZyGDz93SCT4wUvLzf4e7zz
	 NuxwUgs5jNHim2bVOO5TEVF01/tygQ+kDVYVE2ws=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5CGQ117245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 17:05:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 17:05:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 17:05:12 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MM5Crd012605;
	Tue, 22 Apr 2025 17:05:12 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth
 Menon <nm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hiagofranco@gmail.com>, Moteen Shah <m-shah@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH RESEND v3 1/3] dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 17:05:10 -0500
Message-ID: <20250422220512.297396-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422220512.297396-1-jm@ti.com>
References: <20250422220512.297396-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Some Microcenter/Patriot SD cards and Kingston eMMC are failing init
across Sitara K3 boards. Init failure is due to the sequence when
V1P8_SIGNAL_ENA is set. The V1P8_SIGNAL_ENA has a timing component tied
to it where if set, switch to full-cycle timing happens. The failing
cards do not like change to full-cycle timing before changing bus
width, so add flag to sdhci-am654 binding to suppress V1P8_SIGNAL_ENA
before changing bus width. The switch to full-cycle timing should happen
with HIGH_SPEED_ENA after change of bus width.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 676a74695389..0f92bbf8e13b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -201,6 +201,11 @@ properties:
       and the controller is required to be forced into Test mode
       to set the TESTCD bit.
 
+  ti,suppress-v1p8-ena:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When present, V1P8_SIGNAL_ENA shall be suppressed.
+
 required:
   - compatible
   - reg
-- 
2.49.0


