Return-Path: <stable+bounces-240113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD0rD0dL52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143C439458
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C28F300AD8A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A038F226;
	Tue, 21 Apr 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BjBqCrNm"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F733AE6E9
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765631; cv=none; b=TQiQJGmGgAAzv+CT5DBMREyl/qfCGyKqsBM4uaxWpm2a1CkbnHwrk/J+v8/RQmAbEPA4DEYksLURDEyXuCNa6/oofykDkszLeFsV0buvpQsboiFRlUljlzB9lBsaOGOPPpPiFoWQPeeyYAwiIVOIVR4wOquqw7Hx0Nf5Nr7JUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765631; c=relaxed/simple;
	bh=hEgI4tAgeBYfJ8zUJ2BOrFQB5zneozX2dkqPPtbXK+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esyIVQVQvUOMITw2bpn5Knty5S3UA7Rhwi67tM7uJm6Xj22WQHcFPdyKY5bzKZ0j/klmlctDbSkMq4dQD2oqYHhbzJ555KfJrVvwCw6ku/Q0AjGY2Hq8Dfb3sm4z4UMREigbW9tvEF9gPXkffr/VvB5eedS9PaFs+igLAttUnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BjBqCrNm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FFB03026;
	Tue, 21 Apr 2026 03:00:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6D73FBCB;
	Tue, 21 Apr 2026 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776765629; bh=hEgI4tAgeBYfJ8zUJ2BOrFQB5zneozX2dkqPPtbXK+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjBqCrNmC4vX2SxM+2Oh66t72jpSweZ2dPXobXjIjxsB7wl1JupInpU0CAAP7/FS1
	 rhbqrXPYiyN02ivG7333SCq4m5davo+ex6ZpYMq4yDrG/+QbOcYamuqJ1T7lfS6F96
	 Rft5EzR2b7YDC5I6o+KC8azIore9/j8OuxR06Dt4=
From: Catalin Marinas <catalin.marinas@arm.com>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.18.y 5/6] arm64: cputype: Add C1-Pro definitions
Date: Tue, 21 Apr 2026 11:00:16 +0100
Message-ID: <20260421100018.335793-6-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421100018.335793-1-catalin.marinas@arm.com>
References: <20260421100018.335793-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240113-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:mid,arm.com:email,arm.com:dkim,arm.com:url]
X-Rspamd-Queue-Id: 7143C439458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 2c99561016c591f4c3d5ad7d22a61b8726e79735 upstream.

Add cputype definitions for C1-Pro. These will be used for errata
detection in subsequent patches.

These values can be found in "Table A-303: MIDR_EL1 bit descriptions" in
issue 07 of the C1-Pro TRM:

  https://documentation-service.arm.com/static/6930126730f8f55a656570af

Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 9b00b75acbf2..18f98fb7ee78 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -98,6 +98,7 @@
 #define ARM_CPU_PART_CORTEX_A725	0xD87
 #define ARM_CPU_PART_CORTEX_A720AE	0xD89
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
+#define ARM_CPU_PART_C1_PRO		0xD8B
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -189,6 +190,7 @@
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_CORTEX_A720AE MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720AE)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
+#define MIDR_C1_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PRO)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)

