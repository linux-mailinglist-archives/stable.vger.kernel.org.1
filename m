Return-Path: <stable+bounces-230370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jd6O2QdxGnlwQQAu9opvQ
	(envelope-from <stable+bounces-230370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:37:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F6329F5D
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3BD9305E9FA
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B33FE348;
	Wed, 25 Mar 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kVT1fFB9"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA333E0C64;
	Wed, 25 Mar 2026 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459775; cv=none; b=gQeONgG5R2G+OsoN8OrI0m30o5srlqEOVmCsucrN0qPdwAA+kPdjpm6f0MTU85nwEK+CnfwFaD+nH0az7YxYL6HweX0yzBYdEe/E4Aw0Iv7SLcle9zp2Z40KkdgYRFjqQaWo1StrXgAV5hTqG49ROpQYtoIQ7zme+1vY0x4S62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459775; c=relaxed/simple;
	bh=q6eWBosAeDItDiHUT1TERXLrvVldKxWmQvT5h1zzdjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTEmjXTsKxgXqZF6/Te3cmKHFHUeckOkyyS06nX8kJ1y3mNJIjWYMrcrHkK/g0ahXclTzxcHGocwzuoPsFmBN41j9rMmKw4SpZJJnvaK/DH2uzkwkhZDAMPOZRLWpwcAi6LNU4ET+7zu8Ivpynb3mNXjrA8q7FbCvMug5qpTro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kVT1fFB9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90CCA2444;
	Wed, 25 Mar 2026 10:29:27 -0700 (PDT)
Received: from [10.1.26.165] (XHFQ2J9959.cambridge.arm.com [10.1.26.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB1D3F836;
	Wed, 25 Mar 2026 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774459773; bh=q6eWBosAeDItDiHUT1TERXLrvVldKxWmQvT5h1zzdjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kVT1fFB9AZMrcCSWy1U6kIZWPU+dsS9jxoN4CIZPyEpXOCoAF6sIhEyvYHFo3WGNR
	 qd5xg84fI3shijg41iB5Vac8p4fbm62OtMv9hWbyQPG6nP00wlg/fXIydzNWD9FORC
	 3gFA8+2rWeg5DfVXUnuS1+EjsnS9DXDKN9wDBS0o=
Message-ID: <47d033cc-33dd-4fb2-9e8a-bc5762db6b6a@arm.com>
Date: Wed, 25 Mar 2026 17:29:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-2-ryan.roberts@arm.com>
 <a3766dfc-06ed-4cdc-9c55-0dcc3638746e@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a3766dfc-06ed-4cdc-9c55-0dcc3638746e@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230370-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 766F6329F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 21:34, Yang Shi wrote:
> 
> 
> On 3/23/26 6:03 AM, Ryan Roberts wrote:
>> Commit a166563e7ec37 ("arm64: mm: support large block mapping when
>> rodata=full") enabled the linear map to be mapped by block/cont while
>> still allowing granular permission changes on BBML2_NOABORT systems by
>> lazily splitting the live mappings. This mechanism was intended to be
>> usable by realm guests since they need to dynamically share dma buffers
>> with the host by "decrypting" them - which for Arm CCA, means marking
>> them as shared in the page tables.
>>
>> However, it turns out that the mechanism was failing for realm guests
>> because realms need to share their dma buffers (via
>> __set_memory_enc_dec()) much earlier during boot than
>> split_kernel_leaf_mapping() was able to handle. The report linked below
>> showed that GIC's ITS was one such user. But during the investigation I
>> found other callsites that could not meet the
>> split_kernel_leaf_mapping() constraints.
>>
>> The problem is that we block map the linear map based on the boot CPU
>> supporting BBML2_NOABORT, then check that all the other CPUs support it
>> too when finalizing the caps. If they don't, then we stop_machine() and
>> split to ptes. For safety, split_kernel_leaf_mapping() previously
>> wouldn't permit splitting until after the caps were finalized. That
>> ensured that if any secondary cpus were running that didn't support
>> BBML2_NOABORT, we wouldn't risk breaking them.
>>
>> I've fix this problem by reducing the black-out window where we refuse
>> to split; there are now 2 windows. The first is from T0 until the page
>> allocator is inititialized. Splitting allocates memory for the page
>> allocator so it must be in use. The second covers the period between
>> starting to online the secondary cpus until the system caps are
>> finalized (this is a very small window).
>>
>> All of the problematic callers are calling __set_memory_enc_dec() before
>> the secondary cpus come online, so this solves the problem. However, one
>> of these callers, swiotlb_update_mem_attributes(), was trying to split
>> before the page allocator was initialized. So I have moved this call
>> from arch_mm_preinit() to mem_init(), which solves the ordering issue.
>>
>> I've added warnings and return an error if any attempt is made to split
>> in the black-out windows.
>>
>> Note there are other issues which prevent booting all the way to user
>> space, which will be fixed in subsequent patches.
> 
> Hi Ryan,
> 
> Thanks for putting everything to together to have the patches so quickly. It
> basically looks good to me. However, I'm thinking about whether we should have
> split_kernel_leaf_mapping() call for different memory allocators in different
> stages. If buddy has been initialized, it can call page allocator, otherwise,
> for example, in early boot stage, it can call memblock allocator. So
> split_kernel_leaf_mapping() should be able to be called anytime and we don't
> have to rely on the boot order of subsystems.

I considered that, but ultimately we would just be adding dead code. I've added
a warning that will catch this usage. So I'd prefer to leave it as is for now
and only add this functionality if we identify a need.

Thanks,
Ryan


> 
> Thanks,
> Yang
> 

