Return-Path: <stable+bounces-181590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4CB98F9A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504387AAC11
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160762D0601;
	Wed, 24 Sep 2025 08:50:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F2C326E;
	Wed, 24 Sep 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703809; cv=none; b=cbixRdedkSyu2IpxWo2wcvcIeiwfzNxhhOoar8BilXiPUkdlyHAgnA+yF0BPP3r5gOO5eJODmH915gvH9pleB8VllvE34pwFvttDjsFJcGtN3kWbcv2pIO9U5IC5oyToWsAZthxJc1OixNxD7VfJzOSwzUYPPm1S9QiTKiTR150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703809; c=relaxed/simple;
	bh=0vYU8utqlJ7TvWiNebrwWUwVSsKdsZJI0lb3s0ESU4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txExiWlT0t48CnfXhcUiKfMhosR6MVaoO4Vqligpdo5Su1K6F6oD6wOSucuVYzNfc5LXrf0FE60t08C0IBTMfnlWj1Ya5U6CyIsU+Fga7SBGhWj22KtCE2Hpw05B/3V3Y50qak/EBRJK8qN47Pr/nFERhfuD1UCsRr1M6CFeZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E087DC4CEE7;
	Wed, 24 Sep 2025 08:50:02 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:50:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, usamaarif642@gmail.com,
	yuzhao@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	baohua@kernel.org, voidice@gmail.com, Liam.Howlett@oracle.com,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
	surenb@google.com, hughd@google.com, willy@infradead.org,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, qun-wei.lin@mediatek.com,
	Andrew.Yang@mediatek.com, casper.li@mediatek.com,
	chinwen.chang@mediatek.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Message-ID: <aNOwuKmbAaMaEMb7@arm.com>
References: <20250922021458.68123-1-lance.yang@linux.dev>
 <aNGGUXLCn_bWlne5@arm.com>
 <a3412715-6d9d-4809-9588-ba08da450d16@redhat.com>
 <aNKJ5glToE4hMhWA@arm.com>
 <aNLHexcNI53HQ46A@arm.com>
 <f2fe9c01-2a8d-4de9-abd5-dbb86d15a37b@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2fe9c01-2a8d-4de9-abd5-dbb86d15a37b@linux.dev>

On Wed, Sep 24, 2025 at 10:49:27AM +0800, Lance Yang wrote:
> On 2025/9/24 00:14, Catalin Marinas wrote:
> > So alternative patch that also fixes the deferred struct page init (on
> > the assumptions that the zero page is always mapped as pte_special():
> 
> I can confirm that this alternative patch also works correctly; my tests
> for MTE all pass ;)

Thanks Lance for testing. I'll post one of the variants today.

> This looks like a better fix since it solves the boot hang issue too.

In principle, yes, until I tracked down why I changed it in the first
place - 68d54ceeec0e ("arm64: mte: Allow PTRACE_PEEKMTETAGS access to
the zero page"). ptrace() can read tags from PROT_MTE mappings and we
want to allow reading zeroes as well if the page points to the zero
page. Not flagging the page as PG_mte_tagged caused issues.

I can change the logic in the ptrace() code, I just need to figure out
what happens to the huge zero page. Ideally we should treat both in the
same way but, AFAICT, we don't use pmd_mkspecial() on the huge zero
page, so it gets flagged with PG_mte_tagged.

If I go with the first fix for the page merging, I'll look to defer the
zero page initialisation post page_alloc_init_late() in a separate
patch.

-- 
Catalin

