Return-Path: <stable+bounces-120258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555EA4E4D7
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B03E188BB11
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D27296D4F;
	Tue,  4 Mar 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxsR3kes"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB2296D54
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102629; cv=none; b=GmMPyRSxR6p8uCGr8zEjl1Mc8rFwkS+PJC41sJcReYzGr5j0ADkUdtOBd9PxVhMjmeMMC1JHVx7Xh6A43dWd4ntmY1OK81zFJzq61716s26eu6qT/0XH/6og/JO1IP0bHbp8Fl9fGRqNJEbloZCnRwinNYUNiNIQr5A7lS+mXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102629; c=relaxed/simple;
	bh=kcFjGcu3jYUkHERQ0EX75rUx80CnaZ2mtG6fKDBmD8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+YStdfBu+I9hNJptYt5cDHaq+YxovCkCEx1a5LNwImiFR4Dt4zafxeFSFBMsj/JjvqLX7cb462/4tEm7R7T/g+uxtyO9Q9sXUJk8UYMkSEHC2xpdR8UlDo3YOJ0ouBtphj3zhaU0GOKqc3Nl/BzmBlU3rYE8DfatpIojo5UryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxsR3kes; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741102627; x=1772638627;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kcFjGcu3jYUkHERQ0EX75rUx80CnaZ2mtG6fKDBmD8E=;
  b=VxsR3kesirr2V3wKVYC0XlzNsXFAIYG1z+9A3aRK8CCPMaHCqXa37f8F
   DlOT1zfsYUyAyDKyypR6XJOQvVT3MFpbg2jRi8ywNlqLcnV/kEWh/Gr5i
   Wo9LDK+7k9wMvWArdLUPLNaIJKqgm0qnVdbl11Rb5DMMES2KbN6eqpuE8
   hvlJpSCRpmTSiXjd5SJWsFpVSistvqSdse9mnuNiGehLZ5xruiPCjJu3x
   sXt68Hk7js3VI6SzwmDDc/m2AgzXSnGFaFhjfsOpEjdz+kvCj90GK1C72
   L2j4KV093U1raPtjtt8PMkK/KM/BTc2onLXjmGkB4bQD5l8G192KZexjQ
   g==;
X-CSE-ConnectionGUID: dkYeMEdfSiWQRjgId6jaVQ==
X-CSE-MsgGUID: s2E6gzfnQhGrtDGUWthnlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53011191"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53011191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:37:07 -0800
X-CSE-ConnectionGUID: jmN1r1heScmlpMqLc7rzeA==
X-CSE-MsgGUID: 7f9cr/J4Q+Gc2IqNeQkxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122534667"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.227]) ([10.245.246.227])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:37:04 -0800
Message-ID: <55e586e48941f825cb67f408f2a608be0a01e89d.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/xe/hmm: Don't dereference struct page
 pointers without notifier lock
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
Date: Tue, 04 Mar 2025 16:37:02 +0100
In-Reply-To: <1e5ef4c8-9545-4102-88d9-865cf6a4bec9@intel.com>
References: <20250304113758.67889-1-thomas.hellstrom@linux.intel.com>
	 <20250304113758.67889-3-thomas.hellstrom@linux.intel.com>
	 <1e5ef4c8-9545-4102-88d9-865cf6a4bec9@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 15:16 +0000, Matthew Auld wrote:
