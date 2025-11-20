Return-Path: <stable+bounces-195294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71BC7537E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E733E3554F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BB3321C0;
	Thu, 20 Nov 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QD62/jYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3DD2F9C37
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653899; cv=none; b=c36T7YM0sn32E0AaPMIGzkcHYPdCFmhjGtFvwdEd7Fzu1o6RmmB69ZtUAwt6GQjDTW2qkRdX4Y58Z7Ky94C0eqTQj2ErjSJEXMPZym+Jdapb4M9EuoqRUoxjKCTvp8oV6+GBoxfu4KoqGh34F2S75Cjr/Oi5kSO0jNDCyWmBDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653899; c=relaxed/simple;
	bh=+8lD6fBPYp0Pnz/jkDGiEBMw4egtSAOenWEajA3uWsQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UwiUKjZ3hIKxWzh3DJeojZQm6PIB+gnqoofdsM+OPsqBT/anSKCMW7RiU9pCs1Hj83hFq+s3NXwzvi7XkWOlAI2ttJLzM01skxXBGo5GUDTz0yrBc/A2eV0xTOZ36jV7JO8VRnuzzA+uVynTkyUpoCT8kK5FYRMpUWGmZ+p6bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QD62/jYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4052C4CEF1;
	Thu, 20 Nov 2025 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653899;
	bh=+8lD6fBPYp0Pnz/jkDGiEBMw4egtSAOenWEajA3uWsQ=;
	h=Subject:To:Cc:From:Date:From;
	b=QD62/jYhD9knvOV8ZbBKfsEpHiIFofMbHSTpgMuZc1OmIywvNJlOSx4xnTQRmJLRT
	 FzbHK8EoP+lHZRTLPZxfcuOy5+DJTlAKMENnQZYLYcUn8bPt0pM911VTqGPnTYDO1P
	 6+KkAoMZ3QLgvA/uI11+dkD8A6txO7kjp43iq6pY=
Subject: FAILED: patch "[PATCH] KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or" failed to apply to 6.1-stable tree
To: seanjc@google.com,binbin.wu@linux.intel.com,dan.j.williams@intel.com,kai.huang@intel.com,rick.p.edgecombe@intel.com,xiaoyao.li@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:51:30 +0100
Message-ID: <2025112030-dastardly-prowling-1021@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9d7dfb95da2cb5c1287df2f3468bcb70d8b31087
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112030-dastardly-prowling-1021@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d7dfb95da2cb5c1287df2f3468bcb70d8b31087 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 11:21:47 -0700
Subject: [PATCH] KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or
 TDCALL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add VMX exit handlers for SEAMCALL and TDCALL to inject a #UD if a non-TD
guest attempts to execute SEAMCALL or TDCALL.  Neither SEAMCALL nor TDCALL
is gated by any software enablement other than VMXON, and so will generate
a VM-Exit instead of e.g. a native #UD when executed from the guest kernel.

Note!  No unprivileged DoS of the L1 kernel is possible as TDCALL and
SEAMCALL #GP at CPL > 0, and the CPL check is performed prior to the VMX
non-root (VM-Exit) check, i.e. userspace can't crash the VM. And for a
nested guest, KVM forwards unknown exits to L1, i.e. an L2 kernel can
crash itself, but not L1.

Note #2!  The Intel® Trust Domain CPU Architectural Extensions spec's
pseudocode shows the CPL > 0 check for SEAMCALL coming _after_ the VM-Exit,
but that appears to be a documentation bug (likely because the CPL > 0
check was incorrectly bundled with other lower-priority #GP checks).
Testing on SPR and EMR shows that the CPL > 0 check is performed before
the VMX non-root check, i.e. SEAMCALL #GPs when executed in usermode.

Note #3!  The aforementioned Trust Domain spec uses confusing pseudocode
that says that SEAMCALL will #UD if executed "inSEAM", but "inSEAM"
specifically means in SEAM Root Mode, i.e. in the TDX-Module.  The long-
form description explicitly states that SEAMCALL generates an exit when
executed in "SEAM VMX non-root operation".  But that's a moot point as the
TDX-Module injects #UD if the guest attempts to execute SEAMCALL, as
documented in the "Unconditionally Blocked Instructions" section of the
TDX-Module base specification.

Cc: stable@vger.kernel.org
Cc: Kai Huang <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20251016182148.69085-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index 9792e329343e..1baa86dfe029 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -93,6 +93,7 @@
 #define EXIT_REASON_TPAUSE              68
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
+#define EXIT_REASON_SEAMCALL            76
 #define EXIT_REASON_TDCALL              77
 #define EXIT_REASON_MSR_READ_IMM        84
 #define EXIT_REASON_MSR_WRITE_IMM       85
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 76271962cb70..bcea087b642f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6728,6 +6728,14 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 	case EXIT_REASON_NOTIFY:
 		/* Notify VM exit is not exposed to L1 */
 		return false;
+	case EXIT_REASON_SEAMCALL:
+	case EXIT_REASON_TDCALL:
+		/*
+		 * SEAMCALL and TDCALL unconditionally VM-Exit, but aren't
+		 * virtualized by KVM for L1 hypervisors, i.e. L1 should
+		 * never want or expect such an exit.
+		 */
+		return false;
 	default:
 		return true;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f87c216d976d..91b6f2f3edc2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6032,6 +6032,12 @@ static int handle_vmx_instruction(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int handle_tdx_instruction(struct kvm_vcpu *vcpu)
+{
+	kvm_queue_exception(vcpu, UD_VECTOR);
+	return 1;
+}
+
 #ifndef CONFIG_X86_SGX_KVM
 static int handle_encls(struct kvm_vcpu *vcpu)
 {
@@ -6157,6 +6163,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_ENCLS]		      = handle_encls,
 	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
+	[EXIT_REASON_SEAMCALL]		      = handle_tdx_instruction,
+	[EXIT_REASON_TDCALL]		      = handle_tdx_instruction,
 	[EXIT_REASON_MSR_READ_IMM]            = handle_rdmsr_imm,
 	[EXIT_REASON_MSR_WRITE_IMM]           = handle_wrmsr_imm,
 };


