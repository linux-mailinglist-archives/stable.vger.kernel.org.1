Return-Path: <stable+bounces-245281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGctC4UKAmrTnQEAu9opvQ
	(envelope-from <stable+bounces-245281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:57:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98075512CC9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFF443285BF7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBD426EDA;
	Mon, 11 May 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0mfk98R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C57426EA3
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516636; cv=none; b=tdOjQSae0MiRQo8C4vnEYPkJYXBHwLpDVrIof3qEfrz8Nak1qt5ZbP+39XbixM+TCFKQD0VqjUxKyEv/vlBTrrPilO1iX9kdOhCZD7lGDH1e/H9Uwk9JwjJBwkqXMoDrx4jkjAY5SwgczVbF6V5LGOQxVqILBT3IODNcdGcpZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516636; c=relaxed/simple;
	bh=Mw/in4YlkcHa5kw2NjojUEm/rRF3EIdOlkZ9xOsDw8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6CqS5INxNNZwPUJ5QYbd0R6XEYt1BGWlCAVY0yj+xrUtQuLNHgdOsjKUH4bazV/ppRKKKVRfEDZpojD4HcM3jP5eW2PMjWbOsnD+8QSgQSL+GmMDI3+8VRmswfpdvvm2oQlbhVm1Acb4KhFUJthTN7XG/jLYmAsXEj3LxChY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0mfk98R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so56373365e9.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516633; x=1779121433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMpX26rF/Gxlv1NluO7gBhLdEAiljxcRXiQrjd/Hh8Y=;
        b=G0mfk98ReUGUQvjDBmTVm+jhQWdebT8hZMddIvObGP0q681kQ2bSTtdQxkOsYIiqQu
         An1lt/nqu8ste0fATwnxpWekA/UIYu3ltTisIxk57WH+pWA2yMsYlOH5cf+TmLa2kV4I
         QIcH1xUKi/fgyjLJdZninYSLTUYGZMcNNAFaFypJClke1wQD/GFa9yygKkI8ChqY1sVy
         775a6ws6cBI4wifiZT7VqikF/o4bys40ZXWiWvr5qU1Yw4enjq6NEL+Rf4/bzijUlZ6n
         M5H+GKbuAFHpoNH37CYCfWgaq+r11vgt5acLp6JXBN18K7Bch/AOe+BoEh0RBwUIBknA
         6CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516633; x=1779121433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMpX26rF/Gxlv1NluO7gBhLdEAiljxcRXiQrjd/Hh8Y=;
        b=ok7t3U5GoI39wex59XSVtbaOBiPJVNk7Enu4w7hGBihOw1yeGQjAFIkiARISZwfu+M
         1jhhaZckwPg9Q3pbyMiAvMFFsm1HbBlBJCCHrgXh8ejHT1sskh0FeEnGzCvLfJentcjc
         lHYnmFoNYkw7UJo5wIaBa2e29pMVPeheDJg+9GsJZB8l6cmpPvKUOcU8z2dx0HELuX+k
         s6yNMz+ygi3um5ohJSYkULkd7xSr5Kfi7rM5urbHKpXZy/6p/sY2wMdWtKkAVy7dU8hX
         38QjdHj4XgwPovaqhRcuQ3ldR7Mx8A89Dqy0j2NmRX2FZix+FZElCK0E2Y3Pnyy7PBxp
         +uZw==
X-Gm-Message-State: AOJu0YywgYdlO+DlIAlN8o7xdF3gnK+qCsqw5F1+okj8HiXIMNX8o8So
	D+3DFXlpU9kIEUFQk1jHt6H4gceD3v7cWYuN3S2xoWpf5Q280UxwpwRwhoL+u7pr
X-Gm-Gg: Acq92OG686y+KHQH370t/m+QCmDKPDf59mFBu2l8S6JYz66/qSRzBQVbtIRyodbM976
	5cQsPdIVF7DJxZSUO71faeq7vphmGwqC8OImR4Bf2v5AWZHD/GYpK8GSVCI3SWm3iVIZxS4pPSb
	iwIiKyRQdhqrX2UKBxXoJQ2Q5XJnIDHLpP1bFgmf2o7usd8Z9jewFdHkRKomFzaci472+3T15EB
	0iQJRhaEEtyLQAcVdbuUoUPZb+f6itJX5Prku78MkaMsuEdXT3iJvXePlA1PztH1DIypuUKlsvT
	iWKynfC2JqrjP10BLDb9zb5R6ch8V6Pi/Kq0GdNYnVmAqszBbNDv7BmccXcmFRf0sCdw6AW23EL
	7XKSQSzD7a+qcxUB97FrJmyHBEqPaKwlpvPGyYoy0FDF4EiHv1nrLNQwDaclpsARlikI9XRg+3I
	deuNxtKknBV12dcuaA32gYeRFAhifja74W/3i88QHB6JwHeD7tuSyVjLz3kx4r9CxNGxzlggpeq
	o8xbVN2zVOtrUasdrS338KIZUaWBMbhetJVo9qrg7XjjdNzBQ7n8s3LF1Yh+P/KfoBSPxHbR/ML
	mqacw/xyAeclUcrwl5YyWBj+6O/ZlP2AJNIqyB0Zu3k=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr392246505e9.17.1778516633103;
        Mon, 11 May 2026 09:23:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e0bf2sm341157585e9.4.2026.05.11.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:23:52 -0700 (PDT)
Date: Mon, 11 May 2026 18:23:50 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 03/10] bpf: preserve STACK_ZERO slots on partial reg
 spills
Message-ID: <a10acc9737aadeaa848f5cc3d167798f590b6ae3.1778516196.git.paul.chaignon@gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
X-Rspamd-Queue-Id: 98075512CC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245281-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e44da369dff6..8309504d1660 100644
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
2.43.0


