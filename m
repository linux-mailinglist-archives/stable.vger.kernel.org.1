Return-Path: <stable+bounces-213953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA8uLARlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE1AE8882
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C023135BC9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EB2D94AF;
	Wed,  4 Feb 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BBStVxps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A722D8DA8;
	Wed,  4 Feb 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218064; cv=none; b=mt9qpEFvF2ZxQLNRLKCsC6qqpJJkcOiwF4xS0Z8JFwyxxd8uZdu1aTTYBdS9heyk0o9RZglw/QrTWK9TgHLWQ6xF+ZhKW8W0hA6bjP2WXOi74KEd0Dnek9gHZBpTfayvNGX0hyWijgm4W9zJ3rc1Iofzl5oaSMfv+u5v8vQIllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218064; c=relaxed/simple;
	bh=os1uEsBdsifxDCVBydMu3bOLabJM6MSaxE7ULygl5AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEhm5stPkVndna7iYydqCZm+YIw4OAeTrhmgpwhAftLHWSKiKgwyklY5E96swjFe+o6lSwY9SiAG4xvzYyGAH5lwP/GajOKmBjWgnd6VSq6v2unRlPSUWcxduB1LeuwjWaiVt0dI4wTg81uIwkIIPhnohRfDAyDK8Uklr68NXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BBStVxps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A43EC4CEF7;
	Wed,  4 Feb 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218064;
	bh=os1uEsBdsifxDCVBydMu3bOLabJM6MSaxE7ULygl5AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBStVxpsbIpUgrGoxF7vAfWDQiiPxi/Ia0019mviUzpMiB5ZAvP0v5ug+vf4e5rKS
	 +3F7OHfvf5jD72oXQOtdNZn4isHrUAVpGEtvTEWczMh8qceWi72v/nFQsOXGyTj/BH
	 NX+hexvt543N7xs6h3puZ4LMu4bXUGeUcsTaHbiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 167/280] arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA
Date: Wed,  4 Feb 2026 15:39:01 +0100
Message-ID: <20260204143915.631435514@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213953-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2FE1AE8882
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit ea8ccfddbce0bee6310da4f3fc560ad520f5e6b4 upstream.

The code to restore a ZA context doesn't attempt to allocate the task's
sve_state before setting TIF_SME. Consequently, restoring a ZA context
can place a task into an invalid state where TIF_SME is set but the
task's sve_state is NULL.

In legitimate but uncommon cases where the ZA signal context was NOT
created by the kernel in the context of the same task (e.g. if the task
is saved/restored with something like CRIU), we have no guarantee that
sve_state had been allocated previously. In these cases, userspace can
enter streaming mode without trapping while sve_state is NULL, causing a
later NULL pointer dereference when the kernel attempts to store the
register state:

| # ./sigreturn-za
| Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
| Mem abort info:
|   ESR = 0x0000000096000046
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x06: level 2 translation fault
| Data abort info:
|   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
|   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
|   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
| user pgtable: 4k pages, 52-bit VAs, pgdp=0000000101f47c00
| [0000000000000000] pgd=08000001021d8403, p4d=0800000102274403, pud=0800000102275403, pmd=0000000000000000
| Internal error: Oops: 0000000096000046 [#1]  SMP
| Modules linked in:
| CPU: 0 UID: 0 PID: 153 Comm: sigreturn-za Not tainted 6.19.0-rc1 #1 PREEMPT
| Hardware name: linux,dummy-virt (DT)
| pstate: 214000c9 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
| pc : sve_save_state+0x4/0xf0
| lr : fpsimd_save_user_state+0xb0/0x1c0
| sp : ffff80008070bcc0
| x29: ffff80008070bcc0 x28: fff00000c1ca4c40 x27: 63cfa172fb5cf658
| x26: fff00000c1ca5228 x25: 0000000000000000 x24: 0000000000000000
| x23: 0000000000000000 x22: fff00000c1ca4c40 x21: fff00000c1ca4c40
| x20: 0000000000000020 x19: fff00000ff6900f0 x18: 0000000000000000
| x17: fff05e8e0311f000 x16: 0000000000000000 x15: 028fca8f3bdaf21c
| x14: 0000000000000212 x13: fff00000c0209f10 x12: 0000000000000020
| x11: 0000000000200b20 x10: 0000000000000000 x9 : fff00000ff69dcc0
| x8 : 00000000000003f2 x7 : 0000000000000001 x6 : fff00000c1ca5b48
| x5 : fff05e8e0311f000 x4 : 0000000008000000 x3 : 0000000000000000
| x2 : 0000000000000001 x1 : fff00000c1ca5970 x0 : 0000000000000440
| Call trace:
|  sve_save_state+0x4/0xf0 (P)
|  fpsimd_thread_switch+0x48/0x198
|  __switch_to+0x20/0x1c0
|  __schedule+0x36c/0xce0
|  schedule+0x34/0x11c
|  exit_to_user_mode_loop+0x124/0x188
|  el0_interrupt+0xc8/0xd8
|  __el0_irq_handler_common+0x18/0x24
|  el0t_64_irq_handler+0x10/0x1c
|  el0t_64_irq+0x198/0x19c
| Code: 54000040 d51b4408 d65f03c0 d503245f (e5bb5800)
| ---[ end trace 0000000000000000 ]---

Fix this by having restore_za_context() ensure that the task's sve_state
is allocated, matching what we do when taking an SME trap. Any live
SVE/SSVE state (which is restored earlier from a separate signal
context) must be preserved, and hence this is not zeroed.

Fixes: 39782210eb7e ("arm64/sme: Implement ZA signal handling")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: <stable@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -433,6 +433,10 @@ static int restore_za_context(struct use
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
+	sve_alloc(current, false);
+	if (!current->thread.sve_state)
+		return -ENOMEM;
+
 	sme_alloc(current, true);
 	if (!current->thread.za_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;



