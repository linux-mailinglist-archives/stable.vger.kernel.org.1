Return-Path: <stable+bounces-244741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB8TBAvE/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:07:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FABA4F57E6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152A630421DF
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BC3101B6;
	Fri,  8 May 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lQ4iQgkp"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF85351C2A;
	Fri,  8 May 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238112; cv=none; b=OmmdTIRYbFuqTn6YlJYaozC3muaBaGFBT0VhFx1ShvHQjaJEUNhw9XSax58jEAg09O7xOxLxawMtzAhPFTv3nx4QZcjLw7pbHBx7FVqYuai9W1WkmA1wc0X9NKehSknX7UthSbflObT4OrRZUY8vq4PffbFiK3Zi964a5cszpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238112; c=relaxed/simple;
	bh=mqK+2YeESJaV7QV6CYDbc34GQT+5UVZCH1ggHivoFU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRsq09/ABHAPEz3YcqalIRmYPTKS4hpQb/DQdXrGXhK7y4ORuZMt5oGjitkyIiciyA80C1ppnoR7FFLOQHShyWqQubli2kiuqUCyfdV/FvCL7BB+Q1F5/aJ+AGH42ZYFZWwa2sRpDzc2bEXHJqNTRlpAdX253GoF/2mG7fvJoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lQ4iQgkp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3437E1BCA;
	Fri,  8 May 2026 04:01:44 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0FA3F763;
	Fri,  8 May 2026 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778238109; bh=mqK+2YeESJaV7QV6CYDbc34GQT+5UVZCH1ggHivoFU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQ4iQgkpS5ezS7c4f00lDSFmSEvhs+mspN0EmqGsx5if4FCwdrzbHpdT7mnfOkyk8
	 dJTni/hnNWwcrLgw/p2GP7ZB2BYC71vQBRK+9D7NLF7VD9a8LhTQC0qKrTUgtm4ffy
	 vInVgGd10H0aWhQD0xqoa1/PQtE3/RcWIol2KOT4=
Message-ID: <ad90b0cd-a5d2-4953-af7d-753aed60354f@arm.com>
Date: Fri, 8 May 2026 12:01:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FABA4F57E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244741-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026-05-08 11:01 am, Jianpeng Chang wrote:
> 
> 
> 在 2026/5/7 下午9:18, Robin Murphy 写道:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender 
>> and know the content is safe.
>>
>> On 07/05/2026 4:21 am, Jianpeng Chang wrote:
>>> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
>>> However, pfn_valid() only checks for availability of the memory map 
>>> for a
>>> PFN but it does not ensure that the PFN is actually backed by RAM. On
>>> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
>>> share a section with RAM will falsely trigger the WARN_ON_ONCE.
>>>
>>> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
>>> the SPI FIFO register (0xfe204004) falls in the same sparsemem 
>>> section as
>>> the end of RAM (0xf8000000-0xfbffffff), both in section 31
>>> (0xf8000000-0xffffffff).
>>>
>>> The pfn_valid() check was originally removed by commit a9c38c5d267c
>>> ("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
>>> but was accidentally re-introduced by commit f7326196a781
>>> ("dma-mapping: export new dma_*map_phys() interface") during the
>>> refactoring of dma_map_resource() into a wrapper around dma_map_phys().
>>>
>>> Drop the pfn_valid() test from dma_map_resource() again.
>>
>> As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
>> would be enough for what we want here, although now it's strictly under
>> CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
>> might be less of an issue. Either way though, now that it's all
>> channelled through the single dma_map_phys() path, it would probably
>> make sense to consolidate any MMIO sanity-checking into
>> dma_debug_map_phys() anyway :/
> Thanks for the suggestion. Move the check into debug_dma_map_phys() is 
> indeed better, and I will replace pfn_valid() with pfn_valid() && ! 
> PageReserved() as you suggested.

Oh, and just to clarify on the points DavidH raised last time, indeed 
PageReserved isn't 100% accurate for this, and there may well be 
reserved pages which shouldn't be DMA-mapped either, but that's a 
reasonable false-negative (especially compared to having no check at 
all!) - the main thing is any *non*-reserved page represents "kernel 
memory" to enough of a degree that using DMA_ATTR_MMIO is almost 
certainly wrong and liable to break coherency.

Cheers,
Robin.

