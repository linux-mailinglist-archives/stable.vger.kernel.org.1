Return-Path: <stable+bounces-223126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCCWK0J+qGmYvAAAu9opvQ
	(envelope-from <stable+bounces-223126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:47:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165FD2069D9
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CCC314A20F
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4D3D668C;
	Wed,  4 Mar 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbzDtfPC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05918371D15
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649297; cv=none; b=hm3VxtDIrOAhUrPq3zKd4BLfhXOqpgYao2sB5MxQWiGXFKEka2vmH27d7+HBg0NvtWuE/Zx4xoFpahmhGaSJypeetQey0Z5tRL0EYyTSDOHQNpEaHAS8Q2qHpqcjBsYOKoYYIV1kPxUx4B5EEMTl0TsYXJfWn/vxuM+YbAnH6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649297; c=relaxed/simple;
	bh=pddQ1sHqXRKwEx6DgskNl9V+i6uNVeLK7geszSsncxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koiQDSOS2yLwXUf/358xak06tLJORAuNFnSUJh42/AJ6Iu8q9QDMYPl/CJZDRX/5gyBj4pxEhFUf2kl3005MI2R7bVHQLSIQ1DPw9VU6q9lcaC8n9X/KUws+3z5V6HGeUPj6j2bWbX0fVGUSWh4aIX1kb5KX/d0lH6XfT1OXO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbzDtfPC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e425c261so6236668a91.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 10:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772649294; x=1773254094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RNBMpp2q2mifTqjvXaoCxPMqrYTj+LYVfCr+UpK9yU=;
        b=AbzDtfPCDSfpGYXgCao1bPfZ4GJ9SFawOlfbHhsxD6RbNLeiA8RbYJ2yR2JGntyDep
         TMSWixG3/WHQ0QMn6iukWWCQ4YVQomoSnXVMZIXlwYBS5q6f9Nmg5vMLwgIqpKg2aEvf
         VjkVCrPQWVpydSUfjbjfUiYpR4R2OO/9hjFp8PWyDaTo0+VpS4fwCLWr3ORF2qVbNeut
         x3+EY4jyNe58n4Se0+rIglfwT78R/EmkP9WDm92nrVUo0Srqrf4H7b6P0MJL+2yafOSk
         HHywBTlh4/66aixCP8UgUJGIfxx9YAIzE7VpLoupr6CJRtNhwpqZfUBY2hVpGXEX7IRy
         MvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772649294; x=1773254094;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RNBMpp2q2mifTqjvXaoCxPMqrYTj+LYVfCr+UpK9yU=;
        b=UnWZAzy8yZlRWG2GLgvgPeulqh1qRS/otcfUsu9xeD/u6NzJt7x+EfHFNrkzWPEUX2
         uXYmNjaEM+1xUHr4dd0dCt71EwWRwEGxeauAjPhOnTyS7eq/RLvlP1h2y8eTnDH1MNxo
         441LcuKSTcP4oxR1/znzOkPdDVYw3xsKmNp6RZXQeYaMCApac3Z5XBZIhx9kP46pgx4p
         7V2KnO7gJC+GUm2K0QvUSeYHu4kbLqV+Ov9k7Qf8LTfwL9aBDB9yK7ebcvpvrp6K+dlr
         9KLD/dl5HF0vakMr4xFT1P/2Gbyx+bEEjf/Fn86V6FmYuEfzlXYRubKH0lLWSNNUgnIV
         GDpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXmWMvt78VqyyaCHnwHs2I/K8zZ9uK5XBvePRxIJFLE/d1h9rwlXw12sKgeoFzaGNiDWywys8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjOFIjQV0rnbamr8K3LSU80LS35fcyt4KlVd2Ud6t3cTdAD4A
	l4DeusAmONSYlWFvvPU0Cx5ghgwctEKqc5qo6TeSSt0RbXyWwc/FDeu9mcjmBmpFMfMGnfmOmtG
	O5eI4UA==
X-Received: from pjboi15.prod.google.com ([2002:a17:90b:3a0f:b0:354:a065:ec58])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40d:b0:358:e7de:a717
 with SMTP id 98e67ed59e1d1-359a6a69b23mr2328391a91.25.1772649294186; Wed, 04
 Mar 2026 10:34:54 -0800 (PST)
Date: Wed, 4 Mar 2026 10:34:52 -0800
In-Reply-To: <CAO9r8zOvhJgA2v3CXomddmyfrR2KX23fv=HQ6xH2C+m0niswyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225005950.3739782-1-yosry@kernel.org> <20260225005950.3739782-8-yosry@kernel.org>
 <CAO9r8zOvhJgA2v3CXomddmyfrR2KX23fv=HQ6xH2C+m0niswyQ@mail.gmail.com>
Message-ID: <aah7THlqWe9VLv8B@google.com>
Subject: Re: [PATCH v3 7/8] KVM: nSVM: Delay setting soft IRQ RIP tracking
 fields until vCPU run
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 165FD2069D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223126-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026, Yosry Ahmed wrote:
> On Tue, Feb 24, 2026 at 5:00=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index ded4372f2d499..7948e601ea784 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3670,11 +3670,21 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >          * This is done here (as opposed to when preparing vmcb02) to u=
se the
> >          * most up-to-date value of RIP regardless of the order of rest=
oring
> >          * registers and nested state in the vCPU save+restore path.
> > +        *
> > +        * Simiarly, initialize svm->soft_int_* fields here to use the =
most
> > +        * up-to-date values of RIP and CS base, regardless of restore =
order.
> >          */
> >         if (is_guest_mode(vcpu) && svm->nested.nested_run_pending) {
> >                 if (boot_cpu_has(X86_FEATURE_NRIPS) &&
> >                     !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> >                         svm->vmcb->control.next_rip =3D kvm_rip_read(vc=
pu);
> > +
> > +               if (svm->soft_int_injected) {
> > +                       svm->soft_int_csbase =3D svm->vmcb->save.cs.bas=
e;
> > +                       svm->soft_int_old_rip =3D kvm_rip_read(vcpu);
> > +                       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS)=
)
> > +                               svm->soft_int_next_rip =3D kvm_rip_read=
(vcpu);
> > +               }
>=20
> AI found a bug here. These fields will be left uninitialized if we
> cancel injection before pre_svm_run() (e.g. due to
> kvm_vcpu_exit_request()). I was going to suggest moving this to
> pre-run, but this leaves a larger gap where RIP can be updated from
> under us. Sean has a better fixup in progress.

With comments to explain the madness, this should work as fixup.  It's gros=
s and
brittle, but the only alternative I see is to add a flag to differentiate t=
he
save/restore case from the VMRUN case.  Which isn't terrible, but IMO most =
of
the brittleness comes from the disaster that is the architecture.

Given that the soft int reinjection code will be inherently brittle, and th=
at
the save/restore scenario will be _extremely_ rare, I think it's worth the =
extra
bit of nastiness so that _if_ there's a bug, it's at least slightly more li=
kely
we'll find it via the normal VMRUN path.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 258aa3bfb84b..2bfbaf92d3e5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3755,6 +3755,16 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fa=
stpath_t exit_fastpath)
        return svm_invoke_exit_handler(vcpu, svm->vmcb->control.exit_code);
 }
