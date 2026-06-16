Return-Path: <stable+bounces-264543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Hm6Gcd7MWoSkgUAu9opvQ
	(envelope-from <stable+bounces-264543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:37:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B4692451
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="wIxcjn/C";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264543-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264543-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98503301D50F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171744CAF5;
	Tue, 16 Jun 2026 16:14:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4E379EFC;
	Tue, 16 Jun 2026 16:14:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626481; cv=none; b=jbh4OiAvMguofkjS9hhCM6qDbSuedjVBfs9TY2AL6md10d44ksv9xdJyOgySFQErUOGf2dEexbGUQQiyP8bjxOqQ5uQQUNwmE3mJkLDQwaHlHW9NVdaqBQVE1O1ZlBl9+HOutiXMMxsmGGdG3cxvNm9aP8pYGFXjnw+JqClC5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626481; c=relaxed/simple;
	bh=PqzmAkzm+eS/g/lk2eo52XO9YDCKC0VgLX3K+MbfxeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO2IrNm4oel0UUTU20dHIyjtSJas/PZRBPDDz01v0/m5W2zLlknf+Es5y1l7e/NAJpeA5lJATII6hRFgF3x1qzPZNYs0PgS03scGEzEw82pZLv0JjZpGdJCZV5f6EuwU4cCl2g0QNKDJ4mlPypyQpcK4XsCiwgSo+SX/4MbrFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIxcjn/C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB91F000E9;
	Tue, 16 Jun 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626479;
	bh=ulxb1k7u//nA9ueaoYcTBi8PNjrqdKHWOov1Uz4Tknw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wIxcjn/CSaPbrUFeu+4hCiNkSSmKD95HYWQSpj6uT/l2mEDxklK9KhNQswDTWEJwd
	 xxnizXyFSx/Z6KG5hmI0prF5CqM3Zgo+tUNgJo/pyUMNO5GH94VXsPK8yHEagmWFk0
	 T4w8IVAxSPOD1qyHpOobWffIgXZvfmNysa0NjnEE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.18 322/325] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 20:31:58 +0530
Message-ID: <20260616145115.145170182@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264543-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mark.rutland@arm.com,m:catalin.marinas@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,arm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D6B4692451

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit cfd391e74134db664feb499d43af286380b10ba8 upstream.

A number of CPUs developed by Arm suffer from errata whereby a broadcast
TLBI;DSB sequence may complete before the global observation of writes
which are translated by an affected TLB entry.

These errata ONLY affect the completion of memory accesses which have
been translated by an invalidated TLB entry, and these errata DO NOT
affect the actual invalidation of TLB entries. TLB entries are removed
correctly.

This issue has been assigned CVE ID CVE-2025-10263.

To mitigate this issue, Arm recommends that software follows any
affected TLBI;DSB sequence with an additional TLBI;DSB, which will
ensure that all memory write effects affected by the first TLBI have
been globally observed. The additional TLBI can use any operation that
is broadcast to affected CPUs, and the additional DSB can use any option
that is sufficient to complete the additional TLBI.

The ARM64_WORKAROUND_REPEAT_TLBI workaround is sufficient to mitigate
the issue. Enable this workaround for affected CPUs, and update the
silicon errata documentation accordingly.

Note that due to the manner in which Arm develops IP and tracks errata,
some CPUs share a common erratum number.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v6.18.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arch/arm64/silicon-errata.rst |   42 ++++++++++++++++++++++++++++
 arch/arm64/Kconfig                          |   36 ++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              |   32 ++++++++++++++++++++-
 3 files changed, 108 insertions(+), 2 deletions(-)

--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -128,16 +128,28 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76AE    | #4193801        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1491015        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #4193798        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78AE    | #4193793        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #4193794        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
@@ -146,6 +158,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
@@ -158,20 +172,32 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #4193792        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #4193786        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #4118414        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #4193781        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -182,6 +208,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
@@ -190,20 +218,34 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #1619801        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #4193790        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Premium      | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | C1-Pro          | #4193714        | ARM64_ERRATUM_4193714       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Ultra        | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
 |                |                 | #562869,1047329 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1166,6 +1166,42 @@ config ARM64_ERRATUM_4193714
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4118414
+	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	default y
+	select ARM64_WORKAROUND_REPEAT_TLBI
+	help
+	  This option adds a workaround for the following errata:
+
+	  * ARM C1-Premium erratum 4193780
+	  * ARM C1-Ultra erratum 4193780
+	  * ARM Cortex-A76 erratum 4193800
+	  * ARM Cortex-A76AE erratum 4193801
+	  * ARM Cortex-A77 erratum 4193798
+	  * ARM Cortex-A78 erratum 4193791
+	  * ARM Cortex-A78AE erratum 4193793
+	  * ARM Cortex-A78C erratum 4193794
+	  * ARM Cortex-A710 erratum 4193788
+	  * ARM Cortex-X1 erratum 4193791
+	  * ARM Cortex-X1C erratum 4193792
+	  * ARM Cortex-X2 erratum 4193788
+	  * ARM Cortex-X3 erratum 4193786
+	  * ARM Cortex-X4 erratum 4118414
+	  * ARM Cortex-X925 erratum 4193781
+	  * ARM Neoverse-N1 erratum 4193800
+	  * ARM Neoverse-N2 erratum 4193789
+	  * ARM Neoverse-V1 erratum 4193790
+	  * ARM Neoverse-V2 erratum 4193787
+	  * ARM Neoverse-V3 erratum 4193784
+	  * ARM Neoverse-V3AE erratum 4193784
+
+	  On affected cores, some memory accesses might not be completed by
+	  broadcast TLB invalidation.
+
+	  This issue is also known as CVE-2025-10263.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -316,7 +316,35 @@ static const struct arm64_cpu_capabiliti
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
 	},
 #endif
-	{},
+#ifdef CONFIG_ARM64_ERRATUM_4118414
+	{
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+			MIDR_ALL_VERSIONS(MIDR_C1_PREMIUM),
+			MIDR_ALL_VERSIONS(MIDR_C1_ULTRA),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			{}
+		})),
+	},
+#endif
+	{}
 };
 #endif
 
@@ -669,7 +697,7 @@ const struct arm64_cpu_capabilities arm6
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 	{
-		.desc = "Qualcomm erratum 1009, or ARM erratum 1286807, 2441009",
+		.desc = "Broken broadcast TLBI completion",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,



