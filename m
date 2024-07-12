Return-Path: <stable+bounces-59181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5F92F7CE
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A52BB20E89
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24710140E50;
	Fri, 12 Jul 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QVl3ekrY"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BB11422B4;
	Fri, 12 Jul 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776011; cv=none; b=rBh/lJ3yJFApm/A79KdSmWdq70u1KBqdzJN/Vmaib0YJHYpUkFjagk/pbSGPkdPDUFfvmfDLbypbDs32jg6rP1qQ3CRt+vuNPJMf5cDzIRgiUU16dPxVhjf5/jrp1FWBfEsHNwbxlLx1JkDDtsc2d79yI/e91O7xmBHqS9BSScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776011; c=relaxed/simple;
	bh=JFV3wuE42s862gFMz1W1mKhz2VN8ZG4mVI/AHJKGWFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd+ltJR5x8DN+5JJqXeDqE701J5NqWex5XPpOC9vksh4l0+lJWwQFN+CDRWHe6YuB2cYlQXgxHvUo2EiyotWJFPcda6StxQxxwMBSRxkQu8XtDdZZoAbTiqKpKrNHMpKK6R9eDz/ZK9vG6KMVZNTl1dD9E//aIBX3Pb9TaPhqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QVl3ekrY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CV+7c2KCoiFZRjgIBxG8BPV9ZzjPkMf+tPSeCNTaUYY=; b=QVl3ekrYNZ1CuEcNgpGSUVyyy1
	z7rXUCBm+Y7yVtn4dEZ2OtNNiZDMaWe8LShWXyksLVQJYcbI0DGvdRZTOwHUSg2s3aBG+LM+Zh/db
	yqQ9Ze4dSG6yM4A/KijzF4sj/nFzVVLjRMSaXKk5OEAYvkRzlTvjMZ5CG3kXpxImtUEiBvTsAcLPq
	rjtFbWVWGURSYkJUeQ2QtopkFYfzAE5JAiVhuWC/FiyMiEWA/HlXd7wQnYZyeusMpUlsEz8jYnbow
	JboWDKr5vGJAPtE+YtHQBXihXc4dvBMJWSovzPHtI7FFTlmIAlZAC4rb7qbthIYMphKJmwvnFgnOw
	HGY0tVsA==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sSCRM-00EDWr-OU; Fri, 12 Jul 2024 11:19:44 +0200
Message-ID: <916e4781-54b5-417a-be22-499739e4d818@igalia.com>
Date: Fri, 12 Jul 2024 10:19:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
To: "Huang, Ying" <ying.huang@intel.com>, Tvrtko Ursulin
 <tursulin@igalia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 stable@vger.kernel.org
References: <20240708075632.95857-1-tursulin@igalia.com>
 <87ttgzaxzi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <87ttgzaxzi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 09/07/2024 07:19, Huang, Ying wrote:
> Tvrtko Ursulin <tursulin@igalia.com> writes:
> 
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Since balancing mode was added in
>> bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
>> it was possible to set this mode but it wouldn't be shown in
>> /proc/<pid>/numa_maps since there was no support for it in the
>> mpol_to_str() helper.
>>
>> Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
>> would be displayed as 'default' due a workaround introduced a few years
>> earlier in
>> 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").
>>
>> To tidy this up we implement two changes:
>>
>> Replace the MPOL_F_MORON check by pointer comparison against the
>> preferred_node_policy array. By doing this we generalise the current
>> special casing and replace the incorrect 'default' with the correct
>> 'bind' for the mode.
>>
>> Secondly, we add a string representation and corresponding handling for
>> the MPOL_F_NUMA_BALANCING flag.
>>
>> With the two changes together we start showing the balancing flag when it
>> is set and therefore complete the fix.
>>
>> Representation format chosen is to separate multiple flags with vertical
>> bars, following what existed long time ago in kernel 2.6.25. But as
>> between then and now there wasn't a way to display multiple flags, this
>> patch does not change the format in practice.
>>
>> Some /proc/<pid>/numa_maps output examples:
>>
>>   555559580000 bind=balancing:0-1,3 file=...
>>   555585800000 bind=balancing|static:0,2 file=...
>>   555635240000 prefer=relative:0 file=
>>
>> v2:
>>   * Fully fix by introducing MPOL_F_KERNEL.
>>
>> v3:
>>   * Abandoned the MPOL_F_KERNEL approach in favour of pointer comparisons.
>>   * Removed lookup generalisation for easier backporting.
>>   * Replaced commas as separator with vertical bars.
>>   * Added a few more words about the string format in the commit message.
>>
>> v4:
>>   * Use is_power_of_2.
>>   * Use ARRAY_SIZE and update recommended buffer size for two flags.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
>> References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: <stable@vger.kernel.org> # v5.12+
> 
> LGTM, Thanks!
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thank you!

Andrew, this appears safe to pick up now as a replacement for the 
identically named patch you previously picked up but then had to back 
out from the queue.

Thanks!

Tvrtko

>> ---
>>   mm/mempolicy.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index aec756ae5637..a1bf9aa15c33 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>>    * @pol:  pointer to mempolicy to be formatted
>>    *
>>    * Convert @pol into a string.  If @buffer is too short, truncate the string.
>> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
>> - * longest flag, "relative", and to display at least a few node ids.
>> + * Recommend a @maxlen of at least 51 for the longest mode, "weighted
>> + * interleave", plus the longest flag flags, "relative|balancing", and to
>> + * display at least a few node ids.
>>    */
>>   void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>   {
>> @@ -3303,7 +3304,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>   	unsigned short mode = MPOL_DEFAULT;
>>   	unsigned short flags = 0;
>>   
>> -	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
>> +	if (pol &&
>> +	    pol != &default_policy &&
>> +	    !(pol >= &preferred_node_policy[0] &&
>> +	      pol <= &preferred_node_policy[ARRAY_SIZE(preferred_node_policy) - 1])) {
>>   		mode = pol->mode;
>>   		flags = pol->flags;
>>   	}
>> @@ -3331,12 +3335,18 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>   		p += snprintf(p, buffer + maxlen - p, "=");
>>   
>>   		/*
>> -		 * Currently, the only defined flags are mutually exclusive
>> +		 * Static and relative are mutually exclusive.
>>   		 */
>>   		if (flags & MPOL_F_STATIC_NODES)
>>   			p += snprintf(p, buffer + maxlen - p, "static");
>>   		else if (flags & MPOL_F_RELATIVE_NODES)
>>   			p += snprintf(p, buffer + maxlen - p, "relative");
>> +
>> +		if (flags & MPOL_F_NUMA_BALANCING) {
>> +			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
>> +				p += snprintf(p, buffer + maxlen - p, "|");
>> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>> +		}
>>   	}
>>   
>>   	if (!nodes_empty(nodes))

