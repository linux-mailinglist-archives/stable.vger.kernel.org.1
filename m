Return-Path: <stable+bounces-57922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E864926161
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E3D1C20E30
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79E178367;
	Wed,  3 Jul 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8bMvv4G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04137136986;
	Wed,  3 Jul 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011869; cv=none; b=h82V59a5GN/6+sRGqhMnl6TnBoPnZhPMJhLO2cIMX8qVQxbBpW/5DaTv5Ae6/j40fiTOW17SMzd0QtQy2j7/8cU5lIrJNksOSLM/EP5Z9XSUDCtGTonIk3yjb2DRL9JWSINxOFo2uYMtNhTGGfy1dABrhYtFKIltKeXOQ5ncGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011869; c=relaxed/simple;
	bh=oatb/h0wiAkJxZ0BcqIZuCcpxjldh9yKP555vVf00uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlS5vovUcpkUTqZo3ZBjV+ObVfhreFxgm/C1k/4Ywjw1A63c39Badw6mxzv3Dz/jFplRmIoxcCMtCQRRWyLZrpnQHC5RVxRBDq51i8hZ1mYA4l5qTt1ftqPw89ANO79pl6DCbmmcdWm9SjzNHLiJLioOejoA6c7pa8RBSA4o3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8bMvv4G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720011868; x=1751547868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oatb/h0wiAkJxZ0BcqIZuCcpxjldh9yKP555vVf00uI=;
  b=W8bMvv4GtxYvco+H3E4IG+VS4oJ9Mi9o5hqcjJ4tjtrCkd0lzFidpH7A
   8ChxRTAduxpQ6UDzsm3gsujeAKxyj0JbK5gAwegDbFFYQjAGXZK8BM/jt
   8BodI7oaS9UY01/sD86hm05pM9mE2xpPDhLEg9Ue2b3QY1fExjQon+Bv3
   yiFRUIPxd4jzdssHx60S+Ahm7Dk6DLuC6bFvWWSDSjXkBcGGpFEwi6ugl
   SIbZdxLQgCAnOw3a3ro7FjCS2j4pSjJ6NsvVQJVC18I7RrYc4ikYoPULU
   SbdA++VR4HuCeqox8+najKc4b3H5gelw3P7hXNxj/FBkC99NIyUVS+K+X
   w==;
X-CSE-ConnectionGUID: UekKHiaHRiWEkk+6hfq6nw==
X-CSE-MsgGUID: kiA0hPb8TNC5b98xN9/CyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27855320"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27855320"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:04:26 -0700
X-CSE-ConnectionGUID: jWlEzqgwRcO16/X/cv05kw==
X-CSE-MsgGUID: CQBcOgWnQb6uiJtQhpQfTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50557465"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 03 Jul 2024 06:04:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0FFE2194; Wed, 03 Jul 2024 16:04:22 +0300 (EEST)
Date: Wed, 3 Jul 2024 16:04:22 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <oujihwk2ghwpobsuivxlgflalwxigctjp6nld2jdtz4cbwoqnp@7v3s7ap4ul6u>
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
 <05d0b24a-2e21-48c0-85b7-a9dd935ac449@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05d0b24a-2e21-48c0-85b7-a9dd935ac449@suse.com>

On Wed, Jul 03, 2024 at 02:39:09PM +0300, Nikolay Borisov wrote:
> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index 7e12cfa28bec..fecb2a6e864b 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -19,9 +19,17 @@
> >   #define TDG_VM_RD			7
> >   #define TDG_VM_WR			8
> > -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> > +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> > +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> 0x9110000300000016
> > +#define TDCS_TD_CTLS			0x1110000300000017
> 0x9110000300000017

Setting bit 63 in these field id is regression in new TDX spec and TDX
module. It is going to be fixed in next version. Both versions of field
ids are going to be valid.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

