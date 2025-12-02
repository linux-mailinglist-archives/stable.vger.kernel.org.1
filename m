Return-Path: <stable+bounces-198113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E9C9C395
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 17:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A634845F
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BD2848AA;
	Tue,  2 Dec 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AapMLOC3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D279903
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693385; cv=none; b=ZDFb8TqBhuFCDOXVRIJ7ZNqSFCzY2EBugt+Ta5b1wtgbgPScaziC/cfSFUiM2dJL8exLlK/tfz2n8gVCUeLQP8iIdpQrDfsRkmJtgP0VmpbrUKUb6i9c597e0+iJ+FK4kFtM4nyl6ajLSSznlAQv42I0y7aSCJmFhQg0JBEe6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693385; c=relaxed/simple;
	bh=J2FY91mBA+7qsoG5Zmdf/X1yNE61LDROrDP1UQKCDsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CBLlqvyHtF7gCxjicI4HJ6wgSDSNW5YyMuyz5MfNv0OIsVira772NW3Ao0IYC/sreVFc0hL3ivQQYUjcoOhRH1s2u5DLQmNs8juRKbh80/dK7ac+DRv0HHwQXW6hXzCvObNRWIX/HDtBctWqbw9MiQmUOu1CsUvdiUigeLVm0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AapMLOC3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso9355932b3a.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764693383; x=1765298183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1PCQjqHUImrfnuMWQSbY1q1fWBmYQzMPADITESwpfg=;
        b=AapMLOC35Wo5zxnizizAKlCVnt5UUoMZi4dU2xSZEa8WpQK3ZAyJgjyH6fFWLHjWCo
         hFv/W4HUneMKxjUUjWLj9DAnwJ+uRx1FAmRmAz1+RSIVWxvBwi7R/X9j7U3JWwYNjUXd
         wqHeAvm8bCRpfhwjPxptfWexoyktWLH2e0HkN8KTPqpRvUQU4ATSvEhpakjnXIL71J80
         LRW3XakZnAkUKcKdG1se9E5/rd0qdsgcA5pRTG8wVEmx/4e4QRXcwFMqzRPdRObQGMQh
         3VEddrL+v77IykZJ4jBe4GrXLNrzNBpuDlAtLs/vE/Q8pS8gb6MW2ES2Pe7RVVfh+1jc
         Tugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764693383; x=1765298183;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g1PCQjqHUImrfnuMWQSbY1q1fWBmYQzMPADITESwpfg=;
        b=O/Im6NEMoSvnpCYS38bD2B2Lc+9OT3VLMaS4R6iPf2HyncnkWQlWv3aVMNvQ6jgko8
         t2WGclyrvyHh3pBpzGk1ZT4bKlLRZWcds/g0oEo3F58bj6yAt6J66QxJ0x7lhvUrJvDq
         GTGKUsTLXdp0N+iLvPwLVpChg6qVmkhQqLbZIqbtFHq+SuJ3vKXm6FaOiAX6tg8wS28m
         irMNDFj6ZCnL+CBEW6UViphkLJEGHCvVGLItlkSWcMfsw4AAxMI/weXOUcCDyBhGRbTg
         f9Bvh+ONmvsMgnIAj9cFcFX4yxa706EgTgUHW5fc/OfPQ9ooz2ootd+ZgHgQuN08/si0
         3dtw==
X-Forwarded-Encrypted: i=1; AJvYcCUAVbtKLNfkksext9NDEbjYVArIc4albpUM85k6NK9SrzysOAccNN5YLu/8O1cmq15sUjrPDQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOcdYxszDUJo23arNeG6LDGlotkASOixh1XoxUN6sLtV/kVzK
	2kHk7pFXHEISp0sKxKwavjR1RhY+HQzSXchNR0/QyuHqf2ymi4Y4p+5tDCujKNW4Hc2dR629Y0N
	wXOlo/Q==
