Return-Path: <stable+bounces-109074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1FA121B3
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C6716AF5C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6C1E98E4;
	Wed, 15 Jan 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7thQlmO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B134248BB9;
	Wed, 15 Jan 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938764; cv=none; b=ulhP1mXtpAC9vLr+X/Y8MLKjQpd32MKVbZXJcgIqMF/M5sJHgsfuROJ0zcKmCyXFR96Yh061XYlPpaLhCpXiBX1r2ipoaIz1GkKE7ikjBouERYSmGsWAYyK9p3hwDq9g0TzQMa2YLEMfSaarZrVTu16Gw8tuymqnA1uxStt9qEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938764; c=relaxed/simple;
	bh=ERelHAiKO37JmEV7mVGENaXzcYRA/BIfBTyt55y7WSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB444VzKvK5JOzi9BAtZF6a3ZkB7HHBexfcHeV7WMl4HXtRya4W/7JpB4Tc0QMDubkYslDov1rD63oE2k39Y6HOdY54y1IZp0Ow/C3lOcdzvpx910VlpNNSzRb1Yub/MDVLaDBINMuIJ7XHwYXQVBvKZqhuBuluAnhrYPIiNO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7thQlmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E11C4CEDF;
	Wed, 15 Jan 2025 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938763;
	bh=ERelHAiKO37JmEV7mVGENaXzcYRA/BIfBTyt55y7WSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7thQlmO79buGYWpAtxLxN4QvBpS6HeggUTvn7BZHa1/wcxMy+HOn+bZsPpRejKRC
	 W/SuLYyPI/iQfGXNS5Rubcdc6b0cWlIqY11SwpQYObUYOYzOpEGYN8IhimXzVHl1lV
	 HsQpz+fZdu9mhiv9n5+a8pXW5M6a7VxLoZ38liFQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christina Schimpe <christina.schimpe@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6 091/129] x86/fpu: Ensure shadow stack is active before "getting" registers
Date: Wed, 15 Jan 2025 11:37:46 +0100
Message-ID: <20250115103557.996269037@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

commit a9d9c33132d49329ada647e4514d210d15e31d81 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/regset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2a21bd..887b0b8e21e3 100644
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
-- 
2.48.0




