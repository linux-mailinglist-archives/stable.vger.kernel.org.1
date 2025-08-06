Return-Path: <stable+bounces-166689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F998B1C1DD
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DB7624C34
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9C221F0C;
	Wed,  6 Aug 2025 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m6DaK9Ye"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867A221275;
	Wed,  6 Aug 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467889; cv=none; b=F8tXQAIilxoCZCm7Vt679fpzp53YhFMZbu85vFWlOx+iGihDbNXkczc2XrJmZsZLnWt7HhV72q/uuvOkshxP48aw3PepP/NkfsbBIYXc4Je55iacEJ0Z3YM8zmUbZs6TpNSU8nlZedqWp9uGFKIHqBzgb2jQNStl0aumAdwAEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467889; c=relaxed/simple;
	bh=P+57ZUeXhlIPUWR+Lz1h+MLTlAkz+5+vW8yH9ah4+Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=CCZWe8X5GaMFhYnxMMEfCZybZN4QvYaKXoKmV2jEbJFjOGdj0DiGYMFEL4u00uMiryDsC/dn5wDFBPc4MyACcnUy7lUgE3VbaElIBgn22/bdw8OX/3RuNPgchPGBHc22JNx1I21+eSnCbelHCqk5GJCwgz37lqpsQv24RqnUE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m6DaK9Ye; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767po1t012123;
	Wed, 6 Aug 2025 10:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=HXxUnDHaYNU0mMmrMfCxsA
	ctTXfb2hYKcIpCLaZtg2c=; b=m6DaK9YeW5mfl4x4oa5iLccXPZ6A4nrBkmmftK
	12qzjCQ77d+4m6uWsyhI9k9oSCojdH90GjG66kwHlcI0Ncm2xsRd/P2LmxjRruqk
	TQWfZidTKkXYmyj7Kh/YRGMZPB3KTMmE04nP2/kcS+jF9//a14fEJQ1rHd9jC5d3
	d8blssokPrpQJZjbtV8XtAraQO5HlIrRZm71ZhIJwyGlT40KCMYSoaRdxbjfngLA
	5r9OPmNDUo4DhvsQiKqHQwpgazDLS2Ryr+6ZR7wbVZzaffmhcMkE9cUADBn+ppuf
	kDj3CZY+w5goj8bM7mcmnnk9UAUlpDJ+0nsN6f+j+E6d5LKg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48bpx8ac4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 10:11:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B1CBA4004B;
	Wed,  6 Aug 2025 10:10:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DD2B767CC2;
	Wed,  6 Aug 2025 10:09:37 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 10:09:37 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 6 Aug 2025 10:09:35 +0200
Subject: [PATCH] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAL4Nk2gC/x2M0QpAQBAAf0X77GpdXPgV6cLtsQ+HbpGSf3d5n
 KaZB4Qik0CbPRDpYuFtTVDkGUzLsM6k2CUGjbrCGo06dzkiDcF6vq07xG4hqAnRjKbBUvsCUrp
 HSvrfdv37fk1vT8RmAAAA
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
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01

Add memory-region-names property for stm32mp257f-ev1.
This allows to identify and check memory-map area's configuration.

Cc: stable@vger.kernel.org
Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 2f561ad4066544445e93db78557bc4be1c27095a..16309029758cf24834f406f5203046ded371a8f9 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -197,6 +197,7 @@ &i2c8 {
 
 &ommanager {
 	memory-region = <&mm_ospi1>;
+	memory-region-names = "mm_ospi1";
 	pinctrl-0 = <&ospi_port1_clk_pins_a
 		     &ospi_port1_io03_pins_a
 		     &ospi_port1_cs0_pins_a>;

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250806-upstream_fix_dts_omm-c006b69042f1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


