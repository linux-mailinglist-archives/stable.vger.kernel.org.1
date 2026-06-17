Return-Path: <stable+bounces-266649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YmacBMJMMmpryQUAu9opvQ
	(envelope-from <stable+bounces-266649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:29:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59354697303
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:29:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=OJ2nIEfc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266649-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266649-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3E6301113E
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5633B892B;
	Wed, 17 Jun 2026 07:28:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0435295C;
	Wed, 17 Jun 2026 07:27:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681282; cv=none; b=O/CXghAR82y2+vfaHFE6Z8LxDfY9TOgfj8dDzwWz2+D0mF9mj2SLrCN9dIpeaKv7tpBjasKgzLH0ua438XeNxqebK7kCvjU1FFOXAwo9foMDWV8eAJq1GgFF5sVDvOVjMQrczA6eCPpfQxQHQyoE2ychDR71X1graYtrqdjtAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681282; c=relaxed/simple;
	bh=fnlyTTJG67Cu0MhNcw+VM6xc1axm17rj/2pC41SDAIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYXqK7hMV+eutDQlyKPWDjV0S4t/WyJqqmecv32HH+I5sHPwp8Q/XQI9ZZ7J+Tm9+I9kQ5hhG3hKi0Wul+QBcqTUh4FCh8o+X78EOZX0sN0mSBfdOAWONeaTNa+0PYrUK/E1Nfq8XNqO6Dmik5Dz0D6ldZxLKR+Y49xpSdQapE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OJ2nIEfc; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E181477;
	Wed, 17 Jun 2026 00:27:53 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BF4D3FBF8;
	Wed, 17 Jun 2026 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781681278; bh=fnlyTTJG67Cu0MhNcw+VM6xc1axm17rj/2pC41SDAIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJ2nIEfcGEZfVNumI+7DmShcrhSx7v0akIC4NOjbrICARC1jyyKUcwa2id8oyGo7u
	 ObOEw0TmGkyuAiiSkMFIIJUNDqQDO8bGZLKRg8127JdjiNv6s2oKoG6CaJydFG81si
	 4V7hQkTpCo/49PNAQ593put4Ks3Ub1qXFyQ9w/2U=
Message-ID: <0767a224-d988-46d9-a535-2b490d990287@arm.com>
Date: Wed, 17 Jun 2026 08:27:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the
 adjust_perf path
To: Hongyan Xia <hongyan.xia@transsion.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
 <8d3ddc27-5024-4b9f-ac84-f3d92f35246a@transsion.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <8d3ddc27-5024-4b9f-ac84-f3d92f35246a@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hongyan.xia@transsion.com,m:zhongqiu.han@oss.qualcomm.com,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[arm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59354697303

On 6/17/26 05:06, Hongyan Xia wrote:
> On 6/16/2026 11:47 PM, Zhongqiu Han wrote:
>> The need_freq_update flag makes sugov_should_update_freq() return true
>> regardless of the rate_limit_us throttling, and is cleared in
>> sugov_update_next_freq(). sugov_update_single_freq() and
>> sugov_update_shared() go through that helper, so the flag does not
>> persist there.
>>
>> However, sugov_update_single_perf() (used by drivers implementing the
>> ->adjust_perf() callback, e.g. intel_pstate or amd-pstate in passive mode)
>> calls cpufreq_driver_adjust_perf() directly and never goes through
>> sugov_update_next_freq(), so the need_freq_update flag is not cleared in
>> that path.
>>
>> Before commit 75da043d8f88 ("cpufreq/sched: Set need_freq_update in
>> ignore_dl_rate_limit()"), this was effectively harmless because
>> sugov_should_update_freq() still honoured the rate limit even when
>> need_freq_update was set. After that change, the flag forces
>> sugov_should_update_freq() to always return true, so once set, it stays
>> effective indefinitely on the adjust_perf path.
>>
>> As a result, cpufreq_driver_adjust_perf() gets called on every scheduler
>> utilization update (with the runqueue lock held) rather than being
>> throttled by rate_limit_us, even if the driver itself may skip redundant
>> hardware updates.
>>
>> Clear need_freq_update at the end of the adjust_perf path as well.
>>
>> Fixes: 75da043d8f88 ("cpufreq/sched: Set need_freq_update in ignore_dl_rate_limit()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index ae9fd211cec1..a4e689eefdfb 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -486,6 +486,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>>   	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>>   				   sg_cpu->util, max_cap);
>>   
>> +	sg_policy->need_freq_update = false;
>>   	sg_policy->last_freq_update_time = time;
> 
> Nice catch. Thanks.
> 
> It does seem to me that setting last_freq_update_time should then assert 
> !need_freq_update, otherwise it doesn't make sense, but that's a 
> different topic.
+1, feel free to submit that too.

For $SUBJECT:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

