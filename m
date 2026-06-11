Return-Path: <stable+bounces-262788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bRmAOjrwKmrSzgMAu9opvQ
	(envelope-from <stable+bounces-262788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:28:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63478673F7D
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BOgeznWH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262788-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262788-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 574DC30027D2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98944963BE;
	Thu, 11 Jun 2026 17:21:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26B43DA2C
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:20:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198460; cv=none; b=rfdSorfoj8t+7x8LCpYJ9yXFwvtRPQCv8oDcGWGaBtwBLFxyOnNOXenVScD6EATUA5nbLJmGLFYoBLp/eHBFiidYdtS0H5GsMFMlKH5trtuYXhVJpV8m/9tCvzJ7t+ZZNgDXfq0YPdvybNq9sSWERtY72pMZWDUY2Z1NQMXcfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198460; c=relaxed/simple;
	bh=Hot4UniHs4ligl/7ejYYsuex1217fakSzNm+wlM+65E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F2Rd39CzQchADXnKq0wGxgXPUwcfiQD8YmDpg3Cwjpthtw3NFsFz6tb3HIwaYJmrpqK+O0TcmbegT9AyQWbxW1XDTA8R3vENmhjgN0hodJRkmKd20HM4h68OMGSbkZzHWgEAaxKc0vUbu70MY7dabfcRf2Zsm9aliS67bTmPvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOgeznWH; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso607815ad.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198455; x=1781803255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kKAnYeHG2u5wx8ciAL480Un709THxmEGRnj+zMfdq4=;
        b=BOgeznWHOR6a4GlL7C9Mlg84PojMRBzvW48sayqsMWmAeEOCqMrYI2X2DbCjJJtHll
         7N3XW4yWce6Wv1gtbMJoe02XBC4r5K8qJQb6K26UB27s/+0Fo2ocdQOrPRXtTXYJoEKY
         0HrM5KS3fCpzOs81jzRVVEPaKH8bU7+sWWh2nuwOfEP4ihChBEBj0+749t6bJstIviPO
         9kf63KoHLOb3keP/tSD7iMshHKyUGaq18/bHo8d/zhGIKPhY0IpLbsBbGtfr5GMowh8n
         IpG/xRTEQy4s3zBcSGRuCbkvGdfNhyATKXmd07UCT4M4J8gp41tjhAtgs1ZBib3rMoFu
         lmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198455; x=1781803255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kKAnYeHG2u5wx8ciAL480Un709THxmEGRnj+zMfdq4=;
        b=PB6P4PbixWAEQ+xr969q6BoXEhFOtJoUISyoeIW0qT0//cJLUzTsv/+oagEHiQHY1f
         ogIKwNuLUT471TD6aC/Q8lwayaEdceJpxorTL4Dyb6ztdbWBXfkjZ9JPhZpi8/DIh7BJ
         Rx9GYMZCWLnAKcw5W8Xg0D4PZ8CF2U+reXBH/DrYdo+xrRbx3py67xE+rKtdxikWAzZ4
         eUwM1UcFGlhhuLwNFqYZzyYXxQPmUT1gP8PKtpe9UoF1wpom8oAXnlzjOaBcybVhzXr1
         /1Gr+odfauAwLgOSLAvlkLeGOZZjBrBMOlb2hhaanFtogul64t1Wsh7kAEXXp/9hLOS+
         sFqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GXOI0nxS4pA8rTXkjkwgiIiOeLJYwZHYV+A7WDhmCSHWMji45yXHaQ8ehDfl91JWmhbvhjGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFwKMF9QyVeZdXF3qFhE99bo9LDp8duZa5nErBhL2WRIUMcOK
	8kGCkhVyxtOS/sG8UHNyRAR56zweOiIC/wxSH6nWX4HlBdAslyD0JjLX3mSKtAf1N8Vi0eh/T+E
	xCk9C3w==
X-Received: from pllh1.prod.google.com ([2002:a17:902:7481:b0:2b0:b22a:e6ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc8f:b0:2c0:bcb3:86f
 with SMTP id d9443c01a7336-2c2f18e2d19mr45384435ad.6.1781198454681; Thu, 11
 Jun 2026 10:20:54 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:20:53 -0700
In-Reply-To: <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610214523.2905255-2-clopez@suse.de> <6a2adf3b.3b0a2d4e.8c8d1.0012.GAE@google.com>
Message-ID: <airudX6N4oL5X_wE@google.com>
Subject: Re: [syzbot ci] Re: KVM: x86: Unconditionally recompute CR8 intercept
 on PPR update
From: Sean Christopherson <seanjc@google.com>
To: syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>
Cc: bp@alien8.de, clopez@suse.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	osteffen@redhat.com, pbonzini@redhat.com, rkagan@virtuozzo.com, 
	sgarzare@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262788-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com,m:bp@alien8.de,m:clopez@suse.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mingo@redhat.com,m:osteffen@redhat.com,m:pbonzini@redhat.com,m:rkagan@virtuozzo.com,m:sgarzare@redhat.com,m:stable@vger.kernel.org,m:tglx@kernel.org,m:x86@kernel.org,m:syzbot@lists.linux.dev,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63478673F7D

On Thu, Jun 11, 2026, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
> https://lore.kernel.org/all/20260610214523.2905255-2-clopez@suse.de
> * [PATCH v2] KVM: x86: Unconditionally recompute CR8 intercept on PPR update
> 
> and found the following issue:
> WARNING in vmx_update_cr8_intercept

...

> ------------[ cut here ]------------
> debug_locks && !(lock_is_held(&(&vcpu->mutex)->dep_map) || !refcount_read(&vcpu->kvm->users_count))
> WARNING: arch/x86/kvm/vmx/nested.h:61 at get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline], CPU#0: syz.2.19/5879
> WARNING: arch/x86/kvm/vmx/nested.h:61 at vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879, CPU#0: syz.2.19/5879
> Modules linked in:
> CPU: 0 UID: 0 PID: 5879 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:get_vmcs12 arch/x86/kvm/vmx/nested.h:60 [inline]
> RIP: 0010:vmx_update_cr8_intercept+0x3de/0x4e0 arch/x86/kvm/vmx/vmx.c:6879
>  apic_update_ppr arch/x86/kvm/lapic.c:984 [inline]
>  kvm_lapic_reset+0x1c24/0x2980 arch/x86/kvm/lapic.c:3023
>  kvm_vcpu_reset+0x44c/0x1bf0 arch/x86/kvm/x86.c:12986
>  kvm_arch_vcpu_create+0x746/0x8b0 arch/x86/kvm/x86.c:12847
>  kvm_vm_ioctl_create_vcpu+0x428/0x930 virt/kvm/kvm_main.c:4201
>  kvm_vm_ioctl+0x893/0xd50 virt/kvm/kvm_main.c:5159
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is "fine", the assertion just wants to make sure KVM isn't access vmcs12
without holding vcpu->mutex, otherwise any queries are inherently unstable.
It's just that vCPU creation runs without taking vcpu->mutex, because the vCPU
is otherwise unreachable.

I'm pretty sure we can squash the WARN by grabbing vmcs12 if and only if the vCPU
is actually in guest mode.

diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index c548f22375ad..332fbcd924f2 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -6876,11 +6876,10 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
-       struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
        int tpr_threshold;
 
        if (is_guest_mode(vcpu) &&
-               nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
+           nested_cpu_has(get_vmcs12(vcpu), CPU_BASED_TPR_SHADOW))
                return;
 
        guard(vmx_vmcs01)(vcpu);


Longer term, I'll work on figuring out how to handle this in get_vmcs12(), because
to_hv_vcpu() has the solve the same fundamental problem:

https://lore.kernel.org/all/aeqRzanSaa9P_EPg@google.com

