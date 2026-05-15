Return-Path: <stable+bounces-248163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA10ME5IB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:22:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6655A5531D5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64885311864C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7F3E0090;
	Fri, 15 May 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEZ/xNks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A730568A;
	Fri, 15 May 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861033; cv=none; b=fXmrKzDGHNfF01k/BYSgtiETHzsuXAy1oxCL8mr0BZurInFOZrqEutT+v98wdoA9hlVYyMBrd78vKv+JBekg4PyqRz4MWUWecR11YafsTQoAklZcj6yM6ynDOf+f/yjnLH2xBUU+3JbUU+DT95xI5hGdLe6zgRAN/iaTSh/vJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861033; c=relaxed/simple;
	bh=8ewDYznr9Mupqa+LsVao3Fkh9aJbmnv1p83cb+W9aPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMycsEDF1DX+8b524Gm0Qo5TPikPeA6QjloAdPFZ0escmm3MT60FDRr8B9JpXsU/Y667/uKK+C2MyvVlZsld28VyI9IvPZKipY3EdAJYWJtLjsFHGBXUo3lso9Csqo39v2bHkm6FJmZnnmTqMAg1txUxRhWg0xKyaUHlvGRQ0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEZ/xNks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAECC2BCB0;
	Fri, 15 May 2026 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861032;
	bh=8ewDYznr9Mupqa+LsVao3Fkh9aJbmnv1p83cb+W9aPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEZ/xNksDky0bStBX9nKz9erzMfe+yJ51YKI4J3T+lenU/FgmH5AY21jSzi3AOpWo
	 usXiGf7kL+70Dpe2OcbwnUc2YXX8tLHhs4ruCT5YjKP8KArVC5VDsAopoUGy7I5fpG
	 hSWdwkCPcZj23BOKHjh3utTgIveCiS5tTUpQ0o20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/474] bpf: preserve STACK_ZERO slots on partial reg spills
Date: Fri, 15 May 2026 17:44:43 +0200
Message-ID: <20260515154718.787746541@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6655A5531D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248163-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,suse.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit eaf18febd6ebc381aeb61543705148b3e28c7c47 ]

Instead of always forcing STACK_ZERO slots to STACK_MISC, preserve it in
situations where this is possible. E.g., when spilling register as
1/2/4-byte subslots on the stack, all the remaining bytes in the stack
slot do not automatically become unknown. If we knew they contained
zeroes, we can preserve those STACK_ZERO markers.

Add a helper mark_stack_slot_misc(), similar to scrub_spilled_slot(),
but that doesn't overwrite either STACK_INVALID nor STACK_ZERO. Note
that we need to take into account possibility of being in unprivileged
mode, in which case STACK_INVALID is forced to STACK_MISC for correctness,
as treating STACK_INVALID as equivalent STACK_MISC is only enabled in
privileged mode.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-5-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e44da369dff63..8309504d1660e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1347,6 +1347,21 @@ static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
 	       stack->spilled_ptr.type == SCALAR_VALUE;
 }
 
+/* Mark stack slot as STACK_MISC, unless it is already STACK_INVALID, in which
+ * case they are equivalent, or it's STACK_ZERO, in which case we preserve
+ * more precise STACK_ZERO.
+ * Note, in uprivileged mode leaving STACK_INVALID is wrong, so we take
+ * env->allow_ptr_leaks into account and force STACK_MISC, if necessary.
+ */
+static void mark_stack_slot_misc(struct bpf_verifier_env *env, u8 *stype)
+{
+	if (*stype == STACK_ZERO)
+		return;
+	if (env->allow_ptr_leaks && *stype == STACK_INVALID)
+		return;
+	*stype = STACK_MISC;
+}
+
 static void scrub_spilled_slot(u8 *stype)
 {
 	if (*stype != STACK_INVALID)
@@ -4577,7 +4592,8 @@ static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_
 	dst->live = live;
 }
 
-static void save_register_state(struct bpf_func_state *state,
+static void save_register_state(struct bpf_verifier_env *env,
+				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
 				int size)
 {
@@ -4592,7 +4608,7 @@ static void save_register_state(struct bpf_func_state *state,
 
 	/* size < 8 bytes spill */
 	for (; i; i--)
-		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
+		mark_stack_slot_misc(env, &state->stack[spi].slot_type[i - 1]);
 }
 
 static bool is_bpf_st_mem(struct bpf_insn *insn)
@@ -4652,7 +4668,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
-		save_register_state(state, spi, reg, size);
+		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id = 0;
@@ -4662,7 +4678,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
-		save_register_state(state, spi, &fake_reg, size);
+		save_register_state(env, state, spi, &fake_reg, size);
 		insn_flags = 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
@@ -4675,7 +4691,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			verbose(env, "cannot spill pointers to stack into stack frame of the caller\n");
 			return -EINVAL;
 		}
-		save_register_state(state, spi, reg, size);
+		save_register_state(env, state, spi, reg, size);
 	} else {
 		u8 type = STACK_MISC;
 
@@ -4942,6 +4958,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 						continue;
 					if (type == STACK_MISC)
 						continue;
+					if (type == STACK_ZERO)
+						continue;
 					if (type == STACK_INVALID && env->allow_uninit_stack)
 						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
-- 
2.53.0




