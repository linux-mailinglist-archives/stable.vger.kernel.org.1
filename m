Return-Path: <stable+bounces-198152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE71C9D34A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF5F4E3E1E
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6022FA0F2;
	Tue,  2 Dec 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAhPPj+H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C62F7ABE
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714400; cv=none; b=NpJECHcl82yTnhXCSluU+Adfx61rq3bDllKQAUtKzfNPHKT4t8Hpu7JtStUhzJIGtbKpeped6anT7PD8avUI8FG7FMPcn7k6Pp1sMtNLi0kNZWbISWlF/s207M6DKC7YzVEDJ5UW5BtOnQIXKGurKMPlgaSwUig6j0FM6zUxUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714400; c=relaxed/simple;
	bh=rHwN2/sAdchfHT7Zb5HAP3imgxuZsM9T/sqYZAk/6WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Py2zJbZaIYCcb8FYfIfPkzhGjlJmmnI1vZm7sWEYdcQz21Qc6bKa3M4Jjh2Ct/i21BprIx/4kX/57B+mCrcuyX/1iBwHy+mZor9CHZhLW3OLkoT4t5lGIWSXsPKGhiNevddm1i11CW0Xwxiu1LH3L0kIdqG3BFqlsh9bTtmuLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAhPPj+H; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so5851382b3a.1
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764714398; x=1765319198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+lZwWACySoeFUTre/rpZS/RF15vQtVnd6re+B4HeIE=;
        b=kAhPPj+HwejeC1fBp+kmjXHGC5jFMeRWxGDZkKpbqIss8ZM9BPgqu8RC5bn7wAc2hp
         Rpyh4nPDAtyLnCw7OLBHRpyG7lwZZlXor6zqfZXklszpaOGH5U+40JJBCOJ44GzPSe1u
         EExawkpvG6P5brkx6XbmrvouOQONL0UcX4mf4XHdT8l5qKk2s5BX3CYNfBMe93pbxsLY
         DyNGnQoQWkp/SM60kIL67JbBCI/9dhkS4VIbjvf6X5OWf/2zAxZrsUNrbE0kgE2nEd7h
         mCVcYTu0DC93TAC6+VDSPQVskogB75gzjtvlKrKeruYQhlAaJTcv4KvEiBt9XFs9NsgF
         FLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714398; x=1765319198;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z+lZwWACySoeFUTre/rpZS/RF15vQtVnd6re+B4HeIE=;
        b=R7rv8ryxsiN8ssw7jb7qN2fk63g9X1qIHMQxsDJFEaBv4FonIZD27vdnMcPaMGZ/t2
         AFxkJfeLmIghf+YgUreTf0tBw3pIQDWD3ZBiLFB8ntiM+HF4NBYZGcd/hCuLwqIiCDJl
         cxOXLkT4E2RSZgCLrlCJ32WZI1ahFMegQDbrIHFYZvZK9OxZICUI2vgSckKhuXafeMew
         YiGeJjzZWX8poX2ZZ/GPNeK+98Do6kOF6qhkyAepXVsFBQ5MeTZIFOfDfzSPyeLKDsuV
         9VlcVnsVmOjJ4zvWTrbjNlzi1TPFoWOC8XNkzywAxWioseujnbH06/YvGgZPFkcAxyO8
         cNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNEb+eYeqTkfErXnQ2uR5n7pPtZTbHc0+Sltr7Ir/V8Pm7wAvgUw0w6Hb6lh1k+VUeV2Yyu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VmVCGhyBTi0zV+FeXl9VDDq88Qn6xuH4/vsxNv/Ebt65uCQC
	SXRnOO+/cNHAdnpLy3Qcbvjgz76hU8bzxcRJq6eKiIOn2vvVYdoPxMEQea6dOov6zpalY3ZFkeP
	zVEekqg==
X-Google-Smtp-Source: AGHT+IE1BvPtitsWzBS6Ac1tWd884WiXjHWVm75ZLNM3IZD9rkoEJZ62MBJVcyofgFVYw2C6GLmN7Xerad0=
X-Received: from pgaq5.prod.google.com ([2002:a63:4305:0:b0:bac:6acd:8181])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9148:b0:35d:d477:a7ea
 with SMTP id adf61e73a8af0-363f5d4b09cmr428731637.19.1764714397963; Tue, 02
 Dec 2025 14:26:37 -0800 (PST)
