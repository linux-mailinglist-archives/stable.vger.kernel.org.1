Return-Path: <stable+bounces-121690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3DFA5912D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EF23AD439
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DF1A7046;
	Mon, 10 Mar 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PEDp5vea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE970226543
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602546; cv=none; b=P0PumIgI/oMbbQEfw5wrrFWEn6Q6Dlz+F0Bv2B52gNMg46UDYbdxHdr5fCKbwg0FEhkp+zcVKbB2uFoqe8bvqZf9wu/68/ctIdKWCTBODdCLk/IyaxdFpvSvajjVbAUYLnFB0Mby9aybLym6KA+GEpMJTBbSxsTyPk4GbDx1n8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602546; c=relaxed/simple;
	bh=kRMYwjuhuU1ri2rS/Hy2q59JzIIKonUSJsWUu1LKWZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nX8nfRavVK7kgq9QG8h+kyqp82uI6KCI47z9LRwVKonshDB4Z/6o96nATKaj0MwEFG6hbUXRygVYNKj4lu438+9AztSZxscyhQENNePbHDehwV3aiQcub6iuOrOwT/XgJ4YruIk93pXAkIQI0nL0e0iJnCj8XEQMRefm4OJNwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PEDp5vea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03563C4CEE5;
	Mon, 10 Mar 2025 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602545;
	bh=kRMYwjuhuU1ri2rS/Hy2q59JzIIKonUSJsWUu1LKWZM=;
	h=Subject:To:Cc:From:Date:From;
	b=PEDp5vea7xMvbG0/LHF9iWyb5I0DEX/kchUu+ZgLxmhXVHAIwI7WxAL2AHpVs7q4A
	 3CVtUvIoSi6uGCETk4PnhIMyuwtYQfEKTvj5J7ExtEcu77fUsCjLoCJkOfR/VnmCwp
	 EZS3jX3R7sZMAxCvMp/K81GofB52RBkx+2ahyV9I=
Subject: FAILED: patch "[PATCH] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs" failed to apply to 6.6-stable tree
To: seanjc@google.com,ravi.bangoria@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:29:02 +0100
Message-ID: <2025031002-campsite-railroad-4d13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 189ecdb3e112da703ac0699f4ec76aa78122f911
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031002-campsite-railroad-4d13@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 189ecdb3e112da703ac0699f4ec76aa78122f911 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:10 -0800
Subject: [PATCH] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5c6fd0edc41f..12d5f47c1bbe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4968,7 +4968,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10969,6 +10968,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {


