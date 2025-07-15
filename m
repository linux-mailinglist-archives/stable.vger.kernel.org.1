Return-Path: <stable+bounces-161970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5ECB05A61
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6C27AF72B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C352E03F5;
	Tue, 15 Jul 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThRDBy5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB11EDA09
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583077; cv=none; b=qpVMnFq9TMxLkim2SssyQs3nB8Ra8xM/bZn0MMe7hzPAcbX9rSaZbwVFuWFGA78iSrB0UepNuovKC7yJPIEAdrhEXLla0wdlcQ+eeT707/z2zg6Yy4GuXhOJrLOEdktUJqmWqbO1eUjKDunUexmzPK6eF5+r5jAebugzLx/bRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583077; c=relaxed/simple;
	bh=s5SHqgdvo0+2FkVqve51Q95FHinrG/rDBPRm8XadSz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDa36QP2n/g0AkDRFmbZjvdryxzXJJFx77v6wE6uQDnXnMM618V30yphKd6HIOe3ao+5xoEB7RSyI99HrzchDX48iVBnU3HOc3ywVGp4dO7Gp1mtowzcDIDxsqBH0jkEbgMzJZGUpB4/kBs90vpetzTNk7zmX4LcuDt2xtSza0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThRDBy5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052D0C4CEF1;
	Tue, 15 Jul 2025 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583076;
	bh=s5SHqgdvo0+2FkVqve51Q95FHinrG/rDBPRm8XadSz8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ThRDBy5eOp4Mzmi0n1gnRAxe4xJSO3qrQaBtYSOdzoOrdRPAIxRF+PHusYI4btesB
	 Xg5wDiBjTzNF5M8b16XJFtPBHbrNF9qCygw2Bpzz8bwvcFRSgyM4I/k76u8Tf1eVH4
	 i7CxO9qdGxVYe26voc0IzaHPeyL6LZvRdDeTYicj1Sz5NnzAEMVZxpRrVNbZVfL/eD
	 109gzeDfjPA62rNXMzXxDcQGnRbA0vUCfRwl99MDutVQ9k+F8jbFcStJfN0bSwSIvn
	 X5MNFUMEkOYNr7MUP2J6Jt8MFnGWgc7tITunvUviMY+ZZD1hnzaQYTNd3K+tk3kbf7
	 jLczPH5sLzK4Q==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 3/5] KVM: x86: add support for CPUID leaf 0x80000021
Date: Tue, 15 Jul 2025 14:37:47 +0200
Message-ID: <20250715123749.4610-4-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 58b3d12c0a860cda34ed9d2378078ea5134e6812 upstream.

CPUID leaf 0x80000021 defines some features (or lack of bugs) of AMD
processors.  Expose the ones that make sense via KVM_GET_SUPPORTED_CPUID.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kvm/cpuid.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8b07e48612d7..8ec86d2c1a41 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -810,7 +810,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->edx = 0;
 		break;
 	case 0x80000000:
-		entry->eax = min(entry->eax, 0x8000001f);
+		entry->eax = min(entry->eax, 0x80000021);
 		break;
 	case 0x80000001:
 		entry->ebx &= ~GENMASK(27, 16);
@@ -875,6 +875,23 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		if (!boot_cpu_has(X86_FEATURE_SEV))
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
+	case 0x80000020:
+		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		break;
+	case 0x80000021:
+		entry->ebx = entry->ecx = entry->edx = 0;
+		/*
+		 * Pass down these bits:
+		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
+		 *    EAX      2      LAS, LFENCE always serializing
+		 *    EAX      6      NSCB, Null selector clear base
+		 *
+		 * Other defined bits are for MSRs that KVM does not expose:
+		 *   EAX      3      SPCL, SMM page configuration lock
+		 *   EAX      13     PCMSR, Prefetch control MSR
+		 */
+		entry->eax &= BIT(0) | BIT(2) | BIT(6);
+		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
 		/*Just support up to 0xC0000004 now*/
-- 
2.43.0


