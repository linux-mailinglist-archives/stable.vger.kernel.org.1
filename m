Return-Path: <stable+bounces-241257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OHRL58X72kQ6AAAu9opvQ
	(envelope-from <stable+bounces-241257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:00:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832A46EB11
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8692A3004623
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CD399039;
	Mon, 27 Apr 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNZsVs5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881339902B;
	Mon, 27 Apr 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276821; cv=none; b=cj6N6ZrvuaI9tSYEwMgeqxbOp4UlzUq/VKh65mJIH4Pysf6KAfIQiCj7qpC82ooFVq0QO/qGKbRGYRkWHIIlD3hAZSLwhMd5Y/vnI5z+q3yeyiHhKmKPDTDHjCgHZWTreLmZpzzkODP+ab/myPxOLEFpZ+s8Es1p3UGNoZ9+VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276821; c=relaxed/simple;
	bh=6lSQYBY2+IuLHDfyeYcIQP7M9ufPZ8ri79+137pQ1+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpVpc06IyC4B0XuxhBQ4d93i/wgF6c5PZJn47Gvmme6N+Rb5WQv7VasDNnXswcxApoOpsPw4HWR/YX2Raaul/VVRgvNbIz3pXdavq9l491mDPACc/fon95s8p2jE8vaJusiG3gwp2pQK+rNfRyRAILWw9/yu9SAs+dUhVb+KewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNZsVs5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDABC19425;
	Mon, 27 Apr 2026 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777276821;
	bh=6lSQYBY2+IuLHDfyeYcIQP7M9ufPZ8ri79+137pQ1+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vNZsVs5dlJ6IIUwPClc7UZHRymQhjIiYtz4kz7lvFmHQK3+4MOCMw8gtFBpQFAy+c
	 HLiRM0b1nxo6h1KtTqewlfvqG92VW6laNBiW4JdS7lf0apSF9XsJ+6jgf4HGTHsnLB
	 FV2HKV1iVmhhpvKUPno4SpNZXdAektVWSB3+CntNHeor54MMpLDARIaAHT/ZtYf+6P
	 /fv4A+8woGTR4scKjC6Gqh+idMLufSrwNEy8xxZRTkBQA2GzO9RVyUt6ZTsYFIv/fe
	 2rEtyeSGu74o8HZDeVjqdvh3Dyd8AGTmbxAj2QnFT4hlQkZuF7/w4AbYrSR0mryuTH
	 w1r1neGMuyw7A==
Message-ID: <c3f7b8e4-85ae-4e80-bb02-a7b205cec88e@kernel.org>
Date: Mon, 27 Apr 2026 10:00:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes v2 0/2] mm/page_alloc,slab: return NULL early
 from *_nolock() memory allocation APIs in NMI on UP
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8832A46EB11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241257-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/27/26 09:09, Harry Yoo (Oracle) wrote:
> Due to my mistake, V1 was sent twice w/o proper cover letter and
> Cc: stable. Please ignore V1. Apologies for the noise. 
> 
> Changes since V1:
> - used b4 to send patch series (w/ a proper cover letter) instead of
>   my broken git send-email script (Thanks Vlastimil)
> - added Cc: stable to patches 1 and 2
> 
> On UP kernels (!CONFIG_SMP), spin_trylock() is a no-op that
> unconditionally succeeds even when the lock is already held.
> As a result, alloc_frozen_pages_nolock() and kmalloc_nolock() called
> from an NMI context can successfully re-acquire the lock that the
> page/slab allocators are already holding (no deadlock because it's
> trylock,  but leads to e.g., allocating the same page/object twice and
> causing use-after-free).
> 
> It was discovered while testing the new kmalloc/kfree_nolock() test case
> in the slub_kunit test module with CONFIG_DEBUG_SPINLOCK=y on a UP
> kernel.
> 
> Patch 1 fixes alloc_frozen_pages_nolock() and
> patch 2 fixes kmalloc_nolock().

Thanks. Given the problem exposed is in a slab kunit test I think it's
better to handle this in the slab tree. The page_alloc change is small and
should not cause conflicts. So I've merged both in slab/for-next.

> Note: As pointed out by Vlastimil Babka [1], in theory a kprobe in a
> locked section could trigger the same issue. However, fixing that
> involves a non-trivial rework (e.g., inventing a new spinlock type) or
> introduces unnecessary overhead for all spinlocks on UP (e.g., let all
> spinlocks check locked status on UP).
> 
> Given that BPF tracing on UP is rare, and it's even more unlikely to
> trace a function called from the memory allocator within the locked
> section, this patch series addresses the issue only on NMI contexts
> (which is rare as well but now covered by the new test case).
> 
> [1] https://lore.kernel.org/linux-mm/af3a7fa9-b368-4ffd-964d-9e4fcba863a8@kernel.org
> 
> Cc: stable.vger.kernel.org
> ---
> Harry Yoo (Oracle) (2):
>       mm/page_alloc: return NULL early from alloc_frozen_pages_nolock() in NMI on UP
>       mm/slab: return NULL early from kmalloc_nolock() in NMI on UP
> 
>  mm/page_alloc.c | 5 +++++
>  mm/slub.c       | 4 ++++
>  2 files changed, 9 insertions(+)
> ---
> base-commit: ba24da38a519dfcff8cce3f3f2726d7b159a4d75
> change-id: 20260427-nolock-api-fix-bd056911e68e
> 
> Best regards,
> --  
> Cheers,
> Harry / Hyeonggon
> 


