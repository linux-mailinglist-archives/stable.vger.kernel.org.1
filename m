Return-Path: <stable+bounces-119942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD922A49A39
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54E316913B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9026B2B5;
	Fri, 28 Feb 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBE2bU1+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B54261579
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748095; cv=none; b=E1hqfQ27t4R09Yw4CLdnltnhxuRaHxAOXMOgcvSftF9rvjNqJi/IA5JANhltSmT0qEJW+KRZUi9SxPsXksJiyn5E0Kbx/5qco1suLuW7S0kbxD5J/VV+iO/QQwKGCN0sluKRMCsiBBAhLkgm2hyPjHeBF6Ab5c9IoWsLT3djQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748095; c=relaxed/simple;
	bh=97gAMnIreyqDFjzDQCdhayZyZvpF4GTOQAWwkkpmPwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4cyDEdVA280+vf5o3toc+xM9vLUQ+ikOXk+RujtlSZflNlYCTuSScoTjxgEFLiMI39N53Q1ozxqe/eKDJ/SrGxicNBzvdTyA/3KLdIR9ffBn/Jc4TUUc4sCBC+tFiN9FfzjMm7ZJNuZBXimSv+3qGK72K9RXPp5CGa8XTq+1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBE2bU1+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740748094; x=1772284094;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=97gAMnIreyqDFjzDQCdhayZyZvpF4GTOQAWwkkpmPwI=;
  b=QBE2bU1+4o8xYUpDUSO2XyU2meRcmnkAyPj6ykv6xNsSVPZMK552cjby
   hSY5DwyLVbi25Lft6pXhUgNmHaP99qKHudvbCPxIi4/VgBdX1/fWsD144
   kMQCZFBIPN9rsMExaf+4QqnFIJqO/ctXDMCigz9V/ZwlrRZY7LpwpSHC9
   wcyAlzuObw3/fXbp4muNphGIluuj9ydjgP3cPWRalwwG6GMFeeevzSNqM
   Wz6m4i/NFLswT61JZomAA3aAOqvfz2rO+oNp0y0oVylN4e9LXshfT/FoP
   g9gR702ERFHwWp3ZzlkR4P97hgi/1ARMh26BxhBLAgCHI5yfo5fAh2xm4
   g==;
X-CSE-ConnectionGUID: Sus0uuSrRQWQg/Kz1DYYpw==
X-CSE-MsgGUID: 6QueSKpVTCexcbhWhokjoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41926761"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41926761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 05:08:13 -0800
X-CSE-ConnectionGUID: w4Ro8g8gTwOfadPRcpbD3Q==
X-CSE-MsgGUID: gbZhHXxHRbiZzvDzcUVvvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117515478"
Received: from monicael-mobl3 (HELO [10.245.246.40]) ([10.245.246.40])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 05:08:11 -0800
Message-ID: <db2a5741b3e43cc3a54fa9c01e6af55677275070.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] drm/xe/hmm: Don't dereference struct page pointers
 without notifier lock
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
Date: Fri, 28 Feb 2025 14:08:09 +0100
In-Reply-To: <b62352fd-f16a-423c-8a20-5d7697a6c4a7@intel.com>
References: <20250228104418.44313-1-thomas.hellstrom@linux.intel.com>
	 <20250228104418.44313-3-thomas.hellstrom@linux.intel.com>
	 <b62352fd-f16a-423c-8a20-5d7697a6c4a7@intel.com>
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

