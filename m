Return-Path: <stable+bounces-274040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SkGXDxR5VWrYowAAu9opvQ
	(envelope-from <stable+bounces-274040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B3D74FC7B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:47:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shutemov.name header.s=fm3 header.b="j frxqIh";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=FzgXiVZe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274040-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274040-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F110D3046FC8
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FF3A4539;
	Mon, 13 Jul 2026 23:45:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5193D7D69;
	Mon, 13 Jul 2026 23:45:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986354; cv=none; b=SA7o0gD2IKtOINe1B7b0f88JfjTA7tqEAe9uT5LaT1jb590W2cH+dXFaIgJ066T8wGgNzOdwEIPJOSu5RUlVsCIHKSaTGN6ZTRau+l3IQ/Phmzq8tPTl63n1Yt7JCc65JYYjqQKkbExROAz6fEkbjfpwkLxTEeGlsT0mKaYEeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986354; c=relaxed/simple;
	bh=CKFT8mpFCLNeqzZU1YSw3quYthuvOT/cvgnOaJC+3oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWSfvglyfzj24jvJri4yffddoehdmGiraiXYm6U3mWLZ+qeWMSxKsMiyjTnH86uTWfitBrOUYqBBy8vsMVuxqS4nxcABw0fo0L7mprfqEnhOGCE2KsPjv9ldo5crW6e3vTJMfeEDjroKMMuNvcso1li5V/ldaoeeKXeoylDkrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=jfrxqIhb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzgXiVZe; arc=none smtp.client-ip=202.12.124.158
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA2077A00EE;
	Mon, 13 Jul 2026 19:45:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Jul 2026 19:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783986340; x=
	1784072740; bh=VrQ+955Mhao6xQZoL6uljG/95v6TMiuQHwTATw9a67A=; b=j
	frxqIhbjwK3BfoLSXujJBE6K8kMuqrBzd08zOSlwiSLPIrjhRm95J8KNzqh0Jmwi
	CZ7qwJrMib96bL76SAQb6BaL0s0lbWX7sbSciwEpU8vfVbIz6cyY7k/BAE7ylRVa
	Io+hQLuwV63LD7rqPQZR4Pvj0AfAKZKqF8aNgFCU88Ui0UrEG2homUhJnMqi9q4M
	wJLtyiBL3nI5s5ZMt981jT1yBu1fcBVnXEtNSrPpZNF+O9pZ1evqxuFRMCL06sp7
	U51lWGULXKuN94yF116GzunF7tDhS72Wd1VaEwawRsRSrfJiquo4i5f82KER7v50
	dV8dv9YcGFc9IX+6uyHhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783986340; x=1784072740; bh=VrQ+955Mhao6xQZoL6uljG/95v6TMiuQHwT
	ATw9a67A=; b=FzgXiVZeQBltyfp6nso/GKvXzGuPfo6S0L6TiOmBZ2pktXJ0dGL
	mS4t7C4877NF0SpSVvBf6PvOqfktudesZxEGqOqWmORCDss62t0t/dMak4EtkyXq
	ntHDkYcoJfs7+N1ubk3jNSIhWdZuS8wSl6QhHGY24So94Tv6XxN9g+Gkd7jLtPub
	il4sfbEDTkZyWIvIFdn5jND93KfXcbYZAFkZzJ0FcZnpsBEoz/PDC2bNwYo1bDAJ
	OPH/cyl2uoYyrJNdWs8LHpt5qVJlZOFsror6fH4ZTJl0jjbDTRsprDItVUQCO6U2
	h95STcDAQc8VeNz899dwVKC0utt1Mfri87A==
X-ME-Sender: <xms:onhVavHzUhTCIV5GMP_OVvsWml5qo8uv9TXW10sq3ByZ17mOuwCfLQ>
    <xme:onhVauoHoqsggGB7U-cm-ONdyrOFiZ5I5uDv7O8zqlaDDRlwfwJctTH80Z3U9QvCe
    oQZ8eYdg_1TEhl-5N1XXeHPiLZ25J6FgkwhV9Wrolgq-gVx0HhaU5U>
X-ME-Received: <xmr:onhVav33pPscabYLF4rLUyV1nS0w3T0WRRGu2w7bb5yZZmAW1SHU-udPYfgBiQ>
X-ME-Proxy-Cause: dmFkZTGzcd7fELHA1Uwd4cZ6HoYyqGLPRUT63qXpsTSJ0yrBG7mPaQ3t9ryEFvgsjbwBuk
    h0ux5BqP/B3LH4CEFgsJ44aHyJew1sL/dBmL73bi6vZ0KIwGRS/JCYLLzi2CGOE0P70lzQ
    i269kHR4HI0qjMwI27+kygv3dzGtubLKJEqLIh7aqmab4Hh2iUT1cK2horAL/YZCQkaGnR
    H1DMPyAJUS0uF0dVWgXRUiwTZZvkU30yh5oWDsfb/Om4HIFSbGB96AODhwyrS5EMmVA0xB
    t0NePZ5mXrkd8c/zqpm9JJaTlnvmmj+oDnKlb4rqhk2BFkZ9UmvuOr7bbhcd9SGBS/UQZX
    9lwjqa7IJ5pOTY+eRuRJBbG3n33wyYJEHFuJTMR+HA6DiFKh75vKL2iFgBhDJd8J2aww2G
    83pZ11CTYMXizdt/7QB3w9cw0Qek/OhZqvPQRVptHvKtPSQQikCWzCwplWlap1QGqFtZd5
    xaP7uMGlgIGFY+y6aomC/2C96fEwHxlDtHBZITCsuohCLanyRrpp5O1A1yoGMBkwWfDuaE
    +qzlI1QrcqN9c9I5fQLuvEeLmCdmaQRJREw1eWElod9JetFGBV7lN963Ko+TYkGbvAOAwY
    4taMPCXUW3a4PBy0/98L7KmusyIrG9V9Miwuj4Y9GF78Um49P+ivwA2ltgVg
X-ME-Proxy: <xmx:onhVaqD6c9gf5inmPwBNVa6OdROhn2pLoBPB2uXI5UVrXjK5djyrRA>
    <xmx:onhVai-TnsU_lUoTs2SSZ45KtGZYWrW_uwS_RTUazvli8vxsJUUS6w>
    <xmx:onhVagOV5D3KtiZsmT56IILzBGsuZRyTv6tiionjc8hGHwS5feRcgA>
    <xmx:onhVakE6bbvczHlErUQDa8KRjkErDcAOjF4r2iiYbdm-4UvH5mBXSg>
    <xmx:pHhVahB1TCboJNlWMaQmHOs4yZkaQNyrGSANpi6CJ8pVqTIUto7j0fas>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 19:45:38 -0400 (EDT)
Date: Tue, 14 Jul 2026 00:45:36 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hao Zhang <hao_zhang_kdev@163.com>, 
	Hao Zhang <zhanghao1@kylinos.cn>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: pin the inode across a file folio split
Message-ID: <alV3oLwvbeQsagsA@thinkstation>
References: <20260713170915.239819-1-kirill@shutemov.name>
 <20260713161341.eefb7ad32bca25ffc8f3390a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713161341.eefb7ad32bca25ffc8f3390a@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:ziy@nvidia.com,m:baolin.wang@linux.alibaba.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:hao_zhang_kdev@163.com,m:zhanghao1@kylinos.cn,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shutemov.name];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-274040-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linux.alibaba.com,infradead.org,redhat.com,arm.com,linux.dev,163.com,kylinos.cn,kvack.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shutemov.name:from_mime,shutemov.name:email,shutemov.name:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B3D74FC7B

