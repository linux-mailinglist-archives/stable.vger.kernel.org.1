Return-Path: <stable+bounces-94112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E89D3AB0
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4D2B21C07
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06E19C542;
	Wed, 20 Nov 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifki3lrh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE588F77;
	Wed, 20 Nov 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105975; cv=none; b=JyHB4C2ppTW3xM2fmZbakxpLwMItC0PYOtlSNnU7dm9HSPyyWtdGgoz7XkvAsr/mMxpk1FAUSLWnKsX/2K1MlqqU/XgVd3v87mG26szi8Gvnpnzw6v8faRUXkc3bOx6WsxZ6d32G7TGxvUNdMV2DEBzF1OcHaHdwaJmbz9sGzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105975; c=relaxed/simple;
	bh=BORz0CF2IQbmXcz7O43m7nZi39ZyC2WsbFBh0jgAF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJusLqmWlZ430jL09ALU0douVZ3M6Adf/Zu4uaZQy5JgOx2ymv3B+d0+tjg7jEw9rOjQ12xSu/a6EKWrdr30XdwKCXMEHTX0ZdwdLWYNZsQnynqBSVbs4IuULSO2k4CkRLnTUR7cdfNNhOQw4hk6WeuAXBMdeTzSJ4iNpcuLPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifki3lrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C67C4CECD;
	Wed, 20 Nov 2024 12:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732105974;
	bh=BORz0CF2IQbmXcz7O43m7nZi39ZyC2WsbFBh0jgAF0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifki3lrhQlZVPwe2jnQyj376Q5qQ+8rXgBboUtAMtC4UCWqVr2H17dMRQbS/v4gvJ
	 ls8/EVH2agddzteywUb0iuAuWFdE7Ks5lnReoSNK+GepmfORFLrS+4LpZFeYf7ZaUD
	 dSfPyxbOHZk5KzMmThPE9ZoLc99l6K671GQhDOZo=
Date: Wed, 20 Nov 2024 13:32:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.12.y v2] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <2024112019-skating-goofball-d2be@gregkh>
References: <20241119175945.2600945-1-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119175945.2600945-1-Liam.Howlett@oracle.com>

On Tue, Nov 19, 2024 at 12:59:45PM -0500, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The mmap_region() function tries to install a new vma, which requires a
> pre-allocation for the maple tree write due to the complex locking
> scenarios involved.
> 
> Recent efforts to simplify the error recovery required the relocation of
> the preallocation of the maple tree nodes (via vma_iter_prealloc()
> calling mas_preallocate()) higher in the function.
> 
> The relocation of the preallocation meant that, if there was a file
> associated with the vma and the driver call (mmap_file()) modified the
> vma flags, then a new merge of the new vma with existing vmas is
> attempted.
> 
> During the attempt to merge the existing vma with the new vma, the vma
> iterator is used - the same iterator that would be used for the next
> write attempt to the tree.  In the event of needing a further allocation
> and if the new allocations fails, the vma iterator (and contained maple
> state) will cleaned up, including freeing all previous allocations and
> will be reset internally.
> 
> Upon returning to the __mmap_region() function, the error is available
> in the vma_merge_struct and can be used to detect the -ENOMEM status.
> 
> Hitting an -ENOMEM scenario after the driver callback leaves the system
> in a state that undoing the mapping is worse than continuing by dipping
> into the reserve.
> 
> A preallocation should be performed in the case of an -ENOMEM and the
> allocations were lost during the failure scenario.  The __GFP_NOFAIL
> flag is used in the allocation to ensure the allocation succeeds after
> implicitly telling the driver that the mapping was happening.
> 
> The range is already set in the vma_iter_store() call below, so it is
> not necessary and is dropped.
> 
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> Fixes: 5de195060b2e2 ("mm: resolve faulty mmap_region() error path behaviour")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/mmap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Changes since v1:
>  - Don't bail out and force the allocation when the merge failure is
>    -ENOMEM - Thanks Lorenzo

Now queued up, thanks.

greg k-h

