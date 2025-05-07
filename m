Return-Path: <stable+bounces-141975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE74AAD825
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764EA3BF5CF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4FF21B8E0;
	Wed,  7 May 2025 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Hs3+pgg8"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E52153CB;
	Wed,  7 May 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602884; cv=none; b=FK9ODe8SwcHW7eSUxGeRhxXk5dtgeh9l6yfKGECKex+O+JERKK3UGXX36GahSdNpnnBD3PG4/fkU6eGiAzcVV5IDP2VZAK/dfVM/vfwERycxhg3F06C320XmVQSTNjWgPvD4KwlZrrS8Q2DcCyKyt/dDu7DPQp3eHJfZU+ptpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602884; c=relaxed/simple;
	bh=Uxr/S7I0305h1Vy3mJmKvk5INQ0mKoXTnKd+l5Ez5wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oGjZfPkPxrDrrwFjXXxXNsCEGX+Q7qKFWi5H5LhJt/dRHAY2eaIom8/vv5tPUkzGegokGh69Q7BpYlcgF7nkLCoGKkk/9Isqx/lFMxTTQ6EipQOvO0KHg5iG9G0BgU0wtf3ulOolNqqnlZNqWnNY6ZX5TKisq+P7iIrs9Rmuz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Hs3+pgg8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5475tPOD018103;
	Wed, 7 May 2025 09:27:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	z2Wz+02biPobkFgq4687ds23RCGZHo5ebYaXPazcgac=; b=Hs3+pgg8FusUda+P
	uxcmX7XGetPt2IKMSb6nYiOSmwJwe39Qs+rU3AbHk98vY8sLq0Ecvbx9oD4SUKM/
	0rkFT/co2QkWcbctVRnhvSptIjpglNVeMI6iw04QMdbjOd+HlGEa0rjV36Zd60/d
	kxEvzgF9VOfmp+LUXae9OBTuZ6jmji4VNQ/huCM5h7OZUtWdUYvkdsbkPT6fuqFj
	aVikcnmCd96hOzk8zIdxTx020B/tZut3xlDI9DFwS2sNt0bs74chdFlu61ioLk19
	anMeeE37k50lhak9fc3s0oqwIi+/ji5JO/8MohaNtzxKPe1KnAr2zVQa41/MJaAP
	8CVSmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46g1sx8cdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 09:27:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2EBBD4005B;
	Wed,  7 May 2025 09:26:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1142BACBA60;
	Wed,  7 May 2025 09:25:17 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:25:16 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 7 May 2025 09:25:14 +0200
Subject: [PATCH v13 1/4] firewall: Always expose firewall prototype
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250507-upstream_ospi_v6-v13-1-32290b21419a@foss.st.com>
References: <20250507-upstream_ospi_v6-v13-0-32290b21419a@foss.st.com>
In-Reply-To: <20250507-upstream_ospi_v6-v13-0-32290b21419a@foss.st.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>,
        <stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01

In case CONFIG_STM32_FIREWALL is not set, prototype are not visible
which leads to following errors when enabling, for example, COMPILE_TEST
and STM32_OMM:

stm32_firewall_device.h:117:5: error: no previous prototype for
‘stm32_firewall_get_firewall’ [-Werror=missing-prototypes]
  117 | int stm32_firewall_get_firewall(struct device_node *np, struct
stm32_firewall *firewall,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bus/stm32_firewall_device.h:123:5:
error: no previous prototype for ‘stm32_firewall_grant_access’
[-Werror=missing-prototypes]
  123 | int stm32_firewall_grant_access(struct stm32_firewall *firewall)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bus/stm32_firewall_device.h:128:6:
error: no previous prototype for ‘stm32_firewall_release_access’
[-Werror=missing-prototypes]
  128 | void stm32_firewall_release_access(struct stm32_firewall *firewall)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bus/stm32_firewall_device.h:132:5:
error: no previous prototype for ‘stm32_firewall_grant_access_by_id’
[-Werror=missing-prototypes]
  132 | int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bus/stm32_firewall_device.h:137:6:
error: no previous prototype for ‘stm32_firewall_release_access_by_id’
[-Werror=missing-prototypes]
  137 | void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id)
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make prototypes always exposed to fix this issue.

Cc: <stable@vger.kernel.org>
Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 include/linux/bus/stm32_firewall_device.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
index 5178b72bc920986bb6c55887453d146f382a8e77..ba6ef4468a0a8dfeb3e146ec90502e2f35172edc 100644
--- a/include/linux/bus/stm32_firewall_device.h
+++ b/include/linux/bus/stm32_firewall_device.h
@@ -35,7 +35,6 @@ struct stm32_firewall {
 	u32 firewall_id;
 };
 
-#if IS_ENABLED(CONFIG_STM32_FIREWALL)
 /**
  * stm32_firewall_get_firewall - Get the firewall(s) associated to given device.
  *				 The firewall controller reference is always the first argument
@@ -112,6 +111,15 @@ int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsy
  */
 void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id);
 
+#if IS_ENABLED(CONFIG_STM32_FIREWALL)
+
+extern int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
+				unsigned int nb_firewall);
+extern int stm32_firewall_grant_access(struct stm32_firewall *firewall);
+extern void stm32_firewall_release_access(struct stm32_firewall *firewall);
+extern int stm32_firewall_grant_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id);
+extern void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 subsystem_id);
+
 #else /* CONFIG_STM32_FIREWALL */
 
 int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,

-- 
2.25.1


