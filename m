Return-Path: <stable+bounces-108575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786BA10141
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C3F3A67A9
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 07:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4675233156;
	Tue, 14 Jan 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JydE2mjS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B4240235;
	Tue, 14 Jan 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736839650; cv=none; b=GS4mXkNTVwmh0/hMloiwev4LVya27/Ozld1tGpVOFTQcEPcilGlBdELC7LKEMC0GA8GBgf1f1+Ee1mGraL/27AYj3USw4HJx97ZL8HQinWLKLdQODLso5bdCPe8GHDa8773QYD+Ver9nvAX+dXcXMr9Hklg9MjCQkW3vSKQagQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736839650; c=relaxed/simple;
	bh=KJfe9nVlEn8D3imcOLIM2aumy8f4v35mSshgLI8XJhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI1uvAL8uXWTCS8CavdGHNxKkm17LI4kdL64VyIrfdy740nmJ/CTyx0OhLwqo+L1W5yYMsPZqSwNnmQ4kzYX+6Q1QWQASXUtlL4MpIH85cFgSspvM08WhFMSX+7V8xVqlhC4ix3Gk5iXXFhmqwmWTSeMdAkeWTl8NRfydrKXw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JydE2mjS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736839649; x=1768375649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJfe9nVlEn8D3imcOLIM2aumy8f4v35mSshgLI8XJhM=;
  b=JydE2mjSyn+7BxXuVGoLQ5zanJkpq81GYkDpEpCeDrrmBJWpALOIjSQq
   b/DlXXsC6sXgkleId77MSL+qgPCck80xYVzhyYPGP27jZX5CPxnEagHyw
   pxHLcjuyoIylP3ubO+PLEAHIzzjhjjmhyTHoRdsg8derDXymx4W8tjHrk
   AZnK1xYF7fML9O90MPRh12QhI5R/TGRqE+XeBYxaoibD0ia0ZELHDld2o
   LcFsbVP3ChZEOP6meuQoNllA1OE5Xgk7mLyhNFrzpiSv4EftgPK+thFVp
   BMjmN6M3MYw0VBG1niaVsHoAef5m1vc1GneLfb2ip9ptIVWBISzvaZRjf
   Q==;
X-CSE-ConnectionGUID: UTwq5YWcQCOgG9WRXrTVaw==
X-CSE-MsgGUID: ufYZPSs5R5OdLAtWFIFuqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48505553"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="48505553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 23:27:26 -0800
X-CSE-ConnectionGUID: yfW+ptOYR5mGfoxEhg0Blg==
X-CSE-MsgGUID: lzW8z/BNT229n2J3J5ggdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="105286103"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 13 Jan 2025 23:27:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 773212A6; Tue, 14 Jan 2025 09:27:18 +0200 (EET)
Date: Tue, 14 Jan 2025 09:27:18 +0200
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
Message-ID: <vuj7mlvkvazuz5noupusqt2bk42vjkr5lkgivnrub2nby4ma6y@7ezpclbirwcs>
References: <20250113131459.2008123-1-kirill.shutemov@linux.intel.com>
 <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
 <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532becb-f2be-4458-5d34-77070f2c5e2d@amd.com>

On Mon, Jan 13, 2025 at 02:47:56PM -0600, Tom Lendacky wrote:
> On 1/13/25 07:14, Kirill A. Shutemov wrote:
> > Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> > 
> > memremap(MEMREMAP_WB)
> >   arch_memremap_wb()
> >     ioremap_cache()
> >       __ioremap_caller(.encrytped = false)
> > 
> > In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
> > if the resulting mapping is encrypted or decrypted.
> > 
> > Creating a decrypted mapping without explicit request from the caller is
> > risky:
> > 
> >   - It can inadvertently expose the guest's data and compromise the
> >     guest.
> > 
> >   - Accessing private memory via shared/decrypted mapping on TDX will
> >     either trigger implicit conversion to shared or #VE (depending on
> >     VMM implementation).
> > 
> >     Implicit conversion is destructive: subsequent access to the same
> >     memory via private mapping will trigger a hard-to-debug #VE crash.
> > 
> > The kernel already provides a way to request decrypted mapping
> > explicitly via the MEMREMAP_DEC flag.
> > 
> > Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
> > default unless MEMREMAP_DEC is specified.
> > 
> > Fix the crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.
> 
> This patch causes my bare-metal system to crash during boot when using
> mem_encrypt=on:
> 
> [    2.392934] efi: memattr: Entry type should be RuntimeServiceCode/Data
> [    2.393731] efi: memattr: ! 0x214c42f01f1162a-0xee70ac7bd1a9c629 [type=2028324321|attr=0x6590648fa4209879]

Could you try if this helps?

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590..b5051dcb7c1d 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -160,7 +160,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 	if (WARN_ON(!efi_enabled(EFI_MEMMAP)))
 		return 0;
 
-	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB);
+	tbl = memremap(efi_mem_attr_table, tbl_size, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!tbl) {
 		pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
 		       efi_mem_attr_table);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

