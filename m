Return-Path: <stable+bounces-210763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOWELEvgcGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A71584DA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F8CA6CE0EB
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C1B4ADDA0;
	Wed, 21 Jan 2026 13:56:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE494ADD8D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003809; cv=none; b=kvGg4rxX4r9ivv0WxSKIRdySvlV8yc783hDE5aPKAGPeCNCRJKVWwsArDNqJRq/QT/XRj1oQWR9UFePZ257nJkJ4RyPRF27VF24bGz4Et5eA1d+5PpHfNvRxlBucHtSwe3uhR5yky+x754XJCqG/bcYD8jXq/Ta4+5rf5YY2SXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003809; c=relaxed/simple;
	bh=JxOpeELHN1OD5VikasuRZJeKuxqbPHrKCOCFBPxCVa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rK8eEih9n/em82up2++XjQfJYMho40G/cssUEImUuceoBbYf/4Z3YbEMWDKshueQWhFkk7gkCp8/JAGY0AjgNw5fQbFZc2tK0uB1KD7l+CuTnVDNj+pyrRL82FwfCqJt3XMi79hB53duADGB09WNxe548py/jZTSEg6ULmzla4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491BB1476;
	Wed, 21 Jan 2026 05:56:40 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1403F740;
	Wed, 21 Jan 2026 05:56:45 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: david.spickett@arm.com,
	joey.gouly@arm.com,
	kevin.brodsky@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v1] arm64: poe: fix stale POR_EL0 values for ptrace
Date: Wed, 21 Jan 2026 13:56:39 +0000
Message-Id: <20260121135639.1835784-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210763-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey.gouly@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F3A71584DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If a process wrote to POR_EL0 and then crashed before a context switch
happened, the coredump would contain an incorrect value for POR_EL0.

The value read in poe_get() would be a stale value left in thread.por_el0.  Fix
this by reading the value from the system register, if the target thread is the
current thread.

This matches what gcs/fpsimd do.

Fixes: 175198199262 ("arm64/ptrace: add support for FEAT_POE")
Reported-by: David Spickett <david.spickett@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/por.h | 2 ++
 arch/arm64/kernel/process.c  | 7 ++++++-
 arch/arm64/kernel/ptrace.c   | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index d913d5b529e4..46f1356837e2 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -31,4 +31,6 @@ static inline bool por_elx_allows_exec(u64 por, u8 pkey)
 	return perm & POE_X;
 }
 
+void poe_preserve_current_state(void);
+
 #endif /* _ASM_ARM64_POR_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 489554931231..400182099784 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -665,12 +665,17 @@ static int do_set_tsc_mode(unsigned int val)
 	return 0;
 }
 
+void poe_preserve_current_state(void)
+{
+	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+}
+
 static void permission_overlay_switch(struct task_struct *next)
 {
 	if (!system_supports_poe())
 		return;
 
-	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
+	poe_preserve_current_state();
 	if (current->thread.por_el0 != next->thread.por_el0) {
 		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
 		/*
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b9bdd83fbbca..276d8ee630cd 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -37,6 +37,7 @@
 #include <asm/gcs.h>
 #include <asm/mte.h>
 #include <asm/pointer_auth.h>
+#include <asm/por.h>
 #include <asm/stacktrace.h>
 #include <asm/syscall.h>
 #include <asm/traps.h>
@@ -1486,6 +1487,10 @@ static int poe_get(struct task_struct *target,
 	if (!system_supports_poe())
 		return -EINVAL;
 
+	if (target == current) {
+		poe_preserve_current_state();
+	}
+
 	return membuf_write(&to, &target->thread.por_el0,
 			    sizeof(target->thread.por_el0));
 }
-- 
2.25.1


