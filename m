Return-Path: <stable+bounces-215245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANo6E2PyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA254110C05
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17235300D15D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC010378D84;
	Mon,  9 Feb 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv7gdGdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68C36828A;
	Mon,  9 Feb 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648159; cv=none; b=HfzHoqWsQxPUA84Qm5Z2x1gnFe4eZIk6rYqkGmTtE/MvUdLmWn086Gb0eDSPtdm7rWc1scYDW/hI7FKb3yDFzw8AMGGlVW3H254q82lLMrDCWZrCWDkze9bToLk1elVVjX2wYpJlYosg8ymlA0qFl0E7hw0rscRHX2a05XlYdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648159; c=relaxed/simple;
	bh=Fs4sB2u1koZ9CvmTMBSLuz11+SbGRPQ3lf86R5/ZrM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxbkFoUx+M9FPXdCUlEPF4r8j+1tOuniyKTzsyvjHO4uaNRKI0OILW3qCE3JoP9xhGjAwUS603ROiZdX8PirhF8iCliyf7KQFsD6HPEVLpwOOxSI3egWgj+INAORbQzdEhQmUI0lntFzFYTBPA2FAoiDXhMG6fxbwTJEm4A1MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv7gdGdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB05C116C6;
	Mon,  9 Feb 2026 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648159;
	bh=Fs4sB2u1koZ9CvmTMBSLuz11+SbGRPQ3lf86R5/ZrM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mv7gdGdIU6bAaEbCo/cAd2GKTTDLQD4PuzH2DyM9ImRoCCusSYIVnFouRR1J7Ahdx
	 vTNtHh9VURYTSa0rYbPCN3/JdsXMry0knTb1MBck0kaNv96e55NFxbp/yQ4PPT7Tpr
	 DcEj/FLBQBxxcDQuRPIcCGdGutbsO6O7c96Q61R8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghao Duan <duanchenghao@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 24/69] LoongArch: Enable exception fixup for specific ADE subcode
Date: Mon,  9 Feb 2026 15:23:52 +0100
Message-ID: <20260209142302.797429548@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215245-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,loongson.cn:email]
X-Rspamd-Queue-Id: BA254110C05
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghao Duan <duanchenghao@kylinos.cn>

[ Upstream commit 9bdc1ab5e4ce6f066119018d8f69631a46f9c5a0 ]

This patch allows the LoongArch BPF JIT to handle recoverable memory
access errors generated by BPF_PROBE_MEM* instructions.

When a BPF program performs memory access operations, the instructions
it executes may trigger ADEM exceptions. The kernel’s built-in BPF
exception table mechanism (EX_TYPE_BPF) will generate corresponding
exception fixup entries in the JIT compilation phase; however, the
architecture-specific trap handling function needs to proactively call
the common fixup routine to achieve exception recovery.

do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
ensure safe execution.

Relevant test cases: illegal address access tests in module_attach and
subprogs_extable of selftests/bpf.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 12c726482d151..cad1e08ca3fbb 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -361,10 +361,15 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
 asmlinkage void noinstr do_ade(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
+	unsigned int esubcode = FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr_estat);
+
+	if ((esubcode == EXSUBCODE_ADEM) && fixup_exception(regs))
+		goto out;
 
 	die_if_kernel("Kernel ade access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badvaddr);
 
+out:
 	irqentry_exit(regs, state);
 }
 
-- 
2.51.0




