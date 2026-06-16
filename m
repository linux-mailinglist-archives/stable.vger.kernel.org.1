Return-Path: <stable+bounces-264809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0LfoDDd+MWoekwUAu9opvQ
	(envelope-from <stable+bounces-264809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:47:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E469274D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WkXQukp7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264809-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264809-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE22A309AF5B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D373A47798F;
	Tue, 16 Jun 2026 16:40:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB446AF3C;
	Tue, 16 Jun 2026 16:40:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628003; cv=none; b=HXKkVmts1mjQ6RroqZkNSqYDyeXsrZcHX7QuF5aeaRCVZVw98dwRKULm0LQ4SzgAfp4QpQleHF2IZzF/a/XDGUVZtn+EAkjL4qD8A9vyQDkC8OaOppB+BpGftcrbPQqqYTRXpt9hRYWUpj5AMWlTI6okfaauq0tKSH9UIZYnV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628003; c=relaxed/simple;
	bh=dHLNXdjwuPjgzPdLG+nzRsPQmegK4bkqHfjdjR9T4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlCrzz6u+UfthoqvUFBx/iHHwYYuvkbT8lTI3DWutG7XRq2UJYNOHMNj891T4lK5/dU9YQQvih1nutKrnc4Z+2Mv7X0+kWzwRHHJzssZ5owjKOqOmmy27Jamg9MUOiQVPQ1tl2UeLQupHR01vRB2S7Sz9tG7prD3gTgaQabVIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkXQukp7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C71F000E9;
	Tue, 16 Jun 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628002;
	bh=pXgyC+ToQeVdg0m2CzO444y6EcaMgzi/oXc5bX1gGrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WkXQukp7JTQMw6R3LMdIyAnfuU4mV2NbzSr0Pv7+wYyDlQuewm9pNx5KXrn6BFVLQ
	 XI8QfuN5lGk55oOHVomZJ96/o+NAFj2vkoqWAoUc9w2Mvdihdaj0Chd3oqk9UZoqbY
	 594FFzhhr1yhT/ReG51FEGORjtSx6ZQw6VTstFtc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6.12 255/261] arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU
Date: Tue, 16 Jun 2026 20:31:33 +0530
Message-ID: <20260616145056.889022754@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264809-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sdonthineni@nvidia.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA4E469274D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <sdonthineni@nvidia.com>

commit ec7216f92e4ebd485b1c6dc6aa3f6064b71a5768 upstream.

NVIDIA Olympus cores are affected by the TLBI completion issue tracked as
CVE-2025-10263. The existing ARM64_ERRATUM_4118414 handling already uses
ARM64_WORKAROUND_REPEAT_TLBI to issue an additional broadcast TLBI;DSB
sequence and ensure affected memory write effects are globally observed.

Add MIDR_NVIDIA_OLYMPUS to the repeat-TLBI match list so the same
mitigation is enabled on affected Olympus systems. Also document the
NVIDIA Olympus erratum in the arm64 silicon errata table and list it in
the Kconfig help text.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v6.12.y]
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arch/arm64/silicon-errata.rst |    2 ++
 arch/arm64/Kconfig                          |    3 ++-
 arch/arm64/kernel/cpu_errata.c              |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -285,6 +285,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | Olympus core    | T410-OLY-1029   | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1139,7 +1139,7 @@ config ARM64_ERRATUM_4193714
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_4118414
-	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
 	default y
 	select ARM64_WORKAROUND_REPEAT_TLBI
 	help
@@ -1166,6 +1166,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
 	  broadcast TLB invalidation.
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -249,6 +249,7 @@ static const struct arm64_cpu_capabiliti
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 			{}
 		})),
 	},



