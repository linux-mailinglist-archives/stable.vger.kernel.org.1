Return-Path: <stable+bounces-263601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQT3N2zeMGquYAUAu9opvQ
	(envelope-from <stable+bounces-263601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:26:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14668C27C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=cpnvr1y+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263601-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263601-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB133300A644
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B53CF1EB;
	Tue, 16 Jun 2026 05:26:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008E3C9889
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:25:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587560; cv=none; b=EGrvE1Lafgj4IIMTtdsEfWsjfLQfCUgv1w4qdi5Z3rAKcF7lU+8TfbYimaqOmjvgfnQV/ZSboxJSkFDDQT5PGWE62pl4FEpPD/KG1Nlno4ONBNJYsPBR/jszH+DFB5seu5fdPuhlzcTrzLrkUG0o+Px6OBnmiu+NHTIcB5xrjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587560; c=relaxed/simple;
	bh=8l5WZaYvBgTphZmdr9L3TssPYmCJMo0X6d7ka6mYlUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4dmb+K81aYRC19qwUKRAvAIjYfSUR7E2u+Uo0mfOxrx85pNlCUqEFfg9Rit/L3eT0OWrPrGGFUp1p3BFE/aPjKeUFlU4dqpga2kY+ZcbvoBX27IIeQVqX+pFVqfBRdOy2x0tH6qwZl0dAB8fLOy524Ibha3JeLHf4xeTq9lBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cpnvr1y+; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D154B4360;
	Mon, 15 Jun 2026 22:25:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D782E3F763;
	Mon, 15 Jun 2026 22:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587558; bh=8l5WZaYvBgTphZmdr9L3TssPYmCJMo0X6d7ka6mYlUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpnvr1y+SOFySlR8fz5ScVdM/xGcQBPSdHdchOXy3c4Lq5HTEKE06jYRJSedOV+57
	 HCjTcydm544aNEVq1iATWxdyVh8+p7uU68jnTK9Wm6dYGH7TYwammPn9NLaYJPb1Dv
	 eiC0+eEkcpO4cajbPGv0I+mamVWFAIQ/TG79ZkbE=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.10.y 04/10] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
Date: Tue, 16 Jun 2026 06:25:37 +0100
Message-Id: <20260616052543.112176-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616052543.112176-1-mark.rutland@arm.com>
References: <20260616052543.112176-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-263601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:eahariha@linux.microsoft.com,m:gregkh@linuxfoundation.org,m:lee@kernel.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:oupton@kernel.org,m:ryan.roberts@arm.com,m:sdonthineni@nvidia.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC14668C27C

From: Easwar Hariharan <eahariha@linux.microsoft.com>

commit fb091ff394792c018527b3211bbdfae93ea4ac02 upstream.

Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
suffers from all the same errata.

CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240214175522.2457857-1-eahariha@linux.microsoft.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Mark: backport to v5.10.y; only the MIDR is relevant to v5.10.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 9974ef7c788d9..d49743d01fe66 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -130,6 +131,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -185,6 +188,7 @@
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
-- 
2.30.2


