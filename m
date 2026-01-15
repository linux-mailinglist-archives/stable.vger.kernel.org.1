Return-Path: <stable+bounces-208388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B1D21DE7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AE030382A6
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6913D51E;
	Thu, 15 Jan 2026 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N8aevUHY"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219C56B81;
	Thu, 15 Jan 2026 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437351; cv=none; b=Ij7J7pu+kfHAQr8Pw5yIXikjfGrlrmx3KTQnomciIgAEpY2T+UobC4JUqisMNEgnAIpiazyMNoQWMyL/YNyBQdaVSMJePZqweBK74+HDAMj6KlTK7msXr4PHuqN3iTU1e4eCuad2Yu1EXPV92mdAp7sYO+xbgWG5fkbl8K+YIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437351; c=relaxed/simple;
	bh=hV/I1amt69oPCU6aay0nCIv9p4OreJli9oi11PddXe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U87yLpQlWjKmO3Cc+U1e2hshV5Y+s68nkdnUKtIxUSw9828FAQa7OCRECNbFIqnzTUO44PlkBf+IXSBlzruATnnfQX3RPH9nzoRZuNka3VWXfvqDNsIX4ERxTZ1Bj9PHRHsNVlgCJpjaFRKZXiG75XcVAYuIQnRnUgZNUHuPH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N8aevUHY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Jan 2026 00:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768437337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUJ2AGd/KuMhjjY9mP2rbYed6lZnsOVmk5YpNz11QZ0=;
	b=N8aevUHY/lcHDX3YLe72XG0bqFGKINjWc5j4Gh0H76maMTTCj8dqyfUwj6ee3beW/O9Ed+
	MoB99USzUSNf/QGwFo4u4HvTlmGrxsnEnfVz/Fy+RwQI83Y4q3NYWaBhCHdEt4WC73YnwK
	g4if7sQEtYKfRyho59tlRMU0ZvoXqrI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: Fix redundant updates of LBR MSR intercepts
Message-ID: <6cozacewv4sop77ilrqnervzpifinxki2ykef55awan2ka5jdf@sqyj7jed3qii>
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
 <3rdy3n6phleyz2eltr5fkbsavlpfncgrnee7kep2jkh2air66c@euczg54kpt47>
 <aUBjmHBHx1jsIcWJ@google.com>
 <rlwgjee2tjf26jyvdwipdwejqgsira63nvn2r3zczehz3argi4@uarbt5af3wv2>
 <aWgTjoAXdRrA99Dn@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWgTjoAXdRrA99Dn@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 02:07:10PM -0800, Sean Christopherson wrote:
> On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> > On Mon, Dec 15, 2025 at 11:38:00AM -0800, Sean Christopherson wrote:
> > > On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> > > > On Mon, Dec 15, 2025 at 07:26:54PM +0000, Yosry Ahmed wrote:
> > > > > svm_update_lbrv() always updates LBR MSRs intercepts, even when they are
> > > > > already set correctly. This results in force_msr_bitmap_recalc always
> > > > > being set to true on every nested transition, essentially undoing the
> > > > > hyperv optimization in nested_svm_merge_msrpm().
> > > > > 
> > > > > Fix it by keeping track of whether LBR MSRs are intercepted or not and
> > > > > only doing the update if needed, similar to x2avic_msrs_intercepted.
> > > > > 
> > > > > Avoid using svm_test_msr_bitmap_*() to check the status of the
> > > > > intercepts, as an arbitrary MSR will need to be chosen as a
> > > > > representative of all LBR MSRs, and this could theoretically break if
> > > > > some of the MSRs intercepts are handled differently from the rest.
> > > > > 
> > > > > Also, using svm_test_msr_bitmap_*() makes backports difficult as it was
> > > > > only recently introduced with no direct alternatives in older kernels.
> > > > > 
> > > > > Fixes: fbe5e5f030c2 ("KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > > 
> > > > Sigh.. I had this patch file in my working directory and it was sent by
> > > > mistake with the series, as the cover letter nonetheless. Sorry about
> > > > that. Let me know if I should resend.
> > > 
> > > Eh, it's fine for now.  The important part is clarfying that this patch should
> > > be ignored, which you've already done.
> > 
> > FWIW that patch is already in Linus's tree so even if someone applies
> > it, it should be fine.
> 
> Narrator: it wasn't fine.
> 
> Please resend this series.  The base-commit is garbage because your working tree
> was polluted with non-public patches, I can't quickly figure out what your "real"
> base was, and I don't have the bandwidth to manually work through the mess.
> 
> In the future, please, please don't post patches against a non-public base.  It
> adds a lot of friction on my end, and your series are quite literally the only
> ones I've had problems with in the last ~6 months.

Sorry this keeps happening, I honestly don't know how it happened. In my
local repo the base commit is supposedly from your tree:

	$ git show 58e10b63777d0aebee2cf4e6c67e1a83e7edbe0f

	commit 58e10b63777d0aebee2cf4e6c67e1a83e7edbe0f
	Merge: e0c26d47def7 297631388309
	Author: Sean Christopherson <seanjc@google.com>
	Date:   Mon Dec 8 14:58:37 2025 +0000

	    Merge branch 'fixes'

	    * fixes:
	      KVM: nVMX: Immediately refresh APICv controls as needed on nested VM-Exit
	      KVM: VMX: Update SVI during runtime APICv activation
	      KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
	      KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits
	      KVM: Harden and prepare for modifying existing guest_memfd memslots
	      KVM: Disallow toggling KVM_MEM_GUEST_MEMFD on an existing memslot
	      KVM: selftests: Add a CPUID testcase for KVM_SET_CPUID2 with runtime updates
	      KVM: x86: Apply runtime updates to current CPUID during KVM_SET_CPUID{,2}
	      KVM: selftests: Add missing "break" in rseq_test's param parsing

But then I cannot actually find it in your tree. Perhaps I rebased the
baseline patches accidentally :/

Anyway, I rebased and retested on top of kvm-x86/next and will resend
shortly.

