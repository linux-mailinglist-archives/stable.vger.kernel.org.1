Return-Path: <stable+bounces-203109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4820CD12FB
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38336302EA0C
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA433A710;
	Fri, 19 Dec 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7J+Jsiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB002BEC4A
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165912; cv=none; b=XIabraY2fZPBNTfnNv1516Xhe6DaWBmHOGRK4zkS2gCJLb3/q/3z97SyktoBG3dmQqtwhud0E5SQCF1M2xH02oxrYiVIHiMnjufSeCuwBSCi4OmfqziM8sP208fsT0hls2JZCggKtTOeZQMiikry20bLm15fquMghOQI82fGcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165912; c=relaxed/simple;
	bh=ASfT4gSNSrvEamX0B/fST3i4V9CA9tioQB1/+KicrRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XErLSmj2NF4dhR3fsonUq5KcNDwQrv91H5IlC15IVkYkIOqyO/nh090TInHp4d9+TysElCJ9TZLlaDqgMQWMOt3zos1TD7t9J4HkD5xBEcWn8n+h6AXDK1/njka0/dHMGqj0yd9F+SyA265ufW2jun8abY/xFfocPWfoZi7Gyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7J+Jsiq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7dd05696910so3071362b3a.2
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766165911; x=1766770711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbOhKn22cTFMoKpf/GXkxISQsKfNfALH2jWSUuo5nak=;
        b=f7J+JsiqwoiSUgezDiegKOa6zpmptFntlUJU6zGin06BAHV98XD1vNi4MgSviuyt8t
         bCLrWOzXfMWpvNtGhSXONOF8FnJyu9GKtTTtwkzZy6NEO+fv4HNWqff8On3qdSoQ4Lrv
         dqxzhK40+1hE0iJWrUvxkne/x//eJjRtmu4fEgIlpoX83MNLQVNWPCmnvNn9Zn/Ztbom
         ioWwefi/zvDblpdpIzJg/qOfc8p/INCAwZEW4bcZtOhT+vVFnq9jSDFSd4QSK+YzjOJr
         qvQqlpmnRE6s6vDuufnUxgOI+7l2OYeSHSk1/NH7C0SnECtPd5PF1Vmtd2mO7CcZkrUr
         ngYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165911; x=1766770711;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbOhKn22cTFMoKpf/GXkxISQsKfNfALH2jWSUuo5nak=;
        b=T11OgvqZg4ti6XJRZuafhWVyx6uV2RdvH+B0zcpI+bvwLN30Stcz7vrWLWFF6kr+ez
         5wVTY60QDWNMzbwkjY1U2c/3BRelRkRXkeAAYfLEEuEfe9vd9zDqx9NxOQ/JQowCdF8T
         0+uuSjaccQAvghjYktvTjAhbRhOuwMwRnBvjW8FypfAOJzL3dT+JLehSW4D9b1rTu8XM
         L1yCn7ZtERGTatl28g4K9OFueCBBf5Sg5nmqQxOlor5ngXPxltTbABMPKzjOdkSf9QXU
         AcFLXRh+Jfql1vPHm4618AAihKM6VtPDLwGLcBWbJPMcss9l75oFhWJ/G9G1gc34AqAz
         2Nyg==
X-Forwarded-Encrypted: i=1; AJvYcCUwZ3JtxPd4qXWpX9yP8LJJuoHFSkwh3N+cjcvdvyxywoB4kEps5qmUaXvZExgPfbAgosnAM6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnrd7/jbOKw1HIoUVkdhGsG/ALvWAPO/UQGwGBhRZ0Sa3Pn5H
	SgBDqFTPfL4RcGE2SoD+N6EexD0YQWEdeoPclXItT66LEUQIbtd2ma/RolMoy7K5NIMMJP9KLTh
	aHvjmaQ==
X-Google-Smtp-Source: AGHT+IFwzWgtPptIOyQJLby5S982+3QC2rN4V2KVy1J/lj/jLP6cxRNrCIT8QnhPtZST1lAtZV6zpA10OhY=
X-Received: from pfbfb38.prod.google.com ([2002:a05:6a00:2da6:b0:76b:f0d4:ac71])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140e:b0:7ff:885f:9c2a
 with SMTP id d2e1a72fcca58-7ff885fa2d7mr3264079b3a.12.1766165910740; Fri, 19
 Dec 2025 09:38:30 -0800 (PST)
Date: Fri, 19 Dec 2025 09:38:29 -0800
In-Reply-To: <dbe68678-0bc4-483f-aef3-e4c7462bcaff@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219010131.12659-1-ariadne@ariadne.space> <dbe68678-0bc4-483f-aef3-e4c7462bcaff@vates.tech>
Message-ID: <aUWNlTAmbSTXsBDE@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
From: Sean Christopherson <seanjc@google.com>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, 
	kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, 
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	xen-devel@lists.xenproject.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025, Teddy Astie wrote:
> Le 19/12/2025 =C3=A0 02:04, Ariadne Conill a =C3=A9crit=C2=A0:
> > Xen domU cannot access the given MMIO address for security reasons,
> > resulting in a failed hypercall in ioremap() due to permissions.
> >
> > Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset"=
)
> > Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> > Cc: xen-devel@lists.xenproject.org
> > Cc: stable@vger.kernel.org
> > ---
> >   arch/x86/kernel/cpu/amd.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> > index a6f88ca1a6b4..99308fba4d7d 100644
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -29,6 +29,8 @@
> >   # include <asm/mmconfig.h>
> >   #endif
> >
> > +#include <xen/xen.h>
> > +
> >   #include "cpu.h"
> >
> >   u16 invlpgb_count_max __ro_after_init =3D 1;
> > @@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(voi=
d)
> >   	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> >   		return 0;
> >
> > +	/* Xen PV domU cannot access hardware directly, so bail for domU case=
 */
> > +	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain())
> > +		return 0;
> > +
> >   	addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value)=
);
> >   	if (!addr)
> >   		return 0;
>=20
> Such MMIO only has a meaning in a physical machine, but the feature
> check is bogus as being on Zen arch is not enough for ensuring this.
>=20
> I think this also translates in most hypervisors with odd reset codes
> being reported; without being specific to Xen PV (Zen CPU is
> unfortunately not enough to ensuring such MMIO exists).
>=20
> Aside that, attempting unexpected MMIO in a SEV-ES/SNP guest can cause
> weird problems since they may not handled MMIO-NAE and could lead the
> hypervisor to crash the guest instead (unexpected NPF).

IMO, terminating an SEV-ES+ guest because it accesses an unknown MMIO range=
 is
unequivocally a hypervisor bug.  The right behavior there is to configure a
reserved NPT entry to reflect the access into the guest as a #VC.

