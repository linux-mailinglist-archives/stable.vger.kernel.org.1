Return-Path: <stable+bounces-58047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBE9276B3
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC9F1F24F8A
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF81AC221;
	Thu,  4 Jul 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSxntTHM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBE13BADF;
	Thu,  4 Jul 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098222; cv=none; b=L4DqS9eF01OSRrFkjuIRBbOJ9XcxUWXMfEm0tnZ1Z0niiP4CicwRXI7MZNQPZ/UCZi7UeXbOfLDd4WZvo8AwGRMXTFNtNSyJyGWlDOmDoUFEQAq9Vh9Hh2zs7wD15ZLxQ5z47r2YmvC5yHcXfdqUPP2IIN6JstPxd+OlfrZQ450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098222; c=relaxed/simple;
	bh=uZ9UsEweFbXbxOBABtQ/dWLo0fnez7wNxhKZkX2xznc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzW3XlHPHfAuTimZ/Vv3gsbeQHAM2yDa5U4l7d/+oJxZT9p6JHdOd5fHCvdhhI9GN4JwEcvkWUcroM3fACATHW27o1BrUdXFP8/KYREW0LiTTUAr/VWcjWw2m6g+6fcR5PAa3CaHbv3BqgMJkZLkHQL6eO5T1nGADIKRX+gk9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSxntTHM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720098221; x=1751634221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZ9UsEweFbXbxOBABtQ/dWLo0fnez7wNxhKZkX2xznc=;
  b=MSxntTHM4MELE4RbKvYvSglpUEN9MrOPcNAL9NEbUO6A65+V5Gqy11ev
   EijSvw44DysoEwiFzlXVMqlsd9CQWYl8GrZ3hcrZtkavYtdlGJSZhRUXa
   uU3gHaMOWGdq01YIBdlkOCxmbD+pr87g9s8wLHun1Y7H72myWsYbqhHoR
   uQtLX/5JQK93RmnHUXOmwTlg28iT5yvceF6WoY8Fwr+AMJibjCr8C+gJB
   qd1iUrMg4YC3PaQaQPTzzChKWejWMaFf81ieQTK6hLFSpH8uHDgiadfUP
   ZByIJNAZk3Bws8Rrdh5yvT1LrLVQ6QV8CoIeCISTOeUIjsIxcuhmblluw
   g==;
X-CSE-ConnectionGUID: 4E6mSGVsQyyDkSgXutWh0w==
X-CSE-MsgGUID: NRCPQEdKS52+yNXiO971IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="27980951"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27980951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 06:03:40 -0700
X-CSE-ConnectionGUID: o/YWOEYtTSOuRT37J1hNvw==
X-CSE-MsgGUID: +XbghcdiQr67hCyYBw/pcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77335407"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 04 Jul 2024 06:03:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 783F522B; Thu, 04 Jul 2024 16:03:36 +0300 (EEST)
Date: Thu, 4 Jul 2024 16:03:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <4sqvd3zghwp5o23r2s47i56qg34obammtggbtneof26ghbwrxv@rskezsmaqgim>
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
 <05d0b24a-2e21-48c0-85b7-a9dd935ac449@suse.com>
 <oujihwk2ghwpobsuivxlgflalwxigctjp6nld2jdtz4cbwoqnp@7v3s7ap4ul6u>
 <3b164525-f797-478a-a75c-1c2bd83086af@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b164525-f797-478a-a75c-1c2bd83086af@intel.com>

On Wed, Jul 03, 2024 at 07:49:48AM -0700, Dave Hansen wrote:
> On 7/3/24 06:04, Kirill A. Shutemov wrote:
> >>> -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> >>> +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> >>> +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> >> 0x9110000300000016
> >>> +#define TDCS_TD_CTLS			0x11104800000017
> >> 0x9110000300000017
> > Setting bit 63 in these field id is regression in new TDX spec and TDX
> > module. It is going to be fixed in next version. Both versions of field
> > ids are going to be valid.
> 
> I kinda never liked the big ol' magic numbers approach here.  But could
> we please introduce some helpers here?
> 
> Then we'll end up with something like this (if the 0x111 can't be
> decomposed):
> 
> #define _TDCS_CMD(c)	((0x1110UL << 48) | (c))
> 
> #define TDCS_CONFIG_FLAGS _TDCS_CMD(0x16)
> #define TDCS_TD_CTLS	  _TDCS_CMD(0x17)
> 
> Then when folks change their mind about what should be in the TDX spec,
> we have one place to go fix it up in addition to making this all more
> readable.

Hm. I am not sure about this. It can be tedious if we want to encode all
info this way. Like, size of the field, number of elements in the
field, number of elements in the sequence, etc. It is going to be macro on
the macro on the macro. I don't think it would improve readability.

On related note, I think the TDX 1.5 definitions of field ids are more
useful as you can infer more info from them. I consider to switching all
definitions to the new format. It effectively drops TDX 1.0 support as the
newly used bits are reserved in 1.0.

TDX module 1.0 is no longer supported, but kernel haven't broken anything
from the guest side yet. I don't think anybody actually uses it and I need
to jump hoops to get it running for validation.

Any objections for dropping TDX 1.0 support?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