=20
+static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
+{
+       struct vcpu_svm *svm =3D to_svm(vcpu);
+
+       svm->soft_int_csbase =3D svm->vmcb->save.cs.base;
+       svm->soft_int_old_rip =3D kvm_rip_read(vcpu);
+       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
+                       svm->soft_int_next_rip =3D kvm_rip_read(vcpu);
+}
+
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
        struct svm_cpu_data *sd =3D per_cpu_ptr(&svm_data, vcpu->cpu);
@@ -3797,12 +3807,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
                    !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
                        svm->vmcb->control.next_rip =3D kvm_rip_read(vcpu);
=20
-               if (svm->soft_int_injected) {
-                       svm->soft_int_csbase =3D svm->vmcb->save.cs.base;
-                       svm->soft_int_old_rip =3D kvm_rip_read(vcpu);
-                       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
-                               svm->soft_int_next_rip =3D kvm_rip_read(vcp=
u);
-               }
+               if (svm->soft_int_injected)
+                       svm_set_nested_run_soft_int_state(vcpu);
        }
=20
        return 0;
@@ -4250,6 +4256,9 @@ static void svm_complete_soft_interrupt(struct kvm_vc=
pu *vcpu, u8 vector,
        bool is_soft =3D (type =3D=3D SVM_EXITINTINFO_TYPE_SOFT);
        struct vcpu_svm *svm =3D to_svm(vcpu);
=20
+       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending)
+               svm_set_nested_run_soft_int_state(vcpu);
+
        /*
         * If NRIPS is enabled, KVM must snapshot the pre-VMRUN next_rip th=
at's
         * associated with the original soft exception/interrupt.  next_rip=
 is

