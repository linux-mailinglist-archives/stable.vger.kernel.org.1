Return-Path: <stable+bounces-255034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sANvIzdXGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822D5F3FF7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A174F3197DDF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3E2F745C;
	Thu, 28 May 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VFniQAYu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbTe8YeY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64A3F6C4B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979760; cv=none; b=ca/ey9HyLPV6hYksw9VikCC2MleUEAWAPo2eCAOA/eQ5eRfhuTB7PYY0Y9vdeuBqzml52LiZ7hrT4ctBP5tgaucIXMV/tjQUBlxEn/8oY/Tr2Yd7dfIfLX2y5gWtSSFse9cTdyJaMpSTRimIrudv59QjczCh4RcSQy01bhbIsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979760; c=relaxed/simple;
	bh=+hVb6gS/yqmJOq5DhmT3AJ88Hm/2fz9ek+4LrqaO/Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2OW3o3cvjJGM+Y+62hSpEc6fiDBAjR/6fv7m6vAgDWwZY7xW94XQDTXWnnDi7PAWun8pno8NNdHJw9Xckl+d63maWgQG8RVOSE0qEgHPt5ueWErSlTmH5hkIrcJgmKrk3mhxWrbO8GK+xcv3EHkFp3m3AJqknVDFF8NKxavJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VFniQAYu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbTe8YeY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um/frADZcYV2+0OBBoTTElHotjjeMnT2rUdLtIYjyZs=;
	b=VFniQAYu+sG3AwcwTVZ/ptpLa6X4IpafzTexxhm4dI2+tzQwUSq3e0c4VDLX4rYsZ4LQ3Y
	8IQWKPHho/1xbV857a9Wqeh3FXruR2GZdLw1i7I3wdXMFVdGFyksRIBXeXWbO66Gpxcg3u
	E5t94carfgBmKUqbPLDrCKH31plX8lab0XxoomxLG60/MXTbHlKCi+oWDXsMH8ws+Fdrl8
	w5RvKKTAOYbKqHCOb1YLh8C8pFSU3iLEQlktM0o6nMAs19xv9JvQHg8aUa6hcROQQy5TYk
	kdjRHZ69mKeZX6AXH1ZiZMWq1X0y/seEbNvOd/cm52bWtc26pLHMjKAORulddg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Um/frADZcYV2+0OBBoTTElHotjjeMnT2rUdLtIYjyZs=;
	b=JbTe8YeYmHuf6+X7/tfo3SVF9UuLoa4cI2/CaqctV35tKDutPaX/FBfBh5Bu5MtiZlx9Vu
	P7MYOMTY6ibYpMDA==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/14] arm64: debug: call step handlers statically
Date: Thu, 28 May 2026 16:48:15 +0200
Message-ID: <20260528144825.850351-6-bigeasy@linutronix.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255034-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 2822D5F3FF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit 403b48aad5b3e857b8c2576ce6a421f3d23dd6a6

Software stepping checks for the correct handler by iterating over a list
of dynamically registered handlers and calling all of them until one
handles the exception.

This is the only generic way to handle software stepping handlers in arm64
as the exception does not provide an immediate that could be checked,
contrary to software breakpoints.

However, the registration mechanism is not exported and has only
two current users : the KGDB stepping handler, and the uprobe single step
handler.
Given that one comes from user mode and the other from kernel mode, call
the appropriate one by checking the source EL of the exception.
Add a stand-in that returns DBG_HOOK_ERROR when the configuration
options are not enabled.

Remove `arch_init_uprobes()` as it is not useful anymore and is
specific to arm64.

Unify the naming of the handler to XXX_single_step_handler(), making it
clear they are related.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Will Deacon <will@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20250707114109.35672-5-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/kgdb.h      |  9 +++++++++
 arch/arm64/include/asm/uprobes.h   |  9 +++++++++
 arch/arm64/kernel/debug-monitors.c | 25 ++++++-------------------
 arch/arm64/kernel/kgdb.c           | 17 +++--------------
 arch/arm64/kernel/probes/uprobes.c | 15 +--------------
 5 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 82a76b2102fb6..3184f5d1e3ae4 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -26,6 +26,15 @@ extern int kgdb_fault_expected;
=20
 int kgdb_brk_handler(struct pt_regs *regs, unsigned long esr);
 int kgdb_compiled_brk_handler(struct pt_regs *regs, unsigned long esr);
+#ifdef CONFIG_KGDB
+int kgdb_single_step_handler(struct pt_regs *regs, unsigned long esr);
+#else
+static inline int kgdb_single_step_handler(struct pt_regs *regs,
+	unsigned long esr)
+{
+	return DBG_HOOK_ERROR;
+}
+#endif
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/arch/arm64/include/asm/uprobes.h b/arch/arm64/include/asm/upro=
bes.h
index 3659a79a9f325..89bfb0213a500 100644
--- a/arch/arm64/include/asm/uprobes.h
+++ b/arch/arm64/include/asm/uprobes.h
@@ -29,5 +29,14 @@ struct arch_uprobe {
 };