> On 04/03/2025 11:37, Thomas Hellstr=C3=B6m wrote:
> > The pnfs that we obtain from hmm_range_fault() point to pages that
> > we don't have a reference on, and the guarantee that they are still
> > in the cpu page-tables is that the notifier lock must be held and
> > the
> > notifier seqno is still valid.
> >=20
> > So while building the sg table and marking the pages accesses /
> > dirty
> > we need to hold this lock with a validated seqno.
> >=20
> > However, the lock is reclaim tainted which makes
> > sg_alloc_table_from_pages_segment() unusable, since it internally
> > allocates memory.
> >=20
> > Instead build the sg-table manually. For the non-iommu case
> > this might lead to fewer coalesces, but if that's a problem it can
> > be fixed up later in the resource cursor code. For the iommu case,
> > the whole sg-table may still be coalesced to a single contigous
> > device va region.
> >=20
> > This avoids marking pages that we don't own dirty and accessed, and
> > it also avoid dereferencing struct pages that we don't own.
> >=20
> > v2:
> > - Use assert to check whether hmm pfns are valid (Matthew Auld)
> > - Take into account that large pages may cross range boundaries
> > =C2=A0=C2=A0 (Matthew Auld)
> >=20
> > Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate
> > userptr")
> > Cc: Oak Zeng <oak.zeng@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.10+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_hmm.c | 119 ++++++++++++++++++++++++++++--=
-
> > -----
> > =C2=A0 1 file changed, 93 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_hmm.c
> > b/drivers/gpu/drm/xe/xe_hmm.c
> > index c56738fa713b..93cce9e819a1 100644
> > --- a/drivers/gpu/drm/xe/xe_hmm.c
> > +++ b/drivers/gpu/drm/xe/xe_hmm.c
> > @@ -42,6 +42,40 @@ static void xe_mark_range_accessed(struct
> > hmm_range *range, bool write)
> > =C2=A0=C2=A0	}
> > =C2=A0 }
> > =C2=A0=20
> > +static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hmm_range *range, struct
> > rw_semaphore *notifier_sem)
> > +{
> > +	unsigned long i, npages, hmm_pfn;
> > +	unsigned long num_chunks =3D 0;
> > +	int ret;
> > +
> > +	/* HMM docs says this is needed. */
> > +	ret =3D down_read_interruptible(notifier_sem);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (mmu_interval_read_retry(range->notifier, range-
> > >notifier_seq))
>=20
> up_read() ?
>=20
> > +		return -EAGAIN;
> > +
> > +	npages =3D xe_npages_in_range(range->start, range->end);
> > +	for (i =3D 0; i < npages;) {
> > +		unsigned long len;
> > +
> > +		hmm_pfn =3D range->hmm_pfns[i];
> > +		xe_assert(xe, hmm_pfn & HMM_PFN_VALID);
> > +
> > +		len =3D 1UL << hmm_pfn_to_map_order(hmm_pfn);
> > +
> > +		/* If order > 0 the page may extend beyond range-
> > >start */
> > +		len -=3D (hmm_pfn & ~HMM_PFN_FLAGS) & (len - 1);
> > +		i +=3D len;
> > +		num_chunks++;
> > +	}
> > +	up_read(notifier_sem);
> > +
> > +	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
> > +}
> > +
> > =C2=A0 /**
> > =C2=A0=C2=A0 * xe_build_sg() - build a scatter gather table for all the
> > physical pages/pfn
> > =C2=A0=C2=A0 * in a hmm_range. dma-map pages if necessary. dma-address =
is
> > save in sg table
> > @@ -50,6 +84,7 @@ static void xe_mark_range_accessed(struct
> > hmm_range *range, bool write)
> > =C2=A0=C2=A0 * @range: the hmm range that we build the sg table from. r=
ange-
> > >hmm_pfns[]
> > =C2=A0=C2=A0 * has the pfn numbers of pages that back up this hmm addre=
ss
> > range.
> > =C2=A0=C2=A0 * @st: pointer to the sg table.
> > + * @notifier_sem: The xe notifier lock.
> > =C2=A0=C2=A0 * @write: whether we write to this range. This decides dma=
 map
> > direction
> > =C2=A0=C2=A0 * for system pages. If write we map it bi-diretional; othe=
rwise
> > =C2=A0=C2=A0 * DMA_TO_DEVICE
> > @@ -76,38 +111,41 @@ static void xe_mark_range_accessed(struct
> > hmm_range *range, bool write)
> > =C2=A0=C2=A0 * Returns 0 if successful; -ENOMEM if fails to allocate me=
mory
> > =C2=A0=C2=A0 */
> > =C2=A0 static int xe_build_sg(struct xe_device *xe, struct hmm_range
> > *range,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *st, bool write=
)
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *st,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rw_semaphore *notifier_s=
em,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool write)
> > =C2=A0 {
> > +	unsigned long npages =3D xe_npages_in_range(range->start,
> > range->end);
> > =C2=A0=C2=A0	struct device *dev =3D xe->drm.dev;
> > -	struct page **pages;
> > -	u64 i, npages;
> > -	int ret;
> > +	struct scatterlist *sgl;
> > +	struct page *page;
> > +	unsigned long i, j;
> > =C2=A0=20
> > -	npages =3D xe_npages_in_range(range->start, range->end);
> > -	pages =3D kvmalloc_array(npages, sizeof(*pages),
> > GFP_KERNEL);
> > -	if (!pages)
> > -		return -ENOMEM;
> > +	lockdep_assert_held(notifier_sem);
> > =C2=A0=20
> > -	for (i =3D 0; i < npages; i++) {
> > -		pages[i] =3D hmm_pfn_to_page(range->hmm_pfns[i]);
> > -		xe_assert(xe, !is_device_private_page(pages[i]));
> > -	}
> > +	i =3D 0;
> > +	for_each_sg(st->sgl, sgl, st->nents, j) {
> > +		unsigned long hmm_pfn, size;
> > =C2=A0=20
> > -	ret =3D sg_alloc_table_from_pages_segment(st, pages, npages,
> > 0, npages << PAGE_SHIFT,
> > -
> > 						xe_sg_segment_size(dev), GFP_KERNEL);
> > -	if (ret)
> > -		goto free_pages;
> > +		hmm_pfn =3D range->hmm_pfns[i];
> > +		page =3D hmm_pfn_to_page(hmm_pfn);
> > +		xe_assert(xe, !is_device_private_page(page));
> > =C2=A0=20
> > -	ret =3D dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL :
> > DMA_TO_DEVICE,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_ATTR_SKIP_CPU_SYNC |
> > DMA_ATTR_NO_KERNEL_MAPPING);
> > -	if (ret) {
> > -		sg_free_table(st);
> > -		st =3D NULL;
> > +		size =3D 1UL << hmm_pfn_to_map_order(hmm_pfn);
> > +		size -=3D page_to_pfn(page) & (size - 1);
> > +		i +=3D size;
> > +
> > +		if (unlikely(j =3D=3D st->nents - 1)) {
> > +			if (i > npages)
> > +				size -=3D (i - npages);
> > +			sg_mark_end(sgl);
> > +		}
> > +		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
> > =C2=A0=C2=A0	}
> > +	xe_assert(xe, i =3D=3D npages);
> > =C2=A0=20
> > -free_pages:
> > -	kvfree(pages);
> > -	return ret;
> > +	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL
> > : DMA_TO_DEVICE,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_ATTR_SKIP_CPU_SYNC |
> > DMA_ATTR_NO_KERNEL_MAPPING);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -235,16 +273,45 @@ int xe_hmm_userptr_populate_range(struct
> > xe_userptr_vma *uvma,
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		goto free_pfns;
> > =C2=A0=20
> > -	ret =3D xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
> > write);
> > +	if (unlikely(userptr->sg)) {
>=20
> Is it really possible to hit this? We did the unmap above also,
> although=20
> that was outside of the notifier lock?

Right. That was a spill-over from the next patch where we unmap in the
notifier. But for this patch I'll fix up the two issues mentioned and
add your R-B.

Thanks for reviewing.
Thomas



>=20
> Otherwise,
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>=20
> > +		ret =3D down_write_killable(&vm-
> > >userptr.notifier_lock);
> > +		if (ret)
> > +			goto free_pfns;
> > +
> > +		xe_hmm_userptr_free_sg(uvma);
> > +		up_write(&vm->userptr.notifier_lock);
> > +	}
> > +
> > +	ret =3D xe_alloc_sg(vm->xe, &userptr->sgt, &hmm_range, &vm-
> > >userptr.notifier_lock);
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		goto free_pfns;
> > =C2=A0=20
> > +	ret =3D down_read_interruptible(&vm->userptr.notifier_lock);
> > +	if (ret)
> > +		goto free_st;
> > +
> > +	if (mmu_interval_read_retry(hmm_range.notifier,
> > hmm_range.notifier_seq)) {
> > +		ret =3D -EAGAIN;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ret =3D xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
> > +			=C2=A0 &vm->userptr.notifier_lock, write);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > =C2=A0=C2=A0	xe_mark_range_accessed(&hmm_range, write);
> > =C2=A0=C2=A0	userptr->sg =3D &userptr->sgt;
> > =C2=A0=C2=A0	userptr->notifier_seq =3D hmm_range.notifier_seq;
> > +	up_read(&vm->userptr.notifier_lock);
> > +	kvfree(pfns);
> > +	return 0;
> > =C2=A0=20
> > +out_unlock:
> > +	up_read(&vm->userptr.notifier_lock);
> > +free_st:
> > +	sg_free_table(&userptr->sgt);
> > =C2=A0 free_pfns:
> > =C2=A0=C2=A0	kvfree(pfns);
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
> > -
>=20


