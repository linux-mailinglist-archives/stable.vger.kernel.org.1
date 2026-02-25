Return-Path: <stable+bounces-218028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLkyFmc9nmkrUQQAu9opvQ
	(envelope-from <stable+bounces-218028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:08:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCEC18E4BD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 442D6302EAAE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429C17A2F6;
	Wed, 25 Feb 2026 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmgnYt8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667B146D53
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978083; cv=none; b=MBWZFz14M6ZG0kNX6PgEnUt+5ind6v+mYgP8Q0ZEdWE/+xp9icxANYFP708+DUg9XJgX9yVGxkXpgSxaOrce9QIhpzYm3IlhaJ/1W6OvjqtJFCOpEqb3XzHU8TCUgCGeZ/K5V201pw2loZ1PQtQH0Ql9VIrlVBjFKL2wv1wxw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978083; c=relaxed/simple;
	bh=t4OlGCajUJLiL4hjzQEmUeYGoH2v3yJnUwQ7oIfKBTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV4Apo/HOlaNVdDNm2i8W5rxmya3rdYZhBn4aRtjsYQVXKv/3DRfA70DDsOXSDFGbux/jbxjdwCEq3aKd2rOqGlKBSssTIdWw0zj9Hl6cCiOcUffs6ANeurj2edqqdtbFswjoQNtTdQ7LlNCL0uoj+wYTUsqmqZSyk7lJPONa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmgnYt8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9FBC19423
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771978082;
	bh=t4OlGCajUJLiL4hjzQEmUeYGoH2v3yJnUwQ7oIfKBTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HmgnYt8cDUerhw0jKwrAoTnKG3pLVMXeOx5sPwAkAHLD9xh5tXtzc2BjxyLrDPSoF
	 Jpk4qbLip/0nAeOyJzmZT+xSOs6/lbPTlluMfxh9ZLnerz8UPUwM+pUZYIGXRrcAET
	 91wbYXk4QeJ7VAFe89OOGf2HTgt2wtDhfF3up5d1cyWTTSCl5IFyjTTFz93CK1/BpM
	 rdp8lAiau7X98IFONLGQC7ot38O8T/J9/cJvx14GipN8qOTJnt7jWwZXl2oqLBl2q3
	 FERcNKWooaA18ou58SxNsLk/EhpJjIikWLQ2/8tpkwzO91/btA6ywR8XDYRHV/Modp
	 n/71yX/TkzDgw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so1063778266b.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3veJ5GdbiM6ThSF56WReQB2T5T0I9lA0u6IIZyGzpdk7B47P6HvL7eBnvb4yVRGoIgf5TvmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oITX6PpvonzrQ1RsPS4WpTEIJZRleNOWtL2yYkI9kJRhVBjZ
	PTesOeqIJv7rGEn51/9z5LP89iU9pQr3Mu7oTEnv26K1ybz9Nzrc/o5Kabf8f63HI4XRmYmQXRr
	fR/WOpvBqlJeaU5MsMDdDbhNmygsA8Sk=
X-Received: by 2002:a17:907:3d12:b0:b86:e937:d097 with SMTP id
 a640c23a62f3a-b9081b23ddemr951579166b.38.1771978081686; Tue, 24 Feb 2026
 16:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223154636.116671-1-yosry@kernel.org> <20260223154636.116671-3-yosry@kernel.org>
In-Reply-To: <20260223154636.116671-3-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 24 Feb 2026 16:07:50 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com>
X-Gm-Features: AaiRm50Ohbq3rh9rPSXIa4y3k-mLYR9H54rq2fqUK-RemOOY9b7l8dkHpgP0CeY
Message-ID: <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] KVM: nSVM: Delay stuffing L2's current RIP into
 NextRIP until vCPU run
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218028-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCCEC18E4BD
X-Rspamd-Action: no action

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8f8bc863e2143..e084b9688f556 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1413,6 +1413,24 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>                 sd->bp_spec_reduce_set = true;
>                 msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);
>         }
> +
> +       /*
> +        * If nrips is supported in hardware but not exposed to L1, stuff the
> +        * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
> +        * responsible for advancing RIP prior to injecting the event). Once L2
> +        * runs after L1 executes VMRUN, NextRIP is updated by the CPU and/or
> +        * KVM, and this is no longer needed.
> +        *
> +        * This is done here (as opposed to when preparing vmcb02) to use the
> +        * most up-to-date value of RIP regardless of the order of restoring
> +        * registers and nested state in the vCPU save+restore path.
> +        */
> +       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending) {
> +               if (boot_cpu_has(X86_FEATURE_NRIPS) &&
> +                   !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> +                       svm->vmcb->control.next_rip = kvm_rip_read(vcpu);
> +       }
> +

Doing this in svm_prepare_switch_to_guest() is wrong, or at least
after the svm->guest_state_loaded check. It's possible to emulate the
nested VMRUN without doing a vcpu_put(), which means
svm->guest_state_loaded will remain true and this code will be
skipped.

In fact, this breaks the svm_nested_soft_inject_test test. Funny
enough, I was only running it with my repro changes, which papered
over the bug because it forced an exit to userspace after VMRUN due to
single-stepping, so svm->guest_state_loaded got cleared and the code
was executed on the next KVM_RUN, before L2 runs.

I can move it above the svm->guest_state_loaded check, but I think I
will just put it in pre_svm_run() instead.

