Return-Path: <stable+bounces-232864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAHdGA+NzWlfewYAu9opvQ
	(envelope-from <stable+bounces-232864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:24:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6D380983
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784BF301B939
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9F37C0ED;
	Wed,  1 Apr 2026 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cu45X8sK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340B33E34C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078532; cv=none; b=iW9I0joxViiCc/ZYdeSM7CbiSvN6TIWGsZeaISnmws8P+KVwXIfpzKLRQ+0vvJS6DtHpHrjx4DT6/KhiA2PWPliIuYmY44j4rn6Bosn0oTcSj818mx/JkSBWEMzqcHieedA350DoIK1OO0m5pjaEoF8L52//4G0UYEhPS+m9xyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078532; c=relaxed/simple;
	bh=eCHYA9x0msM+/tzsHdHEYnVG5Wv4p2DcHSUPrSWA1ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QAL0hfHenULwrwqipUA6sW6YAQMzP7V46Q/qHjrL3xS7omKf2rWE9+1ZcSkyBTx0eSfLoUQDbZSQJ3EL/zN1lU9N5AO5FwdoyfqgY5e6nbR2eGNHBthHIGXMaYbJ/BJhddR2gcW+aFhuNmQyYOO+knWrxdYCQ9eiA1X7ndumzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cu45X8sK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c6929bd26so321729b3a.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775078530; x=1775683330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rn6ajxX3vZ5d3OVJ7/V0E3/Ul79bTRTt6/OA4HCyBME=;
        b=Cu45X8sKOnqnId5oi6Ll4YiKqrMiF5Tq7nfVhOOL7C+DOwkHduvrnVqesMIghTM11F
         KLAi7zaWehzcHQ0jM0y2ym5OPSSZHXV1ULqJGYFCY/ySbP6acClZTJFz5H8ybv+2r2OI
         qIS07MF16WmsLjMqj48DYzV129cU2ljGLN5J+rGDBwQfCRRZgD1+uZNa02b0lBRq0rik
         UANbqVGPKjAR6JplHqap/QAGNd3FyCt/XsW7v5H+fcZEcNfU6Nag7A0gTV2RVd8UwU2h
         Xkkiff7dnlqGp7Lms+0n6XsP02n1GO6OtOY4Q7O97qP1uKgknJxV1Z3NSMPFm19fz+4J
         8NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078530; x=1775683330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rn6ajxX3vZ5d3OVJ7/V0E3/Ul79bTRTt6/OA4HCyBME=;
        b=exBY+scS1S9uiKAagTINO9pzmvy6q2Aieus4a3Df8mEXsNJ5CNl+Yibxa1bONzyPnl
         1H8x3mPQE21Jw4MlaUdidoFn34I5dUm5qWDqpqYI369WDv8t7Vu4yjxkRG9sHMAGpLiN
         cDIjrIj1rM52vWiF6EZhfX8awlOD5lPPFM76BN+y6On7fzpD285uD8dQDnpUNgDCgnx9
         fGavsRv1EuK98qHvmoWT59+o2iIliS+bR9ksJB5KU/Wzly2JPu94on7kM666ybXITsJA
         sKpva3x0m4P5QuFssQPOInyq3CFwCWFcl164KBxkhPkLuZHcJAIlIDukLDU2K0+9eiDT
         h2fg==
X-Gm-Message-State: AOJu0YxFcD6ag/1aGjXjEtgvCgmDJ8mjMG6DBLQWA0E+i/0dEsI2WRuV
	NKM0JF6wt0nz85w8FJeQkbktHgaeyt//3iPcvIGg/i9fRGBQ3ZO004lNhSXdKxNz6Cc9qjnSkuK
	9aldjEQ==
X-Received: from pfwp50.prod.google.com ([2002:a05:6a00:26f2:b0:829:8aa0:dc3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:26d2:b0:82c:f45d:415e
 with SMTP id d2e1a72fcca58-82cf45d44ffmr2117960b3a.8.1775078530323; Wed, 01
 Apr 2026 14:22:10 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:22:09 -0700
In-Reply-To: <20260401004437.4036016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026033039-occupy-slush-db02@gregkh> <20260401004437.4036016-1-sashal@kernel.org>
Message-ID: <ac2MgQiWdy6QfUSC@google.com>
Subject: Re: [PATCH 5.10.y] KVM: x86/mmu: Drop/zap existing present SPTE even
 when creating an MMIO SPTE
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Alexander Bulekov <bkov@amazon.com>, 
	Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232864-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:email]
X-Rspamd-Queue-Id: B8D6D380983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit aad885e774966e97b675dfe928da164214a71605 ]
> 
> When installing an emulated MMIO SPTE, do so *after* dropping/zapping the
> existing SPTE (if it's shadow-present).  While commit a54aa15c6bda3 was
> right about it being impossible to convert a shadow-present SPTE to an
> MMIO SPTE due to a _guest_ write, it failed to account for writes to guest
> memory that are outside the scope of KVM.
> 
> E.g. if host userspace modifies a shadowed gPTE to switch from a memslot
> to emulted MMIO and then the guest hits a relevant page fault, KVM will
> install the MMIO SPTE without first zapping the shadow-present SPTE.
> 
>   ------------[ cut here ]------------
>   is_shadow_present_pte(*sptep)
>   WARNING: arch/x86/kvm/mmu/mmu.c:484 at mark_mmio_spte+0xb2/0xc0 [kvm], CPU#0: vmx_ept_stale_r/4292
>   Modules linked in: kvm_intel kvm irqbypass
>   CPU: 0 UID: 1000 PID: 4292 Comm: vmx_ept_stale_r Not tainted 7.0.0-rc2-eafebd2d2ab0-sink-vm #319 PREEMPT
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:mark_mmio_spte+0xb2/0xc0 [kvm]
>   Call Trace:
>    <TASK>
>    mmu_set_spte+0x237/0x440 [kvm]
>    ept_page_fault+0x535/0x7f0 [kvm]
>    kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
>    kvm_mmu_page_fault+0x8d/0x620 [kvm]
>    vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
>    kvm_arch_vcpu_ioctl_run+0xc55/0x1c20 [kvm]
>    kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
>    __x64_sys_ioctl+0x8a/0xd0
>    do_syscall_64+0xb5/0x730
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x47fa3f
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Alexander Bulekov <bkov@amazon.com>
> Debugged-by: Alexander Bulekov <bkov@amazon.com>
> Suggested-by: Fred Griffoul <fgriffo@amazon.co.uk>
> Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ replaced `kvm_flush_remote_tlbs_gfn()` with `kvm_flush_remote_tlbs_with_address()` and omitted `pf_mmio_spte_created` stat counter ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

NAK, the buggy commit was introduced in 5.13 and never made its way to 5.10.y.

E.g. the fact that this is purely additive highlights the lack of fixing anything.

> ---
>  arch/x86/kvm/mmu/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 13bf3198d0cee..79bcb5430b5f8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2619,6 +2619,14 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  			was_rmapped = 1;
>  	}
>  
> +	if (unlikely(is_noslot_pfn(pfn))) {
> +		mark_mmio_spte(vcpu, sptep, gfn, pte_access);
> +		if (flush)
> +			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn,
> +					KVM_PAGES_PER_HPAGE(level));
> +		return RET_PF_EMULATE;
> +	}
> +
>  	set_spte_ret = set_spte(vcpu, sptep, pte_access, level, gfn, pfn,
>  				speculative, true, host_writable);
>  	if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
> -- 
> 2.53.0
> 

