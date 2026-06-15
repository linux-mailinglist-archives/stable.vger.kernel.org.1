Return-Path: <stable+bounces-263432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wzNqBrZGMGoBQwUAu9opvQ
	(envelope-from <stable+bounces-263432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:38:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E136893D1
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:38:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cMkqyZBU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263432-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263432-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A4C430C34F7
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480537F729;
	Mon, 15 Jun 2026 18:37:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B334EF1C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 18:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548668; cv=none; b=ixveFYa1gqx9UO5ZRB9V+2Rf6Lq/YVgfx9Hla0Tv4ZHUamlQb/DDssJY9xeqQaXN5FXYAqn4tMKlwypmoz4auBvDwSG1QayNPZwjSI92+W3EXcIMf4awBjkq7LPf3JB+EvUJGkwb32nGbvv/crnkQQEa26pvxTOLDxImLVOObCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548668; c=relaxed/simple;
	bh=xjBtda5yQylDR43xaldFv16csYNrCOOieWasSqFyZII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PamEDXCFhLzPTiwMKhIqsJCxXI/T8aBct8RCPeWbYk3Q0QpK+m7n2T/A2Wtl6MqhdELSFST3/xUZy8/jE8BLLMaTvvICBEz56/tiZ+OCPJQgu0tb1sqIdSo/My5qpXIWVKE41fNa9uTYHMC8qfl/QVeSfaPfOguiKSz4YqoinqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMkqyZBU; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c858e0cbc89so1966726a12.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781548667; x=1782153467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiMgdwm1uK8wMIHpR+UI3R9OpwIEA1Of5OYuzODRAHc=;
        b=cMkqyZBULF5XL0fpwZJODF2GrnMOn5osDCcRffDLlSCPfHun9EbaVm9l1lAITEGLkr
         rp8WzTp7QN7SmhwOfZPmDgtLZn25TcMnWi4KreqgXZGCyVY/waypv4PQlxA/Jg4MqQ/o
         paH3x191I3hwPphaKU7EBAM5Zw5Po8/sipywd15FUW2fb79xalphiiYT1qTwehhEHC5v
         dAXM9N2h6Ae62wCr1fF1GWXzvXnjTnLFO2rq00ztHE6pkhI89A+spHr+wOZCq/b+/PXF
         w+M+T9l0lKJeF765AUkD9BZj67oBnVms/64k6/bTuAxIbELyI8xTEsOa4R6cRFwzn+Dt
         HoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781548667; x=1782153467;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CiMgdwm1uK8wMIHpR+UI3R9OpwIEA1Of5OYuzODRAHc=;
        b=ACkq0jaeLK8eDziF1N6rRf2kHritoRECXm28L2srEg4aim2Yn05YiWZzMmJ+mefvNL
         pBBurs9aZw/Q+4GlDcDLNeeRtlZUQeHr6fqMerH2ZnGKr36vy1kK/rPewkEk0Jq/T1Iu
         shXB4E1K1Ku9ousTWA4/oW+FTwcleES70YuJzRcifdYadPvYucEUYxPJRx+X65cXhvji
         csY97YoddjwolrjHujWqVH0b3DkFtW+91gTDGWG/zXBRMJT8FqjInvgLiSeaWTu2FnPr
         6TXlzD9b5Bzk95J73297WajZmoyUwYuJlT3aeBOu8OWkKhE+7Stwk9XIRHlRdccnlLYa
         Ngfg==
X-Forwarded-Encrypted: i=1; AFNElJ/rEvDFwVHuPWHLnxIHuBuH2GwmGDGqWUJWgWcIi7uW/b7ToIVG0sHJBgTo/oR1B7JmO/Wa02U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzrr8YHMdBJN3ddJtJnLYrSrwI8LA8jHuQw6tlb2xkmdutsbEw
	PIZbXeL5ho18SHfR8yL2eYhsbK2yuTBaigVTJfLhAsY2w7eANEGJG2QL1pOgOYzfowlKMrjupO+
	rgf6tqQ==
X-Received: from pfbmc1.prod.google.com ([2002:a05:6a00:7681:b0:842:b0d3:e4d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc97:b0:39f:82bd:298
 with SMTP id adf61e73a8af0-3b783587375mr16591062637.0.1781548666395; Mon, 15
 Jun 2026 11:37:46 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:37:45 -0700
In-Reply-To: <79c59d84-80bc-41f6-950f-41ff2e6b2b5b@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610214523.2905255-2-clopez@suse.de> <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com>
 <airudX6N4oL5X_wE@google.com> <79c59d84-80bc-41f6-950f-41ff2e6b2b5b@suse.de>
Message-ID: <ajBGeUyhVM1-SI33@google.com>
Subject: Re: [syzbot ci] Re: KVM: x86: Unconditionally recompute CR8 intercept
 on PPR update
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, osteffen@redhat.com, 
	pbonzini@redhat.com, sgarzare@redhat.com, stable@vger.kernel.org, 
	tglx@kernel.org, x86@kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263432-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:clopez@suse.de,m:syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mingo@redhat.com,m:osteffen@redhat.com,m:pbonzini@redhat.com,m:sgarzare@redhat.com,m:stable@vger.kernel.org,m:tglx@kernel.org,m:x86@kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,ci493c6d734b63e050];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E136893D1

On Mon, Jun 15, 2026, Carlos L=C3=B3pez wrote:
> On 6/11/26 7:20 PM, Sean Christopherson wrote:
> > On Thu, Jun 11, 2026, syzbot ci wrote:
> >> ------------[ cut here ]------------
> >> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_r=
ead(&vcpu->kvm->users_count))
> >> WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/n=
ested.h:60 [inline], CPU#0: syz.2.19/5879
> >> WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3d=
e/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
> >> Modules linked in:
> >> CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMP=
T(full)=20
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> >> RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
> >> RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:=
6879
> >>  apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
> >>  kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
> >>  kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
> >>  kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
> >>  kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
> >>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
> >>  vfs_ioctl fs/ioctl.c:51 [inline]
> >>  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> > This is "fine", the assertion just wants to make sure KVM isn't access =
vmcs12
> > without holding vcpu->mutex, otherwise any queries are inherently unsta=
ble.
> > It's just that vCPU creation runs without taking vcpu->mutex, because t=
he vCPU
> > is otherwise unreachable.
> >=20
> > I'm pretty sure we can squash the WARN by grabbing vmcs12 if and only i=
f the vCPU
> > is actually in guest mode.
>=20
> Will you add this on top or should I send a v3?

Gah, I was going to say "I'll fixup when applying", but that leads to an un=
wieldy
changelog.  I'll send a v3 with this slotted in as a proper prep patch, mig=
ht as
well let syzbot have another go at it, to make sure there isn't another ass=
ertion
lurking.

> > diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
> > index c548f22375ad..332fbcd924f2 100644
> > --- arch/x86/kvm/vmx/vmx.c
> > +++ arch/x86/kvm/vmx/vmx.c
> > @@ -6876,11 +6876,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fast=
path_t exit_fastpath)
> > =20
> >  void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
> >  {
> > -       struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> >         int tpr_threshold;
> > =20
> >         if (is_guest_mode(vcpu) &&
> > -               nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
> > +           nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
> >                 return;
> > =20
> >         guard(vmx_vmcs01)(vcpu);
> >=20
> >=20
> > Longer term, I'll work on figuring out how to handle this in get_vmcs12=
(), because
> > to_hv_vcpu() has the solve the same fundamental problem:
> >=20
> > https://lore.kernel.org/all/aeqRzanSaa9P_EPg@google.com
>=20

