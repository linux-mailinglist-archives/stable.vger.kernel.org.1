Return-Path: <stable+bounces-235260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILA7K/am1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:05:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C53C25F0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 277BA304A175
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EFE35C1B5;
	Wed,  8 Apr 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FJ2boGJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CF3BB4A;
	Wed,  8 Apr 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674982; cv=none; b=Mi7oGfjKSWBPEP9KBvQenDKEaPu8+dStW624POhZYoC2K2l/dQTd6NllGxU4Tnbm3HFg5usMPCmZROfRyvd3wv+CH7DuRycVjE3A6e1CWck02JvLJELR1YYnmxwBMQWpNKPhiN3AnWYCG0x17uTRgVKMRdlpbqrUAQifVBDGQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674982; c=relaxed/simple;
	bh=6mLRmDQspn+DvNlOCUKVm/qxVNZR9Gre1BoRNeHwL4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJgKjvE2SB5rMq7PvKQT5z8qgX0UVre6kMGOJ6xq/84Y9VClmZ+W9+r9pBkROU5PmnhTPyP4I1dE57duR1yv9b/NvT459SNkk8TZbp6CV+p+2ZSbdRBvVoCe/0LoOqOi9baOp1QDXJRPpNrzgX1+LfjLHW/jo1HGVjFxJPc++Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FJ2boGJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9DEC19421;
	Wed,  8 Apr 2026 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674982;
	bh=6mLRmDQspn+DvNlOCUKVm/qxVNZR9Gre1BoRNeHwL4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FJ2boGJl+90OE7ReP5xIJORle4ITu4tDLDKypqs5JJEVzqf7DEtD48QdAfWYZ5ve5
	 Ia8reCLb2sgUxPXwYSrLuP67fLwgT7YY0RCDJzYnN43CvfXx1YzSK9CzPCOBNMONjk
	 jephg+sEpPTVcsqnTfsOzEUxk+zP05OpZvMaCZxo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Changwoo Min <changwoo@igalia.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.19 281/311] sched_ext: Fix is_bpf_migration_disabled() false negative on non-PREEMPT_RCU
Date: Wed,  8 Apr 2026 20:04:41 +0200
Message-ID: <20260408175949.872378234@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235260-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B75C53C25F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



