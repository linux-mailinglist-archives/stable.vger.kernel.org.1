Return-Path: <stable+bounces-245280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHh9AZUCAmrknAEAu9opvQ
	(envelope-from <stable+bounces-245280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:23:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDFC5120B1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0119F3006836
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0F426D24;
	Mon, 11 May 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpOyive6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F52425CCB
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516626; cv=none; b=ulgqbkPtHFefTlb5/7hY3f34ID0rMKo1ceJlktqXDkJtXlDAF2P92kW5j5KM/Od8T03YuPnJFhFYR//eakFLmG/NkqTEiD0buiTXHt+dBi2oy6wdNzHo/SJd0Z08OpS1leEPQwQ5ytUA8MmCW9nMAHUc+fjJGXGvUm163Vvn1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516626; c=relaxed/simple;
	bh=tmV04ccJo2DqqDuy1wjVgxDVRO2nJ8uxajOLgt7HkKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX9nA6t3/2Aq0dVcA54zrIOoN34Az5tNKNFmOo2X/+LIskL8vRVqh68TpmX4l1F8c5Wet43snVxkj9Edd6PN80udepXy6JfI4XNFCMMqq9gYGW87oCBeCvrQSrCNiqHl93lQvi30AcgZVm8awHi6/wl8aEBfOSTTWs6jEe8DGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpOyive6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so41357355e9.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516623; x=1779121423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEYbbGCLAz3hBtT/j8MAIFp8PMD5M9fLIOWA7RXEh3A=;
        b=dpOyive6W4KucdJ5DqbqBezjVeBTZDfO7LxvGZyzs76BIZ9kV9Lx6m9XSaZc8ZJu3T
         Eef/45w2auJ/lCQIsHfCf1HzjJTpPITyusZQ9ce/f1Lbsqz+j63lDclfZffOkWkq1vzw
         1o8roKZDv2WBmAS2HM8R8a64Mp9ZS0ydxyPRLsp9MuCRZQHnCmw9yTw0RQSbmdx22glU
         GeacUtqeXPAI3mNxBO4FnF1E2vCq/R0Uru4kubNXGcPp7oyVMs1yB6zNgP0b9dndSNoA
         HkrFPLerYLz9nUFdi3n5j1+AU8ccEGgnrxjfjfi2nftm0Oyc+ZuoKvDE60aSx+PP2myV
         x0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516623; x=1779121423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEYbbGCLAz3hBtT/j8MAIFp8PMD5M9fLIOWA7RXEh3A=;
        b=m417oI/uhL29sN8sqjHFF+sCGYtrrzR6S2IQBycR+YTrd2gyLbSBUi923zyyvPmjs1
         ghQs1jZLxTfneT2a9yrd8vLSmg9/IYfdqY6cbxkwOdRmG4afUjVCm9yK6Ob9pRBVJyJ6
         wdFqIfRzClpxuPkuqThTQuH0dii4YVrscuZ5hFuou1/HZudGckZ7FUYcTakmWvfVb7d6
         2IFi3lzAcRVpAI3xlrhFJWZOQbJafiAG3KSw6eFPwDMYrUsOoClNOjrnyYVltmpjSCGL
         hb+zBBgXiCBu/zrwGp5zHrAyGVDOpBgraFwlAUtM4A1qkoIyxtVbCULoBBB1EHU1PQTK
         CpVQ==
X-Gm-Message-State: AOJu0YziOVCsBRma4n0YGd/muBU/7zdmYIo14rtcQve8+5nZw13T6p+b
	M0uE403awqmXbRN+FouXUSFrU80Qw2F5f5pZ+c0AyuVmY5taU4EKqeq7Pik/ym9y
X-Gm-Gg: Acq92OEtDBkv6x/+d24sdIQvcp7XRCW4RQkmXxjZzhweIb3/hneZsxTOSG9TZjS+mdC
	ixPgvC0vnZxFATpjrtsRBfJS3x3SoZ8p/qFOhf9T4sCEb56Xm4+YEN5pTimhQfkZGOGiA5bb8S2
	IfnfTv+I9C1XY+oZU6myaAWEIkjdnmT4QknoczE2ia4of5be7+FdHlE3iBQjtE2Rn+agh3kF4CV
	o2RvgHoFWGZId/BR73ogM7uP/IRSZkwKJZixreQN2j9tF8HVQmr8Ui8Q55XaAnz/EPPzoURtewB
	ehjVqAPB5iHiIFIJR3MAPkhLKbrd/3q+bWh3ieQPhAIYgF5G6fu7pQaBS9le9QECvXMroCd2iYB
	LmbtILZAjoMDZbvoCtYJraG0fpXQywgeVcUBBs9k9KetS71YOOenoKqIl0uZSRQwOZlVcJhIVI0
	qaZjL+GpNvcaw8jd8jpAHUdhebS6IKKfjlMZq6dOYSllLy/1j4Ko1mDsnCqSuY93rj/gIchM2H9
	cERnzZRArofC85U4O84pi1zpb/2mfKCs/uDfkcxTTuuqvazvKmfpIJ9pYhYqyByjk9ZJJ12JV1q
	6GlfVUekn09kcEUEVieJT9ITuKSmnC7QyTCOfszr8Zg=
X-Received: by 2002:a05:600c:4a25:b0:48a:768b:eea9 with SMTP id 5b1f17b1804b1-48e51e09797mr225302465e9.4.1778516622802;
        Mon, 11 May 2026 09:23:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e957asm196002185e9.6.2026.05.11.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:23:42 -0700 (PDT)
Date: Mon, 11 May 2026 18:23:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 02/10] selftests/bpf: add stack access precision test
Message-ID: <36f60faaac96f64772628545f1186bce0b75f53f.1778516196.git.paul.chaignon@gmail.com>
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
X-Rspamd-Queue-Id: 9BDFC5120B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245280-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 876301881c436bf38e83a2c0d276a24b642e4aab ]

