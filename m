Return-Path: <stable+bounces-255030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IJuOuRVGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:49:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 737745F3F03
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D49083009CF8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CE3D0BE7;
	Thu, 28 May 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+wTD/yG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99YQULt7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB043F39DC
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979743; cv=none; b=bpuvrIom/P0uVuQ3O7FBqx770LHjuoqOEkn5X0ojjuz9OgX4HoE8i4w5MYej1jw5t32Bx89T7fHWjVqxEXQ/9geaFQqA1O2m3A0NZxhcyOuVUoFq9GgL54kUoWfvgs06Oz1+Sn3BHrlosvTnEG+OCFlUMRQxbb2PVsa1oNDkjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979743; c=relaxed/simple;
	bh=fR8OXW9Tr5M8Jf77347gO+O7mnQfCkAa8fY4UO8x974=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU/CKhZMD2VW562nBtVo5KF02SjCmeUCAMLkhk9qCeMCGMvlli5Dy/CCQI+/phavHcO21w3SsDL0dbMRJPUlobyp1sZUXxG3ynU+TG/3ahf7Rg2zH8pVL0i8M8lZtbiRQPwJufSrFrk9YgYyBqjHJOuVLSPzb20eef6rI/pxhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+wTD/yG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=99YQULt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMLzFc47unl5QuIWUjsObPLOCfxwOCMg2GAbMkEspro=;
	b=q+wTD/yGyW1krUCuFZm8I6F3t9oL1d6G2GyCTVJ6ZtAFuWPhXykOSOd548hpCN+W3ZilR0
	toVk/XeDY5jMgCp2+EoHkWSBpKOT0Xi7xyPH9WlVInoLaKCfPV94TEYJSXiPTC8WtSsOct
	93/WRBT8x1Fc9pzo7fk54zdaRHG3mRJuC7u8kE2guWk/X+fSkbo2hdcT5Z7n9UIa97PS8K
	KDzBhdveP3DKhC4jhcZ/EuXnb3PT/zCxF3eR1wpANRf6XqiQlKi58u3oHlGdz9dN0jeh0k
	3bVll5/CR+JROv9hg9ebtt6u81K08dwLGmTS5xlNiSE10gD62I0pDM+eOIsumw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMLzFc47unl5QuIWUjsObPLOCfxwOCMg2GAbMkEspro=;
	b=99YQULt7bh+6gSIWlCkmlkC/wrss2IaaY/JFVw/k4QSJcIpbYb4xymJP9Nb9XQNqvTdrFA
	L75+Gzwwr9R0/sBA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/14] arm64: debug: refactor reinstall_suspended_bps()
Date: Thu, 28 May 2026 16:48:19 +0200
Message-ID: <20260528144825.850351-10-bigeasy@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255030-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 737745F3F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit 80691d35523de3292b64c2ffa444aab3d55e51ba

`reinstall_suspended_bps()` plays a key part in the stepping process
when we have hardware breakpoints and watchpoints enabled.
It checks if we need to step one, will re-enable it if it has
been handled and will return whether or not we need to proceed with
a single-step.

However, the current naming and return values make it harder to understand
the logic and goal of the function.

Rename it `try_step_suspended_breakpoints()` and change the return value
to a boolean, aligning it with similar functions used in
`do_el0_undef()` like `try_emulate_mrs()`, and making its behaviour
more obvious.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-9-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/debug-monitors.h |  6 +++---
 arch/arm64/kernel/debug-monitors.c      |  2 +-
 arch/arm64/kernel/hw_breakpoint.c       | 25 ++++++++++++-------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/a=
sm/debug-monitors.h
index 5319da0f0ca4e..24c7981abeb0b 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -83,11 +83,11 @@ int kernel_active_single_step(void);
 void kernel_rewind_single_step(struct pt_regs *regs);
=20
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-int reinstall_suspended_bps(struct pt_regs *regs);
+bool try_step_suspended_breakpoints(struct pt_regs *regs);
 #else
-static inline int reinstall_suspended_bps(struct pt_regs *regs)
+static inline bool try_step_suspended_breakpoints(struct pt_regs *regs)
 {
-	return -ENODEV;
+	return false;
 }
 #endif
=20
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index a28482e25c4c3..b95a135ef10a9 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -195,7 +195,7 @@ static int single_step_handler(unsigned long unused, un=
signed long esr,
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
 	 */
-	if (!reinstall_suspended_bps(regs))
+	if (try_step_suspended_breakpoints(regs))
 		return 0;
=20
 	if (call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index d7eede5d869c2..309ae24d45480 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -847,36 +847,35 @@ NOKPROBE_SYMBOL(watchpoint_handler);
 /*
  * Handle single-step exception.
  */
-int reinstall_suspended_bps(struct pt_regs *regs)
+bool try_step_suspended_breakpoints(struct pt_regs *regs)
 {
 	struct debug_info *debug_info =3D &current->thread.debug;
-	int handled_exception =3D 0, *kernel_step;
-
-	kernel_step =3D this_cpu_ptr(&stepping_kernel_bp);
+	int *kernel_step =3D this_cpu_ptr(&stepping_kernel_bp);
+	bool handled_exception =3D false;
=20
 	/*
 	 * Called from single-step exception handler.
-	 * Return 0 if execution can resume, 1 if a SIGTRAP should be
-	 * reported.
+	 * Return true if we stepped a breakpoint and can resume execution,
+	 * false if we need to handle a single-step.
 	 */
 	if (user_mode(regs)) {
 		if (debug_info->bps_disabled) {
 			debug_info->bps_disabled =3D 0;
 			toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 1);
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		}
=20
 		if (debug_info->wps_disabled) {
 			debug_info->wps_disabled =3D 0;
 			toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		}
=20
 		if (handled_exception) {
 			if (debug_info->suspended_step) {
 				debug_info->suspended_step =3D 0;
 				/* Allow exception handling to fall-through. */
-				handled_exception =3D 0;
+				handled_exception =3D false;
 			} else {
 				user_disable_single_step(current);
 			}
@@ -890,17 +889,17 @@ int reinstall_suspended_bps(struct pt_regs *regs)
=20
 		if (*kernel_step !=3D ARM_KERNEL_STEP_SUSPEND) {
 			kernel_disable_single_step();
-			handled_exception =3D 1;
+			handled_exception =3D true;
 		} else {
-			handled_exception =3D 0;
+			handled_exception =3D false;
 		}
=20
 		*kernel_step =3D ARM_KERNEL_STEP_NONE;
 	}
=20
-	return !handled_exception;
+	return handled_exception;
 }
-NOKPROBE_SYMBOL(reinstall_suspended_bps);
+NOKPROBE_SYMBOL(try_step_suspended_breakpoints);
=20
 /*
  * Context-switcher for restoring suspended breakpoints.
--=20
2.53.0


