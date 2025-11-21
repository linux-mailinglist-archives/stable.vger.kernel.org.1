Return-Path: <stable+bounces-195482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7EC7839F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52B44E9634
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B83126CC;
	Fri, 21 Nov 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gclqJUBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD02F3632
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718375; cv=none; b=IpZnFu0KrGSnZMTif42N3JbD06lWrBOsSFoacHiwwsYw4IWWsQnJ9wAifMj9hcRfGC/wFCCB90bBw6NyHtUMMyg+LsZ1gdlYR1RZa0BtZe25dt9gmwwW3BFClivJXq9OFTwCQj+bMiY8qC5vnS6xzExfinOZkhA02J760A91O+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718375; c=relaxed/simple;
	bh=ctITErH5aUw2ZjJBqCTspU0fxJuVrUxQTUxkeQkRoXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to1dFHIYGTR4aTKCqs4Xk/b/AghYwM6n5Vwmk+/rsaFXy4reihc59HbyFnPF/0mpIiMNHCSzVpmRkx6H9edMwo0Cy8BvR9b01r3vAcF5BSEPSbXADm4fF4B/GZITAk6DsCg8IcKUd4coKgeFa9S937B0kAwtXL93zEyEeJidsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gclqJUBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D066AC4CEF1;
	Fri, 21 Nov 2025 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763718374;
	bh=ctITErH5aUw2ZjJBqCTspU0fxJuVrUxQTUxkeQkRoXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gclqJUBeZNVhyW6Og1NFEQf42kixLrZSpgZnZQktNZ7DcmWuAdw2s6UMyUpIJmkjC
	 O4INEfpDxCaUK6K60Hz2iNkCczFZOrbeXLtSidUXRL298VnTEgLB94uuLWFCHjFD7r
	 mIzi4YdehciuzUcnzo03Vu72A9ZVhABBemjBDYtM=
Date: Fri, 21 Nov 2025 10:46:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.17.y] mm/truncate: unmap large folio on split failure
Message-ID: <2025112149-antirust-saggy-93e1@gregkh>
References: <2025112037-resurface-backlight-da75@gregkh>
 <20251120165221.892852-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120165221.892852-1-kas@kernel.org>

On Thu, Nov 20, 2025 at 04:52:21PM +0000, Kiryl Shutsemau wrote:
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> This behavior might not be respected on truncation.
> 
> During truncation, the kernel splits a large folio in order to reclaim
> memory.  As a side effect, it unmaps the folio and destroys PMD mappings
> of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
> are preserved.
> 
> However, if the split fails, PMD mappings are preserved and the user will
> not receive SIGBUS on any accesses within the PMD.
> 
> Unmap the folio on split failure.  It will lead to refault as PTEs and
> preserve SIGBUS semantics.
> 
> Make an exception for shmem/tmpfs that for long time intentionally mapped
> with PMDs across i_size.
> 
> Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
> Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit fa04f5b60fda62c98a53a60de3a1e763f11feb41)
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

Does not apply to 6.17.y at all :(

Did you forget to apply this on top of other commits?

thanks,

greg k-h

