Return-Path: <stable+bounces-255033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEakADJXGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F805F3FF0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A334E319502B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBB43F4DE6;
	Thu, 28 May 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfAL0Lew";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOApS1bV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D13F1AAC
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979759; cv=none; b=YFPId8f7Q4Ll3EBrVCPdwOefhkV1hb+XLS0+2TH2RU2hi95xukLHqaHg2Se8VpGI4lBNTp8bFV0UKw2XaQb4gQTaely9XnTZWTNgvYUWlMxOIyDfkMgw18f6hwELFISoY6AzW+wL5/vqUR6lBS0Ph+ZfRpbiZcz49aJnyEQCZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979759; c=relaxed/simple;
	bh=jkCQDSPBQkPlb5Q37K4ap6+a/CWyRWNiMQch6PMUPWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcP4+uYfpJYJssm+uEoP7MDUScvn/zo7NBx3cxC5+xkDWw2Hoqx/Wu5YPhEWrtMQDQW2oTmgLZ+QDh4XLb9+y5alOagc0zXz0XdtqRjVwaJm4h7TD50eR+lG3QnaRZ92MX83TtHuuRiZVwjdqcEwhxET8aOI1LCCCqXuLkiYtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfAL0Lew; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOApS1bV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWNhXGcH3yFCoO8wy4x1gvTX9X7dVjvuvK77owTy41M=;
	b=lfAL0LewaD+bwZbyx696gFySaqRB2iPgwRWa3J+UYhm+9z9AkgRuq/LOuo75dNzQoVdi1R
	/yD+/8ir0ZiTNvU9WMBisv5jKNbgmgmB2z9aM1a7AujNP2+Hm03s8YZD5m6fCTJIS9jQSM
	w1CYuEWmwI8yfWgRsjt70PU6jcx00Ao7PKnDHovBKpAhUAvv4Slm6QASd4VLrazgqIobbl
	koR7Oq/RXZvZ9aJ7Y1sMclwuyJq3gsutq69nN+eXiLx7a0Hl8d1bYnA4bjtIklNv+Ybqx2
	j5hq80EPwj41GpkIb3Xlp9eo/XcNtGTZa7gm9dyKubXjtBDn3sYEITWJD8CAQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWNhXGcH3yFCoO8wy4x1gvTX9X7dVjvuvK77owTy41M=;
	b=gOApS1bVsAqDyYJVpnadTfkPOhCu2puPow42OIUPGSnMDiWOw6M/sfOI1kgdgVuhos7Dkv
	1dRW8xD7wLWDwJDQ==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/14] arm64: debug: remove break/step handler registration infrastructure
Date: Thu, 28 May 2026 16:48:16 +0200
Message-ID: <20260528144825.850351-7-bigeasy@linutronix.de>
In-Reply-To: <20260528144825.850351-1-bigeasy@linutronix.de>
References: <20260528144825.850351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255033-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 60F805F3FF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit d4e0b12620946a4011ad695490211fc38bf5cb42

Remove all infrastructure for the dynamic registration previously used by
software breakpoints and stepping handlers.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-6-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/debug-monitors.h | 24 ----------
 arch/arm64/kernel/debug-monitors.c      | 63 -------------------------
 2 files changed, 87 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 3eeea1c9f0666..5319da0f0ca4e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -62,30 +62,6 @@ struct task_struct;
 #define DBG_HOOK_HANDLED	0
 #define DBG_HOOK_ERROR		1
=20
-struct step_hook {
-	struct list_head node;
-	int (*fn)(struct pt_regs *regs, unsigned long esr);
-};
-
-void register_user_step_hook(struct step_hook *hook);
-void unregister_user_step_hook(struct step_hook *hook);
-
-void register_kernel_step_hook(struct step_hook *hook);
-void unregister_kernel_step_hook(struct step_hook *hook);
-
-struct break_hook {
-	struct list_head node;
-	int (*fn)(struct pt_regs *regs, unsigned long esr);
-	u16 imm;
-	u16 mask; /* These bits are ignored when comparing with imm */
-};
-
-void register_user_break_hook(struct break_hook *hook);
-void unregister_user_break_hook(struct break_hook *hook);
-
-void register_kernel_break_hook(struct break_hook *hook);
-void unregister_kernel_break_hook(struct break_hook *hook);
-
 u8 debug_monitors_arch(void);
=20
 enum dbg_active_el {
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index f929b107840de..a28482e25c4c3 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -159,46 +159,6 @@ NOKPROBE_SYMBOL(clear_user_regs_spsr_ss);
 #define set_regs_spsr_ss(r)	set_user_regs_spsr_ss(&(r)->user_regs)
 #define clear_regs_spsr_ss(r)	clear_user_regs_spsr_ss(&(r)->user_regs)
=20
-static DEFINE_SPINLOCK(debug_hook_lock);
-static LIST_HEAD(user_step_hook);
-static LIST_HEAD(kernel_step_hook);
-
-static void register_debug_hook(struct list_head *node, struct list_head *=
list)
-{
-	spin_lock(&debug_hook_lock);
-	list_add_rcu(node, list);
-	spin_unlock(&debug_hook_lock);
-
-}
-
-static void unregister_debug_hook(struct list_head *node)
-{
-	spin_lock(&debug_hook_lock);
-	list_del_rcu(node);
-	spin_unlock(&debug_hook_lock);
-	synchronize_rcu();
-}
-
-void register_user_step_hook(struct step_hook *hook)
-{
-	register_debug_hook(&hook->node, &user_step_hook);
-}
-
-void unregister_user_step_hook(struct step_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
-void register_kernel_step_hook(struct step_hook *hook)
-{
-	register_debug_hook(&hook->node, &kernel_step_hook);
-}
-
-void unregister_kernel_step_hook(struct step_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
 /*
  * Call single step handlers
  * There is no Syndrome info to check for determining the handler.
@@ -264,29 +224,6 @@ static int single_step_handler(unsigned long unused, u=
nsigned long esr,
 }
 NOKPROBE_SYMBOL(single_step_handler);
=20
-static LIST_HEAD(user_break_hook);
-static LIST_HEAD(kernel_break_hook);
-
-void register_user_break_hook(struct break_hook *hook)
-{
-	register_debug_hook(&hook->node, &user_break_hook);
-}
-
-void unregister_user_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
-void register_kernel_break_hook(struct break_hook *hook)
-{
-	register_debug_hook(&hook->node, &kernel_break_hook);
-}
-
-void unregister_kernel_break_hook(struct break_hook *hook)
-{
-	unregister_debug_hook(&hook->node);
-}
-
 static int call_break_hook(struct pt_regs *regs, unsigned long esr)
 {
 	if (user_mode(regs)) {
--=20
2.53.0


