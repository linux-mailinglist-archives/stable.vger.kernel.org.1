Return-Path: <stable+bounces-74007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E09716E6
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323B51C22D13
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EBC1B583E;
	Mon,  9 Sep 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWw15fUy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8451B3735;
	Mon,  9 Sep 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881390; cv=none; b=qMJEwdoKwwd4hPTnVm25ixs0ImnxljDqXynhlyxTcnYEYrsIy1IiQ98BN6TRxbwdl7eT4ClYTyqwhVhlCiYy+F812gABR9Vr91xpoLjhcp9fuimhLj0hgaJPwfNtmXbBRHqcU4fMQE22AEdeN1dFEOgn45CiiuPOF26bJH9c2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881390; c=relaxed/simple;
	bh=N/oRHbYAMKFAKUpDtfEq7Erb9OiUoM/9NotgDl/AUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTAMo/tqClwMxscOFc0UDkocsMIqVcJ0Aw7swSS4IdTamo2/f+1gCWdQo7Dmj7Qqg/UF1mnxSTuA8SCTpsZLy1KEwy/dnv+r5nR0NAgpS8xN7xvXJwjYnwt8ZWw54598bG0VXY031bhO6bEm8xNMaAsA9IxT/HjDBBAVB+IsQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWw15fUy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725881388; x=1757417388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N/oRHbYAMKFAKUpDtfEq7Erb9OiUoM/9NotgDl/AUOI=;
  b=XWw15fUyl2oRT5D4R1HeQ2HrpL+O2ie+ECJLEhbA6Kzyna44kN4fi97a
   K435MGlz+zdxaN8r2+BRkRNQ0v1vCo0nj646pyecZcSZQdoxU9+wieY/3
   bEXge6qSRgTicwmcLhJE2t6sfXi39t1IfYpeyWAzDrcuYisFDlQRqGsJ9
   ecdjd1M1C5Pa7P+EoSIPKM2JNXYnvxkGO+Z+NoHg8M+9Sr/Genv5NVPA/
   WbjVRt7i6OJo0SO1TlqZ5QLmSWFGWyZJuOUBT68Eo7KNGikKcQA0p20bN
   ZyFZZ7MUTKLOQyh/ALnrzPUUT+gb2fuKtYMFboCu6EUqItS4Tw4vrTkBL
   g==;
X-CSE-ConnectionGUID: dBkmqq62T7ClMzLl60kqpA==
X-CSE-MsgGUID: qfQ1mxGFQWCkHNKp3t5jWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28456309"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="28456309"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 04:29:48 -0700
X-CSE-ConnectionGUID: y1k9qXhnSTmaFD6klw4wqw==
X-CSE-MsgGUID: NYjaBJ5rTBOj92o+Jc+wgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66885614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 04:29:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EC567321; Mon, 09 Sep 2024 14:29:43 +0300 (EEST)
Date: Mon, 9 Sep 2024 14:29:43 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv6 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <k6sk7qmumm4lkvfd26m2r2pd7yv4rosp4zbdpfurznlz5n3a4t@c5sh77tlmjxj>
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
 <20240828093505.2359947-4-kirill.shutemov@linux.intel.com>
 <0dce2a59-544a-4e98-b895-ce5848778108@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dce2a59-544a-4e98-b895-ce5848778108@suse.com>

