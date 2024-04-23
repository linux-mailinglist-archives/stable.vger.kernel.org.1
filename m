Return-Path: <stable+bounces-40678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08B8AE722
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3620228745E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9712DDBE;
	Tue, 23 Apr 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9h1lqNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCA127E1B
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877055; cv=none; b=eW6DWnHHB/jBmnLzP4MVK10GokEfK3X841H33/C+cqdDEc9DN7z/d5d+AQCeZrADF6ilQ6FPmkJo0V6GWKJSYXUOyuOKzT3jhXQkAZHLRsVGLw+B2H1TP+/k6YrKaudH4VMFs6UcVRA+xwLxtW6cTonvkE5TFFl9POeW2su8SPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877055; c=relaxed/simple;
	bh=wMli2bCg34s43+JZSNkQlZmedggBNUCYNl5DhE4GBQk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BUNeCPjgxdWSpf2RRXVfXLHy/n3JUN49O5x4Ioty7uw2h4dm7Fvez/DYTNKVddsMNfJ7tuUG6A+OJuPuGW0AK1nV6qYB4Exu74TbUfzawB6ckPPblrrTSTlrwOG16q2jS6xWxeDntu4t4QRiiWm7DsXgdXagRZQO3LIsVOGeky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9h1lqNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDBCC116B1;
	Tue, 23 Apr 2024 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877055;
	bh=wMli2bCg34s43+JZSNkQlZmedggBNUCYNl5DhE4GBQk=;
	h=Subject:To:Cc:From:Date:From;
	b=i9h1lqNLuEglkBU+VSwKdBhWllAkfkTu7r8Zh/tWj+m390VQzUIQ/XaP3kkCy+lX4
	 ay89mk/VQpih3lQAbg6v2+UvNPf5TMxeO28aGGQ7qp3i4I6t10jjWzb605NMU2dUz3
	 tKFH6bGaKrPJNQaeBBrG8a0h3gRTjGUxO+mgUtoc=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD" failed to apply to 4.19-stable tree
To: sandipan.das@amd.com,jmattson@google.com,pbonzini@redhat.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:57:25 -0700
Message-ID: <2024042325-rockstar-civic-9c1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 49ff3b4aec51e3abfc9369997cc603319b02af9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042325-rockstar-civic-9c1a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


