Return-Path: <stable+bounces-231660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEPjKuv9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8A36DAA8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D15D30E98C8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76B402B9B;
	Tue, 31 Mar 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYO7i40/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02003F23DD;
	Tue, 31 Mar 2026 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974739; cv=none; b=dDHFmdHvP14x2l+dVnOO9q8GOOr9f8qqZVj1CxoO694ekaO58AH4ltiIPXD1EPtalKjfLOYBL50SqE0EVInLFqPH3PKJw+UOU5tmdnuVgA5MabBd7R5Pags9iNSVQ+BBzQslFkArdoEHL7VM0AiHXyYM4ZOFprut+fzjjdBglLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974739; c=relaxed/simple;
	bh=84DTGfouUY06Thgd7U1hKj+EzUDBljr+qsaZtrFYEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsaVk7cWZ0vUdzNycmR2UELMJsnwyq1o/pfBe6UZ5qLGKO10/R0jqETgAeR3lz+uJcyvjD3XErlglFMLnvTQ7sxeCfsQ/aOvnB/CZwfu91wwmaeFf8fAKJfbjgdf0aE0ObIQb1jXjRAwtFu/yvbMT4Uo1jZe4ztCJM583dECbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYO7i40/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454B4C2BCB2;
	Tue, 31 Mar 2026 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974739;
	bh=84DTGfouUY06Thgd7U1hKj+EzUDBljr+qsaZtrFYEGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYO7i40/jFPXFgl8h+n5IVcziaw2dbsgULSdirLK0b9vrMvE6CQFpXGVr6SJdb0Kc
	 7evf+D3aUbYX15Aznxpd4fCwqeGAe1fSfOxQel5s5Ch1FTzuV1GgX0bRAHGMvPfIwY
	 6tP3rPUhdYNkJUStb0uonkKbb3a+Wuzt6ZZDTqaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 018/342] bpf: Fix exception exit lock checking for subprogs
Date: Tue, 31 Mar 2026 18:17:31 +0200
Message-ID: <20260331161759.582564163@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-231660-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email]
X-Rspamd-Queue-Id: ADE8A36DAA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihor Solodrai <ihor.solodrai@linux.dev>

[ Upstream commit 6c2128505f61b504c79a20b89596feba61388112 ]

process_bpf_exit_full() passes check_lock = !curframe to
check_resource_leak(), which is false in cases when bpf_throw() is
called from a static subprog. This makes check_resource_leak() to skip
validation of active_rcu_locks, active_preempt_locks, and
active_irq_id on exception exits from subprogs.

At runtime bpf_throw() unwinds the stack via ORC without releasing any
user-acquired locks, which may cause various issues as the result.

Fix by setting check_lock = true for exception exits regardless of
curframe, since exceptions bypass all intermediate frame
cleanup. Update the error message prefix to "bpf_throw" for exception
exits to distinguish them from normal BPF_EXIT.

Fix reject_subprog_with_rcu_read_lock test which was previously
passing for the wrong reason. Test program returned directly from the
subprog call without closing the RCU section, so the error was
triggered by the unclosed RCU lock on normal exit, not by
bpf_throw. Update __msg annotations for affected tests to match the
new "bpf_throw" error prefix.

The spin_lock case is not affected because they are already checked [1]
at the call site in do_check_insn() before bpf_throw can run.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?h=v7.0-rc4#n21098

Assisted-by: Claude:claude-opus-4-6
Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20260320000809.643798-1-ihor.solodrai@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/exceptions_fail.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf721a1274799..0160c6c28af1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20319,7 +20319,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * state when it exits.
 	 */
 	int err = check_resource_leak(env, exception_exit,
-				      !env->cur_state->curframe,
+				      exception_exit || !env->cur_state->curframe,
+				      exception_exit ? "bpf_throw" :
 				      "BPF_EXIT instruction in main prog");
 	if (err)
 		return err;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 8a0fdff899271..d7f1c492e3dd3 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -8,6 +8,7 @@
 #include "bpf_experimental.h"
 
 extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
@@ -131,7 +132,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,11 +148,13 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
-	return throwing_subprog(ctx);
+	throwing_subprog(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
 }
 
 static bool rbless(struct bpf_rb_node *n1, const struct bpf_rb_node *n2)
-- 
2.51.0




