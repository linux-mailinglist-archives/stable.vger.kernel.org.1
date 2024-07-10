Return-Path: <stable+bounces-58971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C81992CCA6
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17AAB21D19
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACC84E14;
	Wed, 10 Jul 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hcGI96pm"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58984D0F;
	Wed, 10 Jul 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599339; cv=none; b=bVBoNcVIgfCJgE3cy3ng8lDPuPrGe5MO9AM3Q1dNmAzErRYNsE0v9qIaUQHzIczVSNuIXQaR/MUE5P67H1AEGdlOVO6jOAk/d5IhCPf7xitQs90HGuHeICoFZpNnFSx/F10tTa3vkX4CqbAMQBfBGp5XQMe6pYcDxrDgbBEMvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599339; c=relaxed/simple;
	bh=XdXyR5tQq+aY/9Zj3nszauOHOFqQAtnCKqcowQQulG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwLCj99KjBN5fGCky1B+8eojjrhqlSBMVOLaGM79bHENzayoukh41FWX/3j+ICAUoSP6ux0puXcHjJlCH+QfZvdXXoYxDrj1rBPC9gfvlN+WHuftJzTxFhUpmim5uJhjObHexBh+1cvojCNTyWavahOtV+KGJCxzIjpta44NkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hcGI96pm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2004940E0027;
	Wed, 10 Jul 2024 08:15:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OAQjWQu05pHz; Wed, 10 Jul 2024 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720599323; bh=wwqvraycBFldrBQLx5UORin5Ztg1YnULrcBZets4RVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcGI96pmZtbjQLT6F7J1VsTnjsCRcVSX8+V0TrIbNi0OR/8PiHBQP5ctCzXLX7xre
	 379nsZa4/5CDurxtwPMEwde3FU8tr3p9HRHTNDaEMaKaf8HKrQYUXCvi9sQaPynJbB
	 8BM9zB1Q9ljtUPCPlFZgJfJZvO06jv3xq7COFWpYkDGfGwhBy/+xAJ5lVuo7bhExLG
	 yWw0mfZDdfT2kzdB/e1rj4PnQnqSjr4MQfGFKKdBymdA8oRMMVuqUtqoWDfEUbDJrk
	 I6hbY8flmrq/DACJDUuA7RW42cNoauTkYCAQULCVQWA6Me0quNGI9zAPT7P3g67AHE
	 vWrqCBm9JCYl+0fEsT/GjcGAahkUIGOsB9ABBb6HBel9fDxcILdkGMqIzV6+iImjPa
	 AuaPmh+1w4R5p7xf5mz/K6dgCpzKD/yEtNMYrFPMjwR0oZFtw6LpuLeIsl4xpCXT5r
	 3GknMSxaYBpViRQTly+9Uk7zJ5vwc3tesEzP4dX4RNLZn6PUexqzh/IGtqK8Q+k45Z
	 5tx0vwNOFjMYyNxfxrNO/dGDcPrxkWEbcihsRt5ej70kmHfLZXdsOoTcsV1N8Y12u7
	 9IMDlqAJo510h/GvRxvJ4k9xqMTrNbdoylpq3nVqfX+hXgKPFcPrSD5Ti0c83ygvLW
	 AhTKLmwxjE+mVooG35VjQex8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D7A9840E019D;
	Wed, 10 Jul 2024 08:15:08 +0000 (UTC)
Date: Wed, 10 Jul 2024 10:15:01 +0200
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
Message-ID: <20240710081501.GAZo5DBW3nvdzp34AI@fat_crate.local>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>

On Wed, Jul 10, 2024 at 07:48:14AM +0000, Dexuan Cui wrote:
> It's ok to me it will be after -rc1. I just thought the patch would get more
> testing if it could be on some branch (e.g., x86/tdx ?) in the tip.git tree, e.g.,
> if the patch is on some tip.git branch, I suppose the linux-next tree would
> merge the patch so the patch will get more testing automatically. 

Yes, it will get more testing automatically but the period is important: if
I rush it now, it goes to Linus next week and then any fallout it causes needs
to be dealt with in mainline.

If I queue it after -rc1, it'll be only in tip and linux-next for an
additional 7 week cycle and I can always whack it if it breaks something. If
it doesn't, I can send it mainline in the 6.12 merge window.

But we won't have to revert it mainline.

See the difference?

> I guess we have different options on whether "the patch has changed
> substantially". My impression is that it hasn't.

If you're calling the difference between what I reverted and what you're
sending now unsubstantial:

--- /tmp/old	2024-07-10 10:03:20.016629439 +0200
+++ /tmp/new	2024-07-10 10:02:23.696872729 +0200
 diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
-index c1cb90369915..abf3cd591afd 100644
+index 078e2bac25531..8f471260924f7 100644
 --- a/arch/x86/coco/tdx/tdx.c
 +++ b/arch/x86/coco/tdx/tdx.c
-@@ -7,6 +7,7 @@
- #include <linux/cpufeature.h>
+@@ -8,6 +8,7 @@
  #include <linux/export.h>
  #include <linux/io.h>
+ #include <linux/kexec.h>
 +#include <linux/mm.h>
  #include <asm/coco.h>
  #include <asm/tdx.h>
  #include <asm/vmx.h>
-@@ -778,6 +779,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
+@@ -782,6 +783,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  	return false;
  }
  
@@ -53,7 +86,7 @@ index c1cb90369915..abf3cd591afd 100644
  /*
   * Inform the VMM of the guest's intent for this physical page: shared with
   * the VMM or private to the guest.  The VMM is expected to change its mapping
-@@ -785,15 +799,22 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
+@@ -789,15 +803,30 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
   */
  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
  {
@@ -63,23 +96,34 @@ index c1cb90369915..abf3cd591afd 100644
 +	unsigned long end = start + numpages * PAGE_SIZE;
 +	unsigned long step = end - start;
 +	unsigned long addr;
- 
--	if (!tdx_map_gpa(start, end, enc))
--		return false;
++
 +	/* Step through page-by-page for vmalloc() mappings */
 +	if (is_vmalloc_addr((void *)vaddr))
 +		step = PAGE_SIZE;
++
++	for (addr = start; addr < end; addr += step) {
++		phys_addr_t start_pa;
++		phys_addr_t end_pa;
++
++		/* The check fails on vmalloc() mappings */
++		if (virt_addr_valid(addr))
++			start_pa = __pa(addr);
++		else
++			start_pa = slow_virt_to_phys((void *)addr);
+ 
+-	if (!tdx_map_gpa(start, end, enc))
+-		return false;
++		end_pa = start_pa + step;
  
 -	/* shared->private conversion requires memory to be accepted before use */
 -	if (enc)
 -		return tdx_accept_memory(start, end);
-+	for (addr = start; addr < end; addr += step) {
-+		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
-+		phys_addr_t end_pa   = start_pa + step;
-+
 +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
 +			return false;
 +	}
  
  	return true;
  }

especially for a patch which is already known to break things and where we're
especially careful, then yes, we strongly disagree here.

So yes, it will definitely not go in now.

> I started to add people's tags since v4 and my impression is that since then
> it's rebasing and minor changes.

When version N introduces changes like above in what is already non-trivial
code, you drop all tags. And if people want to review it again, then they
should give you those R-by tags.

Also, think about it: your patch broke a use case. How much are those R-by
tags worth if the patch is broken? And why do you want to hold on to them so
badly?

If a patch needs to be reverted because it breaks a use case, all reviewed and
acked tags should simply be removed too. It is that simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

