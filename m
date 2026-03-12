Return-Path: <stable+bounces-224903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCXULY77smmQRQAAu9opvQ
	(envelope-from <stable+bounces-224903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:44:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693A276BC5
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9DD301653F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48043FE34C;
	Thu, 12 Mar 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw4g126U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAB3F0745
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337336; cv=none; b=OvKA17QcUsW5ZiW652QH0RoSlv6LUVt4yy+uENIlg/8f2cwO42RffjBj4xdaTIH2n+FwaHnaSTEE89LlTv4ua8l26oGO14CKFm9WTGfHRnFohVt2eqUrx4RVqxv20QeSdnEs2+zh5jZb15ED6RnjQj3btifG/EOXky6UbNknpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337336; c=relaxed/simple;
	bh=KTWUl87HwagHZtitYE4k+an7GmONrvmz2HqvXZk0bP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy1VlmQGKUVbfGkWHctfaDk7SSR2BgVEKON0U08Cw97ilk5yRIgcOk13w6K+JJQoLNAeE8BZdf80oFLdyUuP01BVfwt/H2eWZfVfzmk2V20SFtbpS3ArLKTQITwTdbrDBPlYz85gsrYcHkaZ8Z5frPum39yAjlaowFIJBeGFgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw4g126U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E1C116C6;
	Thu, 12 Mar 2026 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337336;
	bh=KTWUl87HwagHZtitYE4k+an7GmONrvmz2HqvXZk0bP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cw4g126U7B0XrGJyeQlKQ8ZHVa2L0mHMb68E19RjmoPNDE+0Ar8iYOcmEUXe72pgn
	 AHI5/8oSQj8lCkvHP30lo3H3zA3vZO/8rabbPG68K/s4/BsfwK5wz8CulOz/ps8r4g
	 w5p6XMYDOQFWWuMwIK2OqIJx6z1zDJHz/Rmk0f91tQXFZN5EZroIZpin2x9wgt3XOa
	 zHm+8dy82oIXDr4TNVS1ve5jy3HCFVnwbaKnv1R8tkFKytaqINpPgPfU3FwdqczEDw
	 HwUc/Rx+bHgiLRsAjdXz8UlJa5bfMMAnbxzpVv76ygJKBevEKV/ZG02/6plYpxZQBO
	 r/WSxhsw8AldQ==
Date: Thu, 12 Mar 2026 17:42:13 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-mm@kvack.org, Jane Chu <jane.chu@oracle.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>, 
	Liu Shixin <liushixin2@huawei.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>, 
	Laurence Oberman <loberman@redhat.com>, Lance Yang <lance.yang@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 5.15.y 0/6] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
Message-ID: <c6f63b74-d532-4384-a1e6-2b0dcb7b5303@lucifer.local>
References: <2026012608-tulip-moisten-c6f6@gregkh>
 <20260218110129.41578-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218110129.41578-1-david@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-224903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1693A276BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series was sent a ~month ago, is anything holding this up? The underlying
issue is causing a really serious regression so it's quite urgent to get this
pulled ASAP :)

Thanks, Lorenzo

On Wed, Feb 18, 2026 at 12:01:23PM +0100, David Hildenbrand (Arm) wrote:
> Backport of [1] for 5.15. Backport notes are in the individual patches.
>
> I'm also including a cleanup/fix from Miaohe that makes backporting at
> least a bit easier, followed by the fix from Jane.
>
> Tested on x86-64 with the original reproducer.
>
> [1] https://lore.kernel.org/linux-mm/20251223214037.580860-1-david@kernel.org/
>
> Cc: Jane Chu <jane.chu@oracle.com>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
>
> David Hildenbrand (Red Hat) (4):
>   mm/hugetlb: fix hugetlb_pmd_shared()
>   mm/hugetlb: fix two comments related to huge_pmd_unshare()
>   mm/rmap: fix two comments related to huge_pmd_unshare()
>   mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
>     using mmu_gather
>
> Jane Chu (1):
>   mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count
>
> Miaohe Lin (1):
>   mm/hugetlb: make detecting shared pte more reliable
>
>  include/asm-generic/tlb.h |  77 ++++++++++++++++++++-
>  include/linux/hugetlb.h   |  17 +++--
>  include/linux/mm_types.h  |   1 +
>  mm/hugetlb.c              | 141 +++++++++++++++++++-------------------
>  mm/mmu_gather.c           |  33 +++++++++
>  mm/rmap.c                 |  38 +++++-----
>  6 files changed, 210 insertions(+), 97 deletions(-)
>
> --
> 2.43.0
>

