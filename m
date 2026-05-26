Return-Path: <stable+bounces-254446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODBcIuwHFmpNhAcAu9opvQ
	(envelope-from <stable+bounces-254446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:51:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DBA5DC795
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98818304B104
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45B37DEAD;
	Tue, 26 May 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwaHQ6Hg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982036897F
	for <stable@vger.kernel.org>; Tue, 26 May 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828657; cv=none; b=tFwtGiNX4zsVuhy7yBlq5kgnliAXJXRq0SYmvoMoZBA9V91YePuN9tV/5c9SPhAqUKOprwid5jN4/g6LcPvnCYXNN36MEWODqPXD4V6bEE7FfyN+dDbMENZabDAcnwXxJfrsXldMBzoJ/hVPllsDfMvlNptQeFkjLgszJrc3Ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828657; c=relaxed/simple;
	bh=0TYW5BqkkS32o7ET9R9aBrP4LiKehhAcU+bX+Vk+Avs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hry/9ucVn91mUxXe2x2OxFQqy0XdexArwULXE5CKSNFF/xML0At4+QLpGwLvHEj5EaGtNgvSgey7snXVjO4Tvq1oYPnCjYsPjKsSe87G9KJ4Nr6BoK+Vmhc0M2u0jGOffJarhcIQrKGaPUPuXcGBPu3Pw+JVu3MXIRGNck2UcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwaHQ6Hg; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7e3a338673eso23654816a34.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779828655; x=1780433455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4JLWLHFZ4VAwkmrRbZrIwjkAWpOIB54DvklYIirz08=;
        b=PwaHQ6HgLQblx6ZEhpc8ttn2BlpmqMaMPhFbPIG+9FGZePZCBlKRJezbHNUgvuI9Mh
         80rC8CgMNpdwC7jKmc59PwxWGXe8fftSd5BrL5sJbC8I7Nl/mEm0kGTJ/YbEpeXHLnB1
         bwlVX55pHQH73y+rRrYwz4hV9cglLTOzkwed/5qELqqq0XLDEvm/S+Qb9GtJjIqL5LFs
         aLSX4vXDLtXmfRxlVY5xbUuiKJBgVj/g1nnqvMYPbgDrhSCueljr30s7f3SdqKEzn4+d
         kswZR7tiBubh+C3DGbz6Xx/yVY9wrf63XP+lxCffXfsFc2cFkYnKJvGGcFnamrqjfSM8
         LM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828655; x=1780433455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4JLWLHFZ4VAwkmrRbZrIwjkAWpOIB54DvklYIirz08=;
        b=ibfEUNvKAlUt200ucVJjqkKcP8ok+G9YYErVPXeXtDsO5VcQrdjEFVtiDfSVK1D0E0
         nIzit2iO2RMN4nygZYf7sD5Z4EgF+AHZQrWW9/6p7HQaWD0z+c4lZWiTv9ebq4gCOuev
         1tZ8vbQcO6vyeNkV6J0jD3mDAoPAI/9Vyf+XnuL5GFc9OT8VFTEAqEDlEoqcbVn5WR/o
         z4i1vbMr2mw89Cj14gowTJMAhrBQvqIJ/41j0IFkjRe5q8RnwpgLJSE68pOAAoYkqRiB
         E2MH98prPbxobbvJdJYhdTwM8EWlRblfnRNkyzvS6DO8dd8+51k3LY5KByDg0kTtjFc6
         Wg2A==
X-Forwarded-Encrypted: i=1; AFNElJ92hCl+x5AnZVgfizM78fzOrAq8sBJtiFK+yn+GAX5RCIcx3I8g2eJp2OQyWIftse/KTmIjZmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLPYBNvRPoRLg4IzYJD/eMGuuvZWXfxbp5NRq1cIwOXqcIJgg
	oI3+5P+DwUx8h7xVXkReICYUtwWED14zpU13w9zbqx6GKj3fqSrLfzY7bm3tLwBo5+nPt7rCidL
	igPNILQ==
X-Received: from ilfl18.prod.google.com ([2002:a92:2812:0:b0:500:25fd:8e65])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:16ac:b0:69d:8cf6:2e5a
 with SMTP id 006d021491bc7-69d8cf635acmr8341465eaf.23.1779828654411; Tue, 26
 May 2026 13:50:54 -0700 (PDT)
Date: Tue, 26 May 2026 20:50:43 +0000
In-Reply-To: <20260526205047.3339490-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526205047.3339490-1-avagin@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526205047.3339490-2-avagin@google.com>
Subject: [PATCH 1/5] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
From: Andrei Vagin <avagin@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, criu@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrei Vagin <avagin@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Chang S. Bae" <chang.seok.bae@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 01DBA5DC795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Cc: stable@vger.kernel.org
Acked-by: Chang S. Bae <chang.seok.bae@intel.com>
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
2.54.0.746.g67dd491aae-goog


