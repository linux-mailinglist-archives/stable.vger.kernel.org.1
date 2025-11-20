Return-Path: <stable+bounces-195283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 992BFC7549C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15FFA4E98A1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4481DDC28;
	Thu, 20 Nov 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YLh439yj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56B1B4138
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653839; cv=none; b=DDBgCL7XrVcEIUj2mrX/YFV0HZ4HlNJmjjxwUmvQ1OjenJaRfHDNmu3ENjqBNUY5yB58LNw/GPL5Aix5EluoY0QBs+5Hbqy6oOU3jJZkbJ/exCJZtlFjzlo97D3C4FFBz3+azBa626QvD84mB4D/JdncvsiOOwxCkNv1BXHJVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653839; c=relaxed/simple;
	bh=dx0HJxTcRBo44CjvV/U/3VYJ4zTNYpPtNJ2qT74X/hU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M+aHnrS7HHYEjdvb92Grv4nTWfQctqJWF4RFZ4RtoC8xpZRtzywTIgNkm1GDi9HlKFXKLt5DoG/p1E/+jPj1wffC7KKUFL/QspAVHTqBZnv2aPV4gpexQCxoxBKnN8CQjlkRo55w3iI/qoWQzWb+/JL7E0by9eumzkAkOhfeb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLh439yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3D9C4CEF1;
	Thu, 20 Nov 2025 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653838;
	bh=dx0HJxTcRBo44CjvV/U/3VYJ4zTNYpPtNJ2qT74X/hU=;
	h=Subject:To:Cc:From:Date:From;
	b=YLh439yjg8ePleom1614asAGDqKKsMM7EwGQFKJfOKrBjlsc4+6+HeXkL8VJY4ppy
	 dcn6olOCpCI+qp6qsS+P9n/q1L8cHAZXdWvuS82ExzMfsSTCWafdTBlJPY98k2meud
	 h9MH9h7FcbfLvmZlVgmM156+5Jn2dLWll25D9p0I=
Subject: FAILED: patch "[PATCH] KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is" failed to apply to 6.1-stable tree
To: yosry.ahmed@linux.dev,jmattson@google.com,matteorizzo@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:50:36 +0100
Message-ID: <2025112036-abdominal-envelope-7ca0@gregkh>
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
git cherry-pick -x dc55b3c3f61246e483e50c85d8d5366f9567e188
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112036-abdominal-envelope-7ca0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc55b3c3f61246e483e50c85d8d5366f9567e188 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry.ahmed@linux.dev>
Date: Sat, 8 Nov 2025 00:45:19 +0000
Subject: [PATCH] KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is
 updated

The APM lists the DbgCtlMsr field as being tracked by the VMCB_LBR clean
bit.  Always clear the bit when MSR_IA32_DEBUGCTLMSR is updated.

The history is complicated, it was correctly cleared for L1 before
commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
L2 is running").  At that point svm_set_msr() started to rely on
svm_update_lbrv() to clear the bit, but when nested virtualization
is enabled the latter does not always clear it even if MSR_IA32_DEBUGCTLMSR
changed. Go back to clearing it directly in svm_set_msr().

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Reported-by: evn@google.com
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251108004524.1600006-2-yosry.ahmed@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 76055c0ba177..39538098002b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3004,7 +3004,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
+		if (svm_get_lbr_vmcb(svm)->save.dbgctl == data)
+			break;
+
 		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 		break;
 	case MSR_VM_HSAVE_PA:


