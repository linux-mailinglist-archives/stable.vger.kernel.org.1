Return-Path: <stable+bounces-195297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1FC75241
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5DD152B1D6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859382D7817;
	Thu, 20 Nov 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZ72txtT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84E376BC5
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653908; cv=none; b=iUEY8nDT8tDKrDH4x5hY2QJxw9hjLeE+ZrCIIOgv9oYhiMARea7TSAfb5U9c31Hvs5hRkJLtmKBx0aYTC7o7WGDP++Nx6MzekvCwHmkVKKGlcEkSV8li1+txo1y3s032VALofEH3ktIfx2jLgZeL1m0W4TmNb8TLUy1TGsF3HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653908; c=relaxed/simple;
	bh=K4A//xtfg64rZhOfNKoF/qjHFSxrDxDzY6lbcY766aQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oMXw87fuGjeFInx4OfldPg93EDy5ls0nBBOTZgC7Rxoka7QXF0/t6ATSZh8jgGBerj6+TYDYBM9sN9hxQx2oj5CMwxONLeT6AKNSsTAE68s2vk1L63Nj5508jMlmZ3fHYd0yWJp88XWXSrcB96wysI6WaBp1n6bRtliRu4klQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZ72txtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44607C116C6;
	Thu, 20 Nov 2025 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653907;
	bh=K4A//xtfg64rZhOfNKoF/qjHFSxrDxDzY6lbcY766aQ=;
	h=Subject:To:Cc:From:Date:From;
	b=lZ72txtTmU4CaZFhA3QrUuPA8QVIEp7gk/wAI48KuhRkQ1Z6zl74GtAuFsLinEiCL
	 ++1fddmYvw0uZhW8N/mkyt+P9TjB50HRPZGWXYQMlSntGkL2z1VnbFLI8RFR8DtoIZ
	 0NC4Awh96A9ZDjS12EUxe3zFHFuVvbxAo5Scd1fw=
Subject: FAILED: patch "[PATCH] KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or" failed to apply to 5.4-stable tree
To: seanjc@google.com,binbin.wu@linux.intel.com,dan.j.williams@intel.com,kai.huang@intel.com,rick.p.edgecombe@intel.com,xiaoyao.li@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:51:33 +0100
Message-ID: <2025112033-jovial-sadden-2c80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9d7dfb95da2cb5c1287df2f3468bcb70d8b31087
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112033-jovial-sadden-2c80@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