On Mon, Jul 13, 2026 at 04:13:41PM -0700, Andrew Morton wrote:
> On Mon, 13 Jul 2026 18:09:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kirill@shutemov.name>
> > 
> > __folio_split() looks up mapping = folio->mapping for a file-backed
> > folio and keeps dereferencing it after the split completes:
> > shmem_uncharge(mapping->host) for folios dropped beyond EOF and
> > i_mmap_unlock_read(mapping) on the way out.
> > 
> > Nothing holds an inode reference for that duration. The split relies on
> > the folio the caller keeps locked (@lock_at) to pin the inode through
> > the page cache: while it is locked and present,
> > truncate_inode_pages_final() in evict() cannot make progress. But the
> > split drops @lock_at from the page cache when it falls beyond EOF (the
> > @end handling in __folio_freeze_and_split_unmapped()), while keeping it
> > locked for the caller. That removes the last pin, and a concurrent final
> > iput() can then evict and RCU-free the inode before __folio_split() is
> > done touching mapping.
> > 
> > This is reachable from memory_failure(): poisoning a tail page of a
> > shmem THP that straddles EOF makes try_to_split_thp_page() split at that
> > page, so the dropped @lock_at is the folio returned locked. The result
> > is a use-after-free, e.g.:
> > 
> >   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
> >    i_mmap_unlock_read include/linux/fs.h:537 [inline]
> >    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
> >    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
> >    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> > 
> >   Freed by task 4601:
> >    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
> >    i_callback+0x4c/0xa0 fs/inode.c:326
> >    destroy_inode+0x144/0x1e0 fs/inode.c:402
> >    evict+0x57f/0xac0 fs/inode.c:870
> > 
> > Pin the inode with igrab() before the split and drop the reference with
> > iput() after the last mapping dereference. igrab() returns NULL only if
> > the inode is already being evicted (i_count 0 and I_FREEING set), which
> > a split racing eviction can observe; there is nothing safe to split
> > then, so return -EBUSY, which callers already handle.
> 
> Sashiko is worried about iput() while holding folio_lock():
> 
> 	https://sashiko.dev/#/patchset/20260713170915.239819-1-kirill@shutemov.name

Sashiko is right. If iput() drops the last reference and
@lock_at is still in page cache we would self-deadlock.

I don't see an obvious solution. Will think more tomorrow.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

