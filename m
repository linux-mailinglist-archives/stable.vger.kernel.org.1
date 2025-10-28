Return-Path: <stable+bounces-191544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F514C16A79
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC544EC717
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8EF34FF71;
	Tue, 28 Oct 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9JM/5LT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umfdoBtP"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5571F5827;
	Tue, 28 Oct 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680679; cv=none; b=nYO3e56E9eLhsgmPBOxXjV8IqO/Jz1rwRBrZHCW3rKri8ggaNNMNrbjn2nx8I36nHg5F8zbSRgeW5pTxCHJtADS4Hi+kh+ETJkNeO2Oy5/MaAKjk2UGMNQbJa5zGYybBMgf+SOLXccwX/F3qbvFoAxlAN3XBDjg1MhbnSIWcaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680679; c=relaxed/simple;
	bh=Msq9T36ZFxgTo2O/BlSoUqcqG4aEYoQ5fAFhnErLZog=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=n92lltiUoWiYlS4Lfm65AyM6OFeM7hFf/6y/ZF9kFYUwt2HkhBrUXkh3ROEhMF6ti49psGb/H7UaI3x4OYoVOkjqwgprrz2oQRYpCky7CAc786VnrR+c+dpAALB85WHY219d0L9th8nQtOC7/mOPSVpIJCSRpy17luEmO4FXuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9JM/5LT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umfdoBtP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 19:44:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761680675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p4QVTyWunBvfONVP0Mj//QUzxTGF7UBFnbv9Id8gW9c=;
	b=r9JM/5LTM4P+ZZhyQmXHArJaIndBwGmVCKFOaqitXu07N3zA+EHBCY6kmZnjtFjt4qcebr
	3UWzFyQ6wA+YdQNKT14Y6zRmMZFzqystqUMNSB7J0gOJTPybTbu0mOCJuaL7Gb2wqUTUaW
	C5istUm9vDc0qlgPMDTuRptxDMBRBF6Gx1VJnsxtQ4/6ql2sf1yjMej5vxTWUTqumceuHD
	bta+C6NxWqeHoRVAODy2p6LGF0J4VhJDTqlahuKWCfxO8HRJx9hwUeCstTKIZJWVDyQkqy
	ysnmfbkF2C0fDeOHWGkb4W7CrjD10Gf+2UiZ8cH09D07mojaS+UbIXrQy+VJOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761680675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p4QVTyWunBvfONVP0Mj//QUzxTGF7UBFnbv9Id8gW9c=;
	b=umfdoBtP4M7kpHwgs/K21Xy2kcgGKP6qjJsAoCfQTXU2ObiEbdJi9CgQyJ6dR/lO5pHExc
	+ngg/TF0a8eoKdBw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Ensure XFD state on signal delivery
Cc: Sean Christopherson <seanjc@google.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176168067359.2601451.3900540994771276596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     388eff894d6bc5f921e9bfff0e4b0ab2684a96e9
Gitweb:        https://git.kernel.org/tip/388eff894d6bc5f921e9bfff0e4b0ab2684=
a96e9
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Mon, 09 Jun 2025 17:16:59 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 Oct 2025 12:10:59 -07:00

x86/fpu: Ensure XFD state on signal delivery

Sean reported [1] the following splat when running KVM tests:

   WARNING: CPU: 232 PID: 15391 at xfd_validate_state+0x65/0x70
   Call Trace:
    <TASK>
    fpu__clear_user_states+0x9c/0x100
    arch_do_signal_or_restart+0x142/0x210
    exit_to_user_mode_loop+0x55/0x100
    do_syscall_64+0x205/0x2c0
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

Chao further identified [2] a reproducible scenario involving signal
delivery: a non-AMX task is preempted by an AMX-enabled task which
modifies the XFD MSR.

When the non-AMX task resumes and reloads XSTATE with init values,
a warning is triggered due to a mismatch between fpstate::xfd and the
CPU's current XFD state. fpu__clear_user_states() does not currently
re-synchronize the XFD state after such preemption.

Invoke xfd_update_state() which detects and corrects the mismatch if
there is a dynamic feature.

This also benefits the sigreturn path, as fpu__restore_sig() may call
fpu__clear_user_states() when the sigframe is inaccessible.

[ dhansen: minor changelog munging ]

Closes: https://lore.kernel.org/lkml/aDCo_SczQOUaB2rS@google.com [1]
Fixes: 672365477ae8a ("x86/fpu: Update XFD state where required")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Tested-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/all/aDWbctO%2FRfTGiCg3@intel.com [2]
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20250610001700.4097-1-chang.seok.bae%40intel.c=
om
---
 arch/x86/kernel/fpu/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1f71cc1..e88eacb 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -825,6 +825,9 @@ void fpu__clear_user_states(struct fpu *fpu)
 	    !fpregs_state_valid(fpu, smp_processor_id()))
 		os_xrstor_supervisor(fpu->fpstate);
=20
+	/* Ensure XFD state is in sync before reloading XSTATE */
+	xfd_update_state(fpu->fpstate);
+
 	/* Reset user states in registers. */
 	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
=20

