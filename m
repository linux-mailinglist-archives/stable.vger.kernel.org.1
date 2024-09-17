Return-Path: <stable+bounces-76618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B297B4AD
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341BD1C225A2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1A17E019;
	Tue, 17 Sep 2024 20:30:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FDEEBA;
	Tue, 17 Sep 2024 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605056; cv=none; b=W2ph5QW7zV1pA4uN0iQNMZFBebgpxs69L9UIqgqkqq0aQuswZDEad1uH4bo2eOvdkaFafSHsAYQIh13ReAmSGQmj//u/CzgCstfbrf4plJaMl+gA8lKJg5ZzwIxYHnS0SWsxIv077kx3SxSUtuF8S9SOv796kQJaLZbudYlRq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605056; c=relaxed/simple;
	bh=roKn6yBnU+vuSnt2RPjO6XMboDOQYFUF/LVQHUr1LXM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=l/RZxl4HC5dRzoEbtoNqxGmrRDhkFMfNuUQouWq6L5vQh1dZG4DAEfCi/7k4wNpdEatiYni8MbKdCduHaRCZhSlTjexkvUqHjFPWT33P2RzLTKJOAo4GyB9J0WeEj9moKTuy+fXwerXoaIygNMD6a9F8lh+79N9LUPDQyO/zYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.108] (178.176.74.43) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 23:30:40 +0300
Message-ID: <8ec2130d-0a5a-c9c1-c5de-8f69f52a4b5e@omp.ru>
Date: Tue, 17 Sep 2024 23:30:39 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 5.10.y] genirq/ipi: Fix NULL pointer deref in
 irq_data_get_affinity_mask()
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Content-Language: en-US
Organization: Open Mobile Platform
CC: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/17/2024 20:19:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187809 [Sep 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.43
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/17/2024 20:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/17/2024 6:58:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

[ Upstream commit feabecaff5902f896531dde90646ca5dfa9d4f7d ]

If ipi_send_{mask|single}() is called with an invalid interrupt number, all
the local variables there will be NULL. ipi_send_verify() which is invoked
from these functions does verify its 'data' parameter, resulting in a
kernel oops in irq_data_get_affinity_mask() as the passed NULL pointer gets
dereferenced.

Add a missing NULL pointer check in ipi_send_verify()...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Fixes: 3b8e29a82dd1 ("genirq: Implement ipi_send_mask/single()")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/b541232d-c2b6-1fe9-79b4-a7129459e4d0@omp.ru

---
 kernel/irq/ipi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-stable/kernel/irq/ipi.c
===================================================================
--- linux-stable.orig/kernel/irq/ipi.c
+++ linux-stable/kernel/irq/ipi.c
@@ -186,9 +186,9 @@ EXPORT_SYMBOL_GPL(ipi_get_hwirq);
 static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
 			   const struct cpumask *dest, unsigned int cpu)
 {
-	struct cpumask *ipimask = irq_data_get_affinity_mask(data);
+	struct cpumask *ipimask;
 
-	if (!chip || !ipimask)
+	if (!chip || !data)
 		return -EINVAL;
 
 	if (!chip->ipi_send_single && !chip->ipi_send_mask)
@@ -197,6 +197,10 @@ static int ipi_send_verify(struct irq_ch
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
+	ipimask = irq_data_get_affinity_mask(data);
+	if (!ipimask)
+		return -EINVAL;
+
 	if (dest) {
 		if (!cpumask_subset(dest, ipimask))
 			return -EINVAL;

