Return-Path: <stable+bounces-233519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHVcI4rB1GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:34:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 357BC3AB66B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B28F30058CF
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33939B482;
	Tue,  7 Apr 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BeOvKBOw"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618AC39A063;
	Tue,  7 Apr 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550846; cv=none; b=q9LTNegy/snueT4Sl1AYWv59TAsVK8aWxlsG0wkPMByUgVyIfoy+78aRJRDDeQf43dg+w4UEn0cgce6o7cb6R8fMTqv6cS8m1g3aHU7Wn8HtvgBmT6m6vgoyDOgE2/0IF/vq1OJDDDTTr699YRStgUIOdM2kixDgNTl0SEaWi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550846; c=relaxed/simple;
	bh=Heg4YQbV1vvgUn0TgfKMiao62MWpbj3co/ZqYPpLlFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bmh0qUA50kuqdXTGE5u8LDysSaPVloYy8L83I5O2J9t2cpQ9KkxtDNqRvD0rwRqoVazTmN6aQD1v98Jqxfrx6hvnwGrN+U1ym47zyFeiBOkRQWtlPWWiJonG+BCzqObkgxupkmUv/Y2DovKAOc2x37SnAjWapAl/GuopS7drF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BeOvKBOw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C45E1BB0;
	Tue,  7 Apr 2026 01:33:48 -0700 (PDT)
Received: from [10.57.87.42] (unknown [10.57.87.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27AA33F641;
	Tue,  7 Apr 2026 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775550833; bh=Heg4YQbV1vvgUn0TgfKMiao62MWpbj3co/ZqYPpLlFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BeOvKBOwcfSrrgOOwLTx2bedDd9LnW/QQ2dazXB+DPDeacQE/pprpv5KjsFESUOp7
	 QAEEweOhufhnbL9FV8Fq+lLlX6dX9T/DlPrmxQ6hnW14JoYODNIAQmtXeIsWW89I5K
	 R1kdOEEy+hZf4eWOH8LvTYDjyXg4riRLxA3N6RwA=
Message-ID: <160ec79a-f842-421a-bfde-5b4da32b3b4e@arm.com>
Date: Tue, 7 Apr 2026 09:33:50 +0100
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ac7VD4Z85nS30GCp@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233519-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 357BC3AB66B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 02/04/2026 21:43, Catalin Marinas wrote:
> On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
>>  int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>  {
>>  	int ret;
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
>>  	/*
>>  	 * If the region is within a pte-mapped area, there is no need to try to
>>  	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
>>  	 * change permissions from atomic context so for those cases (which are
>>  	 * always pte-mapped), we must not go any further because taking the
>> -	 * mutex below may sleep.
>> +	 * mutex below may sleep. Do not call force_pte_mapping() here because
>> +	 * it could return a confusing result if called from a secondary cpu
>> +	 * prior to finalizing caps. Instead, linear_map_requires_bbml2 gives us
>> +	 * what we need.
>>  	 */
>> -	if (force_pte_mapping() || is_kfence_address((void *)start))
>> +	if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))
>>  		return 0;
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

Yes I saw the Sashiko report, but we had previously had a (private) discussion
where I thought we had already concluded that this approach is safe in practice
due to the way that the boot cpu brings the secondaries online.

> 
> An option may be to attempt cpus_read_trylock() as this lock is taken by
> _cpu_up(). If it fails, return -EBUSY, otherwise check num_online_cpus()
> and unlock (and return -EBUSY if secondaries already started).

That sounds neat; I could dig deeper and have a go at something like this if you
want?

> 
> Another thing I couldn't get my head around - IIUC is_realm_world()
> won't return true for map_mem() yet (if in a realm). Can we have realms
> on hardware that does not support BBML2_NOABORT? We may not have
> configuration with rodata_full set (it should be complementary to realm
> support).

My understanding is that this is a pre-existing (and known) bug. It's not
related to the "map linear map by large leaves and split dynamically" feature so
wasn't attempting to fix it.

I had heard that in practice all FEAT_RME systems should support FEAT_BBML3
which would solve the problem. Not sure how true that is though.

> 
> I'll add the patches to for-next/core to give them a bit of time in
> -next but let's see next week if we ignore this (with an updated
> comment) or we try to avoid the issue altogether.
> 

Thanks,
Ryan



