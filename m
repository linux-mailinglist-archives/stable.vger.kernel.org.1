Return-Path: <stable+bounces-121191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CABA54508
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F9D1892C0A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D467207A04;
	Thu,  6 Mar 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sGUVnCB9"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FC1DF24E;
	Thu,  6 Mar 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250244; cv=none; b=mL+8WWPUl1t61QaiLJAg+rI6c8guzt5CzvWTWF6V+UEsrgTQJYkBdHZdYvFHIjEESNvXWvakq8oFNsuiiu2mKHrezLkjZGw8I5piNej4Ookkczm5Eo5aVTSccaAlO5J7iE0Ut1ZZzS+GZ85SqG9f+C33lTAijGNQijgyO7UKPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250244; c=relaxed/simple;
	bh=/7ANYMaP62+Mbot+ch5lr0itG0Gzhus/1qB4+BuMJ2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oDVv33TUgq0A9cpgjQXH6H2zoeQd5f9zZwNOihfoRNP9E2vC+uJ5O3Y44+gLuSKhasVMqN1AoWo0z0LXfQ9i1+bO5wHGoznOy8jRCIJMFvnUBqD6+yNb8RDQjFeNlgnzcJhWvMSx/QRMnbEj6VBTZC2LmWv1OgIS+7FSmds4LDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sGUVnCB9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5267Sk4P015077;
	Thu, 6 Mar 2025 09:36:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=AjdIaR6MdC1bXj1PgBl4op
	30U/Eb3YmtVX8LVQkTc3s=; b=sGUVnCB9AsP9lVcBc94H0iRsI1bvs/7vqYrEJW
	SOJgG+zfq/xn1Wj2Lp0GSUOJUpDOPtJdZh20m879FLpDq69j+QZh3yOCjFD7b0VL
	EJrCSaIcaB0oHwJTRs8T/UGlypyqr3Audz+1lrymJFgCrUBzImKLz+D0WVv0NTfl
	HXf4g8xMLVrO73+jSMnP3i6xFnOdOB1nZwY5QAzbWjjZZ+T3vTEfLvIt8S4Wnbh2
	r7uMAA+3CzAbCFoVihzekdEhgqkdCpbDMLd0hJ4+iBby4aoDHR46Zo4K/FO6dQH9
	19Ogdgk4+KDlFbOvTWLnbNVh2vypX7OmsgOkMqZC8wOYLSbw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 456krth3ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:36:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A68EF40072;
	Thu,  6 Mar 2025 09:35:14 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA4CB374AFA;
	Thu,  6 Mar 2025 09:34:19 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:34:19 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:34:19 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <stable@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] clocksource: stm32-lptimer: use wakeup capable instead of init wakeup
Date: Thu, 6 Mar 2025 09:34:07 +0100
Message-ID: <20250306083407.2374894-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

"wakeup-source" property describes a device which has wakeup capability
but should not force this device as a wakeup source.

Fixes: 48b41c5e2de6 ("clocksource: Add Low Power STM32 timers driver")
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/clocksource/timer-stm32-lp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c95161cb22..193e4f643358 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -168,9 +168,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
-- 
2.25.1


