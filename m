Return-Path: <stable+bounces-270786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pqmKFLOgRmoRagsAu9opvQ
	(envelope-from <stable+bounces-270786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:32:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E76FB6D2
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=X8Ll9aeU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270786-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270786-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 047003122DD3
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D835CB76;
	Thu,  2 Jul 2026 16:30:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C135A925;
	Thu,  2 Jul 2026 16:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009847; cv=none; b=cnaeBK8HAulwd3Vcp3Ke6HF2RRc/ECHCVaAyTOQ/CJQmwluH+z/Hpgndveqxh0/pLERfuB+L7z6yHdR5tkAMueQhpgZIHIN1uI23SOq2Y1W3HRSVQsdsgGmy0Fhs4o8/uLigNSn1SnptZldHHJktLmLqhzCfXd3eQjj9yWIIP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009847; c=relaxed/simple;
	bh=7hFIWCON977PkHTLbyVDacWEjcqIdCRUm8KnRRz9+Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1r66RW6whgfPdKqW3HbtpP1lLvBE8lzKov09Fe2u5H3h65HbBXt/h1pNF/PK25wURZ/uglDvfK2KYqlnSrQyDJBTvSqQiJ5FtQL7KANa8eiMF8aK8Cv3d0kukX0ZTbA62ZZRdEiqSADQU5Uv/z9q5O+6k4UX3LOjl8J+VSOqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8Ll9aeU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489BB1F00A3A;
	Thu,  2 Jul 2026 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009846;
	bh=RZfoTYmweGuMzi3mZIK3MIYuhRGu72bBxB2Fr0NRRf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X8Ll9aeUbm5pTK8aj/V4FQFobE8eeGwDW1Puujqp6azBcA4ITRkd5q5rfV63SKMNL
	 FdJ+6OSeJ0CpeEbaRWHdwG8NTgqFA0/3EYTjhgAjTQW9wrYpCh6htYlY1fI5+2o7LC
	 EfFHm+BOdEKe+nDDP95a73ztH6C51g7q/7hq1gfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uros Bizjak <ubizjak@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/129] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
Date: Thu,  2 Jul 2026 18:18:46 +0200
Message-ID: <20260702155112.315509671@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-270786-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ubizjak@gmail.com,m:seanjc@google.com,m:hannelotta@gmail.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A8E76FB6D2

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]

Declare vmread_error_trampoline() as an opaque symbol so that it cannot
be called from C code, at least not without some serious fudging.  The
trampoline always passes parameters on the stack so that the inline
VMREAD sequence doesn't need to clobber registers.  regparm(0) was
originally added to document the stack behavior, but it ended up being
confusing because regparm(0) is a nop for 64-bit targets.

Opportunustically wrap the trampoline and its declaration in #ifdeffery
to make it even harder to invoke incorrectly, to document why it exists,
and so that it's not left behind if/when CONFIG_CC_HAS_ASM_GOTO_OUTPUT
is true for all supported toolchains.

No functional change intended.

Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20220928232015.745948-1-seanjc@google.com
(cherry picked from commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmenter.S |  2 ++
 arch/x86/kvm/vmx/vmx_ops.h | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index b4f8937226c211..ea7be3a74b6d02 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -274,6 +274,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
 
 .section .text, "ax"
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
  * @field:	VMCS field encoding that failed
@@ -322,6 +323,7 @@ SYM_FUNC_START(vmread_error_trampoline)
 
 	RET
 SYM_FUNC_END(vmread_error_trampoline)
+#endif
 
 SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	/*
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2efe..d23705df6a5250 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,14 +11,28 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
 void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+/*
+ * The VMREAD error trampoline _always_ uses the stack to pass parameters, even
+ * for 64-bit targets.  Preserving all registers allows the VMREAD inline asm
+ * blob to avoid clobbering GPRs, which in turn allows the compiler to better
+ * optimize sequences of VMREADs.
+ *
+ * Declare the trampoline as an opaque label as it's not safe to call from C
+ * code; there is no way to tell the compiler to pass params on the stack for
+ * 64-bit targets.
+ *
+ * void vmread_error_trampoline(unsigned long field, bool fault);
+ */
+extern unsigned long vmread_error_trampoline;
+#endif
+
 static __always_inline void vmcs_check16(unsigned long field)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,
-- 
2.53.0




