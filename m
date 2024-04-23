Return-Path: <stable+bounces-40676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487808AE71E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0AF1F26222
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244012C474;
	Tue, 23 Apr 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G4FhDCx1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F468528B
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877039; cv=none; b=D6mVYHxql2c+mu+WP8/UFOng+uRsGuXU3jvVV3CPIDBlyy9P2PkqBsFdPUgU+ShtCOREHEGK4w4yQnJgbORAslyMcW+K2KIE9OtX4pzqMmGv5Jxu/fbSbZjNV5QQ+AaSEJesXblSkEVGkt9zpWJi1MK2WCRYBjLIgk6bn5xFEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877039; c=relaxed/simple;
	bh=Lw8VsIS++uyXUS+vR01Q8suzxQTEMfevQAh0lO8lTms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=itKowd6ZTOZ/y++WIFDhYqRiC9129ukTekKcp9MA6d/kkc8T4EWuV2R5z3R+XZaP7oicpBT7AqSA5URlAIP2BNjJgheCwd0iefwcZhd7i2GCoIr7HEbxiENNKDQeIiOay8nvqc755sB922eu0sQLL8yU6/qr87ZJBdk8VNnJ6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G4FhDCx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6DC116B1;
	Tue, 23 Apr 2024 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877039;
	bh=Lw8VsIS++uyXUS+vR01Q8suzxQTEMfevQAh0lO8lTms=;
	h=Subject:To:Cc:From:Date:From;
	b=G4FhDCx1rc8MBbBfLtOebDjdJyqwuBVIVCcVSocvgvHjMfQnQVjqyMuGGjKnmpO8J
	 aOUURc1cJOSazAOIq61dko74WlSGyMrhXQIjo20npeIFhk3nZNeOWnWa6ApObU/RzH
	 kgOy0ObzbZs1a2iIBs834bCPCMqsIw8IIW9RNMFI=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD" failed to apply to 5.10-stable tree
To: sandipan.das@amd.com,jmattson@google.com,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:57:09 -0700
Message-ID: <2024042306-overfeed-simmering-3d3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 49ff3b4aec51e3abfc9369997cc603319b02af9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042306-overfeed-simmering-3d3c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


