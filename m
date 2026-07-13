Return-Path: <stable+bounces-274038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s8UbHS9xVWrzoQAAu9opvQ
	(envelope-from <stable+bounces-274038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:13:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8E74FA7B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:13:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=mjMeZom2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274038-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274038-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44333302F42A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DF3B95E7;
	Mon, 13 Jul 2026 23:13:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1F3B960B;
	Mon, 13 Jul 2026 23:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984424; cv=none; b=u4AL5dOh6UEubxGBVH82Mb9LDdLMLaAdiGhLKycLni5f7bYCXYqMOjN8XI7urZqkWb39AWhHsShCBXP1svsER+pOWnrpIX60pO/E3L6PYxRDx8rIkTBXi9nghSDfNHjpZ8JiK5uHQOKpjGyb/1+CaJE2DZ9XEdmvGR+Uo3Lafpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984424; c=relaxed/simple;
	bh=zbDcVnZWuBdj490iKTokilbudFw1sR3N99l1rtrOMJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ujWrh4Q/lllYMD4gUWAgQeOmCv1vUHR87VL9zkMaxPfHbmh3rnCz9F5BkAJczoYlUZ89vgvZs1M9bZ/1iU7w/yGPOB1uMYvYhxM9Z5JOr49o/xfaGYWFH2RTTJMzM39m4jo8lRTIME/YKBTfQyM+aJrDEIoEWoL1xIXPZ4/2TAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mjMeZom2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1821F000E9;
	Mon, 13 Jul 2026 23:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783984422;
	bh=W9YdPO3HvLe66KxCbO2DRSUYhRq6Dwyw8iqLclB4nIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mjMeZom2YzBMQy3ABxE8GHcjGhlbUGC/7tDPgykX6NKNCQBeVVXAdy3Ra2Rofkbig
	 MH3s+iVevlnqMBa9adHSAhSCF5YgHmXwx1+ScHoS6nx/j1bXKLk8+L6QL2y+BhRu1Y
	 rSqhbb15zEhABqkUEyjhA3tSAriiP9pjkfQUbeRM=
Date: Mon, 13 Jul 2026 16:13:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry
 Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Hao Zhang
 <hao_zhang_kdev@163.com>, Hao Zhang <zhanghao1@kylinos.cn>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: pin the inode across a file folio split
Message-Id: <20260713161341.eefb7ad32bca25ffc8f3390a@linux-foundation.org>
In-Reply-To: <20260713170915.239819-1-kirill@shutemov.name>
References: <20260713170915.239819-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kirill@shutemov.name,m:david@kernel.org,m:ljs@kernel.org,m:ziy@nvidia.com,m:baolin.wang@linux.alibaba.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:hao_zhang_kdev@163.com,m:zhanghao1@kylinos.cn,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274038-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linux.alibaba.com,infradead.org,redhat.com,arm.com,linux.dev,163.com,kylinos.cn,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,shutemov.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3C8E74FA7B

On Mon, 13 Jul 2026 18:09:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kirill@shutemov.name>
> 
> __folio_split() looks up mapping = folio->mapping for a file-backed
> folio and keeps dereferencing it after the split completes:
> shmem_uncharge(mapping->host) for folios dropped beyond EOF and
> i_mmap_unlock_read(mapping) on the way out.
> 
> Nothing holds an inode reference for that duration. The split relies on
> the folio the caller keeps locked (@lock_at) to pin the inode through
> the page cache: while it is locked and present,
> truncate_inode_pages_final() in evict() cannot make progress. But the
> split drops @lock_at from the page cache when it falls beyond EOF (the
> @end handling in __folio_freeze_and_split_unmapped()), while keeping it
> locked for the caller. That removes the last pin, and a concurrent final
> iput() can then evict and RCU-free the inode before __folio_split() is
> done touching mapping.
> 
> This is reachable from memory_failure(): poisoning a tail page of a
> shmem THP that straddles EOF makes try_to_split_thp_page() split at that
> page, so the dropped @lock_at is the folio returned locked. The result
> is a use-after-free, e.g.:
> 
>   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>    i_mmap_unlock_read include/linux/fs.h:537 [inline]
>    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
> 
>   Freed by task 4601:
>    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>    i_callback+0x4c/0xa0 fs/inode.c:326
>    destroy_inode+0x144/0x1e0 fs/inode.c:402
>    evict+0x57f/0xac0 fs/inode.c:870
> 
> Pin the inode with igrab() before the split and drop the reference with
> iput() after the last mapping dereference. igrab() returns NULL only if
> the inode is already being evicted (i_count 0 and I_FREEING set), which
> a split racing eviction can observe; there is nothing safe to split
> then, so return -EBUSY, which callers already handle.

Sashiko is worried about iput() while holding folio_lock():

	https://sashiko.dev/#/patchset/20260713170915.239819-1-kirill@shutemov.name



