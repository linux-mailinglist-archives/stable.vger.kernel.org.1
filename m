Return-Path: <stable+bounces-132445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745EA87FE3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830C11743A0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB729AAE5;
	Mon, 14 Apr 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4paE3YO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D13280A52;
	Mon, 14 Apr 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631960; cv=none; b=rs3p9Da7y+rYZBKWrNep5Lpm4yfpqbdZ5Hc5KvInYHIkIRNbmRbTUhw8CWoZ4CjvBwCCDULgWoL02dQ1NaErFocexjetd9a5H1vU5jULNVblMz3gzgl4sL8rYZT52etBjVYK5XjGh+UeA/ULF4LNjp16XRXJ5J+b6qoOau3OaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631960; c=relaxed/simple;
	bh=HhUNCGHDmttJtUwyGmHZlFL1eGuPPKuEhYw9AsNBbhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cuw/E59oYCOSL8RwVxYitPFZA/lfDTnLi6x17a0/7Qs4UwEo7ZIawsBzQ5sASdsy8cYKx53NAJJJC5WDLcDiK3W7UEr4Ss0UZ9rFsmRtb9NYbPmxBOqNe7qAcccTYOcsiU7IoEzfp1863/IjZUqXXKecw9pxqq7mjiKLKxnkUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4paE3YO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744631958; x=1776167958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhUNCGHDmttJtUwyGmHZlFL1eGuPPKuEhYw9AsNBbhA=;
  b=m4paE3YOxBNzUEp5YYv+g2A6SrYLx+wHyP/NaUBHs82F/hqHMrn5/3wP
   VF/H9yp6x7Tmhq+KBKVL68XD0aI1iwVEVlPAlImAxQvgQdqv8TxNSL1m3
   59RD2k8KLATt6HPmd/VkemLGRXScp+wXrOyE9r+vqxQ9EuvzJljMBPf8w
   sbYDIK1AOvZg0yHgVH9zNS90rJTNP+GZ093k2XSgBcsUq+JhQ2PVMTDw3
   OP0g+d4wGJSOay6uJfVTbpikgB3trZ559eyYg9SeKSS3FU+Ioimm7ZQYy
   AmFlqbQpTROW7j0YV0H3f2MpOlLrzUZ1Wjikm713hmkILittVddqBdfXl
   g==;
X-CSE-ConnectionGUID: czzQH/ZrSAm6r85O5yOhpA==
X-CSE-MsgGUID: Ju80VftETK648AoLZLks0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46230372"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46230372"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 04:59:15 -0700
X-CSE-ConnectionGUID: Bl+mOcO+RBeGjRc1KKl3Hg==
X-CSE-MsgGUID: MXlTTwyzTGy7X2kGQqjkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="152990903"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 14 Apr 2025 04:59:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7EC558D1; Mon, 14 Apr 2025 14:59:11 +0300 (EEST)
Date: Mon, 14 Apr 2025 14:59:11 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero" has been added to the 6.14-stable tree
Message-ID: <zsvsv723jviiktxgjfpevjq3fzdmn36pavhkrv3dkwq7pegghe@tbaz4aqkdgt3>
References: <20250414103727.580274-1-sashal@kernel.org>
 <nk543is45cokcdjnnovpopirhqlejfp3xgzs4wdpjyyskumw5w@fbw5bqq3x3mt>
 <2025041450-filled-varnish-f9d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025041450-filled-varnish-f9d3@gregkh>

On Mon, Apr 14, 2025 at 01:56:00PM +0200, Greg KH wrote:
> On Mon, Apr 14, 2025 at 02:36:55PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Apr 14, 2025 at 06:37:27AM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     x86/mm/ident_map: Fix theoretical virtual address overflow to zero
> > > 
> > > to the 6.14-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      x86-mm-ident_map-fix-theoretical-virtual-address-ove.patch
> > > and it can be found in the queue-6.14 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > It was explicitly called out that no backporting needed:
> > 
> > >     [ Backporter's note: there's no need to backport this patch. ]
> 
> Now dropped thanks,

BTW, is there any magic words for this? Tag or something?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

