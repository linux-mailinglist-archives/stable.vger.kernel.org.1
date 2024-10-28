Return-Path: <stable+bounces-88246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D746B9B218F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14ADD1C208C3
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78F6FD3;
	Mon, 28 Oct 2024 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEk0M3hW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8684C6C
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075282; cv=none; b=BSaX5KvnbWdAKYjoyH8ZB41y8F2GzG8r/gB7CkgJqqncSSHmBDE6jocDuQD0TRxIPC8/7WXEphIAuJMX563HXdxpRyYUFhugb6yQxTtt5GqYmZN3p/DzVN2sULqlegNXyCvRXhoJYhMyZzYWq78FrZ9Nn62Zx1rMzfTqGbfWF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075282; c=relaxed/simple;
	bh=srrhrb9O0fCdJxNslGcGj1E1pcxzh/X8g/b6I3Nd1qU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nuNYqI9J6/IOPsA3H7OrKMOxjMU/mpavMfvDfJigcVQiDtI8RkQFdSqWQ62WYWqYmuH3omIrkOpkzl8CjKfFF879ueW+zd7R3Ed5HZKMqTZHpO1/hHniUHQKLPU5aX5FeQEEelX31s0af0qbB8c1xuYbHq2xxe3ENYzQYYc+A0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEk0M3hW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC3C4CEC3;
	Mon, 28 Oct 2024 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075282;
	bh=srrhrb9O0fCdJxNslGcGj1E1pcxzh/X8g/b6I3Nd1qU=;
	h=Subject:To:Cc:From:Date:From;
	b=nEk0M3hWyClh83ifdYBEtxQLdFYWkq6Toaghc8S9BG83Iz2ScBtXdhFcmCCvZWrIA
	 oTYizAYusoCwVasVDmlxVWxuO1fX+gbNA8nYPhBAyhCXxCGC6A+RtZi42T4aszTvPz
	 qUMPS4J6HgYpBZbdYRB/bCU0ebl0KnFYvonkqZRY=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory" failed to apply to 4.19-stable tree
To: seanjc@google.com,3pvd@google.com,pbonzini@redhat.com,swidowski@google.com,theflow@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:27:49 +0100
Message-ID: <2024102849-giggle-five-0241@gregkh>
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
git cherry-pick -x f559b2e9c5c5308850544ab59396b7d53cfc67bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102849-giggle-five-0241@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

f559b2e9c5c5 ("KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory")
2732be902353 ("KVM: nSVM: Don't strip host's C-bit from guest's CR3 when reading PDPTRs")
883b0a91f41a ("KVM: SVM: Move Nested SVM Implementation to nested.c")
46a010dd6896 ("kVM SVM: Move SVM related files to own sub-directory")
d55c9d4009c7 ("KVM: nSVM: check for EFER.SVME=1 before entering guest")
0b66465344a7 ("KVM: nSVM: Remove an obsolete comment.")
78f2145c4d93 ("KVM: nSVM: avoid loss of pending IRQ/NMI before entering L2")
b518ba9fa691 ("KVM: nSVM: implement check_nested_events for interrupts")
64b5bd270426 ("KVM: nSVM: ignore L1 interrupt window while running L2 with V_INTR_MASKING=1")
b5ec2e020b70 ("KVM: nSVM: do not change host intercepts while nested VM is running")
689f3bf21628 ("KVM: x86: unify callbacks to load paging root")
257038745cae ("KVM: x86: Move nSVM CPUID 0x8000000A handling into common x86 code")
a50718cc3f43 ("KVM: nSVM: Expose SVM features to L1 iff nested is enabled")
703c335d0693 ("KVM: x86/mmu: Configure max page level during hardware setup")
bde772355958 ("KVM: x86/mmu: Merge kvm_{enable,disable}_tdp() into a common function")
213e0e1f500b ("KVM: SVM: Refactor logging of NPT enabled/disabled")
a1bead2abaa1 ("KVM: VMX: Directly query Intel PT mode when refreshing PMUs")
139085101f85 ("KVM: x86: Use KVM cpu caps to detect MSR_TSC_AUX virt support")
93c380e7b528 ("KVM: x86: Set emulated/transmuted feature bits via kvm_cpu_caps")
bd7919999047 ("KVM: x86: Override host CPUID results with kvm_cpu_caps")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f559b2e9c5c5308850544ab59396b7d53cfc67bd Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 9 Oct 2024 07:08:38 -0700
Subject: [PATCH] KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory

Ignore nCR3[4:0] when loading PDPTEs from memory for nested SVM, as bits
4:0 of CR3 are ignored when PAE paging is used, and thus VMRUN doesn't
enforce 32-byte alignment of nCR3.

In the absolute worst case scenario, failure to ignore bits 4:0 can result
in an out-of-bounds read, e.g. if the target page is at the end of a
memslot, and the VMM isn't using guard pages.

Per the APM:

  The CR3 register points to the base address of the page-directory-pointer
  table. The page-directory-pointer table is aligned on a 32-byte boundary,
  with the low 5 address bits 4:0 assumed to be 0.

And the SDM's much more explicit:

  4:0    Ignored

Note, KVM gets this right when loading PDPTRs, it's only the nSVM flow
that is broken.

Fixes: e4e517b4be01 ("KVM: MMU: Do not unconditionally read PDPTE from guest memory")
Reported-by: Kirk Swidowski <swidowski@google.com>
Cc: Andy Nguyen <theflow@google.com>
Cc: 3pvd <3pvd@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20241009140838.1036226-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d5314cb7dff4..cf84103ce38b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -63,8 +63,12 @@ static u64 nested_svm_get_tdp_pdptr(struct kvm_vcpu *vcpu, int index)
 	u64 pdpte;
 	int ret;
 
+	/*
+	 * Note, nCR3 is "assumed" to be 32-byte aligned, i.e. the CPU ignores
+	 * nCR3[4:0] when loading PDPTEs from memory.
+	 */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(cr3), &pdpte,
-				       offset_in_page(cr3) + index * 8, 8);
+				       (cr3 & GENMASK(11, 5)) + index * 8, 8);
 	if (ret)
 		return 0;
 	return pdpte;


