Return-Path: <stable+bounces-197093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B6C8E4C1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1A2C4E7999
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB1320A20;
	Thu, 27 Nov 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHMIMHsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D9330B02
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247451; cv=none; b=gLOXKX5u6m7f9/FfLck5eNX5EtshGP9EX/V1b/0aSFic5GmvNnBFz01qJ6VjqF8MuV38DD9iyfq4wQByILAIQC7X89R0NXqu9bFvuTT2+GKui+aRgWxwYGiFUFjnXEwHNnlM1KFgmJEwpBy59fGOFsKsBMU9LJI8bGAG/7fSkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247451; c=relaxed/simple;
	bh=iY6rQlF0uHyCL7o5ZtmSAqtJ0UExg/JQNZFaf4VsnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC3SdBp8NJrm76sSw/soQl8Vt/0X1pvBwYRVs+4RQZS9nPCr7Ls9FQytdnphRVmAeZZqqYSXJ+hnVgIzI4Ftrt9783EUW4e3MZrO2vmtKRtfguHMQ+8pUCeIp90kObYiY9f5gn6c7zqo5WqkO9Nog5Ue/aBBH/Bz0/askRxKgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHMIMHsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B8C4CEF8;
	Thu, 27 Nov 2025 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764247451;
	bh=iY6rQlF0uHyCL7o5ZtmSAqtJ0UExg/JQNZFaf4VsnAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHMIMHsX4R+MBfoesW2m8Twa/IdWaMMcQLET0BVc0S9P/HBY2npI3Hx7jPwOZp1yD
	 qzL1LLjBuOsFqcZNgKRbQ+rJrYqcgWRpVU4IZ99qCgRAc5hJa7ymiOBr9GSwPVurYl
	 teyPFqZw2rcDC+ib9Sffa2ACNXZqfvG0wkwXI+0Y=
Date: Thu, 27 Nov 2025 13:44:08 +0100
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
Message-ID: <2025112702-unrobed-recall-4fdc@gregkh>
References: <2025112037-resurface-backlight-da75@gregkh>
 <20251120165221.892852-1-kas@kernel.org>
 <2025112149-antirust-saggy-93e1@gregkh>
 <jqmjjsedulkfhgisw4zrzbkuya34bdh6bvzzpdvo2v6jzbfxsy@qsonu7ijsmva>
 <47zyadovna3yarouvvqrrqlvx7vxb5uul5muwjr4h25mqoyhl4@rdtannv4llvv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47zyadovna3yarouvvqrrqlvx7vxb5uul5muwjr4h25mqoyhl4@rdtannv4llvv>

On Fri, Nov 21, 2025 at 02:17:05PM +0000, Kiryl Shutsemau wrote:
> On Fri, Nov 21, 2025 at 01:20:08PM +0000, Kiryl Shutsemau wrote:
> > On Fri, Nov 21, 2025 at 10:46:11AM +0100, Greg KH wrote:
> > > On Thu, Nov 20, 2025 at 04:52:21PM +0000, Kiryl Shutsemau wrote:
> > > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > > supposed to generate SIGBUS.
> > > > 
> > > > This behavior might not be respected on truncation.
> > > > 
> > > > During truncation, the kernel splits a large folio in order to reclaim
> > > > memory.  As a side effect, it unmaps the folio and destroys PMD mappings
> > > > of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
> > > > are preserved.
> > > > 
> > > > However, if the split fails, PMD mappings are preserved and the user will
> > > > not receive SIGBUS on any accesses within the PMD.
> > > > 
> > > > Unmap the folio on split failure.  It will lead to refault as PTEs and
> > > > preserve SIGBUS semantics.
> > > > 
> > > > Make an exception for shmem/tmpfs that for long time intentionally mapped
> > > > with PMDs across i_size.
> > > > 
> > > > Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
> > > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> > > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Liam Howlett <liam.howlett@oracle.com>
> > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Mike Rapoport <rppt@kernel.org>
> > > > Cc: Rik van Riel <riel@surriel.com>
> > > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > (cherry picked from commit fa04f5b60fda62c98a53a60de3a1e763f11feb41)
> > > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > > ---
> > > 
> > > Does not apply to 6.17.y at all :(
> > > 
> > > Did you forget to apply this on top of other commits?
> > 
> > Hm. It applies cleanly on v6.17.8:
> > 
> > ❯ git log -1 --oneline @
> > 8ac42a63c561 (HEAD) Linux 6.17.8
> > ❯ b4 shazam 20251120165221.892852-1-kas@kernel.org
> > Grabbing thread from lore.kernel.org/all/20251120165221.892852-1-kas@kernel.org/t.mbox.gz
> > Breaking thread to remove parents of 20251120165221.892852-1-kas@kernel.org
> > Checking for newer revisions
> > Grabbing search results from lore.kernel.org
> > Analyzing 2 messages in the thread
> > Analyzing 1 code-review messages
> > Checking attestation on all messages, may take a moment...
> > ---
> >   ✓ [PATCH] mm/truncate: unmap large folio on split failure
> >   ---
> >   ✓ Signed: DKIM/kernel.org
> > ---
> > Total patches: 1
> > ---
> > Applying: mm/truncate: unmap large folio on split failure
> > 
> > Do you have anything on top of v6.17.8 in your 6.17.y queue?
> > 
> > My other backport to 6.17.y doesn't interfere with the patch either.
> 
> I see 6.17.9-rc1 includes
> 
> 	53241caf24c7 ("mm/huge_memory: do not change split_huge_page*() target order silently")
> 
> With the patch applied, fa04f5b60fda ("mm/truncate: unmap large folio on
> split failure") can be cherry-picked cleanly.

Ah, that worked, thanks!

greg k-h

