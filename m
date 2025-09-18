Return-Path: <stable+bounces-176894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62492B3ED69
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3C7AD2BE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459630FC2A;
	Mon,  1 Sep 2025 17:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B321096F;
	Mon,  1 Sep 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747991; cv=none; b=purrS3Ggz7kXLiDC9+maqFXHx67YdCE0uFhlXiOlHY4aNkc0r6x1P9+pQX0IcIFqmPWI1ohy9s5xU9ChIT8eurOOFJBeo81YNxy4ZRJaJMPOHDAP7MSMtn/AIe28dP5VeVI37B3IzXrmzVeHn8qPUxbzp0INecCB+bzwytRFHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747991; c=relaxed/simple;
	bh=UCHV/Na97pI1ciIlyIoNkkkAmLUGUtqDMwOiOXpschQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHpSZYPSm4aq/p6tKaZadZ4d05uQEUu13qmdBfm6CnamXRK6fjx1gUa2Zb5bMVSEOX2eQVHmBnipSZEjRp8MJQYeJc51MdjwACNbZn4G+IekfCk9uw/fUp7FeufvKF9X/JqoKmYKZ6CmBhXL1CoQqvWFEDjQctVl4mwbU5J0aC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612E916A3;
	Mon,  1 Sep 2025 10:33:00 -0700 (PDT)
Received: from [10.57.65.108] (unknown [10.57.65.108])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A10E3F694;
	Mon,  1 Sep 2025 10:33:06 -0700 (PDT)
Message-ID: <dd2e0cdd-ca95-4c83-9397-0606f3899799@arm.com>
Date: Mon, 1 Sep 2025 18:33:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: Fix late boot with holes in CPU topology
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
 kenneth.crudup@gmail.com, stable@vger.kernel.org
References: <20250831214357.2020076-1-christian.loehle@arm.com>
 <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/1/25 17:58, Rafael J. Wysocki wrote:
> On Sun, Aug 31, 2025 at 11:44 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
>> adjustment") added a mechanism to handle CPUs that come up late by
>> retrying when any of the `cpufreq_cpu_get()` call fails.
>>
>> However, if there are holes in the CPU topology (offline CPUs, e.g.
>> nosmt), the first missing CPU causes the loop to break, preventing
>> subsequent online CPUs from being updated.
>> Instead of aborting on the first missing CPU policy, loop through all
>> and retry if any were missing.
>>
>> Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adjustment")
>> Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
>> Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
>> Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8144d@panix.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/power/energy_model.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index ea7995a25780..b63c2afc1379 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
>>  static void em_check_capacity_update(void)
>>  {
>>         cpumask_var_t cpu_done_mask;
>> -       int cpu;
>> +       int cpu, failed_cpus = 0;
>>
>>         if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
>>                 pr_warn("no free memory\n");
>> @@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
>>
>>                 policy = cpufreq_cpu_get(cpu);
>>                 if (!policy) {
>> -                       pr_debug("Accessing cpu%d policy failed\n", cpu);
> 
> I'm still quite unsure why you want to stop printing this message.  It
> is kind of useful to know which policies have had to be retried, while
> printing the number of them really isn't particularly useful.  And
> this is pr_debug(), so user selectable anyway.
> 
> So I'm inclined to retain the line above and drop the new pr_debug() below.
> 
> Please let me know if this is a problem.
For nosmt this leads to a lot of prints every seconds, that's all.
I can resend with the pr_debug for every fail, alternatively print a
cpumask.

