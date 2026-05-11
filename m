Return-Path: <stable+bounces-245289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFboDBwFAmo3nQEAu9opvQ
	(envelope-from <stable+bounces-245289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DF512444
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4DA5313D8CE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853D32E137;
	Mon, 11 May 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P51GjgwP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0742E01D
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516726; cv=none; b=p2cjy8mqF9TlhCyRCBZSXeFQmZS3+4c1tfn4gwGPbSWL/DQadPkrNWTNOkyHfhN+GEq5SsxO2rm3PHITZtl9o3t4jTBInbEipdUkLrdPWWW4hoNboW5Tpo3vVRWYUw2YfZYidl5W2JZMNLleF0xG/YX0ltgwxL0P8KVIDEXKMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516726; c=relaxed/simple;
	bh=ix6bslacwyFxuDsfeOLp+H1n70dKwXifoM/Ad6BjX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq+5g3BqvRxoqiVEoP7FXzYAp71hoT8hgpTvPBJ4vVT1VUtjmWOu3lWcXFYbJoEVnv1NMlb25a6AHyZzW8jIVoosB5qde1WW+Udia88aRJRZtOWFSgd9jrzqrzVA4V8VcMPBish5tQuf9CHtLT6KTgvLGHWtUMykgZGXYJupP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P51GjgwP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so40490875e9.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516723; x=1779121523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uIY2lHZMyHMVtKgzkGvRbez6iZmhJA9qXlOFFYL4pA=;
        b=P51GjgwP3iBXUjjnc8f9VZtuRzuhPVkITL+/hzrF0z5Og5YFYbXBQmCSHco1UyEjlg
         2t9I/CZUUBhRlssNZyfpNHlui9pXJiHS/DSDfS8lRelMhMYoYIEEL4r8Ce+FulZ6Othd
         IZv/S/fFbMmsJU3WuIb4eH16/KnhDPJyyyAlYBT0DuBGrF8WTUcZrTWaMhbYBVCf6BEk
         ILWYfa9lBzXKTlYI/LN7agrLxII+GnSjsiUUpCtnDeG6D+y8bEhcuOtpa5+x5msPcHVt
         rQr1pQyCgIzheCyZWfRtBItau582tRRZQ3PffXA0hzdfFjXnKW33P14gJavJvED/kF3R
         0dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516723; x=1779121523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uIY2lHZMyHMVtKgzkGvRbez6iZmhJA9qXlOFFYL4pA=;
        b=VQ04lVnwTzQoaUi0ivKs653VfBjeVcP+nfyKJFmyltEpm/L2NsxGr2QEPq1cixXwuu
         29/hrt2/Mmbz6T/o/6HT9tAUSFO/33YiO0jFRCoe5u9IVn2nE7l1uXe5mGfeBZq1uCsi
         MA+DLOqgN3uYvfcfvIwioZsdJIRc4+WYcensS4WtEJNFkPyFEiI5TXv/XTybQ3uoK6H8
         UDMFjSIbCQPYVr/RgpQ9+Tm7pPI50ienqEyeiE+Um28/G/JyLdiUXFour3JRk+y64Ypy
         jwu2ORCpC+j0GzWO1KGxOaaYz24dLPJlD5knC+lhac05KPAk170ULV+v6R7VJ4h7TtaS
         yaKg==
X-Gm-Message-State: AOJu0YwDBTwNUbgKaXeEOvKsHxRgW+/1ssWkj6OwRD9m02+zg/GFL2BU
	G0fMI3vcPtUSU4gtgBsMljQqqdYKj0f3tF9Cp9MtUstlidbhxei/6RgJkb9KIiEB
X-Gm-Gg: Acq92OE2THA7pNFMUmU9XIthtdfvwK77eDK0F3xfcenfjOH2ahECZwnghtxT1Sxhf4+
	0/ApaWULEgewlIFVGk1+ZpofNICa/F8ROJ8z3o6TLY6n1eLifuSm5AuoVrB5dFuovUjJ4wWoGKZ
	+noVlPxSdbBvNbOkL2rXUjh4aSWOL1elB6122KXqVlc7P7nJWiupobbR/h2514tdWplzfbBW1A/
	YtK8k9lC11zsiJ37hhPxQPtogFW0cKYynW6kS/7bcyXqDr1MJSoW4fCH/JHukHh9OWn7Igc7Kqm
	2tqG1s3Kiicg+l5/qysOVXNgQAG87aCNv2GJUAEDeHJqT6rQbwLIBjl3+H+LO1rRMWQpV7+B4FX
	+UCDrdSjk1HkPM/4HT2VclBq55EKD967/aDVK4bB9rx/g4uPHMOTqX0Upj765rI+yIOEQ0Tz9cY
	G/eFD0buEL++evs+HfCLW9euOl3xgPmfZejifFJksG9Rg7TJhsjsjcIcq9Fm55XgG+ngQufknlY
	U4JT5xjD47w+JNi8vquT3PmsPwii6m1gAwKBcs2PESJ4ChYqueKLV4n1uQX3Q+x3Obu+I/o08Av
	6hzG88k/KpxLRx/xLksfTxk0oqjCXLUuJvJYru8MoQY=
X-Received: by 2002:a05:600c:1d18:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e51f46dcfmr369424245e9.28.1778516722465;
        Mon, 11 May 2026 09:25:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e63bd88sm38435e9.11.2026.05.11.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:25:21 -0700 (PDT)
Date: Mon, 11 May 2026 18:25:19 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 10/10] selftests/bpf: validate fake register spill/fill
 precision backtracking logic
