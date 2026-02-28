Return-Path: <stable+bounces-221214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q5+0IrRmo2m1CQUAu9opvQ
	(envelope-from <stable+bounces-221214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:05:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA251C95E3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDAF334C2169
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8C359A61;
	Sat, 28 Feb 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYdNj3bV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A3347FCC;
	Sat, 28 Feb 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302432; cv=none; b=epNya6H8sWR3KeSSzfBzAqbRXqwbBR2OR/V11MpvTwGwvOIyPiHspb0Ntdfqdbqtrdv7JQvgqntn/608Ao7aK0NgMeCwfWlEEcL7yfHJErpspwWDv+CeMmBDoo30Er3PAan2LUyr05ihgNRCpxK8VtCrn9ZjxeFSlYdcZcG6WVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302432; c=relaxed/simple;
	bh=vUeFqc4SigPQJZ6Bx9dPgvQ6qYdAUyvXC9qIDH3Zlqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzEC3FG4hfRQSgEJFCTuJJ0VosmhfERKxe+Az8vn+bsfI3uW0CZqKdV67Op6l9LGuwS1qVCBcxBfViP9Tr7LhkbOCSlhhMmz64mJI7HSL0C/FMkKzGSlPfU/rnTPAmU9h2snq60GX6OHzLaYz14gWiac1Ibv8pvZL99LUMYVRuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYdNj3bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF87C116D0;
	Sat, 28 Feb 2026 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302431;
	bh=vUeFqc4SigPQJZ6Bx9dPgvQ6qYdAUyvXC9qIDH3Zlqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYdNj3bVnBahRdLUyKkDMgOvmbNFfsf1M7grnUnZSqLPdLmb0qkE6GMFTzR96Iyy8
	 ACcWMUHqpIz2KHNsEX4HUL//3FxWYNLkZjzdsiuFwKLM+cg+xpgI5uQ/O7IC3w005X
	 qJX5v3sL1z9ZV1IhHh03VMrRD0SYrpRrhCkmKrbfB4/975nlYQxWCS//UKTzTbE569
	 hNVfRFZHx8D12fMRXPYNH9o/380nCZrmtRHcr1YUrmI2ATkMMHw1tiEdpkQRlU+Ye1
	 Nvzf4vRYwX0yY7GUAHpU558J+2zaIpBd0HgyO1n8G3gzfzAqGl5QO/tjMDXnQ2l2c0
	 JoTkk6K/midtw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Yao Zi <me@ziyao.cc>,
	stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1 169/232] MIPS: Work around LLVM bug when gp is used as global register variable
Date: Sat, 28 Feb 2026 13:10:22 -0500
Message-ID: <20260228181127.1592657-169-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228181127.1592657-1-sashal@kernel.org>
References: <20260228181127.1592657-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.977];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,franken.de:email,ziyao.cc:email]
X-Rspamd-Queue-Id: AFA251C95E3
X-Rspamd-Action: add header
X-Spam: Yes

From: Yao Zi <me@ziyao.cc>

commit 30bfc2d6a1132a89a5f1c3b96c59cf3e4d076ea3 upstream.

On MIPS, __current_thread_info is defined as global register variable
locating in $gp, and is simply assigned with new address during kernel
relocation.

This however is broken with LLVM, which always restores $gp if it finds
$gp is clobbered in any form, including when intentionally through a
global register variable. This is against GCC's documentation[1], which
requires a callee-saved register used as global register variable not to
be restored if it's clobbered.

As a result, $gp will continue to point to the unrelocated kernel after
the epilog of relocate_kernel(), leading to an early crash in init_idle,

