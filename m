Return-Path: <stable+bounces-211964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN8qHYoJemkK2AEAu9opvQ
	(envelope-from <stable+bounces-211964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:05:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B48A1C85
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 089D1300BE99
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859B352928;
	Wed, 28 Jan 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iDXq3tL0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D635295D;
	Wed, 28 Jan 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605482; cv=none; b=ONZja2j/+KS+JtAxuXSXhG7ove+FdlzKO39TwfAhWevBU7mbF3yfh+AFF6lT7v5NlG/dljQBBQwy/atV7ZWK5XXCccuZCBUNFWsZ0HFOTarFkOG97EEpXWey/BVlhOKZRiE8H2aSe3BJ16ShThxhC6Nb4SNtbk15D+rrPgYvszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605482; c=relaxed/simple;
	bh=HlDdxHkDqOy28uiOmLYdyBsIPJjEdE024klLAJIryzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEg5su982Gx6PNGm5VzJC8VxI9LzoqimrQDKlcoNa3AQRS+aQXt89NMYfGCtqlOcdOY+W6/vIguPSnU4l9JrlwqpNWXe5Zk/l9/JN9wr1Ultw3f5MTINJNkI1D77jFCQ/kCzAAR4Y9iFJQdBHEXBGKOLFbnlJevD0wNKEB2iD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iDXq3tL0; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60SB0vN6978688;
	Wed, 28 Jan 2026 05:03:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=k/pGhjjYmAKBWBEtTdB176K0sd0KMfPht8r5ew4KCnM=; b=iDXq3tL0fkx6
	iUG695ttVIZmvas0BlfoDpOw7EQzAWF4VRuFWm4hE7AiJFoFMhhDaISMWtPLZZio
	5c0kkajV6J7aDDsMttgdZD6gPhxmen+27SXuUcH+VzRTNX9RAR2Wj2gqd3OLA3GS
	WNUnFoUShTW6CsYXGm1lk+zyswz8/Afi1t4IfF8budHOCncTqcjaefXOI7bj76zk
	FuhkNRhio5NN6PnTcsPH7dB7s3ceL9LJ0hNtmrnmMB8ko3x214UtnC/3EIGshKCN
	uDW1zZ4s48jdjArdbNK/PG0ukz1vW2bLzhMZ52TUzk3IbMUfOYQODMrrXJPgRoDH
	M5jPaXLmcQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4by7wtmax1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Jan 2026 05:03:51 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 28 Jan 2026 13:03:50 +0000
From: Chris Mason <clm@meta.com>
To: Kairui Song <ryncsn@gmail.com>
CC: <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Chris
 Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
        Barry Song
	<baohua@kernel.org>, <linux-kernel@vger.kernel.org>,
        Kairui Song
	<kasong@tencent.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry split
Date: Wed, 28 Jan 2026 05:02:34 -0800
Message-ID: <20260128130336.727049-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwNyBTYWx0ZWRfXwoGNjke19CC7
 n/dt4+Be8CsTyZDuUmOA7wTaR9aLdsB08tTPkDkImpfkNHgDzd1eUj3tz+KxT3y53NaF1CZKirN
 NxqQOfCjWhXudfFYwFmdZ3m1wc5rG8VDyXU06zD/zvha6MsmtLaZBDyoiXjfd4Lf3Sr/JWGxVsT
 PePTbUI+eultJJURd6e0ge+VEJlyMMkJCvkmRmepppT+GQAMRToqz5x8yVCjmg57hTS/UEEO2tv
 2ArCVl1WZq3sHMaf7tJr8mFXRHqjUenaprF21E2LL9PbGS0sg9LkZChFT3vyTBaM9lMs+ENXYOH
 muk6GmxXx5N2/3HVz7tIoCJfpuP4lzB+10mUrqxwwDjRUC7WVDzXmmHJjD56nTo6hfM7IeY+Pkg
 97RzKhL7q4tdk86qo8UEVZqMiX+bfTdCicn/c7018ahehw/k7I0hHhPGnAu/675YY/KerPvc09X
 2SemmyQjd4xHwVR/vQg==
X-Proofpoint-ORIG-GUID: uHLxgoPUD54u1_PxNjda0pDEUYOYnRxj
X-Authority-Analysis: v=2.4 cv=Jsr8bc4C c=1 sm=1 tr=0 ts=697a0937 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=GvQkQWPkAAAA:8
 a=h77ORrGvqfQH1F6JnNAA:9
X-Proofpoint-GUID: uHLxgoPUD54u1_PxNjda0pDEUYOYnRxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211964-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,google.com,linux.alibaba.com,linux-foundation.org,huaweicloud.com,gmail.com,kernel.org,redhat.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,tencent.com:email]
X-Rspamd-Queue-Id: 69B48A1C85
X-Rspamd-Action: no action

