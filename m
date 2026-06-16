Return-Path: <stable+bounces-263550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a7lEOojbMGoQYAUAu9opvQ
	(envelope-from <stable+bounces-263550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB568C0B4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:13:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=GrjCYNn8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263550-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263550-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D68F73011E94
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32B3CEB90;
	Tue, 16 Jun 2026 05:13:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA593CE48E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:13:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586823; cv=none; b=YWPPeW0u10THiaGzNmUxtmhget0tUIhzmp5rJnxh4QdRZZb5Q3X5YrVx1oRxKV+5HHybnD9w4qAWm3LnR9TPqDJZxTGITKeIWR9ZczvqcEEDMKifZi2NKOK2MXTSzYMJ0hxBcbRzFTrAM5z07oNxABTPHePuK1hK+XsZ05lQm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586823; c=relaxed/simple;
	bh=nRdci9h3YFzjfyFk/4O3eTKCJcjXEkQGcdE8p5ubC1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRWWInObQt2CDkT2vMnzDi1xnNyHcr5PF2SJ1EktRBOwAwCgmAg1upmJJmlO04/O5JtSfhGPdJJSQ+XiGhrFmB7iihC+cR//FrFsq4OGnkxzA+BJHqkEfFzEQAniOUZZgyXML9EPIEPDcqsDVyahm5pf3paYT+LJMyQhHGh66ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GrjCYNn8; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B4A3D5D;
	Mon, 15 Jun 2026 22:13:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 835FA3F763;
	Mon, 15 Jun 2026 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781586821; bh=nRdci9h3YFzjfyFk/4O3eTKCJcjXEkQGcdE8p5ubC1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrjCYNn8o8CG7tQZ+JSAfHcK5dC02f3W0DogCQ1PyLs9lCDn4RPE9eVqD/VBbqbNC
	 Pi8sJP/PuaRGj8nFRPIe9fsgKx24m5MJF6ffCR1umfDkv2hecwtazd+8bm8wZcgxsl
	 hUb6HuO/0qJCYKQvxJ+J8L5b2+kGE+WNQw30pJtM=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 6.18.y 2/5] arm64: cputype: Add C1-Premium definitions
Date: Tue, 16 Jun 2026 06:13:26 +0100
Message-Id: <20260616051329.111597-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616051329.111597-1-mark.rutland@arm.com>
References: <20260616051329.111597-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-263550-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:lee@kernel.org,m:mark.rutland@arm.com,m:sdonthineni@nvidia.com,m:will@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:url,arm.com:from_mime,arm.com:dkim,arm.com:email,arm.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AAB568C0B4

commit d28413bfc5a255957241f1df5d7fd0c2cd74fe18 upstream.

Add cputype definitions for C1-Premium. These will be used for errata
detection in subsequent patches.

These values can be found in the C1-Premium TRM:

  https://developer.arm.com/documentation/109416/0100/

... in section A.5.1 ("MIDR_EL1, Main ID Register").

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v6.18.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 544ab4704348a..78dc7314e7e5d 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -100,6 +100,7 @@
 #define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 #define ARM_CPU_PART_C1_PRO		0xD8B
+#define ARM_CPU_PART_C1_PREMIUM		0xD90
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -193,6 +194,7 @@
 #define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_C1_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PRO)
+#define MIDR_C1_PREMIUM MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PREMIUM)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.30.2