Date: Tue, 2 Dec 2025 14:26:36 -0800
In-Reply-To: <fac971fe6625456f3c9ad69d859008117e35826a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251125180557.2022311-1-khushit.shah@nutanix.com>
 <6353f43f3493b436064068e6a7f55543a2cd7ae1.camel@infradead.org>
 <A922DCC2-4CB4-4DE8-82FA-95B502B3FCD4@nutanix.com> <118998075677b696104dcbbcda8d51ab7f1ffdfd.camel@infradead.org>
 <aS8I6T3WtM1pvPNl@google.com> <68ad817529c6661085ff0524472933ba9f69fd47.camel@infradead.org>
 <aS8Vhb66UViQmY_Q@google.com> <fac971fe6625456f3c9ad69d859008117e35826a.camel@infradead.org>
Message-ID: <aS9ng741Osi91O_v@google.com>
Subject: Re: [PATCH v3] KVM: x86: Add x2APIC "features" to control EOI
 broadcast suppression
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Khushit Shah <khushit.shah@nutanix.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kai.huang@intel.com" <kai.huang@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	Jon Kohler <jon@nutanix.com>, Shaju Abraham <shaju.abraham@nutanix.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025, David Woodhouse wrote:
> On Tue, 2025-12-02 at 08:36 -0800, Sean Christopherson wrote:
> >=20
> > Hmm, I suppose that could work for uAPI.=C2=A0 Having both an ENABLE an=
d a DISABLE
> > is obviously a bit odd, but slowing down the reader might actually be a=
 good
> > thing in this case.=C2=A0 And the documentation should be easy enough t=
o write.
> >=20
> > I was worried that having ENABLE and DISABLE controls would lead to con=
fusing code
> > internally, but there's no reason KVM's internal tracking needs to matc=
h uAPI.
> >=20
> > How about this?
> >=20
> > ---
> > =C2=A0arch/x86/include/asm/kvm_host.h |=C2=A0 7 +++++++
> > =C2=A0arch/x86/include/uapi/asm/kvm.h |=C2=A0 6 ++++--
> > =C2=A0arch/x86/kvm/lapic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++++++++++-
> > =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++++---
> > =C2=A04 files changed, 38 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 5a3bfa293e8b..b4c41255f01d 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1226,6 +1226,12 @@ enum kvm_irqchip_mode {
> > =C2=A0	KVM_IRQCHIP_SPLIT,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
created with KVM_CAP_SPLIT_IRQCHIP */
> > =C2=A0};
> > =C2=A0
> > +enum kvm_suppress_eoi_broadcast_mode {
> > +	KVM_SUPPRESS_EOI_QUIRKED,
> > +	KVM_SUPPRESS_EOI_ENABLED,
> > +	KVM_SUPPRESS_EOI_DISABLED,
> > +};
> > +
>=20
> Looks good. I'd probably call it KVM_SUPPRESS_EOI_LEGACY though?

Why legacy?  "Quirk" has specific meaning in KVM: technically broken behavi=
or
that is retained as the default for backwards compatibility.  "Legacy" does=
 not,
outside of a few outliers like HPET crud.

> And just for clarity I wouldn't embed the explicit checks against e.g
> arch.suppress_eoi_broadcast !=3D KVM_SUPPRESS_EOI_LEGACY. I'd make static
> inline functions like

Ya, definitely no objection,
=20
> static inline bool kvm_lapic_advertise_directed_eoi(kvm)

s/directed_eoi/suppress_eoi_broadcast.  I want to provide as clear of split=
 as
possible between the local APIC feature and the I/O APIC feature.

> {
> 	/* Legacy behaviour was to advertise this feature but it
> didn't=20
> 	 * actually work. */
> 	return kvm->arch.suppress_eoi_broadcast !=3D KVM_SUPPRESS_EOI_DISABLED;
> }
>=20
> static inline bool kvm_lapic_suppress_directed_eoi(kvm)

Too close to "suppress EOI broadcast", e.g. it would be easy to read this a=
s
"suppress EOIs" and invert the polarity.  It's wordy, but I think
kvm_lapic_ignore_suppress_eoi_broadcast() is the least awful name.

> {
> 	/* Legacy behaviour advertised this feature but didn't
> actually
> 	 * suppress the EOI. */
> 	return kvm->arch.suppress_eoi_broadcast =3D=3D KVM_SUPPRESS_EOI_ENABLED;
> }
>=20
> Because it keeps the batshittery in one place and clearly documented?
>=20
> I note your version did actually suppress the broadcast even in the
> DISABLED case if the guest had managed to set that bit in SPIV, but I
> don't think it *can* so that difference doesn't matter anyway, right?

Right.  If we want to be paranoid, we could WARN_ON_ONCE() in whatever the =
"ignore
broadcast" accessor is called, because it should only be used if the bit is=
 enabled
in the local APIC.

