Return-Path: <stable+bounces-230256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBa+Cxk1w2lVpAQAu9opvQ
	(envelope-from <stable+bounces-230256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:06:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EE31E31D
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C353034E05
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CD223DE7;
	Wed, 25 Mar 2026 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVZLXqtw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD418AFE;
	Wed, 25 Mar 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400781; cv=none; b=lnMqwLBxiyFSjx/Yn65uFe9kCsZvXj2TVxxrkmuPCxlKqyezAQhjtnlcB3+nQhoBeoTptvKIflAxxmEWJGtMDqcf9qhxBO0VOqNDMk9/IfsjVrR4tmP+gruwaAlqEHh9egn6MR08UsV5PU0Pjg6dKADEapsQyRjzEPcVhECuUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400781; c=relaxed/simple;
	bh=KCKmswUuntgrxMY+FY5NFLWhFQrzDonhgajhndVTwTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTF9vNxO4YUbbaVQJYL5mjWtzT6WKf1ROaPH46N6/z1fnjMm7JkO0hVHgKq03oYRk/zr4OP2uaLFnxp2oXrrNY1pqLwHYO3qE86FwxGTQx/GQfLfDww0/Q9Q5ESXs/nKnqaHl8eBxPWhiVjBd5pHBpKlnO05UsIXMtWSwrOVTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVZLXqtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F63EC19424;
	Wed, 25 Mar 2026 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774400781;
	bh=KCKmswUuntgrxMY+FY5NFLWhFQrzDonhgajhndVTwTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVZLXqtwSvL0LjXz1uF2Fm49ZQn2TlVnQe6H6rXg7njcS9FsCpKQmoIPrynX4aEem
	 vNLZbQ6q1zEQKIwFT2DrAgMJ7F0GlO8aGvJE5g9B6nbV/2arR+uu6PmjROESoUzG0Z
	 yUzFy+iQWLrgE/2JSjj0sBUvuU7dOZom9YvWhHSvWMMK/L6wPNqHBB/Fmq67EZkMPg
	 DKU0sTc42jpNZ2sar9qJ/uNO1ibKreHppHy4X8yHBXLHJBx1k4oniFSCTQKF35srRa
	 qqH8vYGGwywRilF2WMegXvEg00TjO3vd6JVKzvghqfIcbEwjT91kSBvfcGnLPAaKbh
	 3cRYGuOmep/Pg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jianhui Zhou <jianhuizzzzz@gmail.com>,
	jane.chu@oracle.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jonas Zhou <jonaszhou@zhaoxin.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Tue, 24 Mar 2026 18:06:17 -0700
Message-ID: <20260325010618.85366-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,oracle.com,linux.dev,suse.de,redhat.com,google.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-230256-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 815EE31E31D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 17:03:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 11 Mar 2026 18:54:26 +0800 Jianhui Zhou <jianhuizzzzz@gmail.com> wrote:
> 
> > On Tue, Mar 10, 2026 at 12:47:07PM -0700, jane.chu@oracle.com wrote:
> > > Just wondering whether making the shift explicit here instead of
> > > introducing another hugetlb helper might be sufficient?
> > >
> > >      idx >>= huge_page_order(hstate_vma(vma));
> > 
> > That would work for hugetlb VMAs since both (address - vm_start) and
> > vm_pgoff are guaranteed to be huge page aligned. However, David
> > suggested introducing hugetlb_linear_page_index() to provide a cleaner
> > API that mirrors linear_page_index(), so I kept this approach.
> > 
> 
> Thanks.
> 
> Would anyone like to review this cc:stable patch for us?
> 
> 
> From: Jianhui Zhou <jianhuizzzzz@gmail.com>
> Subject: mm/userfaultfd: fix hugetlb fault mutex hash calculation
> Date: Tue, 10 Mar 2026 19:05:26 +0800
> 
> In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
> page index for hugetlb_fault_mutex_hash().  However, linear_page_index()
> returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
> expects the index in huge page units.  This mismatch means that different
> addresses within the same huge page can produce different hash values,
> leading to the use of different mutexes for the same huge page.  This can
> cause races between faulting threads, which can corrupt the reservation
> map and trigger the BUG_ON in resv_map_release().
> 
> Fix this by introducing hugetlb_linear_page_index(), which returns the
> page index in huge page granularity, and using it in place of
> linear_page_index().
> 
> Link: https://lkml.kernel.org/r/20260310110526.335749-1-jianhuizzzzz@gmail.com
> Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
> Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>
> Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: JonasZhou <JonasZhou@zhaoxin.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I added trivial comments below, but looks good to me.

Acked-by: SeongJae Park <sj@kernel.org>

> ---
> 
>  include/linux/hugetlb.h |   17 +++++++++++++++++
>  mm/userfaultfd.c        |    2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/hugetlb.h~mm-userfaultfd-fix-hugetlb-fault-mutex-hash-calculation
> +++ a/include/linux/hugetlb.h
> @@ -796,6 +796,23 @@ static inline unsigned huge_page_shift(s
>  	return h->order + PAGE_SHIFT;
>  }
>  
> +/**
> + * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
> + *				 page size granularity.
> + * @vma: the hugetlb VMA
> + * @address: the virtual address within the VMA
> + *
> + * Return: the page offset within the mapping in huge page units.
> + */
> +static inline pgoff_t hugetlb_linear_page_index(struct vm_area_struct *vma,
> +		unsigned long address)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +
> +	return ((address - vma->vm_start) >> huge_page_shift(h)) +
> +		(vma->vm_pgoff >> huge_page_order(h));

Nit.  The outermost parentheses feels odd to me.

> +}
> +
>  static inline bool order_is_gigantic(unsigned int order)
>  {
>  	return order > MAX_PAGE_ORDER;
> --- a/mm/userfaultfd.c~mm-userfaultfd-fix-hugetlb-fault-mutex-hash-calculation
> +++ a/mm/userfaultfd.c
> @@ -573,7 +573,7 @@ retry:
>  		 * in the case of shared pmds.  fault mutex prevents
>  		 * races with other faulting threads.
>  		 */
> -		idx = linear_page_index(dst_vma, dst_addr);
> +		idx = hugetlb_linear_page_index(dst_vma, dst_addr);
>  		mapping = dst_vma->vm_file->f_mapping;
>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);

Seems userfaulfd.c is the only caller of the new helper function.  Why don't
you define the function in userfaultfd.c ?


Thanks,
SJ

