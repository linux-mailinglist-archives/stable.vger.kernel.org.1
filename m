Return-Path: <stable+bounces-223127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHv4GYx9qGmHuwAAu9opvQ
	(envelope-from <stable+bounces-223127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:44:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE402068D1
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBE3303CEE3
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808C37189D;
	Wed,  4 Mar 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHQu1xZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD713CF699
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649585; cv=none; b=dF+LQjLwaZ1nI/9hWlaavogClMxU3GBKD83vhaVl5VlGuKfRHpdEvdzVpySJbKZ857Ng7dcZ/+8NRsp9iMi6iFgjVbce4l989b6ECsIXrVPBgX3kT39isX/AaWEZKaTUImtKNHLuvKYElwt3uElHHj6KSbb1LEtp/M1/vVPc/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649585; c=relaxed/simple;
	bh=0qljtvoH52xWt1te+IhM6qQalPMLPmWAuRZpkjJffVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnRKe4DXX7jjxyNCyAYBdWUNyPOb0jJTdB335T8fE1OqvCDG/tK70JzBejXJju13Zudl1nqWlLZJVy03EVaQZcFJTETAu4Yo3gIY9pIWUtRKoFP/hrs1qkcxJFfjGXmhkIgqaI/iTPkKMavcBWNCGsgVaNWx53LvEXSa/ZaxC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHQu1xZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BBDC4CEF7
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649584;
	bh=0qljtvoH52xWt1te+IhM6qQalPMLPmWAuRZpkjJffVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FHQu1xZDdwa+xyHN50qHb+05yxvTY7/sQrz/6oUb40gnjlBRDcxPsqYAhV2sy9DE0
	 xjBzj4MXdkoUif2HMXdZ34Iy7IeAgTXv//Z+OAL/tE/8DWt8Y0/J7L5MeWmUByAAGN
	 3seZvXvBRYj+ABr7uQmw5MYwe1BbULMiACIDr/72E1mBgsM6HPwEtXdX4//tfxb5vB
	 qkiLIHMKVqhVXoATs+yWaTPfxwNvkgUKOMxWX85EmMBxEn0NQVxm3qkpOaEFn2Yvfc
	 uLE3cxnMELLkloW4knxBrODP4LSkebrpooWT/lLXULkXAPks2NyC0GRmaMevrj4TUN
	 DkLXBjAPbsWhw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b904e1cd038so961780666b.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 10:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXhbSSQKHw+DKInA9ydEwqT1bwgKC+p90tLn3ihaLRsPc3PcuyFminjvykM0rYLYXTTmz58GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfvzxxt0UzsVdsS1lKj3tyPnJoL4ISwnmMp5MQ0/VwIl5YGFc
	U86dwFxRFAg8iL5B5EZgWgks1Z6Szqy4ZLddzmwiKDJa4QpbqNJwpBR1Lt3zUSkhefHEj4x3qf7
	4DPaPjd+w8ZbEM9Ui7XQYZExu0ypL2os=
X-Received: by 2002:a17:907:5cb:b0:b8a:f225:edde with SMTP id
 a640c23a62f3a-b93f14101d4mr172386566b.45.1772649583598; Wed, 04 Mar 2026
 10:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225005950.3739782-1-yosry@kernel.org> <20260225005950.3739782-8-yosry@kernel.org>
 <CAO9r8zOvhJgA2v3CXomddmyfrR2KX23fv=HQ6xH2C+m0niswyQ@mail.gmail.com> <aah7THlqWe9VLv8B@google.com>
In-Reply-To: <aah7THlqWe9VLv8B@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 4 Mar 2026 10:39:30 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP3YmMf1Rx_mK8Xt1ynyjaP1CcRy5GHqerNMfRv0418fw@mail.gmail.com>
X-Gm-Features: AaiRm52_6lu7ppb7mjiJDrloxdgbqXn1yLLVHOpa0_TZ5nNfrlIgZD7YteLTcrE
Message-ID: <CAO9r8zP3YmMf1Rx_mK8Xt1ynyjaP1CcRy5GHqerNMfRv0418fw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] KVM: nSVM: Delay setting soft IRQ RIP tracking
 fields until vCPU run
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CEE402068D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223127-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > AI found a bug here. These fields will be left uninitialized if we
> > cancel injection before pre_svm_run() (e.g. due to
> > kvm_vcpu_exit_request()). I was going to suggest moving this to
> > pre-run, but this leaves a larger gap where RIP can be updated from
> > under us. Sean has a better fixup in progress.
>
> With comments to explain the madness, this should work as fixup.  It's gross and
> brittle, but the only alternative I see is to add a flag to differentiate the
> save/restore case from the VMRUN case.  Which isn't terrible, but IMO most of
> the brittleness comes from the disaster that is the architecture.
>
> Given that the soft int reinjection code will be inherently brittle, and that
> the save/restore scenario will be _extremely_ rare, I think it's worth the extra
> bit of nastiness so that _if_ there's a bug, it's at least slightly more likely
> we'll find it via the normal VMRUN path.

Agreed, the fixup looks good to me as long as we add comments to
explain WTF is going on here lol.

>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 258aa3bfb84b..2bfbaf92d3e5 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3755,6 +3755,16 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>         return svm_invoke_exit_handler(vcpu, svm->vmcb->control.exit_code);
>  }
>
> +static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_svm *svm = to_svm(vcpu);
> +
> +       svm->soft_int_csbase = svm->vmcb->save.cs.base;
> +       svm->soft_int_old_rip = kvm_rip_read(vcpu);
> +       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> +                       svm->soft_int_next_rip = kvm_rip_read(vcpu);
> +}
> +
>  static int pre_svm_run(struct kvm_vcpu *vcpu)
>  {
>         struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
> @@ -3797,12 +3807,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>                     !guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
>                         svm->vmcb->control.next_rip = kvm_rip_read(vcpu);
>
> -               if (svm->soft_int_injected) {
> -                       svm->soft_int_csbase = svm->vmcb->save.cs.base;
> -                       svm->soft_int_old_rip = kvm_rip_read(vcpu);
> -                       if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> -                               svm->soft_int_next_rip = kvm_rip_read(vcpu);
> -               }
> +               if (svm->soft_int_injected)
> +                       svm_set_nested_run_soft_int_state(vcpu);
>         }
>
>         return 0;
> @@ -4250,6 +4256,9 @@ static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
>         bool is_soft = (type == SVM_EXITINTINFO_TYPE_SOFT);
>         struct vcpu_svm *svm = to_svm(vcpu);
>
> +       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending)
> +               svm_set_nested_run_soft_int_state(vcpu);
> +
>         /*
>          * If NRIPS is enabled, KVM must snapshot the pre-VMRUN next_rip that's
>          * associated with the original soft exception/interrupt.  next_rip is