Add a new selftests that validates precision tracking for stack access
instruction, using both r10-based and non-r10-based accesses. For
non-r10 ones we also make sure to have non-zero var_off to validate that
final stack offset is tracked properly in instruction history
information inside verifier.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/verifier_subprog_precision.c    | 64 +++++++++++++++++--
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 7c159b561862..4b8b0f45d17d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -593,14 +593,68 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
 	);
 }
 
-__naked __noinline __used
-static __u64 subprog_with_checkpoint(void)
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("17: (0f) r1 += r0")
+__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r0 stack= before 16: (bf) r1 = r7")
+__msg("mark_precise: frame0: regs=r0 stack= before 15: (27) r0 *= 4")
+__msg("mark_precise: frame0: regs=r0 stack= before 14: (79) r0 = *(u64 *)(r10 -16)")
+__msg("mark_precise: frame0: regs= stack=-16 before 13: (7b) *(u64 *)(r7 -8) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 12: (79) r0 = *(u64 *)(r8 +16)")
+__msg("mark_precise: frame0: regs= stack=-16 before 11: (7b) *(u64 *)(r8 +16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 10: (79) r0 = *(u64 *)(r7 -8)")
+__msg("mark_precise: frame0: regs= stack=-16 before 9: (7b) *(u64 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 8: (07) r8 += -32")
+__msg("mark_precise: frame0: regs=r0 stack= before 7: (bf) r8 = r10")
+__msg("mark_precise: frame0: regs=r0 stack= before 6: (07) r7 += -8")
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r7 = r10")
+__msg("mark_precise: frame0: regs=r0 stack= before 21: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 20: (bf) r0 = r1")
+__msg("mark_precise: frame1: regs=r1 stack= before 4: (85) call pc+15")
+__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+__naked int stack_slot_aliases_precision(void)
 {
 	asm volatile (
-		"r0 = 0;"
-		/* guaranteed checkpoint if BPF_F_TEST_STATE_FREQ is used */
-		"goto +0;"
+		"r6 = 1;"
+		/* pass r6 through r1 into subprog to get it back as r0;
+		 * this whole chain will have to be marked as precise later
+		 */
+		"r1 = r6;"
+		"call identity_subprog;"
+		/* let's setup two registers that are aliased to r10 */
+		"r7 = r10;"
+		"r7 += -8;"			/* r7 = r10 - 8 */
+		"r8 = r10;"
+		"r8 += -32;"			/* r8 = r10 - 32 */
+		/* now spill subprog's return value (a r6 -> r1 -> r0 chain)
+		 * a few times through different stack pointer regs, making
+		 * sure to use r10, r7, and r8 both in LDX and STX insns, and
+		 * *importantly* also using a combination of const var_off and
+		 * insn->off to validate that we record final stack slot
+		 * correctly, instead of relying on just insn->off derivation,
+		 * which is only valid for r10-based stack offset
+		 */
+		"*(u64 *)(r10 - 16) = r0;"
+		"r0 = *(u64 *)(r7 - 8);"	/* r7 - 8 == r10 - 16 */
+		"*(u64 *)(r8 + 16) = r0;"	/* r8 + 16 = r10 - 16 */
+		"r0 = *(u64 *)(r8 + 16);"
+		"*(u64 *)(r7 - 8) = r0;"
+		"r0 = *(u64 *)(r10 - 16);"
+		/* get ready to use r0 as an index into array to force precision */
+		"r0 *= 4;"
+		"r1 = %[vals];"
+		/* here r0->r1->r6 chain is forced to be precise and has to be
+		 * propagated back to the beginning, including through the
+		 * subprog call and all the stack spills and loads
+		 */
+		"r1 += r0;"
+		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
+		:
+		: __imm_ptr(vals)
+		: __clobber_common, "r6"
 	);
 }
 
-- 
2.43.0


