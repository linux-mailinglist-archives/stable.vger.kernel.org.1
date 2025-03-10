Return-Path: <stable+bounces-121691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E939A5912E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D951889421
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D422652D;
	Mon, 10 Mar 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M0iUGEvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878751E32DA
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602554; cv=none; b=R+zjuD083G2BbxlE4Gyson4/oOhppA7EWWqRUwnYdqjZowoYFPqdA55amKqWjK7c6/niEhHhpZ+6+VRGppYaNJ5GqFBCsxBpahCeORdQip6DPG8Js4vf9TPftncmIl5JdrWoFXJSAd7cS1kXGTiNhV7ziVvPR/RIHqKF/JfSAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602554; c=relaxed/simple;
	bh=7ls8JJHdSTevbQb0Z2BHtxEmMB51DsWpSqeP6xjn7Lw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lxTuXw54E/ybko/K3C4825VESnQC9SuKNpUmuW/6iEmheeg4jQ1E42G9M82UXZz2p1dbki+9i06Bj6S2yMrTgZbo7COJacujtibIOZPBO4nlIk5AGs6Ux9wVScRh3zyniO/ZpCjB2ClFXvaftNKcXqO+fxob1+fGVdb1OVOuAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M0iUGEvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A943C4CEE5;
	Mon, 10 Mar 2025 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602554;
	bh=7ls8JJHdSTevbQb0Z2BHtxEmMB51DsWpSqeP6xjn7Lw=;
	h=Subject:To:Cc:From:Date:From;
	b=M0iUGEvu9XrVhgv+mNpgDvXL5/a6vMsCrmXPOR6XQXQPdt6GHVV6uxE5dUsMGtDuu
	 OmAEBR+qRxNU3PO6D0Nk0ejAQ9xTStM7JISLeMjsuaUhaA7pLDqc6Qb15kUEJnMuIV
	 x515U0L+7qEnHWag0+CQtB373pYPj9CuvqR/ltyo=
Subject: FAILED: patch "[PATCH] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs" failed to apply to 6.1-stable tree
To: seanjc@google.com,ravi.bangoria@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:29:03 +0100
Message-ID: <2025031003-unstitch-arbitrate-baa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 189ecdb3e112da703ac0699f4ec76aa78122f911
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031003-unstitch-arbitrate-baa1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


