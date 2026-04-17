Return-Path: <stable+bounces-238471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKmVEer74Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:22:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C565041930B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF63A305C63E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF336372EED;
	Fri, 17 Apr 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcSVc3kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A423264D0;
	Fri, 17 Apr 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417699; cv=none; b=pudupyYOGRDqGvPmflZC8QQtYjDft/Sd6N/nlE9BFOyJO6tTVhi/9L2Xw4MjVfc4YWgSQjdg8DUq31FfGHYBiFSNoMGZmIfQ/LhYlHqooVp/xiSSzl4OOW9ZcBjoe/8adHqeCkLvMNW8m8H0b55HTdMqcjhd4G3XbvrynF7FVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417699; c=relaxed/simple;
	bh=rmJzUQzsPyc0NxUkUuOpkygTTYh+y/QYrvawDFLMzk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAosF4FiSa0rK+fZI5v3xKoAQzw5noJ1el3h9DB7XV1gU0vFVra/4WqjkpRryIHAQhAvTG2hBAwIIBCCQcOnzPQq9ANb1gKDNUZNSoqY0RiqlA1f/tzNouhFzejgBV3ztEv+i1MS6hOSSyLNZPuEwO3hB/5FPQD8rm0ZVUhn5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcSVc3kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2801C2BCB4;
	Fri, 17 Apr 2026 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776417699;
	bh=rmJzUQzsPyc0NxUkUuOpkygTTYh+y/QYrvawDFLMzk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DcSVc3kb/oCeCw9ntdtcrirK0ELCcQFOeJPS636iSbphduy27yvLI3SemoCwJJAEY
	 fQ0ULGCuaxbo9tvtulLMgOL0/hQQ+8JK33EC95sJ9rirmctvpwlOCg67QzjQXG6Khi
	 k6854fsWrob0iFmVYD3CcuO6sVR8TajtaTQdYNHkL2UJZaRvYdAjLiYmeevUFqyl3b
	 IGlqslqZAxoerQ5BwxZ/xX47XTbRVNqHRSEhMVuctx/EC4C2exQny6YgGNcPSY+Lb1
	 gz8pkA5CVYHsKXsbadKIswwozRrtSjMPHeB5owoz8ToQ2Z3Gq/MORu2u1NGxudWphV
	 vP31kmhtFY3JA==
Date: Fri, 17 Apr 2026 18:21:37 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	stable@vger.kernel.org, Vitaly Wool <vitaly.wool@konsulko.se>,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] slub: fix data loss and overflow in krealloc()
Message-ID: <aeH7oeZtDdDUza0W@hyeyoo>
References: <20260416132837.3787694-1-elver@google.com>
 <aeG6RG41sgZuerYa@hyeyoo>
 <CANpmjNPMxDkzvVnD9pXy1YBTO4n-abQZ+if6XdDj-u4dnfks5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPMxDkzvVnD9pXy1YBTO4n-abQZ+if6XdDj-u4dnfks5A@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238471-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,gentwo.org,google.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: C565041930B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 11:05:09AM +0200, Marco Elver wrote:
> On Fri, 17 Apr 2026 at 06:42, Harry Yoo (Oracle) <harry@kernel.org> wrote:
> > [+Cc relevant folks]
> >
> > On Thu, Apr 16, 2026 at 03:25:07PM +0200, Marco Elver wrote:
> > > Commit 2cd8231796b5 ("mm/slub: allow to set node and align in
> > > k[v]realloc") introduced the ability to force a reallocation if the
> > > original object does not satisfy new alignment or NUMA node, even when
> > > the object is being shrunk.
> > >
> > > This introduced two bugs in the reallocation fallback path:
> > >
> > > 1. Data loss during NUMA migration: The jump to 'alloc_new' happens
> > >    before 'ks' and 'orig_size' are initialized. As a result, the
> > >    memcpy() in the 'alloc_new' block would copy 0 bytes into the new
> > >    allocation.
> >
> > Ouch.
> >
> > > 2. Buffer overflow during shrinking: When shrinking an object while
> > >    forcing a new alignment, 'new_size' is smaller than the old size.
> > >    However, the memcpy() used the old size ('orig_size ?: ks'), leading
> > >    to an out-of-bounds write.
> >
> > Right. before the commit we didn't reallocate when the size is smaller.
> >
> > > The same overflow bug exists in the kvrealloc() fallback path, where the
> > > old bucket size ksize(p) is copied into the new buffer without being
> > > bounded by the new size.
> > >
> > > A simple reproducer:
> > >
> > >       // e.g. add to lkdtm as KREALLOC_SHRINK_OVERFLOW
> > >       while (1) {
> > >               void *p = kmalloc(128, GFP_KERNEL);
> > >               p = krealloc_node_align(p, 64, 256, GFP_KERNEL, NUMA_NO_NODE);
> > >               kfree(p);
> > >       }
> > >
> > > demonstrates the issue:
> > >
> > >   ==================================================================
> > >   BUG: KFENCE: out-of-bounds write in memcpy_orig+0x68/0x130
> > >
> > >   Out-of-bounds write at 0xffff8883ad757038 (120B right of kfence-#47):
> > >    memcpy_orig+0x68/0x130
> > >    krealloc_node_align_noprof+0x1c8/0x340
> > >    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
> > >    lkdtm_do_action+0x3a/0x60 [lkdtm]
> > >    ...
> > >
> > >   kfence-#47: 0xffff8883ad756fc0-0xffff8883ad756fff, size=64, cache=kmalloc-64
> > >
> > >   allocated by task 316 on cpu 7 at 97.680481s (0.021813s ago):
> > >    krealloc_node_align_noprof+0x19c/0x340
> > >    lkdtm_KREALLOC_SHRINK_OVERFLOW+0x8c/0xc0 [lkdtm]
> > >    lkdtm_do_action+0x3a/0x60 [lkdtm]
> > >    ...
> > >   ==================================================================
> > >
> > > Fix it by moving the old size calculation to the top of __do_krealloc()
> > > and bounding all copy lengths by the new allocation size.
> > >
> > > Fixes: 2cd8231796b5 ("mm/slub: allow to set node and align in k[v]realloc")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: https://sashiko.dev/#/patchset/20260415143735.2974230-1-elver%40google.com
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> >
> > Looks good to me, but I think we still have a similar issue in
> > vrealloc_node_align_noprof()? (goto need_realloc; due to NUMA mismatch
> > but the new size is smaller)
> 
> Good find.
>
> That's a separate patch, though, since it's in the vmalloc subsystem

You're right. for this patch:

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

> (it's also not confidence-inspiring that vrealloc_node_align_noprof
> has a bunch of TODOs sprinkled all over...).

;)

looks like one of the TODOs is going to be tacked though. (shrinking)
https://lore.kernel.org/linux-mm/20260404-vmalloc-shrink-v10-0-335759165dfa@zohomail.in

> Since you found that, do you want to claim it?

I have many stuffs going on my plate now (including re-reviewing the
typed kmalloc caches patch) so it'd be nice if somebody could claim :)

> Also by the looks of it slub and vmalloc patches go through different
> trees these days per MAINTAINERS.

Right. slab patches go through the slab tree.

-- 
Cheers,
Harry / Hyeonggon

