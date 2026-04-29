Return-Path: <stable+bounces-241791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O34L5xL8Wn5fgEAu9opvQ
	(envelope-from <stable+bounces-241791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:06:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793648DB4C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136EE3018D66
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F622301;
	Wed, 29 Apr 2026 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRvKsShs"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70389443
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421194; cv=none; b=aDhF7g1dIZj/KPhJoYayL1pkn/d971TaRzrLY9pZ2da1sZAEJfswyPn2S51PFM3BuX1euiNxe8dbjzab4Hrm6qi3QFO14n/LA8FlpY1MxSOLiAVApxrelNoT2IE1Pb7RN9L2JV93w1hxkkUdMHyGhj29qCldXEyGbpRXwH/tIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421194; c=relaxed/simple;
	bh=n0dBxv61kgCZiP6/pcNg8V2oL7fpjyJjwNl78oEnzwU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hr+mc0zJJrWFeZJHtEFbHCxItBYsff5kDjwCFB0qlvP+KvBTHR6Tsl8L9KKDLMzpJCnpFPrACqXhL0yUXcasvcKg6ZBzdW3Gra3IUvKxjLQeILiK2HeNIWVHffDgXu9B2GA40LeIWYNdCvmT2n7EJL+3Vk7qYYBbT0JTsCpO/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRvKsShs; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-40eee5d10c5so19929619fac.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777421190; x=1778025990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FW+L3ubugl0QdPcOsaUMl+x/158JR6QuBxGAIT9xVs=;
        b=GRvKsShsmflt7T6+Kf81aO+y6ca2i0Y4KIGWtxy30IS8A6bm3Yqbxzjrka1/P3rYBH
         tR62JUnFRbk8yCWTEcawEQV6j6nx4YsgulR80v7VuioFXLO6C+puUQAO9fhcXHvbwbfg
         +QUk1yrGK7wFqQefth5dCQ3ffVHPIH0QPN5PMsdWaOB7NThadO3FJtWtgz/uKo/PRkwQ
         eg6mRsXm9yMb+OnVevi8pQtYNnMgEPeUNWKxPij/NYzkkOBOqApjFhGuN4Nh7KqEAszu
         LS057BxN9p5g1AIbGoj3Og60z0X8NS6C0MpHkAuS+u6erAtmwLyu245eY2Keyie+uCcQ
         VB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421190; x=1778025990;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FW+L3ubugl0QdPcOsaUMl+x/158JR6QuBxGAIT9xVs=;
        b=A9CooGuYipkXkCA4L+Ek2QoWAUYs1p4GmzTe84wbi4h7Vxf/oCbonISfgva9VOl7hT
         7byQdfcz50LRizcWdEE6azqDzbAHVgHEagWDrDnZjQHvDITOixfVlJi57TvRLl6DLUPO
         VqbUiNDOrelr4jB2/8kwgvVFApEAjeUf1520jE8nuhCuMripyE4UPp29s8iT4h2RXmfE
         0RC7NPjmffiq8gdN0tyCOXY5qWeeq2b695sAXEVTrrxHkC/iez7Ejm3pLx9mHr9a4AE2
         5geaJrhEc7ngFxEUuEJ9+UmbGRTmmwAXi3+rQLeLG5O0fJBNAAf9MY5OSLivy+vVcdW0
         Rg+Q==
X-Forwarded-Encrypted: i=1; AFNElJ91WrQkglFMgE8jUBd/B+TmwKl8lvg0SCZVLVR2xewSPpNxzyZCtQPfPKCKWfQj7SjvMrRDdjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFaOoTO7AjFrsOrTcASxUIZUqK7283EdhxeSFRwiu9vplzWkvn
	0h9VWJu6EFVsVMAe5Q4WXgjSH3a6lIhvfLWotitLVBPaB4z4q09kDYlh6V9MdIcq2kh6MIt9Y25
	Th7zF0A==
X-Received: from ilut10.prod.google.com ([2002:a05:6e02:160a:b0:4fc:4c72:e6cc])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:a0b:b0:696:22dc:b4db
 with SMTP id 006d021491bc7-696684c23afmr946678eaf.41.1777421190478; Tue, 28
 Apr 2026 17:06:30 -0700 (PDT)
Date: Wed, 29 Apr 2026 00:06:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429000623.3356606-1-avagin@google.com>
Subject: [PATCH] Revert "x86/fpu: Refine and simplify the magic number check
 during signal return"
From: Andrei Vagin <avagin@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, criu@lists.linux.dev, x86@kernel.org, 
	Andrei Vagin <avagin@google.com>, "Chang S. Bae" <chang.seok.bae@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2793648DB4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241791-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

This reverts commit dc8aa31a7ac2 ("x86/fpu: Refine and simplify the
magic number check during signal return").

The reverted commit broke applications that construct signal frames in
userspace (such as CRIU and gVisor) if the frame's xstate size is
smaller than the kernel's fpstate->user_size.

Furthermore, this introduces a critical issue for checkpoint/restore
tools like CRIU. If a process is checkpointed while inside a signal
handler, its stack contains a signal frame formatted according to the
source host's xstate capabilities.  If that process is later restored on
a destination host with larger xstate capabilities (e.g., a newer CPU
with more features enabled, resulting in a larger fpstate->user_size),
the kernel will look for FP_XSTATE_MAGIC2 at the destination host's
larger user_size offset instead of the offset encoded in the frame's
fx_sw->xstate_size.  This causes the magic2 check to fail, forcing
sigreturn to silently fall back to "FX-only" mode. Upon return from the
signal handler, the process's extended state is reset to initial values
instead of being restored, leading to silent data corruption.

The original commit cited commit d877550eaf2d ("x86/fpu: Stop
relying on userspace for info to fault in xsave buffer") as
justification to stop relying on userspace for the magic number check.
However, these two changes are fundamentally different. The last one
only changed how much memory the kernel ensures is paged-in before
running XRSTOR to prevent an infinite loop. It did not change the signal
frame format or how the layout is validated.

Reverting this change restores the use of fx_sw->xstate_size for
locating magic2 and restores the necessary sanity checks, ensuring that
the signal frame remains self-describing and portable.

Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: stable@vger.kernel.org
Fixes: dc8aa31a7ac2 ("x86/fpu: Refine and simplify the magic number check during signal return")
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 arch/x86/kernel/fpu/signal.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c3ec2512f2bb..20b638c507ca 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -27,14 +27,19 @@
 static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 					    struct _fpx_sw_bytes *fx_sw)
 {
+	int min_xstate_size = sizeof(struct fxregs_state) +
+			      sizeof(struct xstate_header);
 	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
 		return false;
 
-	/* Check for the first magic field */
-	if (fx_sw->magic1 != FP_XSTATE_MAGIC1)
+	/* Check for the first magic field and other error scenarios. */
+	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
+	    fx_sw->xstate_size < min_xstate_size ||
+	    fx_sw->xstate_size > x86_task_fpu(current)->fpstate->user_size ||
+	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
 	/*
@@ -43,7 +48,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + x86_task_fpu(current)->fpstate->user_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
 		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
-- 
2.54.0.545.g6539524ca2-goog


