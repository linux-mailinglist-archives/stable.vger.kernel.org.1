Return-Path: <stable+bounces-121939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253DCA59D36
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F063A479A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23222D4C3;
	Mon, 10 Mar 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yPFjan7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11A17C225;
	Mon, 10 Mar 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627067; cv=none; b=p6Avia5NxZ5zgs1jK3rZD5N14ybkX7S3qj0VQTIn1wyfcj0jryxCBwB3FDdN9LODKBbnrd/ZZEuW7YxOdwdKS3OvIlDSB66KTj0O82RsHvyA+CugUwmsx5EtwXXODzqrlnXtvLInSxYbJdpZqOPDWjxEzGPnNj3bATP4M1632jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627067; c=relaxed/simple;
	bh=Ol0SghZerOOGthIQsJ79hrKZGXDmtffZzamtGS7+2GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZpNoFh0bnVeOiEMygH6Si+Ayf5c57tFsWclCalnvaeXt+ArMtup5EzuX1LFLCdBxzkvSN3Qb3s0U7+LqTPWwRYnW8wYmgnEOg2WVGA0hHbq7v/CCRLhMJ1tNV5gF0uXkLeZCJjw6VSEm3++0QRLZGYj/63p5IjzXiPm6efMS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yPFjan7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B89C4CEE5;
	Mon, 10 Mar 2025 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627066;
	bh=Ol0SghZerOOGthIQsJ79hrKZGXDmtffZzamtGS7+2GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yPFjan7p7cxAGA3UUdDD9cb8hnTzItZOzJ4NpPQafdqB8dFE9AKJ+Zg7TmZQfI/NN
	 Sd2JJoieCehpdLCBaD9WNmRZusD/bZsjRGMvnpHxwgxRxRrE8bdHsLsiz/iK/A1Ndm
	 cHDCIVTUYhnYE2wzXQRfsPvgmPew7kKxuR6Ufat4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	rangemachine@gmail.com,
	whanos@sergal.fun,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.13 177/207] KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is disabled
Date: Mon, 10 Mar 2025 18:06:10 +0100
Message-ID: <20250310170454.826135580@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 433265870ab3455b418885bff48fa5fd02f7e448 upstream.

Manually load the guest's DEBUGCTL prior to VMRUN (and restore the host's
value on #VMEXIT) if it diverges from the host's value and LBR
virtualization is disabled, as hardware only context switches DEBUGCTL if
LBR virtualization is fully enabled.  Running the guest with the host's
value has likely been mildly problematic for quite some time, e.g. it will
result in undesirable behavior if BTF diverges (with the caveat that KVM
now suppresses guest BTF due to lack of support).

But the bug became fatal with the introduction of Bus Lock Trap ("Detect"
in kernel paralance) support for AMD (commit 408eb7417a92
("x86/bus_lock: Add support for AMD")), as a bus lock in the guest will
trigger an unexpected #DB.

Note, suppressing the bus lock #DB, i.e. simply resuming the guest without
injecting a #DB, is not an option.  It wouldn't address the general issue
with DEBUGCTL, e.g. for things like BTF, and there are other guest-visible
side effects if BusLockTrap is left enabled.

If BusLockTrap is disabled, then DR6.BLD is reserved-to-1; any attempts to
clear it by software are ignored.  But if BusLockTrap is enabled, software
can clear DR6.BLD:

  Software enables bus lock trap by setting DebugCtl MSR[BLCKDB] (bit 2)
  to 1.  When bus lock trap is enabled, ... The processor indicates that
  this #DB was caused by a bus lock by clearing DR6[BLD] (bit 11).  DR6[11]
  previously had been defined to be always 1.

and clearing DR6.BLD is "sticky" in that it's not set (i.e. lowered) by
other #DBs:

  All other #DB exceptions leave DR6[BLD] unmodified

E.g. leaving BusLockTrap enable can confuse a legacy guest that writes '0'
to reset DR6.

Reported-by: rangemachine@gmail.com
Reported-by: whanos@sergal.fun
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219787
Closes: https://lore.kernel.org/all/bug-219787-28872@https.bugzilla.kernel.org%2F
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4277,6 +4277,16 @@ static __no_kcsan fastpath_t svm_vcpu_ru
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
 
+	/*
+	 * Hardware only context switches DEBUGCTL if LBR virtualization is
+	 * enabled.  Manually load DEBUGCTL if necessary (and restore it after
+	 * VM-Exit), as running with the host's DEBUGCTL can negatively affect
+	 * guest state and can even be fatal, e.g. due to Bus Lock Detect.
+	 */
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(svm->vmcb->save.dbgctl);
+
 	kvm_wait_lapic_expire(vcpu);
 
 	/*
@@ -4304,6 +4314,10 @@ static __no_kcsan fastpath_t svm_vcpu_ru
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
+
 	kvm_load_host_xsave_state(vcpu);
 	stgi();
 



