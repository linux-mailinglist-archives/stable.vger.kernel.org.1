Return-Path: <stable+bounces-234667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GJwEYek1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:55:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BD3C1F05
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C0E30315DE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5D36166F;
	Wed,  8 Apr 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nO94OMoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0827979A;
	Wed,  8 Apr 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673452; cv=none; b=pB6MdmxaRHXKUX7h9q+1ekMEJkDHeyQPVIKMMEhDrGhEY54VYfFcY6ppShhCOXXzeqcGorV0s+THkYbXIOvE/SolXDiCy0NA4dlp7SER53mVwtrAJMnacNalO9WVy/Al6yUJt/NT4fohHrtgdGeAJYCzdoGfdD+O+U2N++Usolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673452; c=relaxed/simple;
	bh=ujUtUitJ9prwfI+J/Ad8lYPLG4JoXqujVXoArB8DEho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfhixkfzFut98mC45cOMZSldUUNYpw5yVXueaHkQFS7rINRWNGx26Rc5PDfGDEVCc6jIHAYFKfc2mem61xfwrt3AFMj/nOPOX9nM6f0uGXD/uebLcSUxNu8/eDFYmyfKjaJNHfAOEjvQwo5jNU4HdK+3qSaS9Df0YkYtTfsh0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nO94OMoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B55FC2BC87;
	Wed,  8 Apr 2026 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673451;
	bh=ujUtUitJ9prwfI+J/Ad8lYPLG4JoXqujVXoArB8DEho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO94OMoBwfLAdeHvvnyjkoCZToNOsmO0TZDyJMwu36BsPIlwWSfRZZFFbdS+jyyqe
	 hR5xgtZTJJTd/fXqnnkUfifpabFpGN1nEO+hAjKHxuYp4WWUo44Midk7D2+KrP9eDg
	 8+dYPYHL5beouFcoWhmTobqHvUIYO8QPpI7ZA0HQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Changwoo Min <changwoo@igalia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.18 237/277] sched_ext: Fix is_bpf_migration_disabled() false negative on non-PREEMPT_RCU
Date: Wed,  8 Apr 2026 20:03:42 +0200
Message-ID: <20260408175942.707235386@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234667-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,igalia.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: B85BD3C1F05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changwoo Min <changwoo@igalia.com>

commit 0c4a59df370bea245695c00aaae6ae75747139bd upstream.

Since commit 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
trampoline.c"), the BPF prolog (__bpf_prog_enter) calls migrate_disable()
only when CONFIG_PREEMPT_RCU is enabled, via rcu_read_lock_dont_migrate().
Without CONFIG_PREEMPT_RCU, the prolog never touches migration_disabled,
so migration_disabled == 1 always means the task is truly
migration-disabled regardless of whether it is the current task.

The old unconditional p == current check was a false negative in this
case, potentially allowing a migration-disabled task to be dispatched to
a remote CPU and triggering scx_error in task_can_run_on_remote_rq().

Only apply the p == current disambiguation when CONFIG_PREEMPT_RCU is
enabled, where the ambiguity with the BPF prolog still exists.

Fixes: 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for trampoline.c")
Cc: stable@vger.kernel.org # v6.18+
Link: https://lore.kernel.org/lkml/20250821090609.42508-8-dongml2@chinatelecom.cn/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext_idle.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -861,25 +861,32 @@ static bool check_builtin_idle_enabled(s
  * code.
  *
  * We can't simply check whether @p->migration_disabled is set in a
- * sched_ext callback, because migration is always disabled for the current
- * task while running BPF code.
+ * sched_ext callback, because the BPF prolog (__bpf_prog_enter) may disable
+ * migration for the current task while running BPF code.
  *
- * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
- * disable and re-enable migration. For this reason, the current task
- * inside a sched_ext callback is always a migration-disabled task.
+ * Since the BPF prolog calls migrate_disable() only when CONFIG_PREEMPT_RCU
+ * is enabled (via rcu_read_lock_dont_migrate()), migration_disabled == 1 for
+ * the current task is ambiguous only in that case: it could be from the BPF
+ * prolog rather than a real migrate_disable() call.
  *
- * Therefore, when @p->migration_disabled == 1, check whether @p is the
- * current task or not: if it is, then migration was not disabled before
- * entering the callback, otherwise migration was disabled.
+ * Without CONFIG_PREEMPT_RCU, the BPF prolog never calls migrate_disable(),
+ * so migration_disabled == 1 always means the task is truly
+ * migration-disabled.
+ *
+ * Therefore, when migration_disabled == 1 and CONFIG_PREEMPT_RCU is enabled,
+ * check whether @p is the current task or not: if it is, then migration was
+ * not disabled before entering the callback, otherwise migration was disabled.
  *
  * Returns true if @p is migration-disabled, false otherwise.
  */
 static bool is_bpf_migration_disabled(const struct task_struct *p)
 {
-	if (p->migration_disabled == 1)
-		return p != current;
-	else
-		return p->migration_disabled;
+	if (p->migration_disabled == 1) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+			return p != current;
+		return true;
+	}
+	return p->migration_disabled;
 }
 
 static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,



