Return-Path: <stable+bounces-169434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0995B24F11
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1C717DE90
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FF299AB4;
	Wed, 13 Aug 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOZlKu6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFD299A84
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100791; cv=none; b=tpuwF9UgmNU/9fKVcNa0QUnKflqfRtHKRmv5fYPHa/T+eT90e1UkxmoqKIMsUw9694rz1CoYwF2uGv7fFkAET1PSckErTHSqInGzhmAU4oTDX77L2C11GACxbtkhMjq/5xiyvSeySe8LHTvOU0oqlMfco/ZglGIF6DTR5WxhLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100791; c=relaxed/simple;
	bh=jDDwobTYRwBoVuPmcs8mFfjkQmVxR+OkbSYAgSZjsNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8QLPgjgI+M4PY2xUHRXMzjUwJ4cHllZJAN3RFEoI7ptcvWcK9DdaxMGMlQFBi8OxEh3hxY6ejytWpU9KobYsdNvTDirZ0d97YI/JbQDWujmcuyQEzMsEJzD7pCu60d+0AuR1UcrEeBX5sam2hF967yc3gPJ37uZEBx0H+OCsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOZlKu6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA2C4CEEF;
	Wed, 13 Aug 2025 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755100791;
	bh=jDDwobTYRwBoVuPmcs8mFfjkQmVxR+OkbSYAgSZjsNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOZlKu6MofilR6z3OmFgXmMbJUiTgdqCE0E52EYEoxRzxIlt9PDgQ6F851E7M3anZ
	 N+uZg5v/HvEqoZmGj0DctoFs+Kux6i9IkLiuVkfuH+QHLC8hv9NujqD7W6fdnHYgMx
	 cRaG0hM7K2dnxqMdz6gxDaMkuwbniEoD8bKTC6eff6eYc/Nex2UN3LY8VdgjrCpf5a
	 EAq+xYEwuWH9CQpmg654ODnx0WW9QBSNwGQP2qAq3bhnyN4Iy6/em6KkweH+veXPDp
	 quDA/mc3O45RhdKItJE7ybmj21cysQY/97iWM0nIWWyXAaKFfiDoFuLav9gdbEJBHJ
	 j0xrNam4AD34g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] x86/fpu: Delay instruction pointer fixup until after warning
Date: Wed, 13 Aug 2025 11:59:47 -0400
Message-Id: <20250813155947.2053690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081250-ominous-saddling-5ac5@gregkh>
References: <2025081250-ominous-saddling-5ac5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit 1cec9ac2d071cfd2da562241aab0ef701355762a ]

Right now, if XRSTOR fails a console message like this is be printed:

	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.

However, the text location (...+0x9a in this case) is the instruction
*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
also points one instruction late.

The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
keep on running after returning from the #GP handler. But it does this
fixup before warning.

The resulting warning output is nonsensical because it looks like the
non-FPU-related instruction is #GP'ing.

Do not fix up RIP until after printing the warning. Do this by using
the more generic and standard ex_handler_default().

Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Acked-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250624210148.97126F9E%40davehans-spike.ostc.intel.com
[ Replace fpu_reset_from_exception_fixup() with __restore_fpregs_from_fpstate() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/extable.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index a9c7efd4b794..cba212d7146a 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -60,13 +60,12 @@ static bool ex_handler_fault(const struct exception_table_entry *fixup,
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
-	return true;
+
+	return ex_handler_default(fixup, regs);
 }
 
 static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-- 
2.39.5


