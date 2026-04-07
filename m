Return-Path: <stable+bounces-233535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTsAC7V1GnuxwcAu9opvQ
	(envelope-from <stable+bounces-233535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:58:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFA3AC64A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DDB301325A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6593A6EE9;
	Tue,  7 Apr 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XU+r8HEd"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C42ED141;
	Tue,  7 Apr 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555860; cv=none; b=TOSuyPrX/o+eFkrxhctuLUbJeJk6QWJDjzve0o/w86stP6fccyg90ND/KoB1lZthSXFixx4g7fsL9M4m3lWY/mZvrC9kGYmZ/lKG8ib2uRcx7eE3I9Mmn1Lp1ESzHwHqS94SuHy2v+hVOfYFWiO8VSTzIK6vz/4z+98HqFu0Ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555860; c=relaxed/simple;
	bh=GDEYdp9RtUTCRAaXXYD6KpDKVf+j1vyiOvYCN2p8fxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvD2aTQFQ1QAAD6LyqsfTMcfzGKfEjaRUeCMjA4TW37G1cnEQRdMX1Px5JC4pUaPrySO7tolhAqTqI0NFoTeX5D7iuXJ0CDkyO6q4wai+3CrbEjzZDsdOepaJvSPFzvLlDKpt7lSxuM/vifXPKNJxn3vO0KBHBRtr+CahpCOBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XU+r8HEd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A354D1BB2;
	Tue,  7 Apr 2026 02:57:32 -0700 (PDT)
Received: from [10.57.62.20] (unknown [10.57.62.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21E03F7D8;
	Tue,  7 Apr 2026 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775555858; bh=GDEYdp9RtUTCRAaXXYD6KpDKVf+j1vyiOvYCN2p8fxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XU+r8HEdffWkHWIz9LDQmKaOh8jWEiuN53Vb72TAtJ3qBPJmaTUn5V/Ts74qgohF5
	 ZiYUKRdqLa89HvI499eDJOJgZprE6LBFrCyNrR87yMTQ0mZowKa7ZQWUaQGHnF5TLK
	 fEsXI26cKPemRpcd0cCuCQ3rXNI/1DUSJahoD9vY=
Message-ID: <1db93bd3-cb47-445b-b8ca-6de6f04b41cc@arm.com>
Date: Tue, 7 Apr 2026 10:57:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>, Jinjiang Tu <tujinjiang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ac7VD4Z85nS30GCp@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233535-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DAFA3AC64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 02/04/2026 21:43, Catalin Marinas wrote:
> On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
>>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>   {
>>   	int ret;
>>   
>> -	/*
>> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
>> -	 * anything that is not pte-mapped in the first place. Just return early
>> -	 * and let the permission change code raise a warning if not already
>> -	 * pte-mapped.
>> -	 */
>> -	if (!system_supports_bbml2_noabort())
>> -		return 0;
>> -
>>   	/*
>>   	 * If the region is within a pte-mapped area, there is no need to try to
>>   	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
>>   	 * change permissions from atomic context so for those cases (which are
>>   	 * always pte-mapped), we must not go any further because taking the
>> -	 * mutex below may sleep.
>> +	 * mutex below may sleep. Do not call force_pte_mapping() here because
>> +	 * it could return a confusing result if called from a secondary cpu
>> +	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
>> +	 * what we need.
>>   	 */
>> -	if (force_pte_mapping() || is_kfence_address((void *)start))
>> +	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
>>   		return 0;
>>   
>> +	if (!system_supports_bbml2_noabort()) {
>> +		/*
>> +		 * !BBML2_NOABORT systems should not be trying to change
>> +		 * permissions on anything that is not pte-mapped in the first
>> +		 * place. Just return early and let the permission change code
>> +		 * raise a warning if not already pte-mapped.
>> +		 */
>> +		if (system_capabilities_finalized())
>> +			return 0;
>> +
>> +		/*
>> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
>> +		 * page allocator. Can't split until it's available.
>> +		 */
>> +		if (WARN_ON(!page_alloc_available))
>> +			return -EBUSY;
>> +
>> +		/*
>> +		 * Boot-time: Started secondary cpus but don't know if they
>> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
>> +		 * window in case they don't.
>> +		 */
>> +		if (WARN_ON(num_online_cpus() > 1))
>> +			return -EBUSY;
>> +	}
> 
> I think sashiko is over cautions here
> (https://sashiko.dev/#/patchset/20260330161705.3349825-1-ryan.roberts@arm.com)
> but it has a somewhat valid point from the perspective of
> num_online_cpus() semantics. We have have num_online_cpus() == 1 while
> having a secondary CPU just booted and with its MMU enabled. I don't
> think we can have any asynchronous tasks running at that point to
> trigger a spit though. Even async_init() is called after smp_init().
> 
> An option may be to attempt cpus_read_trylock() as this lock is taken by
> _cpu_up(). If it fails, return -EBUSY, otherwise check num_online_cpus()
> and unlock (and return -EBUSY if secondaries already started).
> 
> Another thing I couldn't get my head around - IIUC is_realm_world()
> won't return true for map_mem() yet (if in a realm). 
That is correct. map_mem() comes from paginig_init(), which gets called
before arm64_rsi_init(). Realm check was delayed until psci_xx_init().
We had a version which parsed the DT for PSCI conduit early enough
to be able to make the SMC calls to detect the Realm. But there
were concerns around it.


> Can we have realms on hardware that does not support BBML2_NOABORT? 

I can get this checked. I expect that they all will have BBML2 (v8.4
extension). But NOABORT is something that may need to be checked.

We may not have


> configuration with rodata_full set (it should be complementary to realm
> support).



> 
> I'll add the patches to for-next/core to give them a bit of time in
> -next but let's see next week if we ignore this (with an updated
> comment) or we try to avoid the issue altogether.
> 

Thanks

Suzuki


