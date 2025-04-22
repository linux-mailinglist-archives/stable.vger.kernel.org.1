Return-Path: <stable+bounces-135203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA2A97A01
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDA217CBDF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD52D028B;
	Tue, 22 Apr 2025 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wnL83BuH"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7C262FD9;
	Tue, 22 Apr 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359535; cv=none; b=INI1pXagoBHXlL8EPrewh2AvvVxmg8e98vuMnJ/0gMQ/N/Jhm+zbhJwk5164HRa9W30aEtGMOJquy+JNPv4b/oLZ0jbgLHi55tMuOd4Q+l9Z04DC0+KXu9xwBJ50EiqbpZSbLvC7CA7XEq0NgIF647PRbgJ3vTAVjUpz2RoQixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359535; c=relaxed/simple;
	bh=mTWP0qmzfPQqu0NBVqtmffkFWXxD2gO2ig+9q3Jafa8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgZZT9tpPPx3T2bZlstr8Ujjcz3+QLmGqA+gE+tYYrU+wuE2AscU8tHI2bmG/Nah6FYIBxb54oO4g9wUHsWzzsFxcmQ8Y6JtvxebO3DVKnp3flzE6+WIOYdU/PT18PNew5YtUnYw1XxzhtYy7pqHhHdahx8SRFB15Lb/6A7+2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wnL83BuH; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5C3q2117300
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 17:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745359513;
	bh=Sj4pRdp+l765MK714CGTnwQXZFSOrjKSMrjTy5zwMY0=;
	h=From:To:CC:Subject:Date;
	b=wnL83BuH1fhwFoEpJ8Waoxg/SGGYKTFulWHqeZloPhVX5imghxXGolSAk+bkCjdir
	 OE6dgZpmzh6QfGlARknjOv4pKZ8/tMH5UoOfbmKykkSzw1OhGt4UWlV8X5OUBEXYhK
	 9mAeItU5DL/uCRjJ5SYtA2+h/ITooa+Y5zgiBa7M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MM5CHP117244
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 17:05:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 17:05:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 17:05:12 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MM5Crc012605;
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
Subject: [PATCH RESEND v3 0/3] Add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 17:05:09 -0500
Message-ID: <20250422220512.297396-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Resend patch series to fix cc list

There are MMC boot failures seen with V1P8_SIGNAL_ENA on Kingston eMMC
and Microcenter/Patriot SD cards on Sitara K3 boards due to the HS200
initialization sequence involving V1P8_SIGNAL_ENA. Since V1P8_SIGNAL_ENA
is optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
For SD cards we shall parse DT for ti,suppress-v1p8-ena property to
determine whether to suppress V1P8_SIGNAL_ENA. Add new ti,suppress-v1p8-ena
to am62x, am62ax, and am62px SoC dtsi files since there is no internal LDO
tied to sdhci1 interface so V1P8_SIGNAL_ENA only affects timing.

This fix was previously merged in the kernel, but was reverted due
to the "heuristics for enabling the quirk"[0]. This issue is adressed
in this patch series by adding optional ti,suppress-v1p8-ena DT property
which determines whether to apply the quirk for SD.

Changes since v2:
- Include patch 3/3
- Reword cover letter
- Reword binding patch description
- Add fixes/cc tags to driver patch
- Reorder patches according to binding patch first
- Resend to fix cc list in original v3 series

Link to v2:
https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
Link to v1:
https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/

[0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Judith Mendez (3):
  dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena
  mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
  arm64: dts: ti: k3-am62*: add ti,suppress-v1p8-ena

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  1 +
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    |  1 +
 drivers/mmc/host/sdhci_am654.c                | 32 +++++++++++++++++++
 5 files changed, 40 insertions(+)


base-commit: 1be38f81251f6d276713c259ecf4414f82f22c29
-- 
2.49.0


