Return-Path: <stable+bounces-217612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNSKFqgGmWmiPAMAu9opvQ
	(envelope-from <stable+bounces-217612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:13:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09616BA80
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED2CA3005338
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D131B110;
	Sat, 21 Feb 2026 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aE3zpOjB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7C3595D
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636377; cv=none; b=b6mpXFyboLTP0Fc5GZlrPuLs3n5Y1DwiiswxhhO/n8PiXWUOT1E6nsRKtmjqdSAT7gUl9TCkIERNLibp+sAipSk4B9dFRlQ6dATNHNXJNaU9JX3vwTFeIaA/hAiEeB72iCl/zVDAMPuyuTfDS873rVmea8VuSb7VY7k0N0Hmn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636377; c=relaxed/simple;
	bh=sptKJUCd8+x3A8IH5AuYHocimKOtptgixOf8+MB8H8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oU8h2P6J+WaMhEQPrmUptmcaallaXY3hNYA4Bvg2pE6KSmynOaSyz60XElpI9MoGfew7bKlenF2bZX8fo/mFYa6XDtVPIE/n1KYKMDyhvsZviP9VzIAGYlwhkSUCRscOhJCnlXr9FUTQfmAO7cP2+GG3I+vj+TKsaw11oP0nMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aE3zpOjB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a7a98ba326so40642985ad.1
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 17:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771636374; x=1772241174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6OAsBgRAO98KlOsG7z1xcbC84TvI4dL/jf3QhS9k/E=;
        b=aE3zpOjBUc+jTfyAlJ1z6PStKRrhxYJgbP+sbtHkbmbfpFe/0FxWLTbiv4t3OW9hCA
         D29R1ioY0qKwSmXj9Z1zYKNiDZI4XcAoq3728USPoXDNQm7WrHrmKHMZpElEbyA4M4ly
         yhb/DnfwL7GmFfJD8Kc3XP2+o1ifz+FQL34+znjsCQ+wIo75+23fSyuIto6Udvxk4P4p
         FqH9YJ5DixiD9CHFT4IEUAnTpnfkMY6J18KSMFKPs7FvY+et/eo8yXCVjBbP/EHI/Rbo
         RDTDGgfgQx8KR6RkEKnamREL/SFokOnkdRN8lpj4wlO7DeG1EFmFxo2Ecv/9D267zBqI
         bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771636374; x=1772241174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6OAsBgRAO98KlOsG7z1xcbC84TvI4dL/jf3QhS9k/E=;
        b=vRC0WIrzk0FBECkUw555TlhSSw7eHA+phwZcgooh1sXnAP2HdOI2a6gzasC54M8ZP/
         r+wJDgrDc5IiCzv2nQEjeWrFdtcXDO23vlPCOSgp6qvtRLcu+HyPmScUUnwQMgJVaGLd
         hsmmU1a+y+e9qmoLLpPYDSKrG8L/gT6cAXW6FRD3fBnexjZL9cFhuDHBEV90Yn82Ek2G
         WA3gQ1PnnZNwA09/6nnqXzQN/nRIhfEdknEGIJQuRfVyVIF9ZezGxmyot/E44gtCeOPZ
         Q7x9kzGlJx1NTYJK0eaB9FE70FNCTqcpHKj7bvMcWtgOmDkq8138rfFTXn+3bSYy3l/3
         gixQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvuRiGEaqL+nVMNgOaML2N0fO5++DpYbUbKHop7JPx9uaQbYpP3QkWHbhoHqdi8RpZwASSaug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+mHWpPH8LmeqV8mvSXOKlJdV8zWWHse05ctTS7I7PvMiR/8s
	iuy0ylGRil7o7/l+AxFw3t0Z1FG0PXQ4XV4cxbG7kRRZyCZI8xLuCirujTPxspACYvPFLfewzlN
	WznvXjg==
X-Received: from pllk12.prod.google.com ([2002:a17:902:760c:b0:2a9:8200:4985])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce03:b0:2aa:d2f4:9c11
 with SMTP id d9443c01a7336-2ad5f7019c7mr74255455ad.5.1771636373912; Fri, 20
 Feb 2026 17:12:53 -0800 (PST)
Date: Fri, 20 Feb 2026 17:12:52 -0800
In-Reply-To: <20260206190851.860662-10-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev> <20260206190851.860662-10-yosry.ahmed@linux.dev>
Message-ID: <aZkGlFwWeRx0ZGCV@google.com>
Subject: Re: [PATCH v5 09/26] KVM: nSVM: Call enter_guest_mode() before
 switching to VMCB02
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 8B09616BA80
X-Rspamd-Action: no action

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> In preparation for moving more changes that rely on is_guest_mode()
> before switching to VMCB02, move entering guest mode a bit earlier.
> 
> Nothing between the new callsite(s) and the old ones rely on
> is_guest_mode(), so this should be safe.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 29069fc5e8cb..607d99172e2b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -741,9 +741,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  
>  	nested_svm_transition_tlb_flush(vcpu);
>  
> -	/* Enter Guest-Mode */
> -	enter_guest_mode(vcpu);
> -
>  	/*
>  	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
>  	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
> @@ -944,6 +941,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
>  
>  	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
>  
> +	enter_guest_mode(vcpu);
> +
>  	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
>  
>  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> @@ -1890,6 +1889,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>  	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
>  	nested_copy_vmcb_control_to_cache(svm, ctl);
>  
> +	enter_guest_mode(vcpu);
>  	svm_switch_vmcb(svm, &svm->nested.vmcb02);
>  	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);


LOL, guess what!  Today end's in 'y', which means there's a nSVM bug!  It's a
super minor one though, especially in the broader context, I just happened to
see it when looking at this patch.

As per 3f6821aa147b ("KVM: x86: Forcibly leave nested if RSM to L2 hits shutdown"),
shutdown on RSM is suppose to hit L1, not L2.  But if enter_svm_guest_mode() fails,
svm_leave_smm() bails without leaving guest code.  Syzkaller probably hasn't found
the bug because nested_run_pending doesn't get set, but it's still technically
wrong.

Of course, as the comment in emulator_leave_smm() says, the *entire* RSM flow is
wrong, because it's not a VM-Enter/VMRUN, it's somethign else entirely.

Anyways, I don't think there's anything to do in this series, but at some point
we should probably do:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a2452b8ec49d..5cc9ad9b750d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4877,13 +4877,15 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
        vmcb12 = map.hva;
        nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
        nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
+
        ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
-
        if (ret)
-               goto unmap_save;
+               goto leave_nested;
 
        svm->nested.nested_run_pending = 1;
 
+leave_nested:
+       svm_leave_nested(vcpu);
 unmap_save:
        kvm_vcpu_unmap(vcpu, &map_save);
 unmap_map:

