Return-Path: <stable+bounces-104605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191339F5212
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8097E16D23E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D21F76AE;
	Tue, 17 Dec 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkVpxqHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A51F867A;
	Tue, 17 Dec 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455558; cv=none; b=j8DkcEKYXsEQEJSx6HeTkoqC3JGJPHQs8S+RBMrXUD3BFQNLWV+93aBj745BRna2zcC+DbVtm8UEXXpMzXDeUKwLZ3SkPfahbFHaook8ugzM0x/Y/PL0/h8P7Tkj9gAGhOWD3MA5IE3jgVpmL+muzgHvvuNtXfZZd1wUSQchSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455558; c=relaxed/simple;
	bh=1wIRhgv/v4j2qVUCUHe/5lnk1sfEqeMJJCRUAyON0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZXAMq8xVm/lvpJNy9gWwtulyc9ckSX0n2rQntIPgry8OGwaVAAzabrR4J75z0K9HJWi8Kcfof7lEPJ4daqmJNwgjClpXXx5K6pLocLdrtR9P3K/lZ+XmGjIfUv78u3U3hl07N4LnKTCVzNTBn+woCltstB4DuyrFEA6EsqS7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkVpxqHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7374C4CED3;
	Tue, 17 Dec 2024 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455558;
	bh=1wIRhgv/v4j2qVUCUHe/5lnk1sfEqeMJJCRUAyON0Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkVpxqHQx5xUMXuHFceBiX9fU6qkEYcwOlQlnZBlxWyclDLls2zpuGQn+4pXV7Q/p
	 0ehmKbqicJw1tlcUF6+b9/RlqzKcagvq9+JE9LMoF/IY79gm4HJTe3hAXjfoeGkog2
	 TpMvWsr6gAKc3HZvtqfbNPyqV98Yh4eFV73+Gp9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 5.10 39/43] x86/xen: dont do PV iret hypercall through hypercall page
Date: Tue, 17 Dec 2024 18:07:30 +0100
Message-ID: <20241217170522.282595470@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
References: <20241217170520.459491270@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit a2796dff62d6c6bfc5fbebdf2bee0d5ac0438906 upstream.

Instead of jumping to the Xen hypercall page for doing the iret
hypercall, directly code the required sequence in xen-asm.S.

This is done in preparation of no longer using hypercall page at all,
as it has shown to cause problems with speculation mitigations.

This is part of XSA-466 / CVE-2024-53241.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/xen-asm.S |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -198,7 +198,6 @@ SYM_CODE_START(xen_early_idt_handler_arr
 SYM_CODE_END(xen_early_idt_handler_array)
 	__FINIT
 
-hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
 /*
  * Xen64 iret frame:
  *
@@ -208,16 +207,27 @@ hypercall_iret = hypercall_page + __HYPE
  *	cs
  *	rip		<-- standard iret frame
  *
- *	flags
+ *	flags		<-- xen_iret must push from here on
  *
- *	rcx		}
- *	r11		}<-- pushed by hypercall page
- * rsp->rax		}
+ *	rcx
+ *	r11
+ * rsp->rax
  */
+.macro xen_hypercall_iret
+	pushq $0	/* Flags */
+	push %rcx
+	push %r11
+	push %rax
+	mov  $__HYPERVISOR_iret, %eax
+	syscall		/* Do the IRET. */
+#ifdef CONFIG_MITIGATION_SLS
+	int3
+#endif
+.endm
+
 SYM_CODE_START(xen_iret)
 	UNWIND_HINT_EMPTY
-	pushq $0
-	jmp hypercall_iret
+	xen_hypercall_iret
 SYM_CODE_END(xen_iret)
 
 /*
@@ -318,8 +328,7 @@ SYM_CODE_START(xen_entry_SYSENTER_compat
 	UNWIND_HINT_ENTRY
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
-	pushq $0
-	jmp hypercall_iret
+	xen_hypercall_iret
 SYM_CODE_END(xen_entry_SYSENTER_compat)
 SYM_CODE_END(xen_entry_SYSCALL_compat)
 



