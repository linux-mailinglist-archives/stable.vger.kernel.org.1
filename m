Return-Path: <stable+bounces-107929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C84A04E04
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648F63A1457
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF910E4;
	Wed,  8 Jan 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbSx2NGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUA7T3ac"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137F17E;
	Wed,  8 Jan 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294734; cv=none; b=keS7UXikUoWVvf82V+noOR0JuVDBl10LGot2+yERmfY1LFi7dOooNpPzqbDbwZehGF6/msAlAWoMhRDsAYc5Cvs/akAkTxBertJ5j/ufAwRxARrrjdFwdGnHgqlHmCoxWDoS5t6EemGXONItUNnJrw7/F7E0DQf6oSPQCc2Gvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294734; c=relaxed/simple;
	bh=4dofVtsukLso3PdJkEFSjpjBl4NdP/AWrYIgk76Ch7g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZJKbciWOH5GScYAVc6BYY2Xofb8oQ7m3tNnrcdyBwHLOVTx1xQEQjE/k/wmEWjTyOAz1z2AVPSA9CgLIMYYLl3l3M4nYp2ryg9GuJuKFxVX/OhEUHds0we0qjNR2x5hwscFhzTFrro3eCbE0d5zaCfgW7gsGR+pXQTfeNiGvw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbSx2NGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUA7T3ac; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 08 Jan 2025 00:05:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736294728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lepeWKlg0N79qRCOIS0hq19yjSdSJwUmvdm5UDYQ/hM=;
	b=qbSx2NGqYsyqf0DXdbX+DZfpR6FHuU+Di4UP4b8o5ZgrbqEJY6V5sgtn39iXhdCAM/Xdb0
	0kdbPIbVooW7na5fgnhDD5FOhw2iOZeYjItcYoa7nOhfP/Fxq3Ha2SY87fkADxfQvVHfxY
	4/nac6rOMUiVuaCsLZS2D7ftlBJPZMzovelXCEFbWOXdBOY2+7BkEx/drBt2VEVNJx/rvr
	Y50X9Jy6OB/6YII0cbkkdueWvBcUOLfRS3/8djrBwFu7owD5vj5IpbaDmmmgNKqegFXuqX
	D5QXj/BUpHlCm/fMTR864jeINAoCvJrsOWFEABeoe7dQko7rW2zhAgL50+OHmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736294728;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lepeWKlg0N79qRCOIS0hq19yjSdSJwUmvdm5UDYQ/hM=;
	b=bUA7T3acghEiy6WxEK15mP8B7i7vpaMeWPW74CHrdkE4ol4dioSC/67Aq7KHExq+ejc7Gy
	95pYhUR11FsGeJCg==
From: "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Ensure shadow stack is active before
 "getting" registers
Cc: Christina Schimpe <christina.schimpe@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173629472307.399.5774149825311450322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a9d9c33132d49329ada647e4514d210d15e31d81
Gitweb:        https://git.kernel.org/tip/a9d9c33132d49329ada647e4514d210d15e31d81
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Tue, 07 Jan 2025 15:30:56 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 07 Jan 2025 15:55:51 -08:00

x86/fpu: Ensure shadow stack is active before "getting" registers

The x86 shadow stack support has its own set of registers. Those registers
are XSAVE-managed, but they are "supervisor state components" which means
that userspace can not touch them with XSAVE/XRSTOR.  It also means that
they are not accessible from the existing ptrace ABI for XSAVE state.
Thus, there is a new ptrace get/set interface for it.

The regset code that ptrace uses provides an ->active() handler in
addition to the get/set ones. For shadow stack this ->active() handler
verifies that shadow stack is enabled via the ARCH_SHSTK_SHSTK bit in the
thread struct. The ->active() handler is checked from some call sites of
the regset get/set handlers, but not the ptrace ones. This was not
understood when shadow stack support was put in place.

As a result, both the set/get handlers can be called with
XFEATURE_CET_USER in its init state, which would cause get_xsave_addr() to
return NULL and trigger a WARN_ON(). The ssp_set() handler luckily has an
ssp_active() check to avoid surprising the kernel with shadow stack
behavior when the kernel is not ready for it (ARCH_SHSTK_SHSTK==0). That
check just happened to avoid the warning.

But the ->get() side wasn't so lucky. It can be called with shadow stacks
disabled, triggering the warning in practice, as reported by Christina
Schimpe:

WARNING: CPU: 5 PID: 1773 at arch/x86/kernel/fpu/regset.c:198 ssp_get+0x89/0xa0
[...]
Call Trace:
<TASK>
? show_regs+0x6e/0x80
? ssp_get+0x89/0xa0
? __warn+0x91/0x150
? ssp_get+0x89/0xa0
? report_bug+0x19d/0x1b0
? handle_bug+0x46/0x80
? exc_invalid_op+0x1d/0x80
? asm_exc_invalid_op+0x1f/0x30
? __pfx_ssp_get+0x10/0x10
? ssp_get+0x89/0xa0
? ssp_get+0x52/0xa0
__regset_get+0xad/0xf0
copy_regset_to_user+0x52/0xc0
ptrace_regset+0x119/0x140
ptrace_request+0x13c/0x850
? wait_task_inactive+0x142/0x1d0
? do_syscall_64+0x6d/0x90
arch_ptrace+0x102/0x300
[...]

Ensure that shadow stacks are active in a thread before looking them up
in the XSAVE buffer. Since ARCH_SHSTK_SHSTK and user_ssp[SHSTK_EN] are
set at the same time, the active check ensures that there will be
something to find in the XSAVE buffer.

[ dhansen: changelog/subject tweaks ]

Fixes: 2fab02b25ae7 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Christina Schimpe <christina.schimpe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Christina Schimpe <christina.schimpe@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250107233056.235536-1-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/fpu/regset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2..887b0b8 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -190,7 +190,8 @@ int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	struct fpu *fpu = &target->thread.fpu;
 	struct cet_user_state *cetregs;
 
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
 		return -ENODEV;
 
 	sync_fpstate(fpu);

