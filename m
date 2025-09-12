Return-Path: <stable+bounces-179398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300CBB557A9
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2653BF13E
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC113221FCA;
	Fri, 12 Sep 2025 20:35:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3F2DC76D;
	Fri, 12 Sep 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709329; cv=none; b=OmaD9LrWQNWuUlBp/4vMPJUatUX9JIWTuqEopjEAWL87nItzUR+0ORtaWcsilOA43L4XxkWRPOZiq/xXVkKmS0zMwkBnGSOirk2WHPXt/5U2lczt/6Ptqabd7fjCy1ICJncwge517DjYIhBzqaZiP+iRfdw5eXSOrVtWGPkIKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709329; c=relaxed/simple;
	bh=pI2xXThVA2j/bMJn7Qrz6ZQIqgg27DQdVGJLHXZHBxs=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=oLddCUsoq2/I5YRHU9COVhBrVbdpm8OKVWzZw8/6HVwtbhh5UBZSGiK73BuxYcXEWfNIthMK6KHQ6c+2iWhRVeTr0qTZnFc7ni6Y8A1E3wqcyAS/6hlvOEoFwl4efam4mkQrQOdAFzshY7CC/2vkjBFjf046Tbtdl9eLybwt9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.146.251) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 12 Sep
 2025 23:35:07 +0300
Message-ID: <b6ebf19c-8328-44de-a695-157061a9d8a8@omp.ru>
Date: Fri, 12 Sep 2025 23:35:07 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Henry Martin <bsdhenrymartin@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	<lvc-project@linuxtesting.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 5.10.y] cpufreq: scmi: Fix null-ptr-deref in
 scmi_cpufreq_get_rate()
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/12/2025 20:12:11
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 196228 [Sep 12 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;213.87.146.251:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.146.251
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/12/2025 20:14:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/12/2025 6:07:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 484d3f15cc6cbaa52541d6259778e715b2c83c54 ]

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.

[Sergey: resolved reject (reordering the local variables).]

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/cpufreq/scmi-cpufreq.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-stable/drivers/cpufreq/scmi-cpufreq.c
===================================================================
--- linux-stable.orig/drivers/cpufreq/scmi-cpufreq.c
+++ linux-stable/drivers/cpufreq/scmi-cpufreq.c
@@ -29,12 +29,18 @@ static const struct scmi_handle *handle;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
 	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	struct scmi_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;