X-Google-Smtp-Source: AGHT+IHbpjzBbXCvAd9URDI1HhG7vj8KOeHDgurtn5SRw54GzVw6VxJbQiZhVN8zm3l6wh3j7PJMUAxrNXU=
X-Received: from pglg15.prod.google.com ([2002:a63:110f:0:b0:bac:6acd:817f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d8b:b0:33b:625:36be
 with SMTP id adf61e73a8af0-3614ed3e82amr49170495637.38.1764693383200; Tue, 02
 Dec 2025 08:36:23 -0800 (PST)
Date: Tue, 2 Dec 2025 08:36:21 -0800
In-Reply-To: <68ad817529c6661085ff0524472933ba9f69fd47.camel@infradead.org>
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
Message-ID: <aS8Vhb66UViQmY_Q@google.com>
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
> On Tue, 2025-12-02 at 07:42 -0800, Sean Christopherson wrote:
> > On Tue, Dec 02, 2025, David Woodhouse wrote:
> > > On Tue, 2025-12-02 at 12:58 +0000, Khushit Shah wrote:
> > > > Thanks for the review!
> > > >=20
> > > > > On 2 Dec 2025, at 2:43=E2=80=AFPM, David Woodhouse <dwmw2@infrade=
ad.org> wrote:
> > > > >=20
> > > > > Firstly, excellent work debugging and diagnosing that!
> > > > >=20
> > > > > On Tue, 2025-11-25 at 18:05 +0000, Khushit Shah wrote:
> > > > > >=20
> > > > > > --- a/Documentation/virt/kvm/api.rst
> > > > > > +++ b/Documentation/virt/kvm/api.rst
> > > > > > @@ -7800,8 +7800,10 @@ Will return -EBUSY if a VCPU has already=
 been created.
> > > > > > =C2=A0
> > > > > > =C2=A0Valid feature flags in args[0] are::
> > > > > > =C2=A0
> > > > > > -=C2=A0 #define KVM_X2APIC_API_USE_32BIT_IDS=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 0)
> > > > > > -=C2=A0 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK=C2=A0 (1=
ULL << 1)
> > > > > > +=C2=A0 #define KVM_X2APIC_API_USE_32BIT_IDS=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (1ULL << 0)
> > > > > > +=C2=A0 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 1)
> > > > > > +=C2=A0 #define KVM_X2APIC_API_DISABLE_IGNORE_SUPPRESS_EOI_BROA=
DCAST_QUIRK (1ULL << 2)
> > > > > > +=C2=A0 #define KVM_X2APIC_API_DISABLE_SUPPRESS_EOI_BROADCAST=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1ULL << 3)
> > > > > >=20
> > > > >=20
> > > > > I kind of hate these names. This part right here is what we leave
> > > > > behind for future generations, to understand the weird behaviour =
of
> > > > > KVM. To have "IGNORE" "SUPPRESS" "QUIRK" all in the same flag, qu=
ite
> > > > > apart from the length of the token, makes my brain hurt.
> >=20
> > ...
> >=20
> > > > > Could we perhaps call them 'ENABLE_SUPPRESS_EOI_BROADCAST' and
> > > > > 'DISABLE_SUPPRESS_EOI_BROADCAST', with a note saying that modern =
VMMs
> > > > > should always explicitly enable one or the other, because for
> > > > > historical reasons KVM only *pretends* to support it by default b=
ut it
> > > > > doesn't actually work correctly?
> >=20
> > I don't disagree on the names being painful, but ENABLE_SUPPRESS_EOI_BR=
OADCAST
> > vs. DISABLE_SUPPRESS_EOI_BROADCAST won't work, and is even more confusi=
ng IMO.
>=20
> I dunno, KVM never actually *did* suppress the EOI broadcast anyway,
> did it? This fix really *does* enable it =E2=80=94 as opposed to just
> pretending to?
>=20
> I was thinking along the lines of ...
>=20
>=20
> Setting KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST causes KVM to
> advertise and correctly implement the Directed EOI feature in the local
> APIC, suppressing broadcast EOI when the feature is enabled by the
> guest.
>=20
> Setting KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST causes KVM not to
> advertise the Directed EOI feature in the local APIC.
>=20
> Userspace should explicitly either enable or disable the EOI broadcast
> using one of the two flags above. For historical compatibility reasons,
> if neither flag is set then KVM will advertise the feature but will not
> actually suppress the EOI broadcast, leading to potential IRQ storms in
> some guest configurations.

Hmm, I suppose that could work for uAPI.  Having both an ENABLE and a DISAB=
LE
is obviously a bit odd, but slowing down the reader might actually be a goo=
d
thing in this case.  And the documentation should be easy enough to write.

I was worried that having ENABLE and DISABLE controls would lead to confusi=
ng code
internally, but there's no reason KVM's internal tracking needs to match uA=
PI.

How about this?

---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/include/uapi/asm/kvm.h |  6 ++++--
 arch/x86/kvm/lapic.c            | 16 +++++++++++++++-
 arch/x86/kvm/x86.c              | 15 ++++++++++++---
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 5a3bfa293e8b..b4c41255f01d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1226,6 +1226,12 @@ enum kvm_irqchip_mode {
 	KVM_IRQCHIP_SPLIT,        /* created with KVM_CAP_SPLIT_IRQCHIP */
 };
=20
+enum kvm_suppress_eoi_broadcast_mode {
+	KVM_SUPPRESS_EOI_QUIRKED,
+	KVM_SUPPRESS_EOI_ENABLED,
+	KVM_SUPPRESS_EOI_DISABLED,
+};
+
 struct kvm_x86_msr_filter {
 	u8 count;
 	bool default_allow:1;
@@ -1475,6 +1481,7 @@ struct kvm_arch {
=20
 	bool x2apic_format;
 	bool x2apic_broadcast_quirk_disabled;
+	enum kvm_suppress_eoi_broadcast_mode suppress_eoi_broadcast;
=20
 	bool has_mapped_host_mmio;
 	bool guest_can_read_msr_platform_info;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kv=
m.h
index 7ceff6583652..bd51596001f8 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -914,8 +914,10 @@ struct kvm_sev_snp_launch_finish {
 	__u64 pad1[4];
 };
=20
-#define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+#define KVM_X2APIC_API_USE_32BIT_IDS			(_BITULL(0))
+#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK		(_BITULL(1))
+#define KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	(_BITULL(2))
+#define KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST	(_BITULL(3))
=20
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 1597dd0b0cc6..3f00c9640785 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -562,7 +562,8 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 	 * IOAPIC.
 	 */
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_X2APIC) &&
-	    !ioapic_in_kernel(vcpu->kvm))
+	    !ioapic_in_kernel(vcpu->kvm) &&
+	    vcpu->kvm->arch.suppress_eoi_broadcast !=3D KVM_SUPPRESS_EOI_DISABLED=
)
 		v |=3D APIC_LVR_DIRECTED_EOI;
 	kvm_lapic_set_reg(apic, APIC_LVR, v);
 }
