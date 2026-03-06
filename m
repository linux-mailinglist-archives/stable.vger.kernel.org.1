Return-Path: <stable+bounces-223365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMiCOOEHq2kMZgEAu9opvQ
	(envelope-from <stable+bounces-223365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:59:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C7225960
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE73A306374E
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767C3A1E96;
	Fri,  6 Mar 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC6Dt5cH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrM51kX3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B936C0AA
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816022; cv=none; b=hR9C70aVSVJJ6wFGx49O13f8eM4IHx/2HzUJiivdkumCpga6DEKiMXo4dvSdHG8x529ESJ5Fo6gfyOAttQ0Hk4p4WxZpAxCZUE0Ccv31Xswn+TmAXshN0am/zumAXK74SZsx5GrrKxq/xuxkrRxI0Slywo47wff6IlIsabAomQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816022; c=relaxed/simple;
	bh=dEgWalIxjYcg2EYY2421TQfsKS5RXz8KPnQ/ZxF9axA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcYv6u1sDfGAC4PShED92VLTBvdjD/Y4z59+HgSUAxCyC/oFq13LTePhHFwP0ASpxTeECW9McDgRzAtszvNLp81ZTnlcbMhwThMa74TbidKB/w+swMMkA/LiLM6sEQZNGq530UXi5fpwslLrZXG9Erd03ABn6C2+ffY+C+Ku4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UC6Dt5cH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrM51kX3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772816020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNQbk83T93bvLw/SSUDUDFDLerXYgajIMOvnuUhX6A8=;
	b=UC6Dt5cH7ztw3vMeOSFc+p6+tHTyOuLMFSDdx3hqVQ1E5iz1MzTt693bdfB6ryl1FNGSAN
	mXBcPVe1K1vclpESMfOZ1VuvcgQlFMi5vtwP6g7bPMtEa0SrjTpNlxe85U0F2d5abgzyKd
	+RzSX6xUnlb6JXdpqDPF2ScbPRDcek0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-kfKcpl6-Me68ggPrisvjuQ-1; Fri, 06 Mar 2026 11:53:39 -0500
X-MC-Unique: kfKcpl6-Me68ggPrisvjuQ-1
X-Mimecast-MFC-AGG-ID: kfKcpl6-Me68ggPrisvjuQ_1772816019
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ca3ef536ddso2478469785a.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772816019; x=1773420819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNQbk83T93bvLw/SSUDUDFDLerXYgajIMOvnuUhX6A8=;
        b=HrM51kX3cMJ8U9NGgYlNjvBlgtk2ONhUNY0M8+zRwWqeROpS+74NPI8qOD+Rd5V0aC
         R3+Mpg0IGsJVowPS1NrtM+EkleTWcU/z5yYXNU62/HyJLfm/ZMKbFYLgUqlaH+CeQhLC
         kuo00J0NPNkZXTvXELF5VFgW6XSbgG9ROZMHR8nW8lMDO8JfFWJ/zuv8cxU+dx4Fd7o0
         5kGGq8GG9+DSaZmYk5cMEx3PaZ9nejq85zq3D5nTBFJMwS809HndBJgNZr51wRc0G/5M
         uaNpqTxsnGKKxmTrr0yJh+/hebcKdT+CgJZCp/NkL+RYJVSa5NqsgAA5gTYZ7yVvSWax
         NJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816019; x=1773420819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNQbk83T93bvLw/SSUDUDFDLerXYgajIMOvnuUhX6A8=;
        b=S18tVazUo7niCY/dRSGooAQOjk52G29VRYveRhl0/92h0w8+VZSiu2blcumKsm+6/V
         4tT683U4HUfApW6sMzPA6ZD+52Ca0JDYotugCxo77T7oa9BTIMWfPf612kabE9pm2ECe
         wpLiMo4qp5RphgeD+RqmDG/dueC9rwctxWs3HsEwkeVjvJUiCvz9jsoQBR2mY7aa+Uly
         1jk/l8Qp+NcFtgAEZGUmoQQWMPDgYyfjf8Kg+ElbwyPwptVlAcwwpwKc2Cu//g6WfX+R
         VzFnQLDuT5g45rfc2xLx5357iwNXJy1lpvSZeTPKTTNpyRqgDqTjxmmLzieVD+b33sEv
         h2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0lXVfdaymGlg5M8b4OIMJsXgM/nLoxlDvD+FwHI57MJdzkU4BvPM/WBtLfeWuwusS+Oqkro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwU52WUPwJukZoygHgz9odBxVbMyUUxVrxPyclLxtZWOYzvo2
	GNe02okQOmBhMUzAELu+YTFQpTbj0Kb8B4b8K6mnlsVYVzdJw4k76H/GlAeZDGiCdZ2hfVmmMaU
	UJ+YObgg3GedRQIKE159N6YYs+xiEjwU53KIvik3KAi1K4EaebRluX9VVTg==
X-Gm-Gg: ATEYQzza2ZxHluMvnVuSNf0uXOyX9I8cKjEF02lqDS313oboqWo8OdxG9fPKvUWPVlR
	yb5FOQMPLpCbHBkjmUDjczzgzZxCrVpaY6S/jZxZFV64XYCvA+ugyQ2U//p20NuVnVtwLEcDQTo
	Y4C/fyQtGz8/MKp80OqtXsMleuAhTqTjAy+NjOXyxQS31Yof6ZaJw3vHvaLryYw6JbO50GIRiJ0
	pJTkgORABpE5udWYEcFzvcNNc0gPBg3dOGEoTqklzM782kO8skhFSdkq9PJYFXeNyzJkhpFrfO5
	htTT8EGDnyzHG7CzT5lRRN2fS9KR5sGla2k82LxCHsobMjcUnXlt06gxodACj7IEr9me95aF2BO
	SEYnklELpubl3cTbh/bSqNcNjvFSAiXDEKCfj5V5NoQW5z28BGPmWzYaFxd5onjPzyA61BFtHbj
	0S0XCAkw==
X-Received: by 2002:a05:620a:31a0:b0:8c0:88f3:fac4 with SMTP id af79cd13be357-8cd6d46fd1bmr344990285a.56.1772816018747;
        Fri, 06 Mar 2026 08:53:38 -0800 (PST)
X-Received: by 2002:a05:620a:31a0:b0:8c0:88f3:fac4 with SMTP id af79cd13be357-8cd6d46fd1bmr344986185a.56.1772816018115;
        Fri, 06 Mar 2026 08:53:38 -0800 (PST)
Received: from x1.local (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a317187c0sm17735076d6.50.2026.03.06.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:53:37 -0800 (PST)
Date: Fri, 6 Mar 2026 11:53:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Jianhui Zhou <jianhuizzzzz@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jonas Zhou <jonaszhou@zhaoxin.com>,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Message-ID: <aasGkA4r56pLqNC3@x1.local>
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
X-Rspamd-Queue-Id: 4F7C7225960
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterx@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,x1.local:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 10:03:32PM +0800, Jianhui Zhou wrote:
> In mfill_atomic_hugetlb(), linear_page_index() is used to calculate the
> page index for hugetlb_fault_mutex_hash(). However, linear_page_index()
> returns the index in PAGE_SIZE units, while hugetlb_fault_mutex_hash()
> expects the index in huge page units (as calculated by
> vma_hugecache_offset()). This mismatch means that different addresses
> within the same huge page can produce different hash values, leading to
> the use of different mutexes for the same huge page. This can cause
> races between faulting threads, which can corrupt the reservation map
> and trigger the BUG_ON in resv_map_release().
> 
> Fix this by replacing linear_page_index() with vma_hugecache_offset()
> and applying huge_page_mask() to align the address properly. To make
> vma_hugecache_offset() available outside of mm/hugetlb.c, move it to
> include/linux/hugetlb.h as a static inline function.
> 
> Fixes: 60d4d2d2b40e ("userfaultfd: hugetlbfs: add __mcopy_atomic_hugetlb for huge page UFFDIO_COPY")
> Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
> Cc: stable@vger.kernel.org
> Signed-off-by: Jianhui Zhou <jianhuizzzzz@gmail.com>

Good catch.. only one trivial comment below.

> ---
>  include/linux/hugetlb.h | 17 +++++++++++++++++
>  mm/hugetlb.c            | 11 -----------
>  mm/userfaultfd.c        |  5 ++++-
>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 65910437be1c..3f994f3e839c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -796,6 +796,17 @@ static inline unsigned huge_page_shift(struct hstate *h)
>  	return h->order + PAGE_SHIFT;
>  }
>  
> +/*
> + * Convert the address within this vma to the page offset within
> + * the mapping, huge page units here.
> + */
> +static inline pgoff_t vma_hugecache_offset(struct hstate *h,
> +		struct vm_area_struct *vma, unsigned long address)
> +{
> +	return ((address - vma->vm_start) >> huge_page_shift(h)) +
> +		(vma->vm_pgoff >> huge_page_order(h));
> +}
> +
>  static inline bool order_is_gigantic(unsigned int order)
>  {
>  	return order > MAX_PAGE_ORDER;
> @@ -1197,6 +1208,12 @@ static inline unsigned int huge_page_shift(struct hstate *h)
>  	return PAGE_SHIFT;
>  }
>  
> +static inline pgoff_t vma_hugecache_offset(struct hstate *h,
> +		struct vm_area_struct *vma, unsigned long address)
> +{
> +	return linear_page_index(vma, address);
> +}

IIUC we don't need this; the userfaultfd.c reference should only happen
when CONFIG_HUGETLB_PAGE.  Please double check.

Thanks,

> +
>  static inline bool hstate_is_gigantic(struct hstate *h)
>  {
>  	return false;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0beb6e22bc26..b87ed652c748 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1006,17 +1006,6 @@ static long region_count(struct resv_map *resv, long f, long t)
>  	return chg;
>  }
>  
> -/*
> - * Convert the address within this vma to the page offset within
> - * the mapping, huge page units here.
> - */
> -static pgoff_t vma_hugecache_offset(struct hstate *h,
> -			struct vm_area_struct *vma, unsigned long address)
> -{
> -	return ((address - vma->vm_start) >> huge_page_shift(h)) +
> -			(vma->vm_pgoff >> huge_page_order(h));
> -}
> -
>  /**
>   * vma_kernel_pagesize - Page size granularity for this VMA.
>   * @vma: The user mapping.
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 927086bb4a3c..8efebc47a410 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -507,6 +507,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	pgoff_t idx;
>  	u32 hash;
>  	struct address_space *mapping;
> +	struct hstate *h;
>  
>  	/*
>  	 * There is no default zero huge page for all huge page sizes as
> @@ -564,6 +565,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  			goto out_unlock;
>  	}
>  
> +	h = hstate_vma(dst_vma);
> +
>  	while (src_addr < src_start + len) {
>  		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
>  
> @@ -573,7 +576,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  		 * in the case of shared pmds.  fault mutex prevents
>  		 * races with other faulting threads.
>  		 */
> -		idx = linear_page_index(dst_vma, dst_addr);
> +		idx = vma_hugecache_offset(h, dst_vma, dst_addr & huge_page_mask(h));
>  		mapping = dst_vma->vm_file->f_mapping;
>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -- 
> 2.43.0
> 

-- 
Peter Xu