On Fri, 2025-02-28 at 12:55 +0000, Matthew Auld wrote:
> On 28/02/2025 10:44, Thomas Hellstr=C3=B6m wrote:
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
> > Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate
> > userptr")
> > Cc: Oak Zeng <oak.zeng@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.10+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_hmm.c | 115 ++++++++++++++++++++++++++----=
-
> > -----
> > =C2=A0 1 file changed, 85 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_hmm.c
> > b/drivers/gpu/drm/xe/xe_hmm.c
> > index c56738fa713b..d3b5551496d0 100644
> > --- a/drivers/gpu/drm/xe/xe_hmm.c
> > +++ b/drivers/gpu/drm/xe/xe_hmm.c
> > @@ -42,6 +42,36 @@ static void xe_mark_range_accessed(struct
> > hmm_range *range, bool write)
> > =C2=A0=C2=A0	}
> > =C2=A0 }
> > =C2=A0=20
> > +static int xe_alloc_sg(struct sg_table *st, struct hmm_range
> > *range,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rw_semaphore *notifier_s=
em)
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
> > +		return -EAGAIN;
> > +
> > +	npages =3D xe_npages_in_range(range->start, range->end);
> > +	for (i =3D 0; i < npages;) {
> > +		hmm_pfn =3D range->hmm_pfns[i];
> > +		if (!(hmm_pfn & HMM_PFN_VALID)) {
>=20
> Is this possible? The default_flags are always REQ_FAULT, so that
> should=20
> ensure PFN_VALID, or the hmm_fault would have returned an error?
>=20
> =C2=A0From the docs:
>=20
> "HMM_PFN_REQ_FAULT - The output must have HMM_PFN_VALID or=20
> hmm_range_fault() will fail"
>=20
> Should this be an assert?
>=20
> Also probably dumb question, but why do we need to hold the notifier=20
> lock over this loop? What is it protecting?

Docs for hmm_pfn_to_map_order():

/*
 * This must be called under the caller 'user_lock' after a successful
 * mmu_interval_read_begin(). The caller must have tested for
HMM_PFN_VALID
 * already.
 */

I'm fine with changing to an assert, and I agree that the lock is
pointless: We're operating on thread local data, but I also think that
not adhering to the doc requirements might cause problems in the
future. Like if the map order encoding is dropped and the order was
grabbed from the underlying page.

/Thomas


>=20
> > +			up_read(notifier_sem);
> > +			return -EFAULT;
> > +		}
> > +		num_chunks++;
> > +		i +=3D 1UL << hmm_pfn_to_map_order(hmm_pfn);
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
> > @@ -50,6 +80,7 @@ static void xe_mark_range_accessed(struct
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
> > @@ -76,38 +107,33 @@ static void xe_mark_range_accessed(struct
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
> > =C2=A0=C2=A0	struct device *dev =3D xe->drm.dev;
> > -	struct page **pages;
> > -	u64 i, npages;
> > -	int ret;
> > -
> > -	npages =3D xe_npages_in_range(range->start, range->end);
> > -	pages =3D kvmalloc_array(npages, sizeof(*pages),
> > GFP_KERNEL);
> > -	if (!pages)
> > -		return -ENOMEM;
> > -
> > -	for (i =3D 0; i < npages; i++) {
> > -		pages[i] =3D hmm_pfn_to_page(range->hmm_pfns[i]);
> > -		xe_assert(xe, !is_device_private_page(pages[i]));
> > -	}
> > -
> > -	ret =3D sg_alloc_table_from_pages_segment(st, pages, npages,
> > 0, npages << PAGE_SHIFT,
> > -
> > 						xe_sg_segment_size(dev), GFP_KERNEL);
> > -	if (ret)
> > -		goto free_pages;
> > -
> > -	ret =3D dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL :
> > DMA_TO_DEVICE,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_ATTR_SKIP_CPU_SYNC |
> > DMA_ATTR_NO_KERNEL_MAPPING);
> > -	if (ret) {
> > -		sg_free_table(st);
> > -		st =3D NULL;
> > +	unsigned long hmm_pfn, size;
> > +	struct scatterlist *sgl;
> > +	struct page *page;
> > +	unsigned long i, j;
> > +
> > +	lockdep_assert_held(notifier_sem);
> > +
> > +	i =3D 0;
> > +	for_each_sg(st->sgl, sgl, st->nents, j) {
> > +		hmm_pfn =3D range->hmm_pfns[i];
> > +		page =3D hmm_pfn_to_page(hmm_pfn);
> > +		xe_assert(xe, !is_device_private_page(page));
> > +		size =3D 1UL << hmm_pfn_to_map_order(hmm_pfn);
> > +		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
> > +		if (unlikely(j =3D=3D st->nents - 1))
> > +			sg_mark_end(sgl);
> > +		i +=3D size;
> > =C2=A0=C2=A0	}
> > +	xe_assert(xe, i =3D=3D xe_npages_in_range(range->start, range-
> > >end));
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
> > @@ -235,16 +261,45 @@ int xe_hmm_userptr_populate_range(struct
> > xe_userptr_vma *uvma,
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		goto free_pfns;
> > =C2=A0=20
> > -	ret =3D xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
> > write);
> > +	if (unlikely(userptr->sg)) {
> > +		ret =3D down_write_killable(&vm-
> > >userptr.notifier_lock);
> > +		if (ret)
> > +			goto free_pfns;
> > +
> > +		xe_hmm_userptr_free_sg(uvma);
> > +		up_write(&vm->userptr.notifier_lock);
> > +	}
> > +
> > +	ret =3D xe_alloc_sg(&userptr->sgt, &hmm_range, &vm-
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


