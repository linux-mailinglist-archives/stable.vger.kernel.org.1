Return-Path: <stable+bounces-195626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFAC794FC
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 001A4364C0C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90D26E6F4;
	Fri, 21 Nov 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnvEJpKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AA1F09AC
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731210; cv=none; b=mgneOAggIZaITXesnKaThv64nVA9QWy+4NaEQma5nXFJo8kSmF8jq3SKVQQZHXfBZ7mK90aNR2s4FY3WCybAvUmlRNEe7sK253CpwbesRfBn7H9718we4zJt1tTNQKO3wuXcERAL7iJOzYziZv81aMl/fqZ2wIojjK5U9Kw1HKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731210; c=relaxed/simple;
	bh=cVTX0pS1+/2gdB6UfK+cy83GrQRiWSCQUkL+jm52ZPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gks80yTIGRcbJbrzkPMIjraM45wAnZh/igPt4CCW+l1+XauGhdX8u7Fakmw3VSbKim4a4SKlQ6A4mp9KvnvtBq/xsueTZusEFd0VxZDQkLPEpzEvlAL3myIMMlpkAMtMtn6EYl5Snz2DwGE1mmnpFDEK/8HDUm1Sl1PHwRsczrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnvEJpKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A67CC4CEF1;
	Fri, 21 Nov 2025 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763731209;
	bh=cVTX0pS1+/2gdB6UfK+cy83GrQRiWSCQUkL+jm52ZPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnvEJpKTDrQ8Ge8q0wBBbUZls6l0OixMTYz8RMu5JLww4j7LCi+oQatbdqFc2HtKz
	 +IIj/pBORvPLvxXPLBKs1dKJ6yF6Ow5hN0Z8oXCRag1PF3VjuQFv+h38DuoucU7xHw
	 GP69F5UTjRK2DHk38V4qHMJkAcG0DcPFDFOg6Gs9gbzFbTDZwVt8MGfeRsLeVM6QiG
	 0zG2+Y2iMe9frSHKj7moY1+IDdzCpRCWGkYSH9XTJDCmgwnAidIkhyU98Xr+5UYA7i
	 HYx4bByJjpgi5nLXLpxl25X70J8elCG7+az68OkGeWmHJPdkjcHuAp/DdAxX1xh03D
	 iJ3JIh6HjWJjQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 616B4F40079;
	Fri, 21 Nov 2025 08:20:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 08:20:08 -0500
X-ME-Sender: <xms:CGcgaYy3hNw_S9JIrhXpIvwX_c2KjdHKMmpyrZi7Revg5RC38FnkTA>
    <xme:CGcgaSbSBLxgsIKY4D4Q5vns-WgA5Z7RVUHTaKJlvKFcsLY66r0_MCArNglnJjpLH
    S0VtYtIZPXs0Bly8Fpu614bRQCr1HCFM0P6Q0_2uxwyI24BqQH5NgY>
X-ME-Received: <xmr:CGcgaQ1QFdxTlYkVueUH6TYu4b34F2xI1YrRjIUhBkojOw9Z39_SEYj5VP0UeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedttdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CGcgaQhZk707XZirGKo13fVqyQlPtE3nktDRP7e2j_xx-dg4Chvqkg>
    <xmx:CGcgado3IfAJx5Lv3oDaTzZi0zRTN9M6eqwhyQcYy6l0iADCySc8Ig>
    <xmx:CGcgaawMvuPxd4lJvtCIqTUP8MnNi-VbqAiNGLv8jR9XiiHKH4UQtw>
    <xmx:CGcgaQmUiyBf_XUHgYHBABFWstlP-QZf_WaangxzpxmPBm8wjmILQw>
    <xmx:CGcgaT0OTcsXhwade5AGFA87fLwV4vDcrjJYKphIqCnVCUODb0XXiuT3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 08:20:07 -0500 (EST)
Date: Fri, 21 Nov 2025 13:20:06 +0000
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
Message-ID: <jqmjjsedulkfhgisw4zrzbkuya34bdh6bvzzpdvo2v6jzbfxsy@qsonu7ijsmva>
References: <2025112037-resurface-backlight-da75@gregkh>
 <20251120165221.892852-1-kas@kernel.org>
 <2025112149-antirust-saggy-93e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025112149-antirust-saggy-93e1@gregkh>

On Fri, Nov 21, 2025 at 10:46:11AM +0100, Greg KH wrote:
> On Thu, Nov 20, 2025 at 04:52:21PM +0000, Kiryl Shutsemau wrote:
> > Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> > supposed to generate SIGBUS.
> > 
> > This behavior might not be respected on truncation.
> > 
> > During truncation, the kernel splits a large folio in order to reclaim
> > memory.  As a side effect, it unmaps the folio and destroys PMD mappings
> > of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
> > are preserved.
> > 
> > However, if the split fails, PMD mappings are preserved and the user will
> > not receive SIGBUS on any accesses within the PMD.
> > 
> > Unmap the folio on split failure.  It will lead to refault as PTEs and
> > preserve SIGBUS semantics.
> > 
> > Make an exception for shmem/tmpfs that for long time intentionally mapped
> > with PMDs across i_size.
> > 
> > Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
> > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Liam Howlett <liam.howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit fa04f5b60fda62c98a53a60de3a1e763f11feb41)
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > ---
> 
> Does not apply to 6.17.y at all :(
> 
> Did you forget to apply this on top of other commits?

Hm. It applies cleanly on v6.17.8:

❯ git log -1 --oneline @
8ac42a63c561 (HEAD) Linux 6.17.8
❯ b4 shazam 20251120165221.892852-1-kas@kernel.org
Grabbing thread from lore.kernel.org/all/20251120165221.892852-1-kas@kernel.org/t.mbox.gz
Breaking thread to remove parents of 20251120165221.892852-1-kas@kernel.org
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Analyzing 1 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] mm/truncate: unmap large folio on split failure
  ---
  ✓ Signed: DKIM/kernel.org
---
Total patches: 1
---
Applying: mm/truncate: unmap large folio on split failure

Do you have anything on top of v6.17.8 in your 6.17.y queue?

My other backport to 6.17.y doesn't interfere with the patch either.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

