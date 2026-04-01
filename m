Return-Path: <stable+bounces-232650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0iD2mFzGlXTgYAu9opvQ
	(envelope-from <stable+bounces-232650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:39:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8148373F21
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7156309EB9B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E95364050;
	Wed,  1 Apr 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uj8tPH4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1835E930;
	Wed,  1 Apr 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011128; cv=none; b=GB9Hc5wuW1lSYZCL71hM5krgRKIPfUrsbXDGTTpFWxz0CTm6f97W9VC0Fm0DPXUmLB27DkHJHNxPd2ry5You2a7bdO8vjP0oNRWMCYvW3VYZpEMlikbQqYJxoHtqC+BX9cb36VbFyPmrQcLibIY5Dvt2d6B6lyLlTXMVlwj4Id0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011128; c=relaxed/simple;
	bh=nUUu7l1xK87MHgb+obB6Qi0cxCVs6kWFc4Wh3VJ0FBA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RjGP2v4mTzyLSaB3kDlPmnF3NIqQk7G8ePB7CSCabWTA9twNwb4W8rnLiULzaXzvxWP5eftexv7UB3OhBaq75igGLFqq/l4ha5fmHwBZtpf9fAi+MoWpwahI+30ny/ymG2FnpHZPMPsj5DmA2BvKzcS/ay0S0n7a0fjKHF7bE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uj8tPH4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D806C19423;
	Wed,  1 Apr 2026 02:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775011127;
	bh=nUUu7l1xK87MHgb+obB6Qi0cxCVs6kWFc4Wh3VJ0FBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uj8tPH4EzbxuS+eMTIZZmhJq2UCqS9O02dswC4MgLakfc86HqCh4rSadfQhfNxs81
	 UiM6AP+jaxDML8d4U/O/y/vT47/ofQ2P5x5JkM5hCEd1YM684ENbBumvm5aXVNLP0N
	 ki1pr6CWdD4rFg9tdX77Xcqylgrx8Vwt9Qn5JWio=
Date: Tue, 31 Mar 2026 19:38:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/alloc_tag: clear codetag for pages allocated
 before page_ext initialization
Message-Id: <20260331193846.1822055eac7f8555fbb5ebdd@linux-foundation.org>
In-Reply-To: <20260331081312.123719-1-hao.ge@linux.dev>
References: <20260331081312.123719-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232650-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: A8148373F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 16:13:12 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> Due to initialization ordering, page_ext is allocated and initialized
> relatively late during boot. Some pages have already been allocated
> and freed before page_ext becomes available, leaving their codetag
> uninitialized.
> 
> A clear example is in init_section_page_ext(): alloc_page_ext() calls
> kmemleak_alloc(). If the slab cache has no free objects, it falls back
> to the buddy allocator to allocate memory. However, at this point page_ext
> is not yet fully initialized, so these newly allocated pages have no
> codetag set. These pages may later be reclaimed by KASAN, which causes
> the warning to trigger when they are freed because their codetag ref is
> still empty.
> 
> Use a global array to track pages allocated before page_ext is fully
> initialized. The array size is fixed at 8192 entries, and will emit
> a warning if this limit is exceeded. When page_ext initialization
> completes, set their codetag to empty to avoid warnings when they
> are freed later.
> 
> This warning is only observed with CONFIG_MEM_ALLOC_PROFILING_DEBUG=Y
> and mem_profiling_compressed disabled:
> 
> [    9.582133] ------------[ cut here ]------------
> [    9.582137] alloc_tag was not set
>
> ...
>

Thanks.

> v4: Fix sparse warnings by changing the typedef from a function pointer
>     type to a function type, and placing __rcu before the pointer
>     declarator. Use RCU_INITIALIZER() for static initialization.
>     Closes: https://lore.kernel.org/oe-kbuild-all/202603291211.YhY0R0se-lkp@intel.com/

fwiw, here's the delta relative to v3:


--- a/lib/alloc_tag.c~mm-alloc_tag-clear-codetag-for-pages-allocated-before-page_ext-initialization-v4
+++ a/lib/alloc_tag.c
@@ -800,13 +800,13 @@ static void __init __alloc_tag_add_early
 	early_pfns[old_idx] = pfn;
 }
 
-typedef void (*alloc_tag_add_func)(unsigned long pfn);
-static alloc_tag_add_func __rcu alloc_tag_add_early_pfn_ptr __refdata =
-		__alloc_tag_add_early_pfn;
+typedef void alloc_tag_add_func(unsigned long pfn);
+static alloc_tag_add_func __rcu *alloc_tag_add_early_pfn_ptr __refdata =
+	RCU_INITIALIZER(__alloc_tag_add_early_pfn);
 
 void alloc_tag_add_early_pfn(unsigned long pfn)
 {
-	alloc_tag_add_func alloc_tag_add;
+	alloc_tag_add_func *alloc_tag_add;
 
 	if (static_key_enabled(&mem_profiling_compressed))
 		return;
_


