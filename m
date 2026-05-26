Return-Path: <stable+bounces-254308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIPRInZ+FWqtWAcAu9opvQ
	(envelope-from <stable+bounces-254308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5505D4A15
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07FA0300D91F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78D3DE45B;
	Tue, 26 May 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+2Dh7MF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FD2C326F;
	Tue, 26 May 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793523; cv=none; b=d63xHmhj31i2J+6JCZ9f7Dq/oZZ5F7oRfciQ9I0BZe/z8c5F7X5kJGdJeYNyptT+il+eDR3JgGMIbpqMU4FHpFgW/Uhy5FrhsRzHOkpqY3GM+cJrZdK3jwUsp7JoYojIEOs+uYWFCFnuFZIONcAhLZW8+DrKThzXfd1eNg8JLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793523; c=relaxed/simple;
	bh=o2irwX7EG6I+YJ0FvIT9HckDmEnpR+ox2VKp9/aKOyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od+DmgC6QkYNlW78chZLzLlcTrqlhAgKYRtXMBIlzZ2Z7MN1jArG7nUmeXfntqqf4LH78FIIcPX8b1rUOJxh05uj3MwQ28fQldBV1jC1ED4DMyCr7beR5p0CR/TESPWuhBmiaxJmRx8BLw+bLq5/RSVwk47YYOMw8fea873gpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+2Dh7MF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E4B1F000E9;
	Tue, 26 May 2026 11:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793522;
	bh=qk40xgulls2bsEySJ0d4/5IyTPrAc0LfClUBUzlGCjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+2Dh7MFEtK74+pZLmmNLDVqGWGe2BE+kd3pDCqQXGbpTjL7Logl9E6fmQ0ubku+1
	 nyOjwqL+o0m5Ts5cROkskSsx8BBovl9L8IyPmf5m4cF5bkx26ThEevbfbn5KNW9ygl
	 yXWTAuQX9CmIwRFZUksstdZwplvejzDeV1LunwDhE+WlkkWABJoU4quxu4Aa6r1l9s
	 EKOxiCJ0cQvS3yULxl9RIkuNSKc0fB5rcyvNUYLxymB/EWdGPLZ09F6aUnfWem9QML
	 xeIJ6Kzi3M/GWTMKKHZ0SypcJlgX7NGSp7a2OopiPU5ihCB+0KREcp481g6H5y5p9w
	 2mUtT7NpMbH4A==
Date: Tue, 26 May 2026 12:05:15 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Yang Shi <yang.shi@linux.alibaba.com>, 
	wangkefeng.wang@huawei.com, chenjun102@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: update file PMD counter before
 folio_put()
Message-ID: <ahV8PuP2sg7fV_DR@lucifer>
References: <20260526101337.1984081-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526101337.1984081-1-yintirui@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254308-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 0A5505D4A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 06:13:37PM +0800, Yin Tirui wrote:
> __split_huge_pmd_locked() updates the file/shmem RSS counter after
> dropping the PMD mapping's folio reference. If folio_put() drops the
> last reference, mm_counter_file() can later read freed folio state via
> folio_test_swapbacked().
>
> Move the counter update before folio_put().
>
> Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")

That's an old commit :) I mean I suspect we're probably not actually ever
dropping the folio ref to 0 here since we never had a report since ~2018.

The page cache keeping a reference I guess?

But doesn't mean we shouldn't fix this on principal/there being some way
this could happen.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yin Tirui <yintirui@huawei.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0135c29a4372..a5f4a48b7b77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3145,7 +3145,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
>  				folio_set_referenced(folio);
>  			folio_remove_rmap_pmd(folio, page, vma);
> +			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>  			folio_put(folio);
> +			return;

Hmm, sucks to duplicate like this, but for purposes of backport and getting
this resolved fine, we can clean it up later.

>  		}
>  		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
>  		return;
> --
> 2.43.0
>

Cheers, Lorenzo

