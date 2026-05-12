Return-Path: <stable+bounces-246139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK5RAFJsA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FA526CB8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC8DB30A6FAD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBD3BB135;
	Tue, 12 May 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tayMtano"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D13EDE55;
	Tue, 12 May 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608458; cv=none; b=EgffLTfbS4LO6DqT8fkWx8LAs94ZtSlZ9en5bv2HNzPI1M0z4+1A0MwCnawsfIkTKi3jvc7rF9KFGdCwb0h8tzJa4CjM1gp9UNxx0hnSxpaf3VxRsqRURTlyQKSJdfXLOUZQsd352SvM9N+/Mobo8zEZUQVRDnXVf3vQsGfPkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608458; c=relaxed/simple;
	bh=9+IijUFgcAI1WKHWO05FnHyqNzck6LlLsFiszreB5D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA8LX5P9LH5ae1eBOnes3cyMnLTMZ3/QuPyvob0qU7HMFa7j+NzYd9Dd8vBJaqUTJycfUcpsohGXgvjbyRXGh2At7l5tZ1p8kJHmWMRadRfgo5nLqKsnVK/h5xowP9lpwgUNAzJ0iLz9I/cxfm3rZmybxxLl9KrKVB/asVwkzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tayMtano; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43773C2BCB0;
	Tue, 12 May 2026 17:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608458;
	bh=9+IijUFgcAI1WKHWO05FnHyqNzck6LlLsFiszreB5D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tayMtanoDIKpMDYbT0nDGzK3wK0prvwUUmL35GBM4/w//tWAOEymLVXVzD1wU6m29
	 gBb6gxB/gD6fxETiO6ZmbxgcJRRiFjquyLS78s4ZsdA1G5CPGc8mvlMTJOT0XcVlM4
	 24RLWHSiLBKX5EHCk1zcuv46DS7rgjxeG+n5CbEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.18 088/270] arm64: signal: Preserve POR_EL0 if poe_context is missing
Date: Tue, 12 May 2026 19:38:09 +0200
Message-ID: <20260512173940.313323589@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 656FA526CB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246139-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,arm.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Brodsky <kevin.brodsky@arm.com>

commit 030e8a40fff65ca6ac1c04a4d3c08afe72438922 upstream.

Commit 2e8a1acea859 ("arm64: signal: Improve POR_EL0 handling to
avoid uaccess failures") delayed the write to POR_EL0 in
rt_sigreturn to avoid spurious uaccess failures. This change however
relies on the poe_context frame record being present: on a system
supporting POE, calling sigreturn without a poe_context record now
results in writing arbitrary data from the kernel stack into POR_EL0.

Fix this by adding a __valid_fields member to struct
user_access_state, and zeroing the struct on allocation.
restore_poe_context() then indicates that the por_el0 field is valid
by setting the corresponding bit in __valid_fields, and
restore_user_access_state() only touches POR_EL0 if there is a valid
value to set it to. This is in line with how POR_EL0 was originally
handled; all frame records are currently optional, except
fpsimd_context.

To ensure that __valid_fields is kept in sync, fields (currently
just por_el0) are now accessed via accessors and prefixed with __ to
discourage direct access.

Fixes: 2e8a1acea859 ("arm64: signal: Improve POR_EL0 handling to avoid uaccess failures")
Cc: <stable@vger.kernel.org>
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/signal.c |   54 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -67,6 +67,9 @@ struct rt_sigframe_user_layout {
 	unsigned long end_offset;
 };
 
+#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
+#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+
 /*
  * Holds any EL0-controlled state that influences unprivileged memory accesses.
  * This includes both accesses done in userspace and uaccess done in the kernel.
@@ -74,13 +77,35 @@ struct rt_sigframe_user_layout {
  * This state needs to be carefully managed to ensure that it doesn't cause
  * uaccess to fail when setting up the signal frame, and the signal handler
  * itself also expects a well-defined state when entered.
+ *
+ * The struct should be zero-initialised. Its members should only be accessed
+ * via the accessors below. __valid_fields tracks which of the fields are valid
+ * (have been set to some value).
  */
 struct user_access_state {
-	u64 por_el0;
+	unsigned int __valid_fields;
+	u64 __por_el0;
 };
 
-#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
-#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+#define UA_STATE_HAS_POR_EL0	BIT(0)
+
+static void set_ua_state_por_el0(struct user_access_state *ua_state,
+				 u64 por_el0)
+{
+	ua_state->__por_el0 = por_el0;
+	ua_state->__valid_fields |= UA_STATE_HAS_POR_EL0;
+}
+
+static int get_ua_state_por_el0(const struct user_access_state *ua_state,
+				u64 *por_el0)
+{
+	if (ua_state->__valid_fields & UA_STATE_HAS_POR_EL0) {
+		*por_el0 = ua_state->__por_el0;
+		return 0;
+	}
+
+	return -ENOENT;
+}
 
 /*
  * Save the user access state into ua_state and reset it to disable any
@@ -94,7 +119,7 @@ static void save_reset_user_access_state
 		for (int pkey = 0; pkey < arch_max_pkey(); pkey++)
 			por_enable_all |= POR_ELx_PERM_PREP(pkey, POE_RWX);
 
-		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
+		set_ua_state_por_el0(ua_state, read_sysreg_s(SYS_POR_EL0));
 		write_sysreg_s(por_enable_all, SYS_POR_EL0);
 		/*
 		 * No ISB required as we can tolerate spurious Overlay faults -
@@ -122,8 +147,10 @@ static void set_handler_user_access_stat
  */
 static void restore_user_access_state(const struct user_access_state *ua_state)
 {
-	if (system_supports_poe())
-		write_sysreg_s(ua_state->por_el0, SYS_POR_EL0);
+	u64 por_el0;
+
+	if (get_ua_state_por_el0(ua_state, &por_el0) == 0)
+		write_sysreg_s(por_el0, SYS_POR_EL0);
 }
 
 static void init_user_layout(struct rt_sigframe_user_layout *user)
@@ -333,11 +360,16 @@ static int restore_fpmr_context(struct u
 static int preserve_poe_context(struct poe_context __user *ctx,
 				const struct user_access_state *ua_state)
 {
-	int err = 0;
+	int err;
+	u64 por_el0;
+
+	err = get_ua_state_por_el0(ua_state, &por_el0);
+	if (WARN_ON_ONCE(err))
+		return err;
 
 	__put_user_error(POE_MAGIC, &ctx->head.magic, err);
 	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
-	__put_user_error(ua_state->por_el0, &ctx->por_el0, err);
+	__put_user_error(por_el0, &ctx->por_el0, err);
 
 	return err;
 }
@@ -353,7 +385,7 @@ static int restore_poe_context(struct us
 
 	__get_user_error(por_el0, &(user->poe->por_el0), err);
 	if (!err)
-		ua_state->por_el0 = por_el0;
+		set_ua_state_por_el0(ua_state, por_el0);
 
 	return err;
 }
@@ -1095,7 +1127,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
-	struct user_access_state ua_state;
+	struct user_access_state ua_state = {};
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1507,7 +1539,7 @@ static int setup_rt_frame(int usig, stru
 {
 	struct rt_sigframe_user_layout user;
 	struct rt_sigframe __user *frame;
-	struct user_access_state ua_state;
+	struct user_access_state ua_state = {};
 	int err = 0;
 
 	fpsimd_save_and_flush_current_state();



