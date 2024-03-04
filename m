Return-Path: <stable+bounces-26357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAF870E34
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2081C22687
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88D1EB5A;
	Mon,  4 Mar 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qlwhhrpp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EA10A35;
	Mon,  4 Mar 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588513; cv=none; b=acfgBPZfcCvzJV+eX4PCbQz5q87MiBFoeYqGSej0u2N3UCCl3xKUFAs8HYCLxVm5KEssIK4eNPKc0pLLfgCD+aE/Mnjxj9QlOCeC3HngAQS3uOb5VGT8vWILFVwK7IO/sURObTYIvnbH6DW/PY9o8ooEY6HpF4RT2HNR3oHFpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588513; c=relaxed/simple;
	bh=1/0sAuvOuV8DYmZy9s7I3dHINTbSKq7LnaxCfuoYa18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjfgDR31J3nChzblg0463bgjLuG2Qa3+2kJU1yjTahTh6h81shVjNUCLRAP0H3ybsPaBPUD1WQwsVBYNTIo4APTqqdV7+pB7FQMY4NquR6VtcipMlpr8SYS14E9c0rmIHEPKFq1cDShiZAaeD3V86Rx/fATu25EQXlXyB/KChSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qlwhhrpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF8DC433C7;
	Mon,  4 Mar 2024 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588513;
	bh=1/0sAuvOuV8DYmZy9s7I3dHINTbSKq7LnaxCfuoYa18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlwhhrppezoCRLe1YaXKPm0HUXLXROoZy6zkJh9lWTJigszrEyatWQ0LO2sg0kH6I
	 +NOrVyuKYjfa/Rn69CneBz4WOMBjTkJ1bw5FJJxolkyYUrWhNZ5vsr6i8sGkvwMmnf
	 kSs9oUqtDFIWajg3BKTAqcAkP5+jmLpi6SUET+Nc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.6 136/143] KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
Date: Mon,  4 Mar 2024 21:24:16 +0000
Message-ID: <20240304211554.261354939@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

From: Sean Christopherson <seanjc@google.com>

commit 706a189dcf74d3b3f955e9384785e726ed6c7c80 upstream.

Use EFLAGS.CF instead of EFLAGS.ZF to track whether to use VMRESUME versus
VMLAUNCH.  Freeing up EFLAGS.ZF will allow doing VERW, which clobbers ZF,
for MDS mitigations as late as possible without needing to duplicate VERW
for both paths.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-5-a6216d83edb7%40linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/run_flags.h |    7 +++++--
 arch/x86/kvm/vmx/vmenter.S   |    6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx/run_flags.h
+++ b/arch/x86/kvm/vmx/run_flags.h
@@ -2,7 +2,10 @@
 #ifndef __KVM_X86_VMX_RUN_FLAGS_H
 #define __KVM_X86_VMX_RUN_FLAGS_H
 
-#define VMX_RUN_VMRESUME	(1 << 0)
-#define VMX_RUN_SAVE_SPEC_CTRL	(1 << 1)
+#define VMX_RUN_VMRESUME_SHIFT		0
+#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT	1
+
+#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
+#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
 
 #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -139,7 +139,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	test $VMX_RUN_VMRESUME, %ebx
+	bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -161,8 +161,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'test VMX_RUN_VMRESUME' above */
-	jz .Lvmlaunch
+	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
+	jnc .Lvmlaunch
 
 	/*
 	 * After a successful VMRESUME/VMLAUNCH, control flow "magically"