Kairui Song <ryncsn@gmail.com> wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The helper for shmem swap freeing is not handling the order of swap
> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry, but
> it gets the entry order before that using xa_get_order without lock
> protection, and it may get an outdated order value if the entry is split
> or changed in other ways after the xa_get_order and before the
> xa_cmpxchg_irq.
> 
> And besides, the order could grow and be larger than expected, and cause
> truncation to erase data beyond the end border. For example, if the
> target entry and following entries are swapped in or freed, then a large
> folio was added in place and swapped out, using the same entry, the
> xa_cmpxchg_irq will still succeed, it's very unlikely to happen though.
> 
> To fix that, open code the Xarray cmpxchg and put the order retrieval
> and value checking in the same critical section. Also, ensure the order
> won't exceed the end border, skip it if the entry goes across the
> border.
> 
> Skipping large swap entries crosses the end border is safe here.
> Shmem truncate iterates the range twice, in the first iteration,
> find_lock_entries already filtered such entries, and shmem will
> swapin the entries that cross the end border and partially truncate the
> folio (split the folio or at least zero part of it). So in the second
> loop here, if we see a swap entry that crosses the end order, it must
> at least have its content erased already.
> 
> I observed random swapoff hangs and kernel panics when stress testing
> ZSWAP with shmem. After applying this patch, all problems are gone.
> 

Hi everyone, another flag from running mm-next through AI review.  I'm
low confidence on this one:

> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c

[ ... ]

> @@ -1191,12 +1203,23 @@
>  		folio = fbatch.folios[i];
>
>  		if (xa_is_value(folio)) {
> +			int order;
>  			long swaps_freed;
>
>  			if (unfalloc)
>  				continue;
> -			swaps_freed = shmem_free_swap(mapping, indices[i], folio);
> +			swaps_freed = shmem_free_swap(mapping, indices[i],
> +						      end - 1, folio);
>  			if (!swaps_freed) {
> +				/*
> +				 * If found a large swap entry cross the end border,
> +				 * skip it as the truncate_inode_partial_folio above
> +				 * should have at least zerod its content once.
> +				 */
> +				order = shmem_confirm_swap(mapping, indices[i],
> +							   radix_to_swp_entry(folio));
> +				if (order > 0 && indices[i] + (1 << order) > end)
> +					continue;
>  				/* Swap was replaced by page: retry */
>  				index = indices[i];
>  				break;

Could this code infinite loop if a large swap entry crosses the START
boundary instead of the END boundary?

When shmem_free_swap() returns 0, it could be either because:
(a) The entry was replaced by a page, or
(b) The entry failed the boundary check (base < index ||
    base + nr_pages - 1 > end)

The boundary check here only handles case (b) for entries crossing the
END boundary:

    if (order > 0 && indices[i] + (1 << order) > end)
        continue;

But what happens if the entry crosses the START boundary? If
find_get_entries() returns a large swap entry at indices[i] where
the entry's base (calculated as indices[i] & ~((1 << order) - 1)) is
less than the truncation start point, then shmem_free_swap() will
return 0 due to the "base < index" check. The code will then call
shmem_confirm_swap(), get the order, check if it crosses the END
boundary (which it doesn't), and retry with the same index:

    index = indices[i];
    break;

The next iteration will find the same entry again at the same index,
leading to an infinite loop. For example:

- Truncating range [18, 30]
- Large swap entry at [16, 23] (order 3, 8 pages)
- indices[i] = 18
- shmem_free_swap() sees base=16 < index=18, returns 0
- Check: 18 + 8 > 30 is false (26 <= 30)
- Retries with index=18
- Loop repeats indefinitely

Should the boundary check also handle the START case, perhaps:

    if (order > 0) {
        pgoff_t base = indices[i] & ~((1UL << order) - 1);
        if (base + (1 << order) - 1 > end || base < start)
            continue;
    }

where 'start' is preserved from before the loop?


