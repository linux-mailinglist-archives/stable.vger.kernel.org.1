Return-Path: <stable+bounces-233595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFIsD7EB1WnOzQcAu9opvQ
	(envelope-from <stable+bounces-233595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:08:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A03AEDB5
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA3E3076A37
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822993B6C10;
	Tue,  7 Apr 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JdFSpFrj"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713633A4F32;
	Tue,  7 Apr 2026 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567176; cv=none; b=ld/SLjp/VBn6E0i7eBpLNAKv1TdDgwSVUy4Nlagcrfkdxzg3RsEtOAsvPoKnix25fZGiXewJB3aWlqUAmXQRCQats41yKsClMYjV9kk98RIVnYQOPgY6TB8+zPSjq6qtF+SKXXrQGh6bqvPjR74A0UuLGOYi8naYAhGkxRH4jEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567176; c=relaxed/simple;
	bh=zuBn8OJOWsJS9EPWfpklo6YjfsJiO778RvGxeIrnKB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu2PZ+NXx6ghix+vQ+1dgOF2jWbZtUIVeRyto5rmUCF2/USdawMLeVFZCLbf9nbcLGbEfa0VoczXJCNb7w4Xu/xoYStWnmActnbG8JNNbsc68X1JJOF1inocdl1dKLllp31MbGyyUDJBnALfIlBvQ16DjhhaTae7/TcoOZmu9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JdFSpFrj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C92F616F2;
	Tue,  7 Apr 2026 06:06:07 -0700 (PDT)
Received: from [10.57.87.42] (unknown [10.57.87.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA97F3F7D8;
	Tue,  7 Apr 2026 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775567173; bh=zuBn8OJOWsJS9EPWfpklo6YjfsJiO778RvGxeIrnKB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JdFSpFrjdJTWWgkfZtbcCKe7QkoOe2/p8yY8YtJI4/kKTmIonolQrs9Wlg0TfI4XU
	 gqqi2Rc1o3/dUBBf+9GJXwU6k14+I+USFuCJAxcekAKU3dj9Bptgzgqac4FlSW45uJ
	 tERFJhhCbN0JVWxaj8HzUYWmWNswPo95NAUzOdvQ=
Message-ID: <b545e650-f84f-4911-9902-b914870f0e1d@arm.com>
Date: Tue, 7 Apr 2026 14:06:10 +0100
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
 <ac-W9oNM_O5RTtaf@arm.com> <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com> <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
 <adTh8d9k3y5ybemL@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <adTh8d9k3y5ybemL@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,arm.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233595-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 951A03AEDB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 11:52, Catalin Marinas wrote:
> On Tue, Apr 07, 2026 at 11:13:07AM +0100, Ryan Roberts wrote:
>> On 07/04/2026 10:32, Catalin Marinas wrote:
>>> On Tue, Apr 07, 2026 at 09:43:42AM +0100, Ryan Roberts wrote:
>>>> On 03/04/2026 11:31, Catalin Marinas wrote:
>>>>> On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
>>>>>> Another thing I couldn't get my head around - IIUC is_realm_world()
>>>>>> won't return true for map_mem() yet (if in a realm). Can we have realms
>>>>>> on hardware that does not support BBML2_NOABORT? We may not have
>>>>>> configuration with rodata_full set (it should be complementary to realm
>>>>>> support).
>>>>>
>>>>> With rodata_full==false, can_set_direct_map() returns false initially
>>>>> but after arm64_rsi_init() it starts returning true if is_realm_world().
>>>>> The side-effect is that map_mem() goes for block mappings and
>>>>> linear_map_requires_bbml2 set to false. Later on,
>>>>> linear_map_maybe_split_to_ptes() will skip the splitting.
>>>>>
>>>>> Unless I'm missing something, is_realm_world() calls in
>>>>> force_pte_mapping() and can_set_direct_map() are useless. I'd remove
>>>>> them and either require BBML2_NOABORT with CCA or get the user to force
>>>>> rodata_full when running in realms. Or move arm64_rsi_init() even
>>>>> earlier?
>>>>
>>>> I'd need Suzuki to comment on this. As I said in the other mail, I was treating
>>>> this like a pre-existing bug. But I guess linear_map_requires_bbml2 ending up
>>>> wrong is a problem here. I'm not sure it's quite as simple as requiring
>>>> BBML2_NOABORT with CCA as we still need can_set_direct_map() to return true if
>>>> we are in a realm.
>>>
>>> can_set_direct_map() == true is not a property of the realm but rather a
>>> requirement. 
>>
>> Yes indeed. It would be better to call it might_set_direct_map() or something
>> like that...
> 
> The way it is used means "is allowed to set the direct map". I guess
> "may set..." works as well. My reading of "might" is more like in
> might_sleep(), more of hint than a permission check.

OK, I read it as "might" as in a hint that we might want to change the direct
map permissions.

> 
> If you only look at the linear_map_requires_bbml2 setting in map_mem(),
> yes, something like might_set_direct_map() makes sense but that's not
> how this function is used in the rest of the kernel (to reject the
> direct map change if not supported).

ACK.

> 
>>> In the absence of BBML2_NOABORT, I guess the test was added
>>> under the assumption that force_pte_mapping() also returns true if
>>> is_realm_world(). We might as well add a variable or static label to
>>> track whether can_set_direct_map() is possible and avoid tests that
>>> duplicate force_pte_mapping().
>>
>> I'm not sure I follow. We have linear_map_requires_bbml2 which is inteded to
>> track this shape of thing;
> 
> As the name implies, linear_map_requires_bbml2 tracks only this -
> BBML2_NOABORT is required because the linear map uses large blocks.
> Prior to your patches, that's only used as far as
> linear_map_maybe_split_to_ptes() and if splitting took place, this
> variable is no longer relevant (should be turned to false but since it's
> not used, it doesn't matter).
> 
> With your patches, its use was extended to runtime and I think it
> remains true even if linear_map_maybe_split_to_ptes() changed the block
> mappings. Do we need this:

I'll admit it is ugly but it's not a bug; the system capabilitites are finalized
by the time we call linear_map_maybe_split_to_ptes().

The "if (!linear_map_requires_bbml2 || is_kfence_address((void *)start))" check
in split_kernel_leaf_mapping() would ideally be "if (!force_pte_mapping() ||
is_kfence_address((void *)start))", but it is not safe to call
force_pte_mapping() from a secondary cpu prior to finalizing the system caps.
I'm reusing the flag that I already had available to work around that.

> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dcee56bb622a..595d35fdd8c3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -988,6 +988,7 @@ void __init linear_map_maybe_split_to_ptes(void)
>  	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
>  		init_idmap_kpti_bbml2_flag();
>  		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> +		linear_map_requires_bbml2 = false;
>  	}
>  }
>  
> 
>> if we have forced pte mapping then the value of
>> can_set_direct_map() is irrelevant - we will never need to split because we are
>> already pte-mapped.
> 
> can_set_direct_map() is used in other places, so its value is relevant,
> e.g. sys_memfd_secret() is rejected if this function returns false.
> 
>> But if can_set_direct_map() initially returns false because
>> is_realm_world() incorrectly returns false in the early boot environment, then
>> linear_map_requires_bbml2 will be set to false, and we will incorrectly
>> short-circuit splitting any block mappings in split_kernel_leaf_mapping().
>>
>> I think we are agreed on the problem. But I don't understand how tracking
>> can_set_direct_map() in a cached variable helps with that.
> 
> It's not about the map_mem() decision and linear_map_requires_bbml2
> setting but rather its other uses like sys_memfd_secret().
> 
>>> This won't solve the is_realm_world() changing polarity during boot but
>>> at least we know it won't suddenly make can_set_direct_map() return
>>> true when it shouldn't.
>>
>> But is_real_world() _should_ make can_set_direct_map() return true, shouldn't
>> it?
> 
> Yes but not directly. If is_realm_world() is true, we either have
> (linear_map_requires_bbml2 && system_supports_bbml2_noabort()) or
> linear_map_requires_bbml2 is false and we have pte mappings. Adding
> is_realm_world() to can_set_direct_map() does not imply any of these.
> It's just a hope that something before actually ensured the conditions
> are true.
> 
> It might be better if we rename the current function to
> might_set_direct_map() and introduce a new can_set_direct_map() that
> actually tells the truth if all the conditions are met. I suggested a
> variable or static label but checking some conditions related to the
> actual linear map work as well, just not is_realm_world() directly.

I'm not sure I see the distinction between "might" and "can" with your
definition. But regardless, I think we are talking about the pre-existing
is_real_world() bug, so I'm not personally planning to do anything further here
unless you shout.

Thanks,
Ryan



