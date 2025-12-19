Return-Path: <stable+bounces-203108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085FCD12C6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9961300CE06
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BB22A817;
	Fri, 19 Dec 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YieKKMnL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791002C11D3
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165809; cv=none; b=ZPNurGBqOxFFGmddH8SITpyaiZaAj3nnD/PpA9ACKnsBQECrkz+nHlAZB17DOl73yUS+6o7zO7mh3Rk7qOJaqUKsH7LdlYSF54grxPpFWR30Uo3z5o8h2HY8xxPfCiXS/Y4Aef5zu7wUFv7FRqmRFUyYJIfJdelNeSiR7gz9VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165809; c=relaxed/simple;
	bh=GU7KTsDpfXcrTIVP3GuYKqaVe9Kr2qBa23o7wiCu3Wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FA5AVeySCx/r2mh2VNrLb0pOL+rOC2jHm4icbFkIUP/m0Twa1EJNZ/LUShtpIPGdw8GWcDq2ILjHpuu0QwMEH5hMWv84vyQeThsONjG8ekXDKHf0MRKIe2ekbjOshHHteJLPBHI2yocerAUSWa3D6cfVhmyFs30IJywWlPGAJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YieKKMnL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0f47c0e60so48702145ad.3
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766165807; x=1766770607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqnyJGm9t/ZyJN7mQeBjdnUbXeTdowYt1l4KyYLgPcE=;
        b=YieKKMnL3Yr6t6JWKs/9Goqkr3qXj2XOsmUl5Ch4wsJho1cjyJ1VK6HHJg/znilJ2Q
         jvtQVPHfB4CLkUffWcjvaoeKApL3zEdXIfhJArVHINpSYM0eTchKQD9INBxIE3WbpWIb
         cJ0dB4yoI7BOXnG9oBOoLyUmgeIksQ5nGyrpMyg1WplERI5VKUphzU9s9mIK11kBKZtV
         HjoB2UZc/PQXtTrTQHgAXTzaS7k3wcS3m29QTT20syeg35KNKyKsEFkF35YFMLVGNJwh
         N1wCn3layMS7ThQ4KQv+cwVVh41ezx4cXM1Z4kDvRKOW5uaOunb9Dm5akEO+TVO88ZvO
         vEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165807; x=1766770607;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RqnyJGm9t/ZyJN7mQeBjdnUbXeTdowYt1l4KyYLgPcE=;
        b=r9QJt9SXXLK8BJNQioH6Z9mmrT2HmRFcC78fnMaPvCNlf2oQBj80+GuJIzoezrbrsB
         mQXi/bVabVRwc3pUfYj/PNnLftOODEpcKSuNU5rVlc5T8jveGiEmNbrDzMCrEUICWaWQ
         r+b2jRBX+3iTnzehhGHqoWXbN9yd7tDH/DYNd+A9YYa9vyjFmueHEay+/Waa1d7N3gqc
         BIwI8IcO+F1D92HrYWB7X4m4Wuo8qVq4vyH4zkDH75NjiN6d0LWuvL0BLAg5/JIbe16t
         OuVxdh/UO1YjExKc6RIw7q+eMwc4GbhcwcrDpm9YsmuBF00HwVRUsyNf6azQzft86TYH
         A3JA==
X-Forwarded-Encrypted: i=1; AJvYcCXOBCO6M8vwIN9g8yh3O/T3h8jAtA5Mz1GKPiRrZgQ2K8l3iPiMDaFWyyReZnyo2/6XZEK6F4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdU7vF+LKbfbx41AgozFFmR+8Gvyr3HbYAMaiRlmPX1eQrHjQS
	/ZMGysILNxTvK68VjDiJih2xyQQISCSls3C9MOXrP9op8Un60DFIWjTFFZbmlQP7FiZE33rHkI2
	qvMqHpQ==
