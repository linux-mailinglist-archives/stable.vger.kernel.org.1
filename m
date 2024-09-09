Return-Path: <stable+bounces-74005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED89716CB
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC6284004
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4891B5EDD;
	Mon,  9 Sep 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI0c6nn7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A61B5ED8;
	Mon,  9 Sep 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881083; cv=none; b=hBIqZAutvtqQYLXo8b6REx84qp8ezAlbz9oYC6LYiiLkEH5PoaUidE/qnsiFaW+EHIcIsKHEpLjstPNDk6oEy39W+O197BlDFIidtDkytABCQY3IwTcWnC9FKhgg73fLZijoqqul+pZLzepvuHo4TuDrtVlhLF4aI3+w08pJsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881083; c=relaxed/simple;
	bh=ZnHPFe2fwIxePToIasZRpCel4w9o2a9xvZOFvjDcjFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf4YfX4IhFtxL4v+h/kh3LGb48WCD/qK8q2CYdTbRYRCGeMu/QzE5r+GnB3tABvHty2zt2Ar3f4Ai63ntFaKQLMwsf02RxyK+tAipPwtPN286rQq2Z3eU6dZJCwKgljsExIaYrjtLOxdg+GYa+aDxu9CorDLfzQVmoTDjV91TSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI0c6nn7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725881082; x=1757417082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZnHPFe2fwIxePToIasZRpCel4w9o2a9xvZOFvjDcjFA=;
  b=dI0c6nn7kby01z2Taglmf4TjG4L6E2dgwwF/j5uC5dkc+fCL7dVccgfv
   UkHBUgwZ5hkFVKmZ7C3+yE0NtOQwdfgZDcbfn14kk4TEuaWjjtTCUzymx
   AcPhUwdZOLyvw9Efm7L6Tf1YlRmPOJp1I/N+8bt4+JoYQxIW9WnuU3/kZ
   miRCMmrOELQLuyrkePlfZooj4zvvMcSHcOWqKcS92HzyIrMayKEULdweI
   UuhZRnnLBAct+ENj2p+i+ho+MvgUvEMFJfL7mOiRNZBZOxgdKPgvzhFfr
   JDm3xZdW3fTSis7udLyyL4qPF8yhmUJyGdh8+5rz8/+scEsmwt3oGQNxF
   w==;
X-CSE-ConnectionGUID: jJBJGgy1SOG4yO752SaIVw==
X-CSE-MsgGUID: l1TG8rRESROrUKPfvQShsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24732875"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24732875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 04:24:31 -0700
X-CSE-ConnectionGUID: fcgDdeyhTW64bIsEl8dGcw==
X-CSE-MsgGUID: K2LS0eo5TiOHIjfkxupmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71423923"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 09 Sep 2024 04:24:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9A8C8321; Mon, 09 Sep 2024 14:24:26 +0300 (EEST)
Date: Mon, 9 Sep 2024 14:24:26 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv6 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Message-ID: <q5yhj3hpe74h6payob6sw2agr6mlfjqe3b7g6hqehjgivpmvbd@5w3tl3gjjlbf>
References: <20240828093505.2359947-1-kirill.shutemov@linux.intel.com>
 <20240828093505.2359947-3-kirill.shutemov@linux.intel.com>
 <e042faa6-91be-49bb-ae59-e87792756fa4@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e042faa6-91be-49bb-ae59-e87792756fa4@suse.com>

On Wed, Aug 28, 2024 at 04:53:57PM +0300, Nikolay Borisov wrote:
> 
> 
> On 28.08.24 г. 12:35 ч., Kirill A. Shutemov wrote:
> > Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
> > there.
> > 
> > The function will be extended to adjust TD configuration.
> 
> <offtopic>
> Since this deals with renaming, I think it will make sense to rename
> tdx_early_init() to tdx_guest_init/tdx_guest_early_init as it becomes
> confusing as to which parts of the TDX pertain to the host and which to the
> guest. Right now we only have the guest portions under arch/x86/coco/tdx but
> when the kvm/vmx stuff land things will become somewhat messy..
> </offtopic>

I don't see a problem with the current state. KVM side will land under
arch/x86/virt/vmx/tdx, so the path will give it away.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