Message-ID: <0080e53518258c17dd2ac013381958176fb545f0.1778516196.git.paul.chaignon@gmail.com>
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
X-Rspamd-Queue-Id: 7D2DF512444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245289-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 7d8ed51bcb32716a40d71043fcd01c4118858c51 ]

Add two tests validating that verifier's precision backtracking logic
handles BPF_ST_MEM instructions that produce fake register spill into
register slot. This is happening when non-zero constant is written
directly to a slot, e.g., *(u64 *)(r10 -8) = 123.

Add both full 64-bit register spill, as well as 32-bit "sub-spill".

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231209010958.66758-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Note: Adapted the expected log format for the selftests because it
  changed later on in commits 67d43dfbb42d, 0c95c9fdb696, and
  1db747d75b1d. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index df4920da3472..1f71f596d33f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -577,4 +577,158 @@ __naked void partial_stack_load_preserves_zeros(void)
 	: __clobber_common);
 }
 
+char two_byte_buf[2] SEC(".data.two_byte_buf");
+
+SEC("raw_tp")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__success
+/* make sure fp-8 is IMPRECISE fake register spill */
+__msg("3: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1")
+/* and fp-16 is spilled IMPRECISE const reg */
+__msg("5: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16_w=1")
+/* validate load from fp-8, which was initialized using BPF_ST_MEM */
+__msg("8: (79) r2 = *(u64 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=1")
+__msg("9: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 8: (79) r2 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
+/* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx(off=0,imm=0) R6_r=map_value(off=0,ks=4,vs=2,imm=0) R10=fp0 fp-8_rw=P1 fp-16_w=1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
+__msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
+__msg("mark_precise: frame0: regs= stack=-8 before 3: (7a) *(u64 *)(r10 -8) = 1")
+__msg("10: R1_w=map_value(off=1,ks=4,vs=2,imm=0) R2_w=1")
+/* validate load from fp-16, which was initialized using BPF_STX_MEM */
+__msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=1")
+__msg("13: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 12: (79) r2 = *(u64 *)(r10 -16)")
+__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 8: (79) r2 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
+/* now both fp-8 and fp-16 are precise, very good */
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx(off=0,imm=0) R6_r=map_value(off=0,ks=4,vs=2,imm=0) R10=fp0 fp-8_rw=P1 fp-16_rw=P1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
+__msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
+__msg("14: R1_w=map_value(off=1,ks=4,vs=2,imm=0) R2_w=1")
+__naked void stack_load_preserves_const_precision(void)
+{
+	asm volatile (
+		/* establish checkpoint with state that has no stack slots;
+		 * if we bubble up to this state without finding desired stack
+		 * slot, then it's a bug and should be caught
+		 */
+		"goto +0;"
+
+		/* fp-8 is const 1 *fake* register */
+		".8byte %[fp8_st_one];" /* LLVM-18+: *(u64 *)(r10 -8) = 1; */
+
+		/* fp-16 is const 1 register */
+		"r0 = 1;"
+		"*(u64 *)(r10 -16) = r0;"
+
+		/* force checkpoint to check precision marks preserved in parent states */
+		"goto +0;"
+
+		/* load single U64 from aligned FAKE_REG=1 slot */
+		"r1 = %[two_byte_buf];"
+		"r2 = *(u64 *)(r10 -8);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U64 from aligned REG=1 slot */
+		"r1 = %[two_byte_buf];"
+		"r2 = *(u64 *)(r10 -16);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		"r0 = 0;"
+		"exit;"
+	:
+	: __imm_ptr(two_byte_buf),
+	  __imm_insn(fp8_st_one, BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 1))
+	: __clobber_common);
+}
+
+SEC("raw_tp")
+__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__success
+/* make sure fp-8 is 32-bit FAKE subregister spill */
+__msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=1")
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0_w=1 R10=fp0 fp-16=1")
+/* validate load from fp-8, which was initialized using BPF_ST_MEM */
+__msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2_w=1 R10=fp0 fp-8=1")
+__msg("9: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R0_w=1 R1=ctx(off=0,imm=0) R6_r=map_value(off=0,ks=4,vs=2,imm=0) R10=fp0 fp-8_r=P1 fp-16=1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
+__msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
+__msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
+__msg("10: R1_w=map_value(off=1,ks=4,vs=2,imm=0) R2_w=1")
+/* validate load from fp-16, which was initialized using BPF_STX_MEM */
+__msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2_w=1 R10=fp0 fp-16=1")
+__msg("13: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 12: (61) r2 = *(u32 *)(r10 -16)")
+__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R0_w=1 R1=ctx(off=0,imm=0) R6_r=map_value(off=0,ks=4,vs=2,imm=0) R10=fp0 fp-8_r=P1 fp-16_r=P1")
+__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
+__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
+__msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
+__msg("14: R1_w=map_value(off=1,ks=4,vs=2,imm=0) R2_w=1")
+__naked void stack_load_preserves_const_precision_subreg(void)
+{
+	asm volatile (
+		/* establish checkpoint with state that has no stack slots;
+		 * if we bubble up to this state without finding desired stack
+		 * slot, then it's a bug and should be caught
+		 */
+		"goto +0;"
+
+		/* fp-8 is const 1 *fake* SUB-register */
+		".8byte %[fp8_st_one];" /* LLVM-18+: *(u32 *)(r10 -8) = 1; */
+
+		/* fp-16 is const 1 SUB-register */
+		"r0 = 1;"
+		"*(u32 *)(r10 -16) = r0;"
+
+		/* force checkpoint to check precision marks preserved in parent states */
+		"goto +0;"
+
+		/* load single U32 from aligned FAKE_REG=1 slot */
+		"r1 = %[two_byte_buf];"
+		"r2 = *(u32 *)(r10 -8);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U32 from aligned REG=1 slot */
+		"r1 = %[two_byte_buf];"
+		"r2 = *(u32 *)(r10 -16);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		"r0 = 0;"
+		"exit;"
+	:
+	: __imm_ptr(two_byte_buf),
+	  __imm_insn(fp8_st_one, BPF_ST_MEM(BPF_W, BPF_REG_FP, -8, 1)) /* 32-bit spill */
+	: __clobber_common);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


