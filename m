Return-Path: <stable+bounces-187710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CDBEBE11
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E64074F9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1B2417F2;
	Fri, 17 Oct 2025 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSkXZbu4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498523BD06
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738684; cv=none; b=ij9LC8C+fESZqo4vOy/91sAkX4WmmIhjexTcPpTQXsCObnbpaf8o6OR/F5n9ZCucCIl008Z8LtLOIODyJqfnox4Z1gx7jWcaYoCCvWAv0v//CEBb5VieSPLm5AV0+rEFiBQH891vk+xdm/iz9rpjk5S3tuICb95Dv7AlohU7xAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738684; c=relaxed/simple;
	bh=+D0WFDTbOoCfDuT9kqkzxZeqg8IoPJHI1/rV8hFUq3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dx2FQ5Ts+dl6Hc4k+/T0e9Z/FsylQvI3yxJ/84naWmZ9L8//n0DeXYVmPMrl6wkQ7DklLjHIw+YTa5gOjgN97UETQVdeETF99bajBT+F2eCUgDLC84oitj/3wAaVQ7t/i0ucoM+3IBYFViIlRrCDHWcPOqb17n2j1YiM3fpGX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSkXZbu4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so3987028a91.2
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760738682; x=1761343482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pquawVenh2yObWMCdYlmJCyEx8E9Qmy2FfwsOPd2Cw=;
        b=DSkXZbu432vuMRbRa7ZsoA1TAB8N/0aRvKyKS22V0FhhQxeaH1RnycRpP5rFqk38y4
         hy6fAfB6bV1euf4aa2arl4fhxtbLyVaubEjqJayWuSp8inwb9CChooH7pjBJ7H7IBl2o
         cw2sinB9hXNK6svPsWey6BEMVnIByZkMnqiJWFGvRAIo0w0sPovaRbWUGXH9xjaxunbc
         GAjrdEKe4b/6bd3S2zYeFOZpVtwSC86xLL7WIlULqREsHFwAGKCDK9uMdNaTbLrMxl9y
         QpMZ7geDfPQN86dE8wKomlSGTuAFzaM3SY8xQmEWlK3TtxTVtSt/qVEozKkByXCz2sHM
         ElUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738682; x=1761343482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pquawVenh2yObWMCdYlmJCyEx8E9Qmy2FfwsOPd2Cw=;
        b=QMzqYjkxrbvJzXDYStI6HxKE9H6vOf87CBDZ8qPjOC3NhQh7GqGyalpX5HqJJixyXA
         sa/0E7ewjAC6VU1219WEo57qGQSm8oIFwYgUIxKGR4K3PEHRC/uMb5hwjcyVAdcFYqb5
         Byg5Kwtev5w+Lp9dsry1sGi6Mdaobb/ZMrmEM9Y6ujhVXFfpIuDuKLvkngDlpkTiGTkF
         m0zLD6vCsSTAsQNnNXzCI+JpFI2Cys5jTHQj1P8O7EE89xGJzPsCSkSEGaKDvgztBRXI
         nhj6iTw4tBDiRRZzyJ5aYf3VZNhReIfZ10Ryj9FMMsMXKDnt82t11CriRX8XCEHWCps3
         lSUA==
X-Gm-Message-State: AOJu0YzYp8bpb678Q19nTme3A2idfDyRexuYxrwkSLm5bSkabF8eoGKY
	ki+q2PrkHkcp00IAC+U39aE7wQ9F8QRq2hGQvraPvYiLP0rOrgHYOIP6gxQp8pLdrhdNemiW7fp
	v7K57OA==
X-Google-Smtp-Source: AGHT+IHKNEI5UhYONgQQr7lc7J9Wdz7i3sPtzbO1UteCFOQUPzQfdoviyIHwQWiI5KnomwvqaxCYuU58PNs=
X-Received: from pjbfa18.prod.google.com ([2002:a17:90a:f0d2:b0:33b:51fe:1a94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8b:b0:32e:9a24:2df9
 with SMTP id 98e67ed59e1d1-33bcf86c09emr5643461a91.14.1760738682476; Fri, 17
 Oct 2025 15:04:42 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:04:40 -0700
In-Reply-To: <20251014144851.94249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025101348-gigahertz-cauterize-0303@gregkh> <20251014144851.94249-1-sashal@kernel.org>
Message-ID: <aPK9eFfTBgM7Qxwm@google.com>
Subject: Re: [PATCH 6.6.y] KVM: SVM: Skip fastpath emulation on VM-Exit if
 next RIP isn't valid
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 0910dd7c9ad45a2605c45fd2bf3d1bcac087687c ]
> 
> Skip the WRMSR and HLT fastpaths in SVM's VM-Exit handler if the next RIP
> isn't valid, e.g. because KVM is running with nrips=false.  SVM must
> decode and emulate to skip the instruction if the CPU doesn't provide the
> next RIP, and getting the instruction bytes to decode requires reading
> guest memory.  Reading guest memory through the emulator can fault, i.e.
> can sleep, which is disallowed since the fastpath handlers run with IRQs
> disabled.
> 
>  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:106
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 32611, name: qemu
>  preempt_count: 1, expected: 0
>  INFO: lockdep is turned off.
>  irq event stamp: 30580
>  hardirqs last  enabled at (30579): [<ffffffffc08b2527>] vcpu_run+0x1787/0x1db0 [kvm]
>  hardirqs last disabled at (30580): [<ffffffffb4f62e32>] __schedule+0x1e2/0xed0
>  softirqs last  enabled at (30570): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
>  softirqs last disabled at (30568): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
>  CPU: 298 UID: 0 PID: 32611 Comm: qemu Tainted: G     U              6.16.0-smp--e6c618b51cfe-sleep #782 NONE
>  Tainted: [U]=USER
>  Hardware name: Google Astoria-Turin/astoria, BIOS 0.20241223.2-0 01/17/2025
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x7d/0xb0
>   __might_resched+0x271/0x290
>   __might_fault+0x28/0x80
>   kvm_vcpu_read_guest_page+0x8d/0xc0 [kvm]
>   kvm_fetch_guest_virt+0x92/0xc0 [kvm]
>   __do_insn_fetch_bytes+0xf3/0x1e0 [kvm]
>   x86_decode_insn+0xd1/0x1010 [kvm]
>   x86_emulate_instruction+0x105/0x810 [kvm]
>   __svm_skip_emulated_instruction+0xc4/0x140 [kvm_amd]
>   handle_fastpath_invd+0xc4/0x1a0 [kvm]
>   vcpu_run+0x11a1/0x1db0 [kvm]
>   kvm_arch_vcpu_ioctl_run+0x5cc/0x730 [kvm]
>   kvm_vcpu_ioctl+0x578/0x6a0 [kvm]
>   __se_sys_ioctl+0x6d/0xb0
>   do_syscall_64+0x8a/0x2c0
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  RIP: 0033:0x7f479d57a94b
>   </TASK>
> 
> Note, this is essentially a reapply of commit 5c30e8101e8d ("KVM: SVM:
> Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"), but with
> different justification (KVM now grabs SRCU when skipping the instruction
> for other reasons).
> 
> Fixes: b439eb8ab578 ("Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250805190526.1453366-2-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adapted switch-based MSR/HLT fastpath to if-based MSR-only check ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