=20
 int uprobe_brk_handler(struct pt_regs *regs, unsigned long esr);
+#ifdef CONFIG_UPROBES
+int uprobe_single_step_handler(struct pt_regs *regs, unsigned long esr);
+#else
+static inline int uprobe_single_step_handler(struct pt_regs *regs,
+	unsigned long esr)
+{
+	return DBG_HOOK_ERROR;
+}
+#endif
=20
 #endif
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 5e89244803000..f929b107840de 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -200,30 +200,17 @@ void unregister_kernel_step_hook(struct step_hook *ho=
ok)
 }
=20
 /*
- * Call registered single step handlers
+ * Call single step handlers
  * There is no Syndrome info to check for determining the handler.
- * So we call all the registered handlers, until the right handler is
- * found which returns zero.
+ * However, there is only one possible handler for user and kernel modes, =
so
+ * check and call the appropriate one.
  */
 static int call_step_hook(struct pt_regs *regs, unsigned long esr)
 {
-	struct step_hook *hook;
-	struct list_head *list;
-	int retval =3D DBG_HOOK_ERROR;
+	if (user_mode(regs))
+		return uprobe_single_step_handler(regs, esr);
=20
-	list =3D user_mode(regs) ? &user_step_hook : &kernel_step_hook;
-
-	/*
-	 * Since single-step exception disables interrupt, this function is
-	 * entirely not preemptible, and we can use rcu list safely here.
-	 */
-	list_for_each_entry_rcu(hook, list, node)	{
-		retval =3D hook->fn(regs, esr);
-		if (retval =3D=3D DBG_HOOK_HANDLED)
-			break;
-	}
-
-	return retval;
+	return kgdb_single_step_handler(regs, esr);
 }
 NOKPROBE_SYMBOL(call_step_hook);
=20
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index e3c9e6e11a318..f8eaf6084c3d5 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -250,7 +250,7 @@ int kgdb_compiled_brk_handler(struct pt_regs *regs, uns=
igned long esr)
 }
 NOKPROBE_SYMBOL(kgdb_compiled_brk_handler);
=20
-static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned long esr)
+int kgdb_single_step_handler(struct pt_regs *regs, unsigned long esr)
 {
 	if (!kgdb_single_step)
 		return DBG_HOOK_ERROR;
@@ -258,11 +258,7 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsi=
gned long esr)
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 	return DBG_HOOK_HANDLED;
 }
-NOKPROBE_SYMBOL(kgdb_step_brk_fn);
-
-static struct step_hook kgdb_step_hook =3D {
-	.fn		=3D kgdb_step_brk_fn
-};
+NOKPROBE_SYMBOL(kgdb_single_step_handler);
=20
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 {
@@ -301,13 +297,7 @@ static struct notifier_block kgdb_notifier =3D {
  */
 int kgdb_arch_init(void)
 {
-	int ret =3D register_die_notifier(&kgdb_notifier);
-
-	if (ret !=3D 0)
-		return ret;
-
-	register_kernel_step_hook(&kgdb_step_hook);
-	return 0;
+	return register_die_notifier(&kgdb_notifier);
 }
=20
 /*
@@ -317,7 +307,6 @@ int kgdb_arch_init(void)
  */
 void kgdb_arch_exit(void)
 {
-	unregister_kernel_step_hook(&kgdb_step_hook);
 	unregister_die_notifier(&kgdb_notifier);
 }
=20
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/=
uprobes.c
index fc1bd19c827e6..6ae4396577d4a 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -174,7 +174,7 @@ int uprobe_brk_handler(struct pt_regs *regs,
 	return DBG_HOOK_ERROR;
 }
=20
-static int uprobe_single_step_handler(struct pt_regs *regs,
+int uprobe_single_step_handler(struct pt_regs *regs,
 				      unsigned long esr)
 {
 	struct uprobe_task *utask =3D current->utask;
@@ -186,16 +186,3 @@ static int uprobe_single_step_handler(struct pt_regs *=
regs,
 	return DBG_HOOK_ERROR;
 }
=20
-/* uprobe single step handler hook */
-static struct step_hook uprobes_step_hook =3D {
-	.fn =3D uprobe_single_step_handler,
-};
-
-static int __init arch_init_uprobes(void)
-{
-	register_user_step_hook(&uprobes_step_hook);
-
-	return 0;
-}
-
-device_initcall(arch_init_uprobes);
--=20
2.53.0


