Return-Path: <stable+bounces-273211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2FurEVLhUGpc7AIAu9opvQ
	(envelope-from <stable+bounces-273211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:10:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4BF73A910
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dAkxgwXT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273211-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273211-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF28C3129218
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7902426D0C;
	Fri, 10 Jul 2026 11:58:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519C426D29;
	Fri, 10 Jul 2026 11:58:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684693; cv=none; b=iNAa3py5ckp5GZrnHAuXn2V/vWBoqDqhnLaQ69Iw3FykoRDJ/idA7zNGz5dV6u+Ig+YovkveMpkUKW905OyO1bevcJV6r5MaqKC8UeTRQ3ZU0Fohmc22R+AwLWH9qQLHckUY3BCS5f75ps3j/iIC2BPt9ZD8uoVxkWLWiS11lZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684693; c=relaxed/simple;
	bh=hKciZm915bJYzdl/DFU0eneGXBw6w/af0wOeuPei2iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egy3Ccy3lCenbquazmAgF7OXJ9ADKDttgARKNN++OYMBwgjlZZLVy2K/yFJA4FO9xot6vP0ZNFqdBKnd/LCHoJLGOXkB3l23lE7T2390FaE1cX85gSIiejMxMVdFaXoxvNVeI4A448VhIt55yLSzLYW+f3iv8dBtSUmrrFz0v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAkxgwXT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF991F000E9;
	Fri, 10 Jul 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783684690;
	bh=kDw4uHkrjrH2i/wDdxHnoRQvhH62dpRg5r0nrYMHl8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAkxgwXT/R1DI7L+qLyNgdOAeakrAm08Pe6X6aqix0XakuDCSCOZnAqHQ2gRE0t9F
	 h3ZdKHfNDjgo97EBH/Aqec4PzZNwGJAd3zSq1wv6qKfoBcrGvys9ohsuamv/yuQqtL
	 IHh+n7NktbReynKyVPSjKL7zpmcAmDyw3Vf6MtiYXyeievv5tNFZ1ESTOMO9THH8mq
	 bs9g9tjQUWl554Yh5sw1nzgLe/RZ8R/BLPik3sr+gTdFfU/iUatq8IkUVk6xz7c95S
	 U7/08M6TK1ft8TrJ3DhiH4nyvc/SsXkVo/NzMdILO0bGEILpZKpcB4RJSfIJZox+Co
	 auVbqGEDaiSRw==
Date: Fri, 10 Jul 2026 12:57:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alDeMJZdhbKfS023@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <CA+XhMqwpDGYSQvDKrFz9XuQFiaz8_rgW0LupEzFhehSrFvUZaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqwpDGYSQvDKrFz9XuQFiaz8_rgW0LupEzFhehSrFvUZaw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273211-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD4BF73A910

On Fri, Jul 10, 2026 at 12:44:20PM +0100, David CARLIER wrote:
> Hi Lorenzo,
>
> On Fri, 10 Jul 2026 at 11:50, Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > Kernel page table walkers fall into two broad categories - those ranges
> > where no exclusion is required via walk_kernel_page_table_range_lockless()
> > and those where exclusion is required via walk_kernel_page_table_range()
> > or walk_page_range_debug().
> >
> > The former category is used only by arm64 arch code operating on ranges it
> > both wholly owns and does not concurrently write.
> >
> > The latter category consists of kernel page table walkers operating on
> > ranges that are wholly owned (but which need exclusion against concurrent
> > writers).
> >
> > The lock used for exclusion is the mmap lock, and for kernel ranges this
> > the mmap lock on init_mm.
> >
> > ptdump is a special case being both the only user of
> > walk_page_range_debug(), and the only case in which it walks ranges it does
> > not own.
> >
> > This presents a problem, as page tables may be freed under ptdump. And
> > indeed there is a use-after-free bug in the kernel as a result, which this
> > series addresses.
> >
> > vmap promotes page tables to huge leaf entries where possible, freeing the
> > lower leaf page table when it does. It does this with no meaningful locks
> > held against concurrent ptdump walks.
> >
> > As a result, use-after-free can currently occur. This series addresses the
> > issue by having the vmap huge promotion logic acquire the mmap read lock
> > while both setting the huge page table entry and freeing the prior leaf
> > page table.
> >
> > The ptdump code already acquires the mmap write lock, so by doing so we
> > ensure that the ptdump walker only ever observes either the huge page table
> > entry or the existing page table entry, and nothing is freed underneath it.
> >
> > A mitigation for this issue was already applied for arm64 in commit
> > a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series
>
> seems it should be fa93b45fd397.

Yeah oops, I typo'd that.

Andrew - could you fix that up for me? Thanks!

>
> Cheers.
> > has to deal with carefully.
> >
> > This mitigation resolves the issue by acquiring the mmap read lock on
> > init_mm on vmap page table free if a ptdump is in progress.
> >
> > However the fix in this series would cause a deadlock if we were to simply
> > apply it for arm64 without also reverting the change.
> >
> > This is because vmap may acquire the read lock before ptdump attempts to
> > acquire the write lock, which then gets queued, and rwsem starvation rules
> > mean that the (unacknowledged) nested mmap read lock in the arm64 code
> > would also block, meaning the original read lock is never released and thus
> > deadlock.
> >
> > This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> > lock in vmap logic, then partially reverting commit
> > a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), keeping the
> > enablement of huge vmap support, and removing the ifdeffery with the
> > partial revert patch.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> > Lorenzo Stoakes (2):
> >       mm/vmalloc: acquire init_mm read lock on huge vmap promotion
> >       Revert "arm64: Enable vmalloc-huge with ptdump"
> >
> >  arch/arm64/include/asm/ptdump.h |  2 --
> >  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
> >  arch/arm64/mm/ptdump.c          | 11 ++---------
> >  include/linux/mmap_lock.h       |  1 +
> >  mm/pagewalk.c                   | 22 +++++++++++----------
> >  mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
> >  6 files changed, 51 insertions(+), 69 deletions(-)
> > ---
> > base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> > change-id: 20260710-series-vmap-race-fix-2a4cac988938
> >
> > Cheers,
> > --
> > Lorenzo Stoakes <ljs@kernel.org>
> >

