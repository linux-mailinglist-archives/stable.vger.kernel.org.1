Return-Path: <stable+bounces-108603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5952A109A2
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D633AA111
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9515574E;
	Tue, 14 Jan 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzP7KTYC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72137150981;
	Tue, 14 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865860; cv=none; b=A3B6zmamehkrWquG4vEQivTw/dvOCfDH3Yo6z+JpVRZmJ5O6osfIj8mSqtp2DFRJkGfLl5DMQQSf/e0MjSZMQ56DEBOR1WjIlhIeWqSZviBQzpXkIXAFNlBhQ9m8HPveghQutjhPhLbwq5BfqxBCdbDaOUVt4ZTAATOgBiwcp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865860; c=relaxed/simple;
	bh=Wt6Jj95+PYNqxpsm1cs8AMmqyXIhoQDmPbP216JDWbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMHr2atLcZveLAjt9ydQo2tSaMhGGzFFu5z7twF4nL6Bv0lcvtg5BqYrkJ9cz5U6/K0fKEUx/16yTuGHAfbU+Mga9uKFRDWMnsopb786BRBJQ1Q7A1BZc6BHNAP8E4VTzEwX2ZzRrhcZ2z2bIe7JCI6MRz/VHeC32umliyRsBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzP7KTYC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736865857; x=1768401857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wt6Jj95+PYNqxpsm1cs8AMmqyXIhoQDmPbP216JDWbc=;
  b=dzP7KTYCPewlEnDa1/HpQdN9i3m5ihnLK7mPkR4wmWSWclazSo+qNV2h
   SHWvlz6MOKu3Uocxxi/KrNflWSOwe2YSIhYCfqz1sgH7Sc+16pH+YojfP
   NjmpnknNf+fN2KYm99FJ29XMFPC/ysDs4ay9F4ThZ60cYrfdZIuzngm7f
   hFbTSHWDLehU6hA8aqWVUKkt3znsyck0xnPxaIgdzwZHPlBLTwR1h1JAC
   S5mAFCIFAb104OtiQT8DbZEq8fYZToJ3g8q8TI9lejE1VCPBdnF/lFgIY
   J6dBd9gZyTg2SpRBFqTlK0wVuCvqmWuFPg+4gH2OLaTgfWHA6GatZDwha
   Q==;
X-CSE-ConnectionGUID: OmUW2A+JQ/eOQiO2sny6wg==
X-CSE-MsgGUID: dsulq8MbQa6TtvfAhjuE1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47829523"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="47829523"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:44:13 -0800
X-CSE-ConnectionGUID: JdH1HnLSS7mX4lYDcCZNUg==
X-CSE-MsgGUID: O+YI7V2YS3Kgh2RHy9TmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109970974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 14 Jan 2025 06:44:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 948DE39C; Tue, 14 Jan 2025 16:44:04 +0200 (EET)
Date: Tue, 14 Jan 2025 16:44:04 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Chan <ericchancf@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kai Huang <kai.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Russell King <linux@armlinux.org.uk>, Samuel Holland <samuel.holland@sifive.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv3 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <2nc5silj5wbj6kz5tcsutgcjx6wviobhem4z24x4ya2r4q4ra5@5rixeg2wo7c3>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
 <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
 <vuj7mlvkvazuz5noupusqt2bk42vjkr5lkgivnrub2nby4ma6y@7ezpclbirwcs>
 <9981e3f5-1414-dd82-c6ad-379289575b07@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9981e3f5-1414-dd82-c6ad-379289575b07@amd.com>

On Tue, Jan 14, 2025 at 08:33:39AM -0600, Tom Lendacky wrote:
> On 1/14/25 01:27, Kirill A. Shutemov wrote:
> > On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
> >> On 1/13/25 07:14, Kirill A. Shutemov wrote:
> >>> Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> >>>
> >>> memremap(MEMREMAP_WB)
> >>>   arch_memremap_wb()
> >>>     ioremap_cache()
> >>>       __ioremap_caller(.encrytped = false)
> >>>
> >>> In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
> >>> if the resulting mapping is encrypted or decrypted.
> >>>
> >>> Creating a decrypted mapping without explicit request from the caller is
> >>> risky:
> >>>
> >>>   - It can inadvertently expose the guest's data and compromise the
> >>>     guest.
> >>>
> >>>   - Accessing private memory via shared/decrypted mapping on TDX will
> >>>     either trigger implicit conversion to shared or #VE (depending on
> >>>     VMM implementation).
> >>>
> >>>     Implicit conversion is destructive: subsequent access to the same
> >>>     memory via private mapping will trigger a hard-to-debug #VE crash.
> >>>
> >>> The kernel already provides a way to request decrypted mapping
> >>> explicitly via the MEMREMAP_DEC flag.
> >>>
> >>> Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
> >>> default unless MEMREMAP_DEC is specified.
> >>>
> >>> Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
> >>
> >> This patch causes my bare-metal system to crash during boot when using
> >> mem_encrypt=on:
> >>
> >> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
> >> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]
> > 
> > Could you try if this helps?
> > 
> > diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> > index c38b1a335590..b5051dcb7c1d 100644
> > --- a/drivers/firmware/efi/memattr.c
> > +++ b/drivers/firmware/efi/memattr.c
> > @@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
> >  	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
> >  		return 0;
> >  
> > -	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
> > +	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);
> 
> Well that would work for SME where EFI tables/data are not encrypted,
> but will break for SEV where EFI tables/data are encrypted.

Hm. Why would it break for SEV? It brings the situation back to what it
was before the patch.

Note that that __ioremap_caller() would still check io_desc.flags before
mapping it as decrypted.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

