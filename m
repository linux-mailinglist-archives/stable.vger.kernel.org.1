Return-Path: <stable+bounces-261231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGnAKvBHJWqzFwIAu9opvQ
	(envelope-from <stable+bounces-261231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F864FB0C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZDU58xzq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261231-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261231-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABF63037D42
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDF31E831;
	Sun,  7 Jun 2026 10:22:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC30322C6D;
	Sun,  7 Jun 2026 10:22:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827756; cv=none; b=q+QQtYRWMRF4XdwbXHTW9FSxKkTNV1YxsoTbkr1Da6M20ZYFOKf4Rv6pQ3/nQhlbDOK+u6ZRcurwLRhI8RJuPTRJUwA0BPMTs3D80j8nzZ7j0ycBwpAwOkLaVJgTMKT8F69LEXGaNemwo6SZsauQ1xM84Ma0Kk/OT5hEg4FkkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827756; c=relaxed/simple;
	bh=NkYqs61n6pZsDVsx/GTQJrBzgyc45s7/Z8UQkDjI+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD0lDM79uF1cr+Hu88RYj90usmD+zHUUKbZgTnXZlohI6xpSLxaL++2uBfNo4Rqcgx1kXV6TZsHpNH21PFfTTntQUu/Dy1CxGqPLcaFZsTKDYrs6Gj6x0LHBGQjvAB/wdOw2BjV6RMJW9vMiZaXZr785a+2k71IYys6TAsZ3MyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDU58xzq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626E51F00893;
	Sun,  7 Jun 2026 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827754;
	bh=mpOI8JKnFIXVp4VHOa8wazG4NEV+emsX/Ooo8qrBIeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDU58xzqgPB8r0EzfFOMhxhoywlxc06CWpL1hyB3lCEZ5YhRk6b5mXUlb4M/ssc7h
	 S+du4tfVP0Nflseue+GX1qRVU9BgR5CG6zMEyujS6ByFXzHBv8wuq8fPCdjTHIbHwj
	 wS5FzbpG/JTeCBTpe/P8lDvBF/eFmmvv3oe5Gy5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrei Vagin <avagin@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 098/315] Revert "x86/fpu: Refine and simplify the magic number check during signal return"
Date: Sun,  7 Jun 2026 11:58:05 +0200
Message-ID: <20260607095731.237874056@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261231-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:avagin@google.com,m:bp@alien8.de,m:chang.seok.bae@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,alien8.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 073F864FB0C

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Vagin <avagin@google.com>

[ Upstream commit 44eeff9bc467bc7d1fec34fc3f6001f385fe462c ]

This reverts

  dc8aa31a7ac2 ("x86/fpu: Refine and simplify the magic number check during signal return").

The aforementioned commit broke applications that construct signal frames in
userspace (such as CRIU and gVisor) if the frame's xstate size is smaller than
the kernel's fpstate->user_size.

Furthermore, this introduces a critical issue for checkpoint/restore tools
like CRIU. If a process is checkpointed while inside a signal handler, its
stack contains a signal frame formatted according to the source host's xstate
capabilities.

If that process is later restored on a destination host with larger xstate
capabilities (e.g., a newer CPU with more features enabled, resulting in
a larger fpstate->user_size), the kernel will look for FP_XSTATE_MAGIC2 at the
destination host's larger user_size offset instead of the offset encoded in
the frame's fx_sw->xstate_size.

This causes the magic2 check to fail, forcing sigreturn to silently fall back
to "FX-only" mode. Upon return from the signal handler, the process's extended
state is reset to initial values instead of being restored, leading to silent
data corruption.

The aforementioned commit cited

  d877550eaf2d ("x86/fpu: Stop relying on userspace for info to fault in xsave buffer")

as justification to stop relying on userspace for the magic number check.

However, these two changes are fundamentally different. The last one only
changed how much memory the kernel ensures is paged-in before running XRSTOR
to prevent an infinite loop. It did not change the signal frame format or how
the layout is validated.

Reverting this change restores the use of fx_sw->xstate_size for
locating magic2 and restores the necessary sanity checks, ensuring that
the signal frame remains self-describing and portable.

  [ bp: Massage commit message. ]

Fixes: dc8aa31a7ac2 ("x86/fpu: Refine and simplify the magic number check during signal return")
Signed-off-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260429000623.3356606-1-avagin@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/fpu/signal.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c3ec2512f2bbe4..20b638c507ca2d 100644
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
2.53.0




