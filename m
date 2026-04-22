Return-Path: <stable+bounces-240305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCaRNcqj6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:32:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E338E444C12
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05AC930046B5
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F33A6B6F;
	Wed, 22 Apr 2026 10:32:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B23A5E98;
	Wed, 22 Apr 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853944; cv=none; b=IYL4KZFD6fxIUVsXcPIeL2YgzbRUlduJiJDOvZoaiEdPH9VuVg6WUFFuGNC+UWWfKv6oNpfImPDRUodgmd0nvJXPHEhCRAA8My2T3ER3niSjCnK4ZPSUdpDlBv7fAQhN+lNIem+n1q7awZfCsQTt/zDLQqidFdCFYOq/KhSG1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853944; c=relaxed/simple;
	bh=82h2/uMxRpAbFgwLTzVEK7omZXq7HC3v7dgouAkza0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+fvFBAkrF5Efh92iAaWzPkxQGAal5bfs124vdSqKCWo33YGQrbPWRjB2Gj/9sEqtRusWDKwARlskU7usX1npnbQXhgUtCL11RIbedMeiqn7Ld4xmXVAqThB1kHy/rXFRgHVcI1RX8IgnrSYKO7QDFuIAyGgvwL74Kb1SYhBtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ABEC19425;
	Wed, 22 Apr 2026 10:32:20 +0000 (UTC)
Date: Wed, 22 Apr 2026 11:32:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: fix initialization of tags of the huge
 zero folio with init_on_free
Message-ID: <aeiivYFfC_EfGuFC@arm.com>
References: <20260421-zerotags-v2-1-05cb1035482e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-zerotags-v2-1-05cb1035482e@kernel.org>
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240305-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E338E444C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 05:39:07PM +0200, David Hildenbrand wrote:
> __GFP_ZEROTAGS semantics are currently a bit weird, but effectively this
> flag is only ever set alongside __GFP_ZERO and __GFP_SKIP_KASAN.
> 
> If we run with init_on_free, we will zero out pages during
> __free_pages_prepare(), to skip zeroing on the allocation path.
> 
> However, when allocating with __GFP_ZEROTAG set, post_alloc_hook() will
> consequently not only skip clearing page content, but also skip
> clearing tag memory.
> 
> Not clearing tags through __GFP_ZEROTAGS is irrelevant for most pages that
> will get mapped to user space through set_pte_at() later: set_pte_at() and
> friends will detect that the tags have not been initialized yet
> (PG_mte_tagged not set), and initialize them.
> 
> However, for the huge zero folio, which will be mapped through a PMD
> marked as special, this initialization will not be performed, ending up
> exposing whatever tags were still set for the pages.
> 
> The docs (Documentation/arch/arm64/memory-tagging-extension.rst) state
> that allocation tags are set to 0 when a page is first mapped to user
> space. That no longer holds with the huge zero folio when init_on_free
> is enabled.
> 
> Fix it by decoupling __GFP_ZEROTAGS from __GFP_ZERO, passing to
> tag_clear_highpages() whether we want to also clear page content.
> 
> Invert the meaning of the tag_clear_highpages() return value to have
> clearer semantics.
> 
> Reproduced with the huge zero folio by modifying the check_buffer_fill
> arm64/mte selftest to use a 2 MiB area, after making sure that pages have
> a non-0 tag set when freeing (note that, during boot, we will not
> actually initialize tags, but only set KASAN_TAG_KERNEL in the page
> flags).
> 
> 	$ ./check_buffer_fill
> 	1..20
> 	...
> 	not ok 17 Check initial tags with private mapping, sync error mode and mmap memory
> 	not ok 18 Check initial tags with private mapping, sync error mode and mmap/mprotect memory
> 	...
> 
> This code needs more cleanups; we'll tackle that next, like
> decoupling __GFP_ZEROTAGS from __GFP_SKIP_KASAN.
> 
> Fixes: adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero folio")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

The logic looks fine to me. Thanks!

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

