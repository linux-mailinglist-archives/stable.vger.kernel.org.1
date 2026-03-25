Return-Path: <stable+bounces-230383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAJjNFI0xGkAxQQAu9opvQ
	(envelope-from <stable+bounces-230383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:15:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EE32B169
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0E3E302BDD6
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C13126D7;
	Wed, 25 Mar 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tISE3rgV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1613D51E;
	Wed, 25 Mar 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465882; cv=none; b=nQMZaLb+NAdH9sic35PFxXc3Q7BlbrbmnWQQ5tPDeGFBrSHQyVIJ912WF9pS7qORaJymzSnCsTPYQuxOQVL8dR7JuBg0hyhBsOxKiVzjH8EuYLC4rtX9OpA+OF79H3Fmq8FAJvoRqYsfuVmAQaozqkRQqyb1pObrr7Xf7Vmn7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465882; c=relaxed/simple;
	bh=+7WMGti3dXwAOyhG5CeCqAhjakNMSRvjhZh/2jZRxoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzWnBU+FMQi3U4+SV1t+u+UtytlfwUIk810PH5gupsKbWNfFPax7sb7IuzsE0AbZqr5XgpDcQz7oajjhpajBukj/0TcaFxXGDRwcBYtDvQ8Ij9mR4Rd24RkqKUTKgnFwcgb0ZdfyFwqtIU405dK3mKRyCQFPJ7mHfT8weihwzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tISE3rgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C55C4CEF7;
	Wed, 25 Mar 2026 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774465882;
	bh=+7WMGti3dXwAOyhG5CeCqAhjakNMSRvjhZh/2jZRxoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tISE3rgV54h2NbgNcJwFnAMi0cL06Z7rnwc1d9XbX+CnLsXyLle4Q4Y8WdNNLL5l0
	 7bEEM7w6i/vpH21LFGWA5EznC65bhF7oqFBfLUBGNHWVFL7ngdrl0n4bc5j8/kb0sF
	 fR22PbMNFGCx8vc5V0y4uEcX1G8IkjcxLJuzeoWaRp0nl0Mbv6csL7vdOUvtO7wgWx
	 33s7bEkT+2GV3j6dkyWIJ4RpSDkV1lMGNKKYftfwxHuYxmNILb6214YB3c49QgjM4+
	 I4wye5WfNV4yx/TtDtTaNamJUYakAZg8YxP5fb1A0yQD6WR1BEiB1/0msYQKQJcXCG
	 zMd3be9feOANA==
Date: Wed, 25 Mar 2026 21:10:37 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jianhui Zhou <jianhuizzzzz@gmail.com>, jane.chu@oracle.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash
 calculation
Message-ID: <acQzLYrp8W3PJZsh@kernel.org>
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260310110526.335749-1-jianhuizzzzz@gmail.com>
 <12e822c4-a4f2-4447-80b9-2eec35a03188@oracle.com>
 <CAEgWzV5ryMBgJWH3QmWfr9LaZoihXcffFWKjK6OfJF=pDF6BtA@mail.gmail.com>
 <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230383-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux.dev,suse.de,kernel.org,redhat.com,google.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 516EE32B169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 05:03:11PM -0700, Andrew Morton wrote:
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

Looks fine from uffd perspective, and simple enough for stable@.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> _
> 

-- 
Sincerely yours,
Mike.

