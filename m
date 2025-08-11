Return-Path: <stable+bounces-167039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0ABB20A3B
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE232A4E51
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55D2D9784;
	Mon, 11 Aug 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5WPhiOz8"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0F2D320E;
	Mon, 11 Aug 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919040; cv=none; b=AN4K2C9O2mb+9zkKju48/Oqrilo+NMpfSYccprcmfYppv3j+idewv6tMXaBoh2o+mY2VIj+9CNoeGThjtQ91qUpIpr5P5ztXIAb5/5reLGJfVz0ROsPe7clcXPUAP2tdN7FH3L05voGX4NeIpYI6nbeHvzRzjEIMakVwdOyaZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919040; c=relaxed/simple;
	bh=jCK5Wtf43sYwOhnjBsKmCdwu199RFoIgenO7BIaUZ1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EMjTIVW6qK3ECfPFzUpdx+KPPSGttqRxLwCOAmr9TVAUpuJqstgj21KTcoWRwnJRku2294l/Lryndm0YzmC6l6duKHYo/TawDWDQ5er9XUlvfGDy4lY8SEWmvmgBY8O05bv4CNGJOqEtcjKQWib9MFZ/kNjYfjL5cQtohmj1+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5WPhiOz8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BCc97o032379;
	Mon, 11 Aug 2025 15:30:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=2jQId8J7hJCUUyc0leXs7a
	3GHenaf+1ZJSfH2NICKrs=; b=5WPhiOz83OFz+h3h9LpGnHuzXRzWvTfDuQ9gSk
	lTFPf2PEZOLv7hBu3bcXzMvyYDpXFELxQqD5DFmLUMX6jLPy0nEE7Td7LbnkO26u
	LSLGaJa70dHEuEqjRixHCFL8QraoltOuUMKWjxeKvBlRwyNsZQuLTPOrUT1ecr6E
	BgxMxlYoy8vu3hIYrG6/65mc9Qa6B+31r67Wmr8EdH/xJajOUIxAs7w+JzyQinFv
	576ZurbegUwBMjfS8CyfIdbpcBabgLjw4CfhXEZ5PnVO02z4LlT8izeVVyacb/uu
	SZECueEu+JJIgB9hmBvVsmwfKfXH7ss1al7+2pH2AzohZXIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48durkxvex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 15:30:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1D85F4002D;
	Mon, 11 Aug 2025 15:29:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0449C73D3F6;
	Mon, 11 Aug 2025 15:28:54 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 15:28:53 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 11 Aug 2025 15:28:49 +0200
Subject: [PATCH v3] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250811-upstream_fix_dts_omm-v3-1-c4186b7667cb@foss.st.com>
X-B4-Tracking: v=1; b=H4sIABDwmWgC/4XNSw7CIBCA4asY1tIMWLC68h7GNC0Py4LSMEg0T
 e8u7UoXxuU/k/lmJmiiM0jOu5lEkx26MJY47HdEDd14N9Tp0oQDF9CApI8JUzSdb617tjphG7y
 nCkD28gQ1t4yU0ymast7Y66304DCF+Nq+ZLZO/4CZUUaNbBQTRtec64sNiBWmSgVPVjLzD4axH
 wwvDIC1QsBR9lp8M8uyvAEJ7sqLAQEAAA==
X-Change-ID: 20250806-upstream_fix_dts_omm-c006b69042f1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01

In order to set the AMCR register, which configures the
memory-region split between ospi1 and ospi2, we need to
identify the ospi instance.

By using memory-region-names, it allows to identify the
ospi instance this memory-region belongs to.

Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
Cc: stable@vger.kernel.org
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v3:
- Set again "Cc: <stable@vger.kernel.org>"
- Link to v2: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v2-1-00ff55076bd5@foss.st.com

Changes in v2:
- Update commit message.
- Use correct memory-region-names value.
- Remove "Cc: <stable@vger.kernel.org>" tag as the fixed patch is not part of a LTS.
- Link to v1: https://lore.kernel.org/r/20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 2f561ad4066544445e93db78557bc4be1c27095a..7bd8433c1b4344bb5d58193a5e6314f9ae89e0a4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -197,6 +197,7 @@ &i2c8 {
 
 &ommanager {
 	memory-region = <&mm_ospi1>;
+	memory-region-names = "ospi1";
 	pinctrl-0 = <&ospi_port1_clk_pins_a
 		     &ospi_port1_io03_pins_a
 		     &ospi_port1_cs0_pins_a>;

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250806-upstream_fix_dts_omm-c006b69042f1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


