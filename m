Return-Path: <stable+bounces-163025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075EB066BE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826441AA5BFF
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6224169E;
	Tue, 15 Jul 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuEt1pIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6D8633F
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607504; cv=none; b=UTNIh2U6VjxCvSJXpjsBs5HhtNsHJBaD2QHkS/TJBypZs5N5HQlT6UszlMVvUjLhQv/xY29FmunATmG4p1XkzzoWPXbSU99+uIjMFfuFzrzgk+szZ+YyjCP8NAK76dse8kfRmwRBRcy0ULec2rMkiUI2fD5vsT80BIIZtSi3ZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607504; c=relaxed/simple;
	bh=bvA1qHG3ABoeT8A5GTz5d6mDcR8a7zuwuuj6SpIDF4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7llM7RKXEzfhwmr/lqWbOZyOQEByg7nQH/1tLuJ+hR8G6BQTm6m6TmD16KDbK4uarURwxw0HIRqeg6ulWKOwrUp3lTDdg6EFrr+2OJ53I2c/cJHl9qEffB0diljWsA+bQcShY8RzZgBE/jl/1QGmr6ppcvIV7YXRt8pJybRB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuEt1pIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF6C4CEE3;
	Tue, 15 Jul 2025 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752607503;
	bh=bvA1qHG3ABoeT8A5GTz5d6mDcR8a7zuwuuj6SpIDF4E=;
	h=From:To:Cc:Subject:Date:From;
	b=VuEt1pIlje8B+2NRC4/3InwdiCbk8lt3mCm0WtXCTCKh0HqpmF25UEf5MQ6RGSeQU
	 5JcbN95Coltiu3jldwx37C1Tr1pR6uG110WBBgGioKpJq2bnAN9Oo+cMcJoz+b8JYE
	 rWG9H+8Kt0hDQaBIzxD/02GwwLtsBZIZhbnQQ2/rHUBfI/SHnh/8hTIrH+9GVuq+wq
	 7irFb5q80pYpwWp4YjQG2XlWCWMlekVSeTyBuVjjolEK825R3NEq0SYJ9y3gLqsPih
	 ZUOQYrIh1bwMAenikUcD7STFGMb/1fnZpBbeaBTZyLosNMr3I8r4QPmj6nCXaoTfAR
	 J0Dw1WNMkmH8A==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Jinpu Wang <jinpu.wang@ionos.com>
Subject: [PATCH 6.12] KVM: SVM: Set synthesized TSA CPUID flags
Date: Tue, 15 Jul 2025 21:24:59 +0200
Message-ID: <20250715192459.21804-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

VERW_CLEAR is supposed to be set only by the hypervisor to denote TSA
mitigation support to a guest. SQ_NO and L1_NO are both synthesizable,
and are going to be set by hw CPUID on future machines.

So keep the kvm_cpu_cap_init_kvm_defined() invocation *and* set them
when synthesized.

This fix is stable-only.

Co-developed-by: Jinpu Wang <jinpu.wang@ionos.com>
Signed-off-by: Jinpu Wang <jinpu.wang@ionos.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kvm/cpuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 02196db26a08..8f587c5bb6bc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -822,6 +822,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_VERW_CLEAR);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
 		F(PERFMON_V2)
@@ -831,6 +832,9 @@ void kvm_set_cpu_caps(void)
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_SQ_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_L1_NO);
+
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
 	 * KVM's supported CPUID if the feature is reported as supported by the
-- 
2.43.0


