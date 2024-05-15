Return-Path: <stable+bounces-45167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FAB8C6741
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0657BB23664
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C508615E;
	Wed, 15 May 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5QiQDgM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DA14AB4;
	Wed, 15 May 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779383; cv=none; b=d260i0Mu/Gisf8JaLJ5uN0wzU0ngFytJLt6K/OejHeBhSxoJvSFaGRrqRFRJwVBwcZL/Cy9haqhriit+cT//PLbWKF9gdCxJd87dAfxYqi7WKjoGRAy1nidHHr458V100Ipn9Eota0rKT6FF0Dc0izYsEsYq4ClFQkcZYRku+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779383; c=relaxed/simple;
	bh=Wbg7b4ydt/+8jq5wvj6n6dJOlOXthP31qnywghWhedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXGqMLi7Y/H08U+PetUJL/gouzi0Q+f8hFBQZeXUOnIKsTkob+grR09MVFpY079CiOdyia3EyKSZ6BInt96DeR9NakMzsDBj5KkOJcj2fBmqDyXjSQ9sn+45hd0uNl8R+A0sFjSfROukBHOtHqRozakfVxUpeuo3RreTEBnoq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5QiQDgM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715779382; x=1747315382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wbg7b4ydt/+8jq5wvj6n6dJOlOXthP31qnywghWhedM=;
  b=U5QiQDgMPcwIhvE7mimXvooiRK6ny5Co6AzhsB3A74WZHJtYPOlNgAkq
   JwNnH5897DQEBuA4Mk7DrmTUJYTtbq8b+QR2sQzo1aTfKqH0jB4FdcMbt
   L/UmTcXEVOLeQPMoxzmXtzQoGmzvTbxshZLTXrfNFn5PweM2YQd8daFoQ
   bO7gxwBCWpQPjSIHnRPA9nALQSrssbFqaUfwq97YFv4XMZoGuR581s8Dz
   Q0QYdV4aFWZwy0ON6vy9dkZfggxAbm6CDTzpXZKgNY+7ZJuPESuF75FNj
   Jqx/9DX0kgqPaB6eykr5njYaOhCOJ5TgvPNZr4Lt0iwOkIh9AtLmyYnrM
   g==;
X-CSE-ConnectionGUID: nO8IaYXvTMarceGd4Y0kVA==
X-CSE-MsgGUID: GmtG3dNpSN+IzNbjGr67uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="14774802"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="14774802"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 06:23:01 -0700
X-CSE-ConnectionGUID: E0PZQ22fSbaKasd2DoLfUg==
X-CSE-MsgGUID: +xP9Ra5UQF2dyU0evu9TUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35935779"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2024 06:22:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 96B6197D; Wed, 15 May 2024 16:22:57 +0300 (EEST)
Date: Wed, 15 May 2024 16:22:57 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv4 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <l3yziplqp6cj7bwmimzzsld22bedmtnyj67q5tolbwez6jmpor@35xye7pkfd47>
References: <20240512122154.2655269-1-kirill.shutemov@linux.intel.com>
 <20240512122154.2655269-4-kirill.shutemov@linux.intel.com>
 <4019eff6-18a9-49b2-9567-096cdb498fb0@suse.com>
 <hlif565xmuj4oqdpap3boizepwg5ch3dssb67zzvy7i7smzp3n@x6hzdyc2qk4y>
 <8a5fa107-a055-4c05-bcb1-dc4044be841d@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a5fa107-a055-4c05-bcb1-dc4044be841d@suse.com>

On Wed, May 15, 2024 at 04:14:18PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.05.24 г. 12:30 ч., Kirill A. Shutemov wrote:
> > On Tue, May 14, 2024 at 05:56:21PM +0300, Nikolay Borisov wrote:
> > > > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > > > index 1ff571cb9177..ba37f4306f4e 100644
> > > > --- a/arch/x86/coco/tdx/tdx.c
> > > > +++ b/arch/x86/coco/tdx/tdx.c
> > > > @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
> > > >    		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
> > > >    }
> > > > +/* Read TD-scoped metadata */
> > > > +static inline u64 tdg_vm_rd(u64 field, u64 *value)
> > > > +{
> > > > +	struct tdx_module_args args = {
> > > > +		.rdx = field,
> > > > +	};
> > > > +	u64 ret;
> > > > +
> > > > +	ret = __tdcall_ret(TDG_VM_RD, &args);
> > > > +	*value = args.r8;
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > nit: Perhaps this function can be put in the first patch and the description
> > > there be made more generic, something along the lines of "introduce
> > > functions for tdg_rd/tdg_wr" ?
> > 
> > A static function without an user will generate a build warning. I don't
> > think it is good idea.
> > 
> 
> But are those 2 wrappers really static-worthy? Those two interfaces seem to
> be rather generic and could be used by more things in the future? OTOH when
> the time comes they can be exposed as needed.

Generally, functions have to static unless they used outside of the
translation unit.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

