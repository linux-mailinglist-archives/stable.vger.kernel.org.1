Return-Path: <stable+bounces-196484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A7C7A237
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA4584F5201
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711230EF7F;
	Fri, 21 Nov 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeuwoutZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C19DF6A
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734630; cv=none; b=W2uHF6dLT7A3Y/WqLUWDZHBCTz7jbbSZuZ6/m3SHtOC1Gsne1UR8h0ygEu0qkhOuEtxR2aqFso3Dg6TZNrfSpU1ywRPHk5MY2TSofhFGLwzlkSlSNEuuCTfhp/Cz2xKHaVlO6cn/D948pnSSU8mC0CRG47T+F34gKGJ0yrYAz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734630; c=relaxed/simple;
	bh=ytbbWReDTIKyeeb0o9yP5ClBu4PIxO+e4Wl+WiWLdk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW40mBRDPAkBq49BMZ1E7LF7jZdFZo33xWQHx1RpBosP88p2VGSxAM5dTh6/NHjPvz65/AHtGA8dRXS3ljwYZ2RgVliDOKgKBO9BG3Um2Y3st+C4sFoTgWJ9xiMF4Hr0Bza0OthmI8pM1J15Kg4vz7bnOfmah/8LY/8OUXILhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeuwoutZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEDC4CEFB;
	Fri, 21 Nov 2025 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763734628;
	bh=ytbbWReDTIKyeeb0o9yP5ClBu4PIxO+e4Wl+WiWLdk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeuwoutZu3OI80bQVIjok59/iPnKkwNe08sQm54DmoEB2AtJ/0FIf1JZur1Ci7HWI
	 07nawA6EA+w0Hk6R7G+uXX0JWvGzSpYk+6/+yxAQLns8DbxKwuJgRKFhx6ecWbPSvP
	 /W/N2gT6g943gbICTC3k85yYv/VjsbYKM3Nt6mDMP46sqIh0mI2CXIoXW4fSht35bX
	 j1nFIXeoQGEO3eWTW3ahwch3c1hXzU2wgxcqPwoqEbwJkHAQn+mAHGIV8aof4qlDO3
	 kcJxXeTfA96O2I8a1/Lah68RdWy3+Qwn+o1t5JRS6yd856cAndngtBokrqFUUlQ5jl
	 SaE7Xn3ebcyEA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E43BF40076;
	Fri, 21 Nov 2025 09:17:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 09:17:07 -0500
X-ME-Sender: <xms:YnQgaaDWUzYceAhrQMAluGAT-CZ13619vNQM8Fbn_8L0uXNGplrp5Q>
    <xme:YnQgaaoFkQ0dllmQ0rLrodxYtSD_GvMqLV1lYILHfvFw5xEIAzpewwteuekx-VSw_
    0yKJ9iZi31meB6twQfwRLUj1kSHFI_f57sCcQRcAsHhSIBSMF1jOW0>
X-ME-Received: <xmr:YnQgaUHXv4DOOvVimUYfywUCaib8oebZuSDce7wLrH1XpV2vWS3BhYBCfs-QZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpefggfektdeileehffdtgeejteffgfdtjeefffdvleduheelkeehgefgfedtudev
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppe
    hkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohep
    gedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidroh
    hrghdruhhkpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgs
    rggsrgdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhi
    ugesfhhrohhmohhrsghithdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrth
    drtghomhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:YnQgaSyil8sAOKh9Jxv7Y5fkkgTu06XKHJC5Y4erivpUufwuTgrbgw>
    <xmx:YnQgaS602ma-RrffvINPqmOoKyrbkxIV7XCYf2BB141RK1u-IrJlkg>
    <xmx:YnQgaXB024v0BYU2k23tEYgyU2M7MsJJ_uVhOzm8CXWFIwfHowgM5g>
    <xmx:YnQgaX3a-sAQTvDiBNLAAze8fx1Duivu4NxhaWV3Ylt6HplFtK0mJA>
    <xmx:Y3QgaaFF6p6HAzjptj49GuvFby2tliSavIrDBrDQYrfUNGlkDZdnjWUY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 09:17:06 -0500 (EST)
Date: Fri, 21 Nov 2025 14:17:05 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.17.y] mm/truncate: unmap large folio on split failure
Message-ID: <47zyadovna3yarouvvqrrqlvx7vxb5uul5muwjr4h25mqoyhl4@rdtannv4llvv>
References: <2025112037-resurface-backlight-da75@gregkh>
 <20251120165221.892852-1-kas@kernel.org>
 <2025112149-antirust-saggy-93e1@gregkh>
 <jqmjjsedulkfhgisw4zrzbkuya34bdh6bvzzpdvo2v6jzbfxsy@qsonu7ijsmva>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jqmjjsedulkfhgisw4zrzbkuya34bdh6bvzzpdvo2v6jzbfxsy@qsonu7ijsmva>

On Fri, Nov 21, 2025 at 01:20:08PM +0000, Kiryl Shutsemau wrote:
> On Fri, Nov 21, 2025 at 10:46:11AM +0100, Greg KH wrote:
> > On Thu, Nov 20, 2025 at 04:52:21PM +0000, Kiryl Shutsemau wrote:
> > > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > > supposed to generate SIGBUS.
> > > 
> > > This behavior might not be respected on truncation.
> > > 
> > > During truncation, the kernel splits a large folio in order to reclaim
> > > memory.  As a side effect, it unmaps the folio and destroys PMD mappings
> > > of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
> > > are preserved.
> > > 
> > > However, if the split fails, PMD mappings are preserved and the user will
> > > not receive SIGBUS on any accesses within the PMD.
> > > 
> > > Unmap the folio on split failure.  It will lead to refault as PTEs and
> > > preserve SIGBUS semantics.
> > > 
> > > Make an exception for shmem/tmpfs that for long time intentionally mapped
> > > with PMDs across i_size.
> > > 
> > > Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
> > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Liam Howlett <liam.howlett@oracle.com>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > (cherry picked from commit fa04f5b60fda62c98a53a60de3a1e763f11feb41)
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > ---
> > 
> > Does not apply to 6.17.y at all :(
> > 
> > Did you forget to apply this on top of other commits?
> 
> Hm. It applies cleanly on v6.17.8:
> 
> ❯ git log -1 --oneline @
> 8ac42a63c561 (HEAD) Linux 6.17.8
> ❯ b4 shazam 20251120165221.892852-1-kas@kernel.org
> Grabbing thread from lore.kernel.org/all/20251120165221.892852-1-kas@kernel.org/t.mbox.gz
> Breaking thread to remove parents of 20251120165221.892852-1-kas@kernel.org
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 2 messages in the thread
> Analyzing 1 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH] mm/truncate: unmap large folio on split failure
>   ---
>   ✓ Signed: DKIM/kernel.org
> ---
> Total patches: 1
> ---
> Applying: mm/truncate: unmap large folio on split failure
> 
> Do you have anything on top of v6.17.8 in your 6.17.y queue?
> 
> My other backport to 6.17.y doesn't interfere with the patch either.

I see 6.17.9-rc1 includes

	53241caf24c7 ("mm/huge_memory: do not change split_huge_page*() target order silently")

With the patch applied, fa04f5b60fda ("mm/truncate: unmap large folio on
split failure") can be cherry-picked cleanly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

