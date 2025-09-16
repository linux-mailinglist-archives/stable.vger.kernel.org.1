Return-Path: <stable+bounces-179749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363BBB5A0EB
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 21:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFD71C01961
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642602D47F1;
	Tue, 16 Sep 2025 19:05:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6E1E0DEA;
	Tue, 16 Sep 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049517; cv=none; b=V7mF7AdL/vtFJe/4lFrOgzk65h7eoqKO+Ooan0BU3JcG3cVPogdmxn1vBWQIGmcCqSoKNZv/og6oY2zS3wQaB6pplqTwdDG25ZYCvStAZl8ITV2U8SItbQc5GpxiHAJlEAwie+sm5v3Hk/WOkTo5KiPLVeqJHZDoWtWKfWmQv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049517; c=relaxed/simple;
	bh=BocNEQlJuQpTpdJ+perq7Zf+f5uddM0lcHE0m9ROn5U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=abLQSuUWUZ04r0iOrR4V8L9Jnu+3jqeubE7OXTq2nW9SCLkJMisUaDT8kV+ry2pGamPvXc8LcL8LWfDuG/EwR7lCNngM16NpcZU8v61TurIKDG634buc15HA6SbdGmSKqJfFG+wjFl0/jdYnHOO4Fx0ouxdMP5069AhxIrtdjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.103] (213.87.161.48) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Sep
 2025 22:04:53 +0300
Message-ID: <ed43a751-3b02-46db-9fe1-da6c9f79fd80@omp.ru>
Date: Tue, 16 Sep 2025 22:04:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] cpufreq: scmi: Fix null-ptr-deref in
 scmi_cpufreq_get_rate()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Henry Martin <bsdhenrymartin@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	<lvc-project@linuxtesting.org>
References: <b6ebf19c-8328-44de-a695-157061a9d8a8@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <b6ebf19c-8328-44de-a695-157061a9d8a8@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/16/2025 18:41:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 196326 [Sep 16 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_spam_in_reply_from_match_msgid}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.161.48 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;marc.info:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.161.48
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/16/2025 18:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/16/2025 4:28:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/12/25 11:35 PM, Sergey Shtylyov wrote:

> From: Henry Martin <bsdhenrymartin@gmail.com>
> 
> [ Upstream commit 484d3f15cc6cbaa52541d6259778e715b2c83c54 ]
> 
> cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
> in the policy->cpus mask. scmi_cpufreq_get_rate() does not check for
> this case, which results in a NULL pointer dereference.
> 
> Add NULL check after cpufreq_cpu_get_raw() to prevent this issue.
> 
> [Sergey: resolved reject (reordering the local variables).]
> 
> Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   Probably should have noted that this patch fixes CVE-2025-37830:

https://marc.info/?l=linux-cve-announce&m=174668615621702

   (Sorry, lore doesn't work for me anymre...]

MBR, Sergey


