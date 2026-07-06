Return-Path: <stable+bounces-272327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RYHZM88nTGouhAEAu9opvQ
	(envelope-from <stable+bounces-272327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 00:10:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C1715E6D
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 00:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=sg5u+ECN;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272327-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272327-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D43330156FA
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA74189D8;
	Mon,  6 Jul 2026 22:10:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839033ED3A4
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 22:10:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375817; cv=none; b=PwF1AsDD8ESpQdfhPD/2j/2X7j5ToIVmt0VabVhRZT8yBCx4icb8sjGkBbDqSkBOqLgNmkc34u8U5fy8mWyXOa/GtemIQJAVgQXGpKfmFBzdmKVmI+gGbzp8kHs9LjLNKtpqhHORrhkSyj3v1NTA6SS8e6MVl08TDtVnEcteUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375817; c=relaxed/simple;
	bh=c8331qU0zElZiGYbOypMxmtCYlvlKhbGlWxIgnZlFF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmSkJPUwK/nRyA3n9EBfh0u3vZthpTKTul+Ctgy4YlypoSJxyNbkgyhrlS4qU9GCq9HmjOmt51jkSFltdbBbjXpiSszrNLGcPczlUSPEzYcAD0ONrlWsScrV2znU+GGVqxvzt7EITkh/ZHtgc7xBnnqxdlvJB61QRsoS6tRsEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sg5u+ECN; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8479b7c3adbso6016006b3a.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783375816; x=1783980616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=shsPuPYRf4PBbLjGf0VAoe1fRpZE08znUWvrGZax6Yk=;
        b=sg5u+ECNsFRDx2FqvvxHjZDParfJGEl4R+/fQU0L1ONR3NI0hdOb4MCskeq8hQ45iI
         OmKJy4bVHDii1azv0uTB2hXRLAANKaxcEwmz7+oOecwJM77iq0VLoeUUWs12iTz7CUWg
         DvU3YKniXOz1gPhGH8Tp4KcHm27UQ5lTEsxf42TBlizWToUuzwVB3iy2uh+9g50E/KzM
         c9fGGARuNqCqcjll9UgpR0B9nBxAOCcKkrdje2h6NbUc80TTvx5tJWmt9FGJfq9yTpDN
         04RAKiyCB/x+nAieFO/nmXi+cQKfhQp8xTkf2zh38D3I0wdSr7PgAga14amGh8oCdrX4
         6Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375816; x=1783980616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shsPuPYRf4PBbLjGf0VAoe1fRpZE08znUWvrGZax6Yk=;
        b=SmrtfPAihk02tcUfsBDiBLNc7Wr+Og5QZoCii5PM7jAI5bpDYo+cspfmmroBZGx1pI
         AoAx1WNTnjph38dI6dMe08zHwqNw3gGHN2dhMfNNH5rwmLbfO8ql5wZpXufx2uJGzGf0
         ReVW+2c7L4crH4wv8Xx0LhQRcUjLNIHALxu0InrlzEXswNjJ/lM4zyTEEOUqd+dps+TJ
         aEBheXWpbWVX3sjJUUwbQ3SzH0lFM3RC99/Ll3+qfvMHWoU+p2apVtr6yxf9zDxilIDf
         iCpGrTxZAu2iY65nbbfXZgEPQfYE3bsqz/J4n6wg7nYAODJ6lT9hE5agDlfh2xqHB7fN
         wWpA==
X-Forwarded-Encrypted: i=1; AHgh+Rpqo5qLbJgNLFROEsJNCgRYPyL7NhILlrNQ0KLZxRo53Q0QRnqSiloK6gBbEnxJ8jbHSIyNilc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsd+gbYGXTRysDkhMoab//YaiXXh28EGiUqwvAM3oKEzB9ZBy
	4mrK+NjxBR/0n16kLeoKuiLGkuRJbCqv/LXFT7avwPzRtFmmznec25X7+wc9QMKY1IfR07sWUIz
	kZh2yHQ==
X-Received: from pfdh12.prod.google.com ([2002:aa7:914c:0:b0:846:c7d3:7d45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e08:b0:842:5ea5:5fdd
 with SMTP id d2e1a72fcca58-84826d305f6mr2467802b3a.40.1783375815601; Mon, 06
 Jul 2026 15:10:15 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:10:15 -0700
In-Reply-To: <51b8068149510179f59901b439e5f393c7757760.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260705045450.1325048-2-bestswngs@gmail.com> <20260706180025.2735341-3-bestswngs@gmail.com>
 <akvx7que1BE5DY-O@google.com> <51b8068149510179f59901b439e5f393c7757760.camel@intel.com>
Message-ID: <akwnx1ovr-Rkl6q7@google.com>
Subject: Re: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "bestswngs@gmail.com" <bestswngs@gmail.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "zhanghy@sangfor.com" <zhanghy@sangfor.com>, 
	Zhong Wang <wangzhong.c0ss4ck@bytedance.com>, 
	"shixuanqing.11@bytedance.com" <shixuanqing.11@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272327-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,sangfor.com,bytedance.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kai.huang@intel.com,m:bestswngs@gmail.com,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:pbonzini@redhat.com,m:stable@vger.kernel.org,m:zhanghy@sangfor.com,m:wangzhong.c0ss4ck@bytedance.com,m:shixuanqing.11@bytedance.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 403C1715E6D

On Mon, Jul 06, 2026, Kai Huang wrote:
> 
> >     Alternatively, KVM could simply destroy the I/O APIC during the "pre" phase
> >     of VM destruction, but that gets more than a bit sketchy as KVM expects the
> >     I/O APIC to exist if ioapic_in_kernel() is true, and nested virtualization
> >     in particular has a bad habit of touching VM-scope state during vCPU
> >     destruction.  E.g. attempting to free the PIC during the pre phase would
> >     lead to a NULL pointer dereference in kvm_cpu_has_extint(), and it's not
> >     hard to imagine the I/O APIC having a similar flaw.
> 
> Hmm seems vmx_vcpu_free() can eventually call into kvm_cpu_has_extint() via
> nested_vmx_vmexit().  Thanks for pointing out.

Yeah, I found out the hard way :-)

> >     Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
> >     Reported-by: <zdi-disclosures@trendmicro.com>
> >     Cc: stable@vger.kernel.org
> >     Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
> > index 0626e835e9eb..a0cc74c8ded1 100644
> > --- arch/x86/kvm/x86.c
> > +++ arch/x86/kvm/x86.c
> > @@ -9942,6 +9942,8 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
> >          */
> >  #ifdef CONFIG_KVM_IOAPIC
> >         kvm_free_pit(kvm);
> > +       if (kvm->arch.vioapic)
> > +               cancel_delayed_work_sync(&kvm->arch.vioapic->eoi_inject);
> 
> Maybe add a comment to explain why we cannot destroy IOAPIC and PIC here?

Hmm, agreed, the block comment above can/should be extended to explain why it's
ok to destroy the PIT, but not the PIC or I/O APIC.

