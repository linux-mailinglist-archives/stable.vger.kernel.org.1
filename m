Return-Path: <stable+bounces-201102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7607FCBFB5E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6007A3049D3C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2132ED860;
	Mon, 15 Dec 2025 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k5NAXrya"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F925B1C7
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829473; cv=none; b=VnodSK4XRlnn6lW0DySJpqrAbouVlyXSfZ5OwijhezmVXHSv2C92+3OWXxNYqXLSi9xusGKDYtBnKwQa4g909KxYZ3QZvD5oyxHL9r1ga+UoQHN3fgqe9Gf31b2spCYGZ1ZbIyXuHCW4aJ9Ie6rL2aqqXfaMzCNfT49xROxJEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829473; c=relaxed/simple;
	bh=q/LYhOuV2YpEyCEmejQf0P7Eu/DntrPAh8/QWUtJ6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLCeujShxVAR8vaCTnmjGJ3tFE0KntVJTCya8RUtmIe5VsNIDFvySzsD02xePImSmcXEbdHTTsJlxP/9pmFKEWvDUMyO3wriA82UdyYi/zV0ksEQ3e7ydTs3ZQN3xof3hqWVPjR4P9H61qkcfIqi9iPNunA9m4mRVm+INNRv6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k5NAXrya; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 20:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765829454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOqWmgUj0AAwYWJPWLBqrj8UijMveyhjIFurgZUrRlI=;
	b=k5NAXrya1BV1jaTcgTvgVUHeeDFiTqTQrAYcqMTFLBhOwnRZLwXjQ35P0P7nXrflKf9Idz
	Mao62By3qkt1n8BujsdCzR6l6riG5Y28wRK5QCqqvKwC38/nlIeYpzZ/P0NF9DLEnmR83/
	WfJG1K62Dk0Dg2vWLP/Men50+nABFFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: Fix redundant updates of LBR MSR intercepts
Message-ID: <rlwgjee2tjf26jyvdwipdwejqgsira63nvn2r3zczehz3argi4@uarbt5af3wv2>
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
 <3rdy3n6phleyz2eltr5fkbsavlpfncgrnee7kep2jkh2air66c@euczg54kpt47>
 <aUBjmHBHx1jsIcWJ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBjmHBHx1jsIcWJ@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 15, 2025 at 11:38:00AM -0800, Sean Christopherson wrote:
> On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> > On Mon, Dec 15, 2025 at 07:26:54PM +0000, Yosry Ahmed wrote:
> > > svm_update_lbrv() always updates LBR MSRs intercepts, even when they are
> > > already set correctly. This results in force_msr_bitmap_recalc always
> > > being set to true on every nested transition, essentially undoing the
> > > hyperv optimization in nested_svm_merge_msrpm().
> > > 
> > > Fix it by keeping track of whether LBR MSRs are intercepted or not and
> > > only doing the update if needed, similar to x2avic_msrs_intercepted.
> > > 
> > > Avoid using svm_test_msr_bitmap_*() to check the status of the
> > > intercepts, as an arbitrary MSR will need to be chosen as a
> > > representative of all LBR MSRs, and this could theoretically break if
> > > some of the MSRs intercepts are handled differently from the rest.
> > > 
> > > Also, using svm_test_msr_bitmap_*() makes backports difficult as it was
> > > only recently introduced with no direct alternatives in older kernels.
> > > 
> > > Fixes: fbe5e5f030c2 ("KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > 
> > Sigh.. I had this patch file in my working directory and it was sent by
> > mistake with the series, as the cover letter nonetheless. Sorry about
> > that. Let me know if I should resend.
> 
> Eh, it's fine for now.  The important part is clarfying that this patch should
> be ignored, which you've already done.

FWIW that patch is already in Linus's tree so even if someone applies
it, it should be fine.

