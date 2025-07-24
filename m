Return-Path: <stable+bounces-164635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D52B10EDC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7983BAAAF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFBE2E54AA;
	Thu, 24 Jul 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="os/+tCBS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1112279917
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371537; cv=none; b=VXhVnjIhnHppLz11bvskUANVFq0h7SdWENVwwmK6ZcOdIfRnpOriJGkk7/oDvESAY3VxpyEsHnA/r1hVv6wd61NF+ruNzYgJ+8ChhTpO8RKLkAP87prlw3qL3hvpkC+AgEDoCi2skis4Mco3yHX4xysUVw89V4y80O+FiOQ/wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371537; c=relaxed/simple;
	bh=XeryQQub00e3CsiBdwVSP1q48vZr+YkE4SxWBDDdWAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sMBiDQ+KY94ls+WnqYVRWCn5uNuSgTIlKeaAHCY1lkpJiXP6cVjvpmuWvEmH9uurIg9ooJCdslUml9Xg4VpPTVaIEwsKeii2PptZFk0pQ+c5pwzqZ4487wdwB4STJaZVqG7u4F+nEkcYwgSGAOefZnh8nX3+EAWhI102U1GcQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=os/+tCBS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23689228a7fso18992005ad.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371535; x=1753976335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibMj7KxCA52T9nYfHm52Szgpvph4SrjYLR+2AFPU3as=;
        b=os/+tCBSZTg1R7yIo1iZvQD3GCg0s6okAwrAAGUCOu4tIeILkoyMEchFde2LpInN8W
         Xo+PcHk4IQHIbdjRpK8NXwUHf0+N1vUmXr00hwPqrYrEvYQu95vXyxAo+Gp82cs+MLhd
         JrlZlBMiWMCboJD+P4rqqy81bp4UgAHjh0XUWZ9Q2vsbGyKg9LkjmXjkydZA0mezwtgl
         6VQvBWlJbKIxF+Cyr1C8RrqF6s3CayiDzRXLMLCES8eiTwZWFuAqZOYTznQBXKq/Yubn
         TL4tCI6ONCwEqGV6g2bqRzUj0SJQQiv30W419KE9KWpqtBFtHjXAdbPgBSXKU8DkAmdV
         vIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371535; x=1753976335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibMj7KxCA52T9nYfHm52Szgpvph4SrjYLR+2AFPU3as=;
        b=aLfeG3zy0wiLCwb1Xff2FlDkOWDcYAKmkgkuxck1nLWdVePxiHSb+4jMFtdPkYotZK
         mWORVOlCnGk5TAxAzsr2xCxJ6qkbjDEc06lQbepUUGefbKdlvucQFP/Ybi811O5DhoXT
         kCwJhEWVT3eJfo4OZwZZzFlku+/JK/e4X1vwWYSD4rGpYWm5BYKqCioo7/Cb8QEXqWPW
         Lz4sYjtD6X/ysDpwsqwlCKgY4ywDCRAB5zNh2efMZZzmoAzP716ABNqKME0NKQ7YeZHq
         qrFqIKXz/JbbsA1ajD83z/c7LLbfyxqF12Mkj5LdVEZe2SyhUoqH3GifEvdqUzacu8/f
         kd6w==
X-Gm-Message-State: AOJu0Yw/agev4kjLUJ4Vmu7saP2BfwgMI6JKWm6KV/PpBUtsnh0bzOC8
	OVbAyi+uDWxXmdVZ7W2hyW2QLYBTjCNr3Ir2hpHjQaJAgaraAa2PaBrYh0VWIUMpljwMKPenJaR
	xSx6jgQ==
X-Google-Smtp-Source: AGHT+IHuS3unJkm5PNw75/7ti8QD0fXVWwudCENZeeysECJu5OcY5dmhgh86Kv4w3AU7enlzs52rQAFiWPA=
X-Received: from plgx2.prod.google.com ([2002:a17:902:ec82:b0:235:1661:e986])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4901:b0:235:866:9fac
 with SMTP id d9443c01a7336-23fa23c07b7mr37084895ad.2.1753371535115; Thu, 24
 Jul 2025 08:38:55 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:38:53 -0700
In-Reply-To: <20250723151416.1092631-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025071240-phoney-deniable-545a@gregkh> <20250723151416.1092631-1-sashal@kernel.org>
 <20250723151416.1092631-5-sashal@kernel.org>
Message-ID: <aIJTjSq2FCO3x2uD@google.com>
Subject: Re: [PATCH 6.12.y 5/5] KVM: x86/hyper-v: Skip non-canonical addresses
 during PV TLB flush
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Manuel Andreas <manuel.andreas@tum.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Sasha Levin wrote:
> From: Manuel Andreas <manuel.andreas@tum.de>
> 
> [ Upstream commit fa787ac07b3ceb56dd88a62d1866038498e96230 ]
> 
> In KVM guests with Hyper-V hypercalls enabled, the hypercalls
> HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST and HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX
> allow a guest to request invalidation of portions of a virtual TLB.
> For this, the hypercall parameter includes a list of GVAs that are supposed
> to be invalidated.
> 
> However, when non-canonical GVAs are passed, there is currently no
> filtering in place and they are eventually passed to checked invocations of
> INVVPID on Intel / INVLPGA on AMD.  While AMD's INVLPGA silently ignores
> non-canonical addresses (effectively a no-op), Intel's INVVPID explicitly
> signals VM-Fail and ultimately triggers the WARN_ONCE in invvpid_error():
> 
>   invvpid failed: ext=0x0 vpid=1 gva=0xaaaaaaaaaaaaa000
>   WARNING: CPU: 6 PID: 326 at arch/x86/kvm/vmx/vmx.c:482
>   invvpid_error+0x91/0xa0 [kvm_intel]
>   Modules linked in: kvm_intel kvm 9pnet_virtio irqbypass fuse
>   CPU: 6 UID: 0 PID: 326 Comm: kvm-vm Not tainted 6.15.0 #14 PREEMPT(voluntary)
>   RIP: 0010:invvpid_error+0x91/0xa0 [kvm_intel]
>   Call Trace:
>     vmx_flush_tlb_gva+0x320/0x490 [kvm_intel]
>     kvm_hv_vcpu_flush_tlb+0x24f/0x4f0 [kvm]
>     kvm_arch_vcpu_ioctl_run+0x3013/0x5810 [kvm]
> 
> Hyper-V documents that invalid GVAs (those that are beyond a partition's
> GVA space) are to be ignored.  While not completely clear whether this
> ruling also applies to non-canonical GVAs, it is likely fine to make that
> assumption, and manual testing on Azure confirms "real" Hyper-V interprets
> the specification in the same way.
> 
> Skip non-canonical GVAs when processing the list of address to avoid
> tripping the INVVPID failure.  Alternatively, KVM could filter out "bad"
> GVAs before inserting into the FIFO, but practically speaking the only
> downside of pushing validation to the final processing is that doing so
> is suboptimal for the guest, and no well-behaved guest will request TLB
> flushes for non-canonical addresses.
> 
> Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Link: https://lore.kernel.org/r/c090efb3-ef82-499f-a5e0-360fc8420fb7@tum.de
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

