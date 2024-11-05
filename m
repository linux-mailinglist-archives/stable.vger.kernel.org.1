Return-Path: <stable+bounces-89890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0B9BD29C
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92159B22E08
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71171DC04D;
	Tue,  5 Nov 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+4hhM3e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F231D9A62
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824726; cv=none; b=ghmvtVP747C+/aQmSTYPBdPt9h9cEWxXOZILt5UHTknZ2rbA5bA8+NcEOd7FqFMevD2gdEHVw3qLAd7zwM8Ga8FYOg8AmOBxBoYxX5IJg8ZSMllBSh3RV7QcZTnXhlFybilAn1EYWIROgIFKClruXF0+zPXSvAXGvEqfFWxRMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824726; c=relaxed/simple;
	bh=k0zFIXSRiY0TqDbJn78MOkTzYaYke7ZqT6GlgPuzS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZb4WrdOLiWgu7VwdI9elcyNPTPJ7ilPtmdxH8w5TJaKZAEgjAIMkltT4n10ki0Klu3tt2wpVGjLaFGojkghebIRWLFF9wSsZ48o0RM84MsC7XWAAL+iQ0vgj7zLEgs7Q233dxY4Twt2McuW0RM26BmufyTai0TGWphgM/UMm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+4hhM3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75E1C4CECF;
	Tue,  5 Nov 2024 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824726;
	bh=k0zFIXSRiY0TqDbJn78MOkTzYaYke7ZqT6GlgPuzS4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+4hhM3eosYbwNp4//g/hOcyaiLcd7UQMmwiwufZLc3biPfHrp9Fy2SXmGsKjrtVx
	 OkrnQKEGsRkB8c/Zrw20MusOngtCcmXvq7aW9MCBSowM8EySvTO5819s1TLCECYr3K
	 Dzg+LFwvhZAVTulC653TRMuVQliB9SfYSBzcaRmE=
Date: Tue, 5 Nov 2024 17:38:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>, stable@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Fu <bfu@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6.6.y] mm: huge_memory: add vma_thp_disabled() and
 thp_disabled_by_hw()
Message-ID: <2024110508-cascade-employed-e28f@gregkh>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241022090755.4097604-1-david@redhat.com>
 <2024115125648-ZyoWEF1F7lBRpXqH-arkamar@atlas.cz>
 <26be0c08-1c83-451d-902b-a843b9ef4b0e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26be0c08-1c83-451d-902b-a843b9ef4b0e@redhat.com>

On Tue, Nov 05, 2024 at 05:30:14PM +0100, David Hildenbrand wrote:
> On 05.11.24 13:56, Petr Vaněk wrote:
> > Hi David,
> > 
> 
> Hi Petr,
> 
> > On Tue, Oct 22, 2024 at 11:07:55AM +0200, David Hildenbrand wrote:
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 9aea11b1477c..dfd6577225d8 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -78,19 +78,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> > >   	if (!vma->vm_mm)		/* vdso */
> > >   		return false;
> > > -	/*
> > > -	 * Explicitly disabled through madvise or prctl, or some
> > > -	 * architectures may disable THP for some mappings, for
> > > -	 * example, s390 kvm.
> > > -	 * */
> > > -	if ((vm_flags & VM_NOHUGEPAGE) ||
> > > -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > > -		return false;
> > > -	/*
> > > -	 * If the hardware/firmware marked hugepage support disabled.
> > > -	 */
> > > -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
> > > -		return false;
> > > +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
> > > +		return 0;
> > 
> > Shouldn't this return false for consistency with the rest of the
> > function?
> 
> Yes, that's better. Same applies to the 6.1.y backport of this.

Ok, dropping this from the review queue, please resend the updated
versions.

thansk,

greg k-h

