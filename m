Return-Path: <stable+bounces-58287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7392B62C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F081F22B15
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB5157A4F;
	Tue,  9 Jul 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AhhcefCX"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BD155389;
	Tue,  9 Jul 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523244; cv=none; b=s2pCGiX1e6ln38otZTnzbR3vwLExiOdIovRJvnDE7w6UHxvtd1z4VVI+8re/NlPfnBtAhuZDuDhXdjT7COCCY6YWbKmKNDXPU20iaN3ry4GNVN0VShsSx1hcCohkWQ4ot3UlCfWSipQY9ZSF54zV9YvgKE+q2XPY888vRdOEx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523244; c=relaxed/simple;
	bh=ZQfO6yaxvGPGddmV/JKSFfpd7XOGtVMtsvCFc2pp4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBfNX0jVeOatw8uWdsdbfmg6Is5CV9TSA3SUTd5lWo+CKWdKqYRYuRYGGuMKkR+NNp1As8z6YLX3KcdP+MuNYJJF8NEnX7yRvqdXthZ43L4y8X/t3dPa6FFrF2w/6b7lEB7JbGjH2cCFOaJDzPKJ5urbmmt3qUoNk/SaCyxox/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AhhcefCX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A8D840E019D;
	Tue,  9 Jul 2024 11:07:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JulpA9dQV5i9; Tue,  9 Jul 2024 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720523235; bh=zM5vw2X4vXpF2Weeo34wNg92YVwfkbif2ErMikAhomk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhhcefCX8GcIWDqFu+CTWnaGOI8YROW+o6+kE/EBLRUy8wBbjOwQSMEYWpBjcewtt
	 Kw3JyPCLj2ge+an+LZvW76/2PJgtXq0Gu/6KWZdgTjErlsPthfe1bRXyXDOqTSJElo
	 JsLYoTsQkBnLO09zbMXR1QjBdXbyaiIzrOCzlHNgBmvps6DpiR/HMGAi0zY6Qndds7
	 ngyFkDuacq13fW/JXW7QgwCwCjs6mxHCsR3qCfCJOlpY/f7j7o2bBLmp14Qe/4WIcA
	 cjMywPLZ2keKPx3AlfAvSfUOj0+42DxBb47K5pX6eY2WaNeG6GN8KE9FQFjPaVhXBf
	 7K0ZpdQpokWNU1P+W0RXU0AESICYqyIohVQOybFUkl2oNZpBRt2WupCHEOskKZmtp+
	 jJ5+1jOZx69JRXpIZwWcdik17n7jRf2AeWD2pOXhNkn3eEgN297aCKX255PVst1Gmb
	 +VJLxcLsgGWcCWY4+Snbe65Dki70zCMaBvKqlK1sGu5tb+jVr7RovLvjLCydf38VyP
	 Z4xcoYuFM/LZPrpdA0WZLeCEDSMzjjCV+lXOFtgjI5qYktZERz4uVIiaAkm2HaTWi+
	 yIsQNgx8nLvA0X5Z8vCUffbj0sg+OzzjxG5jVq0QfhPhFz10YxDCr6chy5mFUOtw9B
	 xRYy6A1TLjpks9S3y0J7VGso=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0282E40E0192;
	Tue,  9 Jul 2024 11:07:00 +0000 (UTC)
Date: Tue, 9 Jul 2024 13:06:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Message-ID: <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>

On Mon, Jul 08, 2024 at 09:45:24PM +0000, Dexuan Cui wrote:
> x86/tdx: Fix set_memory_decrypted() for vmalloc() buffers
> 
> When a TD mode Linux TDX VM runs on Hyper-V, the Linux hv_netvsc driver
> needs to share a vmalloc()'d  buffer with the host OS: see
> netvsc_init_buf() -> vmbus_establish_gpadl() -> ... ->
> __vmbus_establish_gpadl() -> set_memory_decrypted().
> 
> Currently set_memory_decrypted() doesn't work for a vmalloc()'d  buffer
> because tdx_enc_status_changed() uses __pa(vaddr), i.e., it assumes that
> the 'vaddr' can't be from vmalloc(), and consequently hv_netvsc fails
> to load.
> 
> Fix this by handling the pages one by one.
> 
> hv_netvsc is the first user of vmalloc() + set_memory_decrypted(), which
> is why nobody noticed this until now.
> 
> v6.6 is a longterm kernel, which is used by some distros, so I hope
> this patch can be in v6.6.y and newer, so it won't be carried out of tree.

So this is a corner-case thing. I guess CC:stable is ok, we have packported
similar "fixes" in the past.

> I think the patch (without Kirill's kexec fix)  has been well tested, e.g.,
> it has been in Ubuntu's linux-azure kernel for about 2 years. Kirill's 
> kexec fix works in my testing and it looks safe to me. 

You seem to think that a patch which has been tested in some out-of-tree
kernel,

- gets modified
- gets applied to the upstream kernel
- it *breaks* a use case,

and then it can still be considered tested.

Are you seriously claiming that?!

> I hope this can be in 6.11-rc1 if you see no high risks. 
> It's also fine to me if you decide to queue the patch after 6.11-rc1.

Yes, it will be after -rc1 because what you consider "tested" and what I do
consider "tested" can just as well be from two different planets.

> > > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> https://lwn.net/ml/linux-kernel/20230412151937.pxfyralfichwzyv6@box/

Since you'd go the length to quote the mail messages which gave you the tags
but you will not read what I point you to, lemme read it for you:

"Both Tested-by and Reviewed-by tags, once received on mailing list from
tester or reviewer, should be added by author to the applicable patches when
sending next versions.  However if the patch has changed substantially in
following version, these tags might not be applicable anymore and thus should
be removed.  Usually removal of someone's Tested-by or Reviewed-by tags should
be mentioned in the patch changelog (after the '---' separator)."

From Documentation/process/submitting-patches.rst

Again, if you want to keep sending patches to the kernel, I'd strongly urge
you to read that document!

> This is not really a newly submitted patch :-)

If you still think that and you want to keep your tags, all I can give you is
a big fat NAK until you read and understand how the process works.

Your decision.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

