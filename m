Return-Path: <stable+bounces-241910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH/JKP8m8mm/oQEAu9opvQ
	(envelope-from <stable+bounces-241910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1084497264
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0CB0306C97A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A8381B0E;
	Wed, 29 Apr 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N2xbpZiW"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BC3815E4
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476629; cv=none; b=tt5qL88YLwCBbhi2ktZHJtMqwgiRKNsV5s3yw46tSH4yIEGJ1FoXjCDq96i9uXnjiMHYO5/eWDAbH7rcROI5uY2Be2WGEBFNMghwUnPUgwUgufuKzSB78iAz6qCPt/gFk7qrl1J4NkTelskFCI+UQzgBJ0gzXqcAA1kTHV6n+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476629; c=relaxed/simple;
	bh=wr2Cjzi48zX0nGmklAOr0JeVqZqqLYl0lRJmnThQBwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bra2lu+ljWa0kh9rrbW0TumUH4xEVcLJNbvC8URJOEa0V2zufDk1rCp1rSdXhnFI2V/TWSl4M5dHdNRHaY3CeFtn+VS3AwKkNmHeKvWyhOTshMvgx5DSdDfLqOhEKN+j7N7uZEmUHLSCqfMbXfu2sKNNz13EPw6PhzPtfs4+aRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N2xbpZiW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2aa36364-6c60-4927-9344-6c4e0a072aac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777476625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRKjPGTHB7gLsglvS58rZ1PmYiUs4SxFlaTZpxLq+pI=;
	b=N2xbpZiWavmWTwLOQZ9SLU3kOEvqkgRkMHKC2SfGAAdy2KqvPcXuf7tfqARmWRGt7BgSDf
	h03I8++9UxXR5pvDvj1K1I7HyZd7fLtpLApqxFr7VluomyCioKyr7kzB71uz/uydKe/v51
	+0jD4ZvgPMiL0Gq0oVrNCjzSzsGQetE=
Date: Wed, 29 Apr 2026 23:29:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] x86/mm: fix freeing of PMD-sized vmemmap pages
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20260429-vmemmap-v2-1-8dfcacffd877@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260429-vmemmap-v2-1-8dfcacffd877@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D1084497264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241910-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]



On 2026/4/29 18:49, David Hildenbrand (Arm) wrote:
> In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
> from freeing non-boot page tables through __free_pages() to
> pagetable_free().
> 
> However, the function is also called to free vmemmap pages.
> 
> Given that vmemmap pages are not page tables, already the page_ptdesc(page)
> is wrong. But worse, pagetable_free() calls
> 
> 	__free_pages(page, compound_order(page));
> 
> As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
> except for HVO, which doesn't apply here -- we will only free the first
> page when freeing a PMD-sized vmemmap page, leaking the other ones.
> 
> Fix it by properly decoupling pagetable and vmemmap freeing.
> free_pagetable() no longer has to mess with SECTION_INFO, as only the
> vmemmap is marked like that in register_page_bootmem_memmap().
> 
> The indentation in remove_pmd_table() is messed up, let's fix that
> while touching it.
> 
> Note that we'll try to get rid of that bootmem info handling soon. For
> now, we'll handle it similar to free_pagetable(), just avoiding the
> ifdef.
> 
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> Reproduced and tested with a simple VM with a virtio-mem device,
> repeatedly adding and removing memory.
> 
> Found by code inspection while working on bootmem_info removal.
> ---

Retested. Works as expected :)

Cheers, Lance

