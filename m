Return-Path: <stable+bounces-5523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E180D524
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5838B20E15
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDA51015;
	Mon, 11 Dec 2023 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCI7VU2q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694B5100B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 18:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF3C433C8;
	Mon, 11 Dec 2023 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702318728;
	bh=bbTxAMGuUPDt2FFN8JV08W+1k29jKmN/sYxkQ7BQNdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCI7VU2qvR5eczy1v0uNPwnPCDAAFfkicEtWXDMm4u3K/BP9iiem1N9VPw7IwOXiF
	 hSBQEBNugxpDEifv8ktnJzaSOIjEbkjJlCRKDU7iRFpDu1fF2gJETZwTBDhfRq3b5F
	 4zuygS2VtzjbS54xOqPSkqOF4Uhy09IMUVcg6yHM=
Date: Mon, 11 Dec 2023 19:18:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	willy@infradead.org, akpm@linux-foundation.org, david@redhat.com,
	jannh@google.com,
	=?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>,
	kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 5.15.y] mm: fix oops when filemap_map_pmd) without
 prealloc_pte
Message-ID: <2023121137-spur-juniper-d8bc@gregkh>
References: <b7fc5151-3d73-b6ca-ce28-f4a4556294bb@google.com>
 <2023121120-degree-target-cd18@gregkh>
 <ac3262ba-7398-eef1-1d80-8425e394dc6f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac3262ba-7398-eef1-1d80-8425e394dc6f@google.com>

On Mon, Dec 11, 2023 at 09:18:06AM -0800, Hugh Dickins wrote:
> On Mon, 11 Dec 2023, Greg KH wrote:
> > On Sat, Dec 09, 2023 at 09:18:42PM -0800, Hugh Dickins wrote:
> > > syzbot reports oops in lockdep's __lock_acquire(), called from
> > > __pte_offset_map_lock() called from filemap_map_pages(); or when I run the
> > > repro, the oops comes in pmd_install(), called from filemap_map_pmd()
> > > called from filemap_map_pages(), just before the __pte_offset_map_lock().
> > > 
> > > The problem is that filemap_map_pmd() has been assuming that when it finds
> > > pmd_none(), a page table has already been prepared in prealloc_pte; and
> > > indeed do_fault_around() has been careful to preallocate one there, when
> > > it finds pmd_none(): but what if *pmd became none in between?
> > > 
> > > My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made it
> > > easy for *pmd to be cleared while servicing a page fault; but even before
> > > those, a huge *pmd might be zapped while a fault is serviced.
> > > 
> > > The difference in symptomatic stack traces comes from the "memory model"
> > > in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
> > > models that is strict, and will oops on the NULL prealloc_pte; in other
> > > models, it will construct a bogus value to be populated into *pmd, then
> > > __pte_offset_map_lock() oops when trying to access split ptlock pointer
> > > (or some other symptom in normal case of ptlock embedded not pointer).
> > > 
> > > Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarinen@foxhound.fi/
> > > Link: https://lkml.kernel.org/r/6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com
> > > Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@google.com/
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Cc: Jann Horn <jannh@google.com>,
> > > Cc: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: <stable@vger.kernel.org>    [5.12+]
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > (cherry picked from commit 9aa1345d66b8132745ffb99b348b1492088da9e2)
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > >  mm/filemap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > 
> > Now queued up, thanks.
> > 
> > greg k-h
> 
> Thanks Greg: but Sasha appears to have a competing queue, in which
> he's cherry-picked in a dependency from 5.16 ahead of a clean
> cherry-pick for this one.
> 
> He posted his the next day: I expect it's more to your taste (pull
> in dependency rather than edit cherry-pick) and it looked fine to me.
> Please sort out with Sasha which goes forward, either will do.

I dropped his version and took yours :)

