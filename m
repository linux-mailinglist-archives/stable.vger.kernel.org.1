Return-Path: <stable+bounces-56337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1F923AAC
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5685C1C2170B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46791156641;
	Tue,  2 Jul 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="z686CsZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLO0Gg8q"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C8150987
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913904; cv=none; b=ZOs1lUEM8Q+SxoyrWjTUTU+BAXChyHz+4+bkQyJfOzuoSOnKJXaTSvA/iy5wbpMQBOzMHXEpAmblVlIONyQl3CZ/kionuGUZIGx72TRPHFqbY8kio6pXhjtC6CtnMQW4D49N+NG4gbIlMA39/fPIq+LQlKcT6WubKG/834cCnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913904; c=relaxed/simple;
	bh=wG8nuJ18kEWNZxA1URtb6sRIDTEESc7DAajCKNtffJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR0MWp3qb4yzaWisJ1noNX9ziuHeketG5ZGRq6KVLA+oDSU/Pz2Nfx/KemfFKjqYBKXJ6xrdCXKfVSFs+hnn25uQekzGjc5PGdEOSGHck6aB4hZ1iZucklI3DM+5acrqDR4pqw43QFJ+9ltXxdyCzR3atcpQHZMrzda/5jCsB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=z686CsZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLO0Gg8q; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 11A9A114030B;
	Tue,  2 Jul 2024 05:51:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Jul 2024 05:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719913902; x=1720000302; bh=1q/f/Z3aXa
	3glDkoIJDX+geb/b6FQVyqlSoz/L30IIY=; b=z686CsZaShYywBu1z1jCuLv0f9
	wLETV1c4jptXWkXlH3T3SeKOY3KuuHp4vcUH1jdZj6GkVYQzvC1W5HcuwoZSBB89
	+80hkbejupF0u33DhvQwwNTmZgtrcKd7tYLIw07s8zIQvkfDW9H0pTbr0zltWitX
	a/3FGjnRY8vEol25YshJnw6fUnoevrEwSijXC/9p8xzDim831t9xSc3+lHz5e/KB
	whOOiOjy0hp1v4LUGxNtvenJg89o30UkESKzaoCQ4C6wBntCrnaaTen7IbMWO0Uy
	SG/c/5RLl5IawLZugHtowmwsoTOK3ecuW1Tet+AsIT8qUkSgSE1tXmL/poYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719913902; x=1720000302; bh=1q/f/Z3aXa3glDkoIJDX+geb/b6F
	QVyqlSoz/L30IIY=; b=RLO0Gg8qdxbUQBiUgb69qwuy/TGTrIYZv7/cRfRqqxAp
	jguSf3ZVeC8r0jiwbsinxVedAvbPRYRCr2mZG4KqGwqWf2QMAPhfN3cUcvrx/tz3
	+n9dMN+gaNLxqoR1OHyO81Dj6G6V66NojleLQ4ZJYqXE+k213LKLO5zo2ZK4LW9R
	qDeZ9juGbx3v4z5/VqN6/vpCxtFLxPN7GH1oMuT/YkmtAFwp7kUggX9MINfh5TnI
	PVjEyVgGQJXmg0DVZU1Lk+QYz17kYbZDy1VTVEEjWxv1t++u79VVFFdF4RAfeKKP
	cPxGAsFHLX6PP7eST3pkSxnTKA0FTBADmn3DQSWrhQ==
X-ME-Sender: <xms:rc2DZqBeRamfB6drvSN8KOv9d4hmtym0IuPf1D8GFzWj_0kATq-6pQ>
    <xme:rc2DZkgmA6l2AVIWNc90HcCgDTg6UcDGmO6JoGiEMFyiQQXofsxXXJVbeA4FarbKb
    Qe7q71GDyjh6A>
X-ME-Received: <xmr:rc2DZtlUfHzLp6VRP3MWmRgA3UZJNqTodUpHYaaHy5nwJzbVewX_jO-Kijce0lfRLnxVH0J30WEVYumJf67DJwuAbafCUY1j2kA9zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiff
    dvudeffeelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:rc2DZoyCGmDJ13FFFmTC-iF64cidJnT6WP6YF-l6VufTIsQvZFd-8g>
    <xmx:rc2DZvQh57ke2SJCb38RXUZlHkXhnTvTBqbfHUBRx7KLijp-T_0HPg>
    <xmx:rc2DZjZJwTWRMChPdqqoCxZ4kiOIEpRHxLEVKjs1JUVMk3-1wZYkcg>
    <xmx:rc2DZoRBeE8BJbImJK6Is4QtjqVL-NYcj0fJMup-FRfyqykDWG6icw>
    <xmx:rs2DZrrOdYKKYOoZgxd9UFTm0tW4-hT2Fy3VVRjXuOO3V8Df_0PWZ32a>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 05:51:40 -0400 (EDT)
Date: Tue, 2 Jul 2024 11:51:37 +0200
From: Greg KH <greg@kroah.com>
To: yangge1116@126.com
Cc: stable@vger.kernel.org, 21cnbao@gmail.com, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
	liuzixing@hygon.cn
Subject: Re: [PATCH 6.1.y] mm/page_alloc: Separate THP PCP into movable and
 non-movable categories
Message-ID: <2024070229-gliding-onion-3759@gregkh>
References: <2024070129-movable-commend-1b2a@gregkh>
 <1719892819-2868-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719892819-2868-1-git-send-email-yangge1116@126.com>

On Tue, Jul 02, 2024 at 12:00:19PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type of
> pages in THP-sized PCP list, it's possible that non-movable allocation
> requests may get a CMA page from the list, in some cases, it's not
> acceptable.
> 
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> machine with device passthrough will get stuck.  During starting the
> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
> ...) to pin memory.  Normally if a page is present and in CMA area,
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> area because of FOLL_LONGTERM flag.  But if non-movable allocation
> requests return CMA memory, migrate_longterm_unpinnable_pages() will
> migrate a CMA page to another CMA page, which will fail to pass the check
> in check_and_migrate_movable_pages() and cause migration endless.
> 
> Call trace:
> pin_user_pages_remote
> --__gup_longterm_locked // endless loops in this function
> ----_get_user_pages_locked
> ----check_and_migrate_movable_pages
> ------migrate_longterm_unpinnable_pages
> --------alloc_migration_target
> 
> This problem will also have a negative impact on CMA itself.  For example,
> when CMA is borrowed by THP, and we need to reclaim it through cma_alloc()
> or dma_alloc_coherent(), we must move those pages out to ensure CMA's
> users can retrieve that contigous memory.  Currently, CMA's memory is
> occupied by non-movable pages, meaning we can't relocate them.  As a
> result, cma_alloc() is more likely to fail.
> 
> To fix the problem above, we add one PCP list for THP, which will not
> introduce a new cacheline for struct per_cpu_pages.  THP will have 2 PCP
> lists, one PCP list is used by MOVABLE allocation, and the other PCP list
> is used by UNMOVABLE allocation.  MOVABLE allocation contains GPF_MOVABLE,
> and UNMOVABLE allocation contains GFP_UNMOVABLE and GFP_RECLAIMABLE.
> 
> Link: https://lkml.kernel.org/r/1718845190-4456-1-git-send-email-yangge1116@126.com
> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
> Signed-off-by: yangge <yangge1116@126.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit bf14ed81f571f8dba31cd72ab2e50fbcc877cc31)
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  include/linux/mmzone.h | 9 ++++-----
>  mm/page_alloc.c        | 8 ++++++--
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 

All now queued up, thanks.

greg k-h

