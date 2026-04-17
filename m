Return-Path: <stable+bounces-238468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGwPNFz64Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FA419242
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86C7317AA0B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5E3A6F15;
	Fri, 17 Apr 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtVx276i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35973A1D01;
	Fri, 17 Apr 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417094; cv=none; b=UvJ/ghHEvpsMyKXqY0zjyE1naD4eGH1pB1eUNGdjeSXvr7Z/aFiBHJ0KNoHK5K2ioyq7mC6x5Z1AsaDNV0NG7NAq4Ecm9S+WGlO78A7YDWU5wwh0IjrpDUFcaz3euIB0ZPaiGpXvZer/qSwByibB7C3B69/FRgTp7CH26BHwYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417094; c=relaxed/simple;
	bh=b9DebVhvg3kMguhZCy3y+KwHTug2uDLeAd0Plgmcc4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nanaq4e1rNKGXaneIRBIySChr7LgvaMiKUYbLfPRCaOaIlcC7WSOA8fT+LKZ+JyHDAzd1yB4dYdgg4n1FQvebyWUDtaLh2uv4OcgtO2GAqZ84nOtgKh0oW43xHaTJ8yxziQF+NOsuVYvKj0T4KPW6cWarIXHiMAylFhyhXxSK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtVx276i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FAEC19425;
	Fri, 17 Apr 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776417094;
	bh=b9DebVhvg3kMguhZCy3y+KwHTug2uDLeAd0Plgmcc4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VtVx276ikd8VY5G/3b9udrxO99gGFLmUPQkhx4AKxGVhfBTcOq4MzDQjajqLfL1bD
	 PaIJoyjhOB5bqnxjh5DAg/CgM2hxtBYXaiKVfei39lAD4sSf5BACulYZyHjcjNkw25
	 bcQ5sDPRBh5HuJtiOhMnyqnr1FPB5tM4X8MMfYj2KWoKIIHi19GenyJ4aMnfT6KRmi
	 v28nyAmseut8Fky0sIJ+x/yWSwFnAxEtsQtIQuuhVaQPkx31nCUGnVA2EU65QJxYC+
	 JEEG/uH/uxwtcDykSvnfBEaEvgmOw0JKSQv5n868HhcAdWdPnJEDCjSS1RA3s/5n0G
	 uikaIEBV2EKdw==
Message-ID: <3a6e90d0-59de-4eb6-ae3d-56aaaf3e5354@kernel.org>
Date: Fri, 17 Apr 2026 11:11:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: fix data loss and overflow in krealloc()
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 stable@vger.kernel.org
References: <20260416132837.3787694-1-elver@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260416132837.3787694-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238468-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 378FA419242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 15:25, Marco Elver wrote:
> Commit 2cd8231796b5 ("mm/slub: allow to set node and align in
> k[v]realloc") introduced the ability to force a reallocation if the
> original object does not satisfy new alignment or NUMA node, even when
> the object is being shrunk.
> 
> This introduced two bugs in the reallocation fallback path:
> 
> 1. Data loss during NUMA migration: The jump to 'alloc_new' happens
>    before 'ks' and 'orig_size' are initialized. As a result, the
>    memcpy() in the 'alloc_new' block would copy 0 bytes into the new
>    allocation.
> 
> 2. Buffer overflow during shrinking: When shrinking an object while
>    forcing a new alignment, 'new_size' is smaller than the old size.
>    However, the memcpy() used the old size ('orig_size ?: ks'), leading
>    to an out-of-bounds write.
> 
> The same overflow bug exists in the kvrealloc() fallback path, where the
> old bucket size ksize(p) is copied into the new buffer without being
> bounded by the new size.
> 
> A simple reproducer:
> 
> 	// e.g. add to lkdtm as KREALLOC_SHRINK_OVERFLOW
> 	while (1) {
> 		void *p = kmalloc(128, GFP_KERNEL);
> 		p = krealloc_node_align(p, 64, 256, GFP_KERNEL, NUMA_NO_NODE);
> 		kfree(p);
> 	}
> 
> demonstrates the issue:
> 
>   ==================================================================
>   BUG: KFENCE: out-of-bounds write in memcpy_orig+0x68/0x130
> 
>   Out-of-bounds write at 0xffff8883ad757038 (120B right of kfence-#47):
>    memcpy_orig+0x68/0x130
>    krealloc_node_align_noprof+0x1c8/0x340
>    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
>    lkdtm_do_action+0x3a/0x60 [lkdtm]
>    ...
> 
>   kfence-#47: 0xffff8883ad756fc0-0xffff8883ad756fff, size=64, cache=kmalloc-64
> 
>   allocated by task 316 on cpu 7 at 97.680481s (0.021813s ago):
>    krealloc_node_align_noprof+0x19c/0x340
>    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
>    lkdtm_do_action+0x3a/0x60 [lkdtm]
>    ...
>   ==================================================================
> 
> Fix it by moving the old size calculation to the top of __do_krealloc()
> and bounding all copy lengths by the new allocation size.
> 
> Fixes: 2cd8231796b5 ("mm/slub: allow to set node and align in k[v]realloc")
> Cc: <stable@vger.kernel.org>
> Reported-by: https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
> Signed-off-by: Marco Elver <elver@google.com>

Ouch, thanks. Added to slab/for-next-fixes
Indeed the vrealloc would be separate patch with different Fixes: commit and
handled in the mm tree.

> ---
>  mm/slub.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 92362eeb13e5..161079ac5ba1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6645,16 +6645,6 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
>  	if (!kasan_check_byte(p))
>  		return NULL;
>  
> -	/*
> -	 * If reallocation is not necessary (e. g. the new size is less
> -	 * than the current allocated size), the current allocation will be
> -	 * preserved unless __GFP_THISNODE is set. In the latter case a new
> -	 * allocation on the requested node will be attempted.
> -	 */
> -	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> -		     nid != page_to_nid(virt_to_page(p)))
> -		goto alloc_new;
> -
>  	if (is_kfence_address(p)) {
>  		ks = orig_size = kfence_ksize(p);
>  	} else {
> @@ -6673,6 +6663,16 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
>  		}
>  	}
>  
> +	/*
> +	 * If reallocation is not necessary (e. g. the new size is less
> +	 * than the current allocated size), the current allocation will be
> +	 * preserved unless __GFP_THISNODE is set. In the latter case a new
> +	 * allocation on the requested node will be attempted.
> +	 */
> +	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> +		     nid != page_to_nid(virt_to_page(p)))
> +		goto alloc_new;
> +
>  	/* If the old object doesn't fit, allocate a bigger one */
>  	if (new_size > ks)
>  		goto alloc_new;
> @@ -6707,7 +6707,7 @@ __do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags,
>  	if (ret && p) {
>  		/* Disable KASAN checks as the object's redzone is accessed. */
>  		kasan_disable_current();
> -		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
> +		memcpy(ret, kasan_reset_tag(p), min(new_size, (size_t)(orig_size ?: ks)));
>  		kasan_enable_current();
>  	}
>  
> @@ -6941,7 +6941,7 @@ void *kvrealloc_node_align_noprof(const void *p, size_t size, unsigned long alig
>  		if (p) {
>  			/* We already know that `p` is not a vmalloc address. */
>  			kasan_disable_current();
> -			memcpy(n, kasan_reset_tag(p), ksize(p));
> +			memcpy(n, kasan_reset_tag(p), min(size, ksize(p)));
>  			kasan_enable_current();
>  
>  			kfree(p);


