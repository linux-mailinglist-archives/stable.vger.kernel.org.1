Return-Path: <stable+bounces-244791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bf3LCwL/mm2mQAAu9opvQ
	(envelope-from <stable+bounces-244791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:11:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E54F93E9
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1245330531FF
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE43D524E;
	Fri,  8 May 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ew52XfXR"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B710376BD9;
	Fri,  8 May 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256277; cv=none; b=Jy5imbL/5HEYuUq4d1aF5cyzjwXrKnrnLLoYfQihhn/1rL14B0utCOXhG08lmH2sQJSLqpLy2OxsOeHMncIupkt9bamkanUwNuQ4QI73nc0yZl5CE1X0Q1wo6mjbrVd9oZBkQaSKrchSLSBCDV51QWosXNf+qS/iGul5Zy3iubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256277; c=relaxed/simple;
	bh=kmD/l6NJJEgqq90/B8qBpAxyVg8m8aN6Dr1wB60XbVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMU1r3DXxXFfUXNR9JJq0sS35FA/7uZSljqvFRRY9H1ojMSN+Y225YKRWFRUA4eK7kIM+eekRZEAlubGvvzetLzIBKAeKu1jyWPykz+qXsy8nzbBK6Rz191Ar2UJbYfNVoCZ3T/HO+T5pejX7M9WHzLGq0vMICPSsip3nCER6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ew52XfXR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 862641E5E;
	Fri,  8 May 2026 09:04:29 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6867E3F763;
	Fri,  8 May 2026 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778256274; bh=kmD/l6NJJEgqq90/B8qBpAxyVg8m8aN6Dr1wB60XbVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ew52XfXRv1zqge0MsDtQJn/S+diiX2J5oNTuPQxBNK81e47icmoL89a67yhXrmXnb
	 dMW7EX4NXvBVHWnDd3Vv/+Tl9LWeJ7Rlq0/+ioVClwTcEgYxzWQRiKOTB4zhmhsejE
	 AbFUjSvAzysaEmi8NWCHRSY7pJs9B3iuuoTwsttk=
Message-ID: <4134fcd9-7d12-4e76-955d-5a679916a0c0@arm.com>
Date: Fri, 8 May 2026 17:04:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
 m.szyprowski@samsung.com, leon@kernel.org, kbusch@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
 <20260508113100.GA9285@ziepe.ca>
 <662fdf07-6475-4807-94b0-54b3b439ae1c@arm.com>
 <20260508151857.GB9285@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260508151857.GB9285@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 329E54F93E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244791-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026-05-08 4:18 pm, Jason Gunthorpe wrote:
> On Fri, May 08, 2026 at 01:16:25PM +0100, Robin Murphy wrote:
>> On 2026-05-08 12:31 pm, Jason Gunthorpe wrote:
>>> On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
>>>>> As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
>>>>> would be enough for what we want here, although now it's strictly under
>>>>> CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
>>>>> might be less of an issue. Either way though, now that it's all
>>>>> channelled through the single dma_map_phys() path, it would probably
>>>>> make sense to consolidate any MMIO sanity-checking into
>>>>> dma_debug_map_phys() anyway :/
>>>
>>>> Thanks for the suggestion. Move the check into debug_dma_map_phys() is
>>>> indeed better, and I will replace pfn_valid() with pfn_valid() &&
>>>> !PageReserved() as you suggested.
>>>
>>> I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
>>> P2P pages that are used with map_phys but never with map_resource.
>>>
>>> PageReserved isn't enough to fix it.
>>
>> It fixes the false-positive on non-reserved pages, which is the important
>> thing. Yes, we'll get false-negatives on reserved ZONE_DEVICE pages and
>> similar, but that's still an improvement over getting false-negatives on
>> _everything_ by not checking at all. Realistically, dma-debug can never be
>> exhaustive and 100% accurate, but there's still value in catching as much
>> obvious misuse as is straightforward to do.
> 
> I'm saying I think the new expression still has a false positive for
> the common case of map_phys with ZONE_DEVICE P2P, and I don't want to
> see debugging logging for normal as-designed scenarios in map_phys.
> 
> So we either need to narrow the expression further somehow, or leave
> it in map_resource which has fewer users and doesn't accept
> ZONE_DEVICE anyhow.

But surely anything with a ZONE_DEVICE page is "memory" to the degree 
that mapping it with DMA_ATTR_MMIO would be wrong, no? However, IIRC 
ZONE_DEVICE pages _are_ reserved, so still wouldn't warn whether we'd 
like it or not. I'm confused as to what you're objecting to...

Robin.

