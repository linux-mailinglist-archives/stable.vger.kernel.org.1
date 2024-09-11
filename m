Return-Path: <stable+bounces-75835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28612975328
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B71C223F2
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE61885B8;
	Wed, 11 Sep 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoPiNejF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA41156C6C;
	Wed, 11 Sep 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059821; cv=none; b=qAEHuWAR6hHFuFDWdj42ZW/DI+/d/CxXWtItgqqxY0PCc03y/fEopDbJ8zHgV//cMSDIGI5uVZ4+DvN/5FqU/34ojNyYdithaURHA3rgotKvBjILPH8PSuWhN6tLWm4G+9+ErqM23AO+1RjsxneMsCy7YAVoISjh4nQMcNVc8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059821; c=relaxed/simple;
	bh=06KUJ6FSLxBVrfoCMTs/MWMdnJKm/uUyZyDWiPvPxm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwOr7RPQcYwU5fhCwscA9Fq/i7QKg5kJgZ/+nPDwWcoHlu0+KR1T0lPYpdJCTECJSLl0EpkxE9/YI8/8rRUlmdTAjxWdOrmSbKrpVPGVqTV3rtXUp/L9Pfmw1iAwkJRv0XASfguuZLyNF3gVjTSK1sGyW6ITq1Abf2XrJ3RYcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoPiNejF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726059820; x=1757595820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=06KUJ6FSLxBVrfoCMTs/MWMdnJKm/uUyZyDWiPvPxm0=;
  b=FoPiNejFZa75Xvqq1L6e6t2Tn3qdEDiR6E+5QSRB6y+lkXI0Cw1mcHz5
   q0rzP7kD11FbnQI2OoT6j7eZdeJJ3x5DiT/7jeovJ9jmzBRAH49IFp+X1
   xlc7PPPOVF9QUskPOtJ4JYLzqzc46ejdRpFPPkMDLaqxwQ4X0A0Ap2cZm
   JXhID4ZdxCPoEOOZpcBwT0LrfCtcWvZ7Mx0J5VfSaPlFTqDwwIUxP9Ok8
   UQcKRKEz4HIm+Ew8w4l53jHEXMYawQI4fpQcByW5yGvwBNckGQHnqYEWu
   fCIJhSNWmCi3J/llP/t9VJrXRRri0bD47SlOW1ni9gHP50h5Zzb2m0OAW
   g==;
X-CSE-ConnectionGUID: 9kkHQUEyR8SLv6IhFQIi8A==
X-CSE-MsgGUID: 2lCGWjQsTa2dFGbOP7mTyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="47375161"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="47375161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 06:03:40 -0700
X-CSE-ConnectionGUID: quJw22cRT7al/h7UKBNqYw==
X-CSE-MsgGUID: cExRptkVTTCixmES8/hz4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="68128173"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2024 06:03:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DB83F192; Wed, 11 Sep 2024 16:03:33 +0300 (EEST)
Date: Wed, 11 Sep 2024 16:03:33 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/6] x86/tdx: Fix "in-kernel MMIO" check
Message-ID: <ijxp5xk6kq7gk4myfaijnq5vunrq6tcoqu3eoqoy6n7qfvvqjg@5ca372qmmy2o>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <398de747c81e06be4d3f3602ee11a7e2881f31ed.1725622408.git.legion@kernel.org>
 <24ec1497-af03-4e65-abb4-db89590fb28e@intel.com>
 <ZuGITwFiv5X3wg0y@example.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuGITwFiv5X3wg0y@example.org>

On Wed, Sep 11, 2024 at 02:08:47PM +0200, Alexey Gladkov wrote:
> On Tue, Sep 10, 2024 at 12:54:19PM -0700, Dave Hansen wrote:
> > On 9/6/24 04:49, Alexey Gladkov wrote:
> > > +static inline bool is_kernel_addr(unsigned long addr)
> > > +{
> > > +	return (long)addr < 0;
> > > +}
> > > +
> > >  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > >  {
> > >  	unsigned long *reg, val, vaddr;
> > > @@ -434,6 +439,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > +	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
> > > +		WARN_ONCE(1, "Access to userspace address is not supported");
> > > +		return -EINVAL;
> > > +	}
> > 
> > Should we really be open-coding a "is_kernel_addr" check?  I mean,
> > TASK_SIZE_MAX is there for a reason.  While I doubt we'd ever change the
> > positive vs. negative address space convention on 64-bit, I don't see a
> > good reason to write a 64-bit x86-specific is_kernel_addr() when a more
> > generic, portable and conventional idiom would do.
> 
> I took arch/x86/events/perf_event.h:1262 as an example. There is no
> special reason in its own function.
> 
> > So, please use either a:
> > 
> > 	addr < TASK_SIZE_MAX
> > 
> > check, or use fault_in_kernel_space() directly.
> 
> I'll use fault_in_kernel_space() since SEV uses it. Thanks.

Also user_mode() check is redundant until later in the patchset. Move it
to the patch that allows userspace MMIO.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

