Return-Path: <stable+bounces-251374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPwUH0/9DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE559640B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 396BD30F8A95
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9295E36F421;
	Wed, 20 May 2026 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SuWdMFOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B65331220;
	Wed, 20 May 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297813; cv=none; b=u/+zjjdDlJuYnJ1N+XvKRK77tbZAarGXPMWLrGuFekuWEQWz5SL3pvDKhUwcP3eEdO8BTgUGk3yPNpISSCF6fVUEGVIsllYcL/bht9ErowmMHyXeP2XYJ9qYp0mwvuilMOuu/5LoE8avWpU6Ege94R0NL/IY/WY6Jl0E2tfQBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297813; c=relaxed/simple;
	bh=f4lMwJAD+WxsLl2xAGfXfiQ/51hbgMY1eWRpVrknH2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFEVeHuFK1b/meVfsW4TsTkQVELys+y63cHP3hzuf4SsgXOx8UhNpPPu3B5KlkgQu6W+EPjaBEbIcT2dme5e6eQ1DZl8TKHZYfGhu5WnrdOzeSMfByQZiywGM9EfBc1eKjRAtR8FAfwIQ2m95i9GvH+ixjasxXxFe8pdENyNzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SuWdMFOf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E621F000E9;
	Wed, 20 May 2026 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297812;
	bh=fw75t3NYjH3DeWxr3V1Zu2kijD09mmA/sGMNh9cA4dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SuWdMFOfI1fL+wiWO1OK3kSmpciJlNxraXhXOmqGluDp0CAS8ltMbckT3qZm6EYbw
	 zvYPn3c7Lt6wJLpyX1uNDhT8Jvxaac68UpTt10cVJC6U30TU0UPL7P+9g6BS7StSTD
	 78FgSb7JnuaSpM0X5Lbia2WmB7S3v6GkE+rZ0dbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 132/957] arm64: entry: Dont preempt with SError or Debug masked
Date: Wed, 20 May 2026 18:10:15 +0200
Message-ID: <20260520162137.418889881@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251374-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,huawei.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 83CE559640B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 2371bd83b3df9d833191fe58dadb0e69a794a1cd ]

On arm64, involuntary kernel preemption has been subtly broken since the
move to the generic irqentry code. When preemption occurs, the new task
may run with SError and Debug exceptions masked unexpectedly, leading to
a loss of RAS events, breakpoints, watchpoints, and single-step
exceptions.

Prior to moving to the generic irqentry code, involuntary preemption of
kernel mode would only occur when returning from regular interrupts, in
a state where interrupts were masked and all other arm64-specific
exceptions (SError, Debug, and pseudo-NMI) were unmasked. This is the
only state in which it is valid to switch tasks.

As part of moving to the generic irqentry code, the involuntary
preemption logic was moved such that involuntary preemption could occur
when returning from any (non-NMI) exception. As most exception handlers
mask all arm64-specific exceptions before this point, preemption could
occur in a state where arm64-specific exceptions were masked. This is
not a valid state to switch tasks, and resulted in the loss of
exceptions described above.

As a temporary bodge, avoid the loss of exceptions by avoiding
involuntary preemption when SError and/or Debug exceptions are masked.
Practically speaking this means that involuntary preemption will only
occur when returning from regular interrupts, as was the case before
moving to the generic irqentry code.

Fixes: 99eb057ccd67 ("arm64: entry: Move arm64_preempt_schedule_irq() into __exit_to_kernel_mode()")
Reported-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/entry-common.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/entry-common.h b/arch/arm64/include/asm/entry-common.h
index cab8cd78f6938..20f0a7c7bde15 100644
--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -29,14 +29,19 @@ static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
 
 static inline bool arch_irqentry_exit_need_resched(void)
 {
-	/*
-	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
-	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
-	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
-	 * DAIF we must have handled an NMI, so skip preemption.
-	 */
-	if (system_uses_irq_prio_masking() && read_sysreg(daif))
-		return false;
+	if (system_uses_irq_prio_masking()) {
+		/*
+		 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
+		 * priority masking is used the GIC irqchip driver will clear DAIF.IF
+		 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
+		 * DAIF we must have handled an NMI, so skip preemption.
+		 */
+		if (read_sysreg(daif))
+			return false;
+	} else {
+		if (read_sysreg(daif) & (PSR_D_BIT | PSR_A_BIT))
+			return false;
+	}
 
 	/*
 	 * Preempting a task from an IRQ means we leave copies of PSTATE
-- 
2.53.0




