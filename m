Return-Path: <stable+bounces-217328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAeWFtlJlmngdQIAu9opvQ
	(envelope-from <stable+bounces-217328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:23:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E231515AE91
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102073015476
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2033ADA4;
	Wed, 18 Feb 2026 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmEFCEVr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC833ADA2
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456968; cv=none; b=o8wqV4ElUQauuxtt0LxzFkF5Ta1krETq1dsY3wD7206WBLXS4kd+K57MLRNyR0E+ucR4ShtnFJEoDtwCoB7/aba5vVb1iKQ/wstbEz1yEqNhB4k0Gj/JxE4g/3jD17A4DWdq6ND+RRRc7cCDNyOoL98h7sPJt6UOxN333vvBezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456968; c=relaxed/simple;
	bh=ak+Fjrc8c6aDkTgBoI7fd+2k7yh8dnyTxfOcRaoQ/ok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UhEPpbhvGi/c7NFQm0jb5bW4l1Gf3yVvowOrq4hWvXMl5XKyZCfbAF65IKzlTZT5f4glzPRfkxkx150p3D/KYLOOXJ3aFlxSB0EEcHIkVqwKkHmU+407RjE21nDWvNYv82DPgmNaTvSRYw1FsSeXcePZSc50KYQGJSSllPMIp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmEFCEVr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6de1ee12a3so174004a12.2
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771456965; x=1772061765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oBGE3p/lhKaQkwFweneW6rHkdciCRGmOksHejZJMmw=;
        b=OmEFCEVrDaO/oYez2gF5z+P+oStD3Owr3qDvDMp16rkyf7MKJ9dZH9yqzfow86Hek7
         kLu5bVHuEwrXvzV82LNSipzMdOMyHsc3VUI0jWXA5l/JHoKBK9ze6+uFCtE5sbhKp/3Q
         myxjzVNH+vPNEyD9YaC5VlLq15fLBKiLTtGcuxfWAHlWzewJSxpRNQvr1HQzqr0TmisU
         M6SiGz3sIyehWOp4cACokHswIlEm7hCZTvBmI5UddkMduxGYQhalQovS1QlYqgacaeKq
         X6qQKXfMbQMv0GUtmIl6h91PBwDFXBJADgn7JS7yZqkHXwVZsNRbMallFNk4EybddGGQ
         5tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771456965; x=1772061765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oBGE3p/lhKaQkwFweneW6rHkdciCRGmOksHejZJMmw=;
        b=oQ0DLAHcA4yvtv+riLa8Ba6lU10/kNb+MBEUoGK5kMU8xepMNOyHQveQULqlJdtlvp
         e4lklQghAh044u8qNXs9kyJkRbLtAYIksld3yajLs4pLCALb2W3a5dyzBzAZxdR0XBiE
         wL4AN06GOI1IXsabg8itysWvVM9B83eaT566m7LONUM8ITUovyq2uuv/QF/TltWqptFf
         iHXxYpF7SvZu+6F7QtgrjKUjICyS1Ocf+Ght1hWpoeqKGwEV816KJH3ir26zK6Bc7lMX
         zvxSJmqxC1WbiK6y5Tqf2PqlGOTGlropSezk4txtGYZ744HQplcyN5GeDXGCt7laD+6l
         tWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVdO79ABc3ZH0g8dtHLpOKYe2i2WkIpmnr18u1MyIP6cEgmm9p9YlWLZQXgGLDsVF+aOlY4Yeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVqDcxjphevVuZAzdPmj3HXHKQ8ncS/VVFcr55kaaK1oFy2Lq
	rcNaWAcXLHQp2wtfJ7365Em54hCY0s5liHSbip2K//JahyWMtxsGqRwO0qnzdCTvxzwozRZoE9Z
	lLU0ylQ==
X-Received: from pgc10.prod.google.com ([2002:a05:6a02:2f8a:b0:b98:d6e8:a405])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b0d:b0:394:594c:1ab6
 with SMTP id adf61e73a8af0-39512210c2dmr614317637.59.1771456965343; Wed, 18
 Feb 2026 15:22:45 -0800 (PST)
Date: Wed, 18 Feb 2026 15:22:44 -0800
In-Reply-To: <20260212230751.1871720-2-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260212230751.1871720-1-yosry.ahmed@linux.dev> <20260212230751.1871720-2-yosry.ahmed@linux.dev>
Message-ID: <aZZJxDVK4ekHxaLb@google.com>
Subject: Re: [RFC PATCH 1/5] KVM: nSVM: Do not use L2's RIP for vmcb02's
 NextRIP after first L2 VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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
	TAGGED_FROM(0.00)[bounces-217328-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E231515AE91
X-Rspamd-Action: no action

On Thu, Feb 12, 2026, Yosry Ahmed wrote:
> For guests with NRIPS disabled, L1 does not provide NextRIP when running
> an L2 with an injected soft interrupt, instead it advances L2's RIP
> before running it. KVM uses L2's RIP as the NextRIP in vmcb02 to emulate

Should "L2's RIP" be "vmcb12's RIP"?  The "L2's RIP" terminology gets really
confusing in the next paragraph, as NextRIP _is_ L2's (Next)RIP.  Hmm, or maybe
"current RIP"?  I.e. "current RIP" vs. "NextRIP"?

> a CPU without NRIPS.
> 
> However, after L2 runs the first time, NextRIP will be updated by the
> CPU and/or KVM, and L2's RIP is no longer the correct value to use in
> vmcb02. Hence, after save/restore, do not use L2's RIP if a nested run
> is not pending (i.e. L2 has run at least once), use the NextRIP value.

Too many negatives in this last sentence, it can just be (I think):

  Hence, after save/restore, use the current RIP if and only if a nested
  run is pending, otherwise use NextRIP.

> Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
> CC: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index de90b104a0dd..eebbe00714e3 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -844,14 +844,18 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  	vmcb02->control.event_inj_err       = svm->nested.ctl.event_inj_err;
>  
>  	/*
> -	 * next_rip is consumed on VMRUN as the return address pushed on the
> +	 * NextRIP is consumed on VMRUN as the return address pushed on the
>  	 * stack for injected soft exceptions/interrupts.  If nrips is exposed
> -	 * to L1, take it verbatim from vmcb12.  If nrips is supported in
> -	 * hardware but not exposed to L1, stuff the actual L2 RIP to emulate
> -	 * what a nrips=0 CPU would do (L1 is responsible for advancing RIP
> -	 * prior to injecting the event).
> +	 * to L1, take it verbatim from vmcb12.
> +	 *
> +	 * If nrips is supported in hardware but not exposed to L1, stuff the
> +	 * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
> +	 * responsible for advancing RIP prior to injecting the event). This is
> +	 * only the case for the first L2 run after VMRUN. After that (e.g.
> +	 * during save/restore), NextRIP is updated by the CPU and/or KVM, and
> +	 * the value of the L2 RIP from vmcb12 should not be used.
>  	 */
> -	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) || !svm->nested.nested_run_pending)

This is technically wrong since KVM doesn't require NRIPS.  Maybe this?

	if (boot_cpu_has(X86_FEATURE_NRIPS)) {
		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
		    !svm->nested.nested_run_pending)
			vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
		else
			vmcb02->control.next_rip    = vmcb12_rip;
	}
	

>  		vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
>  	else if (boot_cpu_has(X86_FEATURE_NRIPS))
>  		vmcb02->control.next_rip    = vmcb12_rip;
> -- 
> 2.53.0.273.g2a3d683680-goog
> 

