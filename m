Return-Path: <stable+bounces-264208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cHNPM8lxMWrkjQUAu9opvQ
	(envelope-from <stable+bounces-264208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:54:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8AD6917F5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:54:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PKOTOIWj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264208-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264208-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B1AC31317AF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B2466B7B;
	Tue, 16 Jun 2026 15:45:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B074466B53;
	Tue, 16 Jun 2026 15:44:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624702; cv=none; b=B/sO4pwy5+s6C4LL/iGG4VP1/a+NSa1zsVOOaLFXtEbBoEv/QwM4B7SUsGKtuigy5ZukuwsC/ewnvYbI5ozi1CXWUJWkELpYqyOxJ8CbmWjOf4qKTms34qSmUP5XlM8PKo4f6/Xq/tPk1BXLg4F3uDyqjH0KgocdYDBKe+1hbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624702; c=relaxed/simple;
	bh=0mOT6q9XdIZZk1bI+HYatH8Vy4q9xjzJDWHG4+1mPJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txc5Szgv2jRjUHD4aQasL1zSPgNDIG+dkfcyfRbdE9GeDjC57g7X71BFWbiukrDfUa2hv6fiq47w/f8Y6T23qR5oVli0mC5Gq/SzaMzlj0g4oP740ZNVfle6gjybbs1PCMWUJ79qLcWzpRtPsMNOIH4hXytTV/ixTZyUj5EXT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKOTOIWj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4CE1F000E9;
	Tue, 16 Jun 2026 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624698;
	bh=Ohvpbe/NZjsrZSVh03wRCyrYz83Y15nJvVYBwkKG9bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKOTOIWjrLP5LTKQCq8uHG0qV0JZ3KwXKP9C/rOKKFlMiNrdJPA0hIEu8Kx9sg8gk
	 /IvTHqLkiqBYObr9ln3hwj4ve25ulCU2/Voj4HxJXbmOl960yqcNobPW1zJQr8TYKc
	 Ub3srH//4C+mH/oMMFk9h5XbwlOVnQGfUdwPPXxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 7.0 377/378] arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU
Date: Tue, 16 Jun 2026 20:30:08 +0530
Message-ID: <20260616145129.920691510@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264208-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,arm.com:email,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C8AD6917F5

7.0-stable review patch.  If anyone has any objections, please let me know.

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
[Mark: backport to v7.0.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arch/arm64/silicon-errata.rst |    2 ++
 arch/arm64/Kconfig                          |    3 ++-
 arch/arm64/kernel/cpu_errata.c              |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -289,6 +289,8 @@ stable kernels.
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
@@ -1177,7 +1177,7 @@ config ARM64_ERRATUM_4311569
 	  If unsure, say Y.
 
 config ARM64_ERRATUM_4118414
-	bool "Cortex-*/Neoverse-*/C1-*: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
 	default y
 	select ARM64_WORKAROUND_REPEAT_TLBI
 	help
@@ -1204,6 +1204,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
 	  broadcast TLB invalidation.
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -363,6 +363,7 @@ static const struct arm64_cpu_capabiliti
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 			{}
 		})),
 	},