On Wed, Aug 28, 2024 at 05:27:32PM +0300, Nikolay Borisov wrote:
> 
> 
> On 28.08.24 г. 12:35 ч., Kirill A. Shutemov wrote:
> > Memory access #VEs are hard for Linux to handle in contexts like the
> > entry code or NMIs.  But other OSes need them for functionality.
> > There's a static (pre-guest-boot) way for a VMM to choose one or the
> > other.  But VMMs don't always know which OS they are booting, so they
> > choose to deliver those #VEs so the "other" OSes will work.  That,
> > unfortunately has left us in the lurch and exposed to these
> > hard-to-handle #VEs.
> > 
> > The TDX module has introduced a new feature. Even if the static
> > configuration is set to "send nasty #VEs", the kernel can dynamically
> > request that they be disabled. Once they are disabled, access to private
> > memory that is not in the Mapped state in the Secure-EPT (SEPT) will
> > result in an exit to the VMM rather than injecting a #VE.
> > 
> > Check if the feature is available and disable SEPT #VE if possible.
> > 
> > If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> > attribute is no longer reliable. It reflects the initial state of the
> > control for the TD, but it will not be updated if someone (e.g. bootloader)
> > changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> > determine if SEPT #VEs are enabled or disabled.
> 
> LGTM. However 2 minor suggestions which might be worth addressing.
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 373e715e31bf ("x86/tdx: Panic on bad configs that #VE on "private" memory access")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kai Huang <kai.huang@intel.com>
> > ---
> >   arch/x86/coco/tdx/tdx.c           | 76 ++++++++++++++++++++++++-------
> >   arch/x86/include/asm/shared/tdx.h | 10 +++-
> >   2 files changed, 69 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 08ce488b54d0..f969f4f5ebf8 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -78,7 +78,7 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
> >   }
> >   /* Read TD-scoped metadata */
> > -static inline u64 __maybe_unused tdg_vm_rd(u64 field, u64 *value)
> > +static inline u64 tdg_vm_rd(u64 field, u64 *value)
> >   {
> >   	struct tdx_module_args args = {
> >   		.rdx = field,
> > @@ -193,6 +193,62 @@ static void __noreturn tdx_panic(const char *msg)
> >   		__tdx_hypercall(&args);
> >   }
> > +/*
> > + * The kernel cannot handle #VEs when accessing normal kernel memory. Ensure
> > + * that no #VE will be delivered for accesses to TD-private memory.
> > + *
> > + * TDX 1.0 does not allow the guest to disable SEPT #VE on its own. The VMM
> > + * controls if the guest will receive such #VE with TD attribute
> > + * ATTR_SEPT_VE_DISABLE.
> > + *
> > + * Newer TDX modules allow the guest to control if it wants to receive SEPT
> > + * violation #VEs.
> > + *
> > + * Check if the feature is available and disable SEPT #VE if possible.
> > + *
> > + * If the TD is allowed to disable/enable SEPT #VEs, the ATTR_SEPT_VE_DISABLE
> > + * attribute is no longer reliable. It reflects the initial state of the
> > + * control for the TD, but it will not be updated if someone (e.g. bootloader)
> > + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> > + * determine if SEPT #VEs are enabled or disabled.
> > + */
> > +static void disable_sept_ve(u64 td_attr)
> > +{
> > +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
> > +	bool debug = td_attr & ATTR_DEBUG;
> > +	u64 config, controls;
> > +
> > +	/* Is this TD allowed to disable SEPT #VE */
> > +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
> > +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
> 
> Should you check for the presence of those controls in in
> TDX_FEATURES0.PENDING_EPT_VIOLATION_V2 ? I.e perhaps this code can be put in
> the same function that checks the presence of RBP_NO_MOD in a different
> series by Kai Huang?

No. TDX_FEATURES0 check is not required. This bit in TDCS_CONFIG_FLAGS
cannot be anything else than FLEXIBLE_PENDING_VE and checking only this
bit is enough.

> 
> 
> > +		/* No SEPT #VE controls for the guest: check the attribute */
> > +		if (td_attr & ATTR_SEPT_VE_DISABLE)
> > +			return;
> 
> nit: Given that we expect most guests to actually have this attribute set
> perhaps moving this check at the top of the function will cause it exit
> early more often than not?

The attribute is not reliable source if flexible VE controls are present
as I mentioned in the commit message. We can only rely on it if there's no
TDCS_CONFIG_FLEXIBLE_PENDING_VE.

> > +
> > +		/* Relax SEPT_VE_DISABLE check for debug TD for backtraces */
> > +		if (debug)
> > +			pr_warn("%s\n", msg);
> > +		else
> > +			tdx_panic(msg);
> > +		return;
> > +	}
> > +
> > +	/* Check if SEPT #VE has been disabled before us */
> > +	tdg_vm_rd(TDCS_TD_CTLS, &controls);
> > +	if (controls & TD_CTLS_PENDING_VE_DISABLE)
> > +		return;
> > +
> > +	/* Keep #VEs enabled for splats in debugging environments */
> > +	if (debug)
> > +		return;
> > +
> > +	/* Disable SEPT #VEs */
> > +	tdg_vm_wr(TDCS_TD_CTLS, TD_CTLS_PENDING_VE_DISABLE,
> > +		  TD_CTLS_PENDING_VE_DISABLE);
> > +
> > +	return;
> > +}
> > +
> >   static void tdx_setup(u64 *cc_mask)
> >   {
> >   	struct tdx_module_args args = {};
> 
> <snip>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