[    0.000000] CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == ffffffff81afada8, ra == ffffffff81afad90
[    0.000000] Oops[#1]:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G        W           6.19.0-rc5-00262-gd3eeb99bbc99-dirty #188 VOLUNTARY
[    0.000000] Tainted: [W]=WARN
[    0.000000] Hardware name: loongson,loongson64v-4core-virtio
[    0.000000] $ 0   : 0000000000000000 0000000000000000 0000000000000001 0000000000000000
[    0.000000] $ 4   : ffffffff80b80ec0 ffffffff80b53d48 0000000000000000 00000000000f4240
[    0.000000] $ 8   : 0000000000000100 ffffffff81d82f80 ffffffff81d82f80 0000000000000001
[    0.000000] $12   : 0000000000000000 ffffffff81776f58 00000000000005da 0000000000000002
[    0.000000] $16   : ffffffff80b80e40 0000000000000000 ffffffff80b81614 9800000005dfbe80
[    0.000000] $20   : 00000000540000e0 ffffffff81980000 0000000000000000 ffffffff80f81c80
[    0.000000] $24   : 0000000000000a26 ffffffff8114fb90
[    0.000000] $28   : ffffffff80b50000 ffffffff80b53d40 0000000000000000 ffffffff81afad90
[    0.000000] Hi    : 0000000000000000
[    0.000000] Lo    : 0000000000000000
[    0.000000] epc   : ffffffff81afada8 init_idle+0x130/0x270
[    0.000000] ra    : ffffffff81afad90 init_idle+0x118/0x270
[    0.000000] Status: 540000e2	KX SX UX KERNEL EXL
[    0.000000] Cause : 00000008 (ExcCode 02)
[    0.000000] BadVA : 0000000000000000
[    0.000000] PrId  : 00006305 (ICT Loongson-3)
[    0.000000] Process swapper (pid: 0, threadinfo=(____ptrval____), task=(____ptrval____), tls=0000000000000000)
[    0.000000] Stack : 9800000005dfbf00 ffffffff8178e950 0000000000000000 0000000000000000
[    0.000000]         0000000000000000 ffffffff81970000 000000000000003f ffffffff810a6528
[    0.000000]         0000000000000001 9800000005dfbe80 9800000005dfbf00 ffffffff81980000
[    0.000000]         ffffffff810a6450 ffffffff81afb6c0 0000000000000000 ffffffff810a2258
[    0.000000]         ffffffff81d82ec8 ffffffff8198d010 ffffffff81b67e80 ffffffff8197dd98
[    0.000000]         ffffffff81d81c80 ffffffff81930000 0000000000000040 0000000000000000
[    0.000000]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.000000]         0000000000000000 000000000000009e ffffffff9fc01000 0000000000000000
[    0.000000]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.000000]         0000000000000000 ffffffff81ae86dc ffffffff81b3c741 0000000000000002
[    0.000000]         ...
[    0.000000] Call Trace:
[    0.000000] [<ffffffff81afada8>] init_idle+0x130/0x270
[    0.000000] [<ffffffff81afb6c0>] sched_init+0x5c8/0x6c0
[    0.000000] [<ffffffff81ae86dc>] start_kernel+0x27c/0x7a8

This bug has been reported to LLVM[2] and affects version from (at
least) 18 to 21. Let's work around this by using inline assembly to
assign $gp before a fix is widely available.

Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Global-Register-Variables.html # [1]
Link: https://github.com/llvm/llvm-project/issues/176546 # [2]
Signed-off-by: Yao Zi <me@ziyao.cc>
Acked-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/relocate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 58fc8d089402b..dcc2763b39d6e 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -420,7 +420,20 @@ void *__init relocate_kernel(void)
 			goto out;
 
 		/* The current thread is now within the relocated image */
+#ifndef CONFIG_CC_IS_CLANG
 		__current_thread_info = RELOCATED(&init_thread_union);
+#else
+		/*
+		 * LLVM may wrongly restore $gp ($28) in epilog even if it's
+		 * intentionally modified. Work around this by using inline
+		 * assembly to assign $gp. $gp couldn't be listed as output or
+		 * clobber, or LLVM will still restore its original value.
+		 * See also LLVM upstream issue
+		 * https://github.com/llvm/llvm-project/issues/176546
+		 */
+		asm volatile("move $28, %0" : :
+			     "r" (RELOCATED(&init_thread_union)));
+#endif
 
 		/* Return the new kernel's entry point */
 		kernel_entry = RELOCATED(start_kernel);
-- 
2.51.0


