Return-Path: <stable+bounces-40677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CD8AE721
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5C1F248B1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135212DDAC;
	Tue, 23 Apr 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZf7+6eG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19A12D777
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877052; cv=none; b=PdaWCMmBGYAEXa9AijjcMVqeY0+j9+tuDBaMa2i/3AlKDSCgG9uE6+PN2+AJ4G8J3IY+cabl3UwTgU4EU4UEJbdq/raN0HDxGLfoZSYTLKUvx+oL2GihTECN5OaTnHfLv00CbwTAiGC9H2LbW/O+4nLsrQl9geMjSajnevwb8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877052; c=relaxed/simple;
	bh=ibMpyEKP3nTRyXuqggUlhnbhzA2dlKf9uRPaLEGwkZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XhvDOb5W0xG59bwL7faJ6ik+Y8Q9/0p5htphfY+3nybW3cTRAq9GmDGFGttx4N0IOhQ5nysH40F0/37gwEZ6K2W1OPXm1Oht2WKYDSdJCk38kbNdZlTj0JbVbuq/9zP5xKaTVJDl/kO7VaulQtnOwJtm/fmLPB+bBGUgiwYSRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZf7+6eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3218C2BD11;
	Tue, 23 Apr 2024 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877052;
	bh=ibMpyEKP3nTRyXuqggUlhnbhzA2dlKf9uRPaLEGwkZ0=;
	h=Subject:To:Cc:From:Date:From;
	b=NZf7+6eGf/+BPwIlLGBt78RIt3FroRNJqdaUCPf0opUcWnrz/85WN6MSxoJHUlZjI
	 0tvbpti9URUMu23lBqEgC05cj1YO6H0WWhm9qIoKCYXn2qnGvdsMXtQy8lSiPT4ECC
	 xcTWaOTxpalDzZyCGs/gPU5YwOug/5upPNfoKWYc=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD" failed to apply to 5.4-stable tree
To: sandipan.das@amd.com,jmattson@google.com,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:57:22 -0700
Message-ID: <2024042320-deflected-pester-4998@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 49ff3b4aec51e3abfc9369997cc603319b02af9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042320-deflected-pester-4998@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

49ff3b4aec51 ("KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms")
a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49ff3b4aec51e3abfc9369997cc603319b02af9a Mon Sep 17 00:00:00 2001
From: Sandipan Das <sandipan.das@amd.com>
Date: Fri, 5 Apr 2024 16:55:55 -0700
Subject: [PATCH] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD
 platforms

On AMD and Hygon platforms, the local APIC does not automatically set
the mask bit of the LVTPC register when handling a PMI and there is
no need to clear it in the kernel's PMI handler.

For guests, the mask bit is currently set by kvm_apic_local_deliver()
and unless it is cleared by the guest kernel's PMI handler, PMIs stop
arriving and break use-cases like sampling with perf record.

This does not affect non-PerfMonV2 guests because PMIs are handled in
the guest kernel by x86_pmu_handle_irq() which always clears the LVTPC
mask bit irrespective of the vendor.

Before:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (1 samples) ]

After:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]

Fixes: a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
[sean: use is_intel_compatible instead of !is_amd_or_hygon()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20240405235603.1173076-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cf37586f0466..ebf41023be38 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2776,7 +2776,8 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}


