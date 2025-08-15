Return-Path: <stable+bounces-169660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA9B273BF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D32916BCE1
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3241C63;
	Fri, 15 Aug 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3FB3rTs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAD27442
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217548; cv=none; b=CxTNIEq7H0Wuh5hykPMJhuB54gJiCqKAsZAwb7vPVigIy1bUYz92vjQjfG45+n6qnQgiDGXd9T7A1uwRvH5ZzJGyxnOWVzfCl+NSvKX9FlQaCrBTkzRGriPqr4O/8wVqc5J7kzYn7z4ki8rraTn0GPa54lg0D+BQaatQ7zmdzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217548; c=relaxed/simple;
	bh=lNrTG3ug7ln/k29T/kkm8iUv2vwABLIpyspckgsl/Wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vEWDw9856LSfa5CzGfOXJyOBg0dT71fuTOAPZRWmM6Nkh0K4uIC1+u4aIUnCV/gJeD/IvoakxypbY5Bvj3/HTZMQxe4akszLm9spyCTHLPh5QLaAfKd+MxbSrdLFJmy70qyHvHNO3Ha0sNUPe9SxTjVK0iVXMR0fnocr4rQRWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3FB3rTs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e8fc814so1331769b3a.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217546; x=1755822346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7ig53neGTMgA3a5TU6R5Q/bPz27KtuTvwJhepf6GScA=;
        b=r3FB3rTslRJzwaJlrbEK07gGZ4YIN1iTUBgEN8157Pe3aZ3R8OrP47DLNCwtA/f5K2
         v5Wpmx09iAMaUmsJbjKAOhRtcXdy6itjoaPIl2tkgukqKwyAHTiXNK0F0Q3kVojJWpW1
         9JDVrq2SykEE9WmPVySD0f9uwvdOBce2Dszv6uqZjskt20ZkkXMl3LAXFtZ/bjx6W06q
         AogcI+GylXg1/G54mjaqJYY/BakF9x7S2G9uBUBb2xngTclbSS0BMaVGcvqK9bXcwgrM
         Xc60+JSuTLl4l6Te21y6/3gBAzuvFd7iZmhhj4pEl46iph36wu1LZXcru3huKEFsc4Qk
         MyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217546; x=1755822346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ig53neGTMgA3a5TU6R5Q/bPz27KtuTvwJhepf6GScA=;
        b=U7MVB1IIaeYElEpfr1KtfJxevluB97sx36n06sHO8T7/zhz12If1NWKGR7nrpnfrjO
         dUDmlxSE3+SyMcvrU4zG/0B9R39DMKM02SdTv4NHaShNZlw6PQt/aL6q85jwx4GsEReM
         W1YrPQ4xGZJ0uroZ9xg6/DvZHka2ohhjGEb47vT4C0xgS+qplPyNoaCptDc6MZMwWvlX
         zqlcoq/ZFlzJPctxIQ6/sm/ofQuMwbKpWwGz+9aG8sOaxl7IpIX+cUw+qFqX1QZR+0Io
         IUrIS98Xaz7ygUu+xwxfxOrYlAozcL3SuoJ7Ow+Czi/RbHVil+Qs0w7drvFIGQMZNHx0
         MWjQ==
X-Gm-Message-State: AOJu0YwjntFES9xKj1d64yrNmOjXzamGNBdIwChZOZDVZQkxuRAv7HHX
	hiPP6UF4UIvrXL96NeqOZi9sAw6XtHcSYd6s38l8sR8/dsr4w2q7U+0zcc3TjPL5Mak6ppx99MJ
	evMvQVfVdiaIQIm8lW+dnLT4V30Bv7PtTgwpHe6pbxhdZHEtOr17HU4NTmwUJMfkpVixO8Jw7wc
	0l+Opp33IqV1Mz89zDnaXSwTg6YlrUP08G5m/N
X-Google-Smtp-Source: AGHT+IHjpVTcPVWerqqHUBx6ySGF71sq1mvsS8WJJPtYX/zo6Hu9hQzhi2GqqSK+vmUtRFPhlaVn/ZAbOXc=
X-Received: from pfbfb7.prod.google.com ([2002:a05:6a00:2d87:b0:76b:b0c5:347c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e1a:b0:76b:c9b9:a11b
 with SMTP id d2e1a72fcca58-76e446af2e1mr126654b3a.3.1755217545972; Thu, 14
 Aug 2025 17:25:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:21 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-2-seanjc@google.com>
Subject: [PATCH 6.6.y 01/20] KVM: x86/hyper-v: Skip non-canonical addresses
 during PV TLB flush
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Manuel Andreas <manuel.andreas@tum.de>

[ Upstream commit fa787ac07b3ceb56dd88a62d1866038498e96230 ]

In KVM guests with Hyper-V hypercalls enabled, the hypercalls
HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST and HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX
allow a guest to request invalidation of portions of a virtual TLB.
For this, the hypercall parameter includes a list of GVAs that are supposed
to be invalidated.

However, when non-canonical GVAs are passed, there is currently no
filtering in place and they are eventually passed to checked invocations of
INVVPID on Intel / INVLPGA on AMD.  While AMD's INVLPGA silently ignores
non-canonical addresses (effectively a no-op), Intel's INVVPID explicitly
signals VM-Fail and ultimately triggers the WARN_ONCE in invvpid_error():

  invvpid failed: ext=0x0 vpid=1 gva=0xaaaaaaaaaaaaa000
  WARNING: CPU: 6 PID: 326 at arch/x86/kvm/vmx/vmx.c:482
  invvpid_error+0x91/0xa0 [kvm_intel]
  Modules linked in: kvm_intel kvm 9pnet_virtio irqbypass fuse
  CPU: 6 UID: 0 PID: 326 Comm: kvm-vm Not tainted 6.15.0 #14 PREEMPT(voluntary)
  RIP: 0010:invvpid_error+0x91/0xa0 [kvm_intel]
  Call Trace:
    vmx_flush_tlb_gva+0x320/0x490 [kvm_intel]
    kvm_hv_vcpu_flush_tlb+0x24f/0x4f0 [kvm]
    kvm_arch_vcpu_ioctl_run+0x3013/0x5810 [kvm]

Hyper-V documents that invalid GVAs (those that are beyond a partition's
GVA space) are to be ignored.  While not completely clear whether this
ruling also applies to non-canonical GVAs, it is likely fine to make that
assumption, and manual testing on Azure confirms "real" Hyper-V interprets
the specification in the same way.

Skip non-canonical GVAs when processing the list of address to avoid
tripping the INVVPID failure.  Alternatively, KVM could filter out "bad"
GVAs before inserting into the FIFO, but practically speaking the only
downside of pushing validation to the final processing is that doing so
is suboptimal for the guest, and no well-behaved guest will request TLB
flushes for non-canonical addresses.

Fixes: 260970862c88 ("KVM: x86: hyper-v: Handle HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently")
Cc: stable@vger.kernel.org
Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/c090efb3-ef82-499f-a5e0-360fc8420fb7@tum.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: use plain is_noncanonical_address()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index bd3fbd5be5da..223f4fa6a849 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1929,6 +1929,9 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
+		if (is_noncanonical_address(entries[i], vcpu))
+			continue;
+
 		/*
 		 * Lower 12 bits of 'address' encode the number of additional
 		 * pages to flush.
-- 
2.51.0.rc1.163.g2494970778-goog


