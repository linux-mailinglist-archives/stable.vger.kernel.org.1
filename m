Return-Path: <stable+bounces-270245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bqJhLF19RWo0BAsAu9opvQ
	(envelope-from <stable+bounces-270245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:49:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C066F1980
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RdeVwqBJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270245-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270245-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31DAD30B7531
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 20:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417F63BBFD1;
	Wed,  1 Jul 2026 20:43:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106D3ACF05
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:43:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938628; cv=none; b=TXl3sveNTdPBj5YoPDmxkTIJYYqnVSPKSKI7im9bWVc+BE7+1SGAP3ZuFSz34ujqneJZ0CFpDQzLqgmT5BIN4Bqe0A30Xe2wxcbCMGc1B1tjv0g9/jvfxCZftzLzkDDSGhkWiJhzu1AywGx8GhtigO/SqU7TMdJ2sU2SvQgFChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938628; c=relaxed/simple;
	bh=Qn218Vl/+isGAI3Z1DhmCzpq+tptNiE/Fo8jVmC6SRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oM4R11VreG2cIvQTx1nKmxNNasr5FSf/BP6vKWZmPlOxtGQoG9C6Y5Q1N6caCvCYuAqjt98zL+DkVUb7kuI6N5xS3FITmByCfY3/WBTzc6oFq1joVjHjt/wa45oLZaoW1xdbxqaxnsNXgYP2BBvOWY3z1qoyjuIn2C8Zm5BHhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdeVwqBJ; arc=none smtp.client-ip=209.85.167.201
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-495f637105eso1715047b6e.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938625; x=1783543425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzU5geEAdlGdzp5rSJKP+9OB0IsgaotJw1U5Q6pxjvc=;
        b=RdeVwqBJLuD/10YaG3oBEtBMkbOR0YMZ+w7fwrp9xtqLf1tNXxFAonJrzHh2j7e1/O
         GpVnn9VrTtpytZkoEBRDACMfQZRE9Z0RS1A47aWyhm7EiIfdgWcsB5pWyO4gWb7raiGy
         3YMFOghxFHUmHtbcFvXp0IBn1aBFP36izfb48eY+llGnghmHXr9v6YmNmON0SRLp+5Zg
         J5GhpXKgQ+vu5E0xJutNWBC0kBiUYxFX43NYdnVymQUn5omBcLI6+X463oSDyRZiXsGT
         yTWdZ1bOQaVctPIPUGG1MRAJHiZwodR062V9qNQ3IvkUF3iUbI63kdW5Qs3jJet2V8Cq
         usqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938625; x=1783543425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzU5geEAdlGdzp5rSJKP+9OB0IsgaotJw1U5Q6pxjvc=;
        b=CFawdDfenp+PezryifekFj2FsWDRwlwHTs+CrJ3lLvtz6Ac7dBREPpod/rM78mGyGV
         tyPHx5k0mFz1wouKj+ml649FUK8RmFhmEzTxuuPEBw/GA1apbBA/1Y3UF1GaA45p9isR
         dXJOWMxeimhE1KuSskgf8hr4hhuy+0Xm3qumsj77nlxJt7fdEObOzHjo7FLLJtISPxGG
         RjkU+ocjyyS0/dFyes0Mo/7EDTB/PuaqC2LIv+s/fYbdOLzRPNH8BI9XITqo8v7mL6Xp
         VIIuJstH0wrxorM9TOk+SV7zr2qna8Ir4anhqlQWUZKr61tIURwVHydL0L8SC8n6PwhV
         njYA==
X-Gm-Message-State: AOJu0Yyv6YlDiK2bwkfQogTmTqS/UykIIgDIwYRAxJC9D/hWwD5Mpuej
	U7lqIjkVxK13u3fxxKZqDfj3IQ3fNQ2K8YqoBiZCelB4imMTIXLqE/V+JVQ+92kufbrAajji49M
	YgMdkTfxEZqCQ0pKnjiJovTSU3fL1UWmmJ8hi3369Rbd/uIbdVJmrd41n4B19OndA59MW5nUMTs
	GghKjJ7HwSIqZI2Fc3ZaRKDRG3erciPPL6HHgJPtsXS3Qa7rYwuhGjffp9rW5zz6w=
X-Received: from iodr16-n1.prod.google.com ([2002:a05:6602:6c90:10b0:993:783e:f2bb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5088:b0:487:6930:d50 with SMTP id 5614622812f47-4960efba909mr1932765b6e.35.1782938625160;
 Wed, 01 Jul 2026 13:43:45 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:43:39 +0000
In-Reply-To: <20260701204342.2654385-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701204342.2654385-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260701204342.2654385-3-coltonlewis@google.com>
Subject: [PATCH 2/5] arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0
 is negative
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270245-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:oliver.upton@linux.dev,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mizhang@google.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09C066F1980

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 3944382fa6f22b54bc3624c9657b98ec34b5ba59 ]

For CPUs that have ID_AA64MMFR4_EL1.E2H0 as negative, it is important
to avoid the boot path that sets HCR_EL2.E2H=0. Fortunately, we
already have this path to cope with fruity CPUs.

Tweak init_el2 to look at ID_AA64MMFR4_EL1.E2H0 first.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20240122181344.258974-8-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kernel/head.S | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6517bf2644a08..e32c8dd0b17a7 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -589,25 +589,32 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
 
 	/*
-	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
-	 * making it impossible to start in nVHE mode. Is that
-	 * compliant with the architecture? Absolutely not!
+	 * Compliant CPUs advertise their VHE-onlyness with
+	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
+	 * RES1 in that case.
+	 *
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1, but
+	 * don't advertise it (they predate this relaxation).
 	 */
+	mrs_s	x0, SYS_ID_AA64MMFR4_EL1
+	ubfx	x0, x0, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
+	tbnz	x0, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH - 1), 1f
+
 	mrs	x0, hcr_el2
 	and	x0, x0, #HCR_E2H
-	cbz	x0, 1f
-
+	cbz	x0, 2f
+1:
 	/* Set a sane SCTLR_EL1, the VHE way */
 	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
 	mov	x2, #BOOT_CPU_FLAG_E2H
-	b	2f
+	b	3f
 
-1:
+2:
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x1
 	mov	x2, xzr
-2:
+3:
 	__init_el2_nvhe_prepare_eret
 
 	mov	w0, #BOOT_CPU_MODE_EL2
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