@@ -1517,6 +1518,19 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *ap=
ic, int vector)
=20
 	/* Request a KVM exit to inform the userspace IOAPIC. */
 	if (irqchip_split(apic->vcpu->kvm)) {
+		/*
+		 * Don't exit to userspace if the guest has enabled Directed
+		 * EOI, a.k.a. Suppress EOI Broadcasts, in which case the local
+		 * APIC doesn't broadcast EOIs (the guest must EOI the target
+		 * I/O APIC(s) directly).  Ignore the suppression if userspace
+		 * has not explictly enabled support (KVM's historical quirky
+		 * behavior is to advertise support for Suppress EOI Broadcasts
+		 * without actually suppressing EOIs).
+		 */
+		if ((kvm_lapic_get_reg(apic, APIC_SPIV) & APIC_SPIV_DIRECTED_EOI) &&
+		    apic->vcpu->kvm->arch.suppress_eoi_broadcast !=3D KVM_SUPPRESS_EOI_Q=
UIRKED)
+			return;
+
 		apic->vcpu->arch.pending_ioapic_eoi =3D vector;
 		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
 		return;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c6d899d53dd..b36e048c7862 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -121,8 +121,10 @@ static u64 __read_mostly efer_reserved_bits =3D ~((u64=
)EFER_SCE);
=20
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
=20
-#define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
-                                    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK=
)
+#define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS |		\
+				    KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK |	\
+				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST |	\
+				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
=20
 static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
@@ -6739,11 +6741,18 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (cap->args[0] & ~KVM_X2APIC_API_VALID_FLAGS)
 			break;
=20
+		if (cap->args[0] & KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST &&
+		    cap->args[0] & KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
+			break;
+
 		if (cap->args[0] & KVM_X2APIC_API_USE_32BIT_IDS)
 			kvm->arch.x2apic_format =3D true;
 		if (cap->args[0] & KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 			kvm->arch.x2apic_broadcast_quirk_disabled =3D true;
-
+		if (cap->args[0] & KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST)
+			kvm->arch.suppress_eoi_broadcast =3D KVM_SUPPRESS_EOI_ENABLED;
+		if (cap->args[0] & KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
+			kvm->arch.suppress_eoi_broadcast =3D KVM_SUPPRESS_EOI_DISABLED;
 		r =3D 0;
 		break;
 	case KVM_CAP_X86_DISABLE_EXITS:

base-commit: 6c3373b26189853230552bd3932b3edba5883423
--