X-Google-Smtp-Source: AGHT+IHQHE/zSpVReAa4QYKKE9L22G3Nm8CEtCKN+zptcqFuHVITJGNdcTVWwZJuDaA8gysKF1rlDI2aruk=
X-Received: from pldd12.prod.google.com ([2002:a17:902:c18c:b0:29e:fd13:927b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fb0:b0:2a0:7f87:2347
 with SMTP id d9443c01a7336-2a2f2a536ebmr35477985ad.46.1766165806775; Fri, 19
 Dec 2025 09:36:46 -0800 (PST)
Date: Fri, 19 Dec 2025 09:36:45 -0800
In-Reply-To: <e2632ad6-6721-4697-a923-53b5bb0c9f0f@citrix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219010131.12659-1-ariadne@ariadne.space> <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
 <aUV4u0r44V5zHV5f@google.com> <e2632ad6-6721-4697-a923-53b5bb0c9f0f@citrix.com>
Message-ID: <aUWNLUEme9FCUeAb@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>, Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, 
	kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, 
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, xen-devel@lists.xenproject.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025, Andrew Cooper wrote:
> On 19/12/2025 4:09 pm, Sean Christopherson wrote:
> > On Fri, Dec 19, 2025, Borislav Petkov wrote:
> >> On December 19, 2025 1:01:31 AM UTC, Ariadne Conill <ariadne@ariadne.s=
pace> wrote:
> >>> Xen domU cannot access the given MMIO address for security reasons,
> >>> resulting in a failed hypercall in ioremap() due to permissions.
> > Why does that matter though?  Ah, because set_pte() assumes success, an=
d so
> > presumably the failed hypercall goes unnoticed and trying to access the=
 MMIO
> > #PFs due to !PRESENT mapping.
> >
> >>> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last rese=
t")
> >>> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> >>> Cc: xen-devel@lists.xenproject.org
> >>> Cc: stable@vger.kernel.org
> >>> ---
> >>> arch/x86/kernel/cpu/amd.c | 6 ++++++
> >>> 1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> >>> index a6f88ca1a6b4..99308fba4d7d 100644
> >>> --- a/arch/x86/kernel/cpu/amd.c
> >>> +++ b/arch/x86/kernel/cpu/amd.c
> >>> @@ -29,6 +29,8 @@
> >>> # include <asm/mmconfig.h>
> >>> #endif
> >>>
> >>> +#include <xen/xen.h>
> >>> +
> >>> #include "cpu.h"
> >>>
> >>> u16 invlpgb_count_max __ro_after_init =3D 1;
> >>> @@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(v=
oid)
> >>> 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> >>> 		return 0;
> >>>
> >>> +	/* Xen PV domU cannot access hardware directly, so bail for domU ca=
se */
> > Heh, Xen on Zen crime.
> >
> >>> +	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain()=
)
> >>> +		return 0;
> >>> +
> >>> 	addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value)=
);
> >>> 	if (!addr)
> >>> 		return 0;
> >> Sean, looka here. The other hypervisor wants other checks.
> >>
> >> Time to whip out the X86_FEATURE_HYPERVISOR check.
> > LOL, Ariadne, be honest, how much did Boris pay you?  :-D
> >
> > Jokes aside, I suppose I'm fine adding a HYPERVISOR check, but at the s=
ame time,
> > how is this not a Xen bug?  Refusing to create a mapping because the VM=
 doesn't
> > have a device defined at a given GPA is pretty hostile behavior for a h=
ypervisor.
>
> This is a Xen PV guest.=C2=A0 No SVM/VT-x.
>=20
> A PV Guest (by it's contract with Xen) cannot create mappings to host
> physical addresses it doesn't own.

Huh, assuming wiki.xenproject.org[*] can be trusted, TIL Xen PV has no noti=
on
of a virtual motherboard/chipset:

  In a paravirtualized VM, guests run with fully paravirtualized disk and
  network interfaces; interrupts and timers are paravirtualized; there is n=
o
  emulated motherboard or device bus; guests boot directly into the kernel
  in the mode the kernel wishes to run in (32-bit or 64-bit), without needi=
ng
  to start in 16-bit mode or go through a BIOS; all privileged instructions
  are replaced with paravirtualized equivalents (hypercalls), and access to
  the page tables was paravirtualized as well.

[*] https://wiki.xenproject.org/wiki/Understanding_the_Virtualization_Spect=
rum

> Xen rejects the attempt, and Linux is ignoring the failure in this case.=
=C2=A0
> This has been ABI for 25 years.

Heh, I suspected as much.

> From a more practical point of view, because guests can read their own
> pagetables, Xen can't swap the requested PTE for safe alternative to
> trap the MMIO access, because that violates Linux's model of what's
> mapped in this position.

That all makes sense, but shouldn't the inability to ioremap() chipset MMIO=
 be
addressed in ioremap()?  E.g. after poking around a bit, commit 6a92b11169a=
6
("x86/EISA: Don't probe EISA bus for Xen PV guests") fudged around the same
underlying flaw in eisa_bus_probe().  Ha!  Though maybe that's no longer ne=
cessary
as of 80a4da05642c ("x86/EISA: Use memremap() to probe for the EISA BIOS si=
gnature")?

Anyways, I'm still opposed to using HYPERVISOR.  E.g. given that Dom0 can a=
pparently
access host MMIO just fine, and that it's perfectly reasonable for a KVM-ba=
sed VMM
to emulate the chipset, assuming a guest doesn't have access to some asset =
is simply
wrong.

But rather than play whack-a-mole, can't we deal with the ignore PTE write =
failures
in ioremap()?  E.g. something like this?

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..b7e2c752af1d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -29,6 +29,8 @@
 #include <asm/memtype.h>
 #include <asm/setup.h>
=20
+#include <xen/xen.h>
+
 #include "physaddr.h"
=20
 /*
@@ -301,6 +303,20 @@ __ioremap_caller(resource_size_t phys_addr, unsigned l=
ong size,
        if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
                goto err_free_area;
=20
+       /*
+        * Verify the range was actually mapped when running as a Xen PV Do=
mU
+        * guest.  Xen PV doesn't emulate a virtual chipset/motherboard, an=
d
+        * disallows DomU from mapping host physical addresses that the dom=
ain
+        * doesn't own.  Unfortunately, the PTE APIs assume success, and so
+        * Xen's rejection of the mapping is ignored.
+        */
+       if (xen_pv_domain() && !xen_initial_domain()) {
+               int level;
+
+               if (!lookup_address(vaddr, &level))
+                       goto err_free_area;
+       }
+
        ret_addr =3D (void __iomem *) (vaddr + offset);
        mmiotrace_ioremap(unaligned_phys_addr, unaligned_size, ret_addr);

