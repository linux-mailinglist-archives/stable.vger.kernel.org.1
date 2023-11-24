Return-Path: <stable+bounces-2234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F026B7F8352
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B42B1C254A9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD51381CC;
	Fri, 24 Nov 2023 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuWSyUwg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B526364B7;
	Fri, 24 Nov 2023 19:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C640C433C9;
	Fri, 24 Nov 2023 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853384;
	bh=6eIW8PXkkxlvtYZ4HnjRiJ64eLzk869tRx8/vcDxWDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuWSyUwgI3zqDkS2QCYxsyp3fWUTaAJPHeA6hpM95uUdTNcMDKWHSUhnHQODd4Wuj
	 7O0fXkSMg2jtgdjDcDe9abxpz7dXe1UccNBwnddtK8OYQrhDjezJGfF+uipdg6+p1H
	 POO0XLWSL3/oZHEc1N73lrlaB8WuuF8q4z2weuiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15 167/297] KVM: x86: Ignore MSR_AMD64_TW_CFG access
Date: Fri, 24 Nov 2023 17:53:29 +0000
Message-ID: <20231124172006.099540791@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

commit 2770d4722036d6bd24bcb78e9cd7f6e572077d03 upstream.

Hyper-V enabled Windows Server 2022 KVM VM cannot be started on Zen1 Ryzen
since it crashes at boot with SYSTEM_THREAD_EXCEPTION_NOT_HANDLED +
STATUS_PRIVILEGED_INSTRUCTION (in other words, because of an unexpected #GP
in the guest kernel).

This is because Windows tries to set bit 8 in MSR_AMD64_TW_CFG and can't
handle receiving a #GP when doing so.

Give this MSR the same treatment that commit 2e32b7190641
("x86, kvm: Add MSR_AMD64_BU_CFG2 to the list of ignored MSRs") gave
MSR_AMD64_BU_CFG2 under justification that this MSR is baremetal-relevant
only.
Although apparently it was then needed for Linux guests, not Windows as in
this case.

With this change, the aforementioned guest setup is able to finish booting
successfully.

This issue can be reproduced either on a Summit Ridge Ryzen (with
just "-cpu host") or on a Naples EPYC (with "-cpu host,stepping=1" since
EPYC is ordinarily stepping 2).

Alternatively, userspace could solve the problem by using MSR filters, but
forcing every userspace to define a filter isn't very friendly and doesn't
add much, if any, value.  The only potential hiccup is if one of these
"baremetal-only" MSRs ever requires actual emulation and/or has F/M/S
specific behavior.  But if that happens, then KVM can still punt *that*
handling to userspace since userspace MSR filters "win" over KVM's default
handling.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1ce85d9c7c9e9632393816cf19c902e0a3f411f1.1697731406.git.maciej.szmigiero@oracle.com
[sean: call out MSR filtering alternative]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/kvm/x86.c               |    2 ++
 2 files changed, 3 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -511,6 +511,7 @@
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
+#define MSR_AMD64_TW_CFG		0xc0011023
 
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3393,6 +3393,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -3733,6 +3734,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 	/*
 	 * Intel Sandy Bridge CPUs must support the RAPL (running average power



