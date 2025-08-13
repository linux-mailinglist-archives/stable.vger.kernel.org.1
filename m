Return-Path: <stable+bounces-169438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D91B24FCF
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E605C43C8
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1328643E;
	Wed, 13 Aug 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5HvPAnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FD2857C1
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102268; cv=none; b=fKNUDjxxRvEsBirP7kPD6Or71B4q32C7FoRR7ajyVNqfJd/kY6ghHyjVFNr8nRHzXe8G/nhV2XGxAhhUNTXzvd02drzNjAYZXi0s5SwNsI0IGvXr73yThE3gROXoejxEzlUXlzlxBkbhXRvLdp/IsnTTxoBrn0s2DKu0ErfMX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102268; c=relaxed/simple;
	bh=711CkjRmnwJ76WtzMyBXRav45YSQZxzUKT8pg05Swec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFm7kvEcHgVKiDqcSd/ZeWpWGdwPlgtOOEJLGLblLYXwJuupf9rReDZbt2XVmjrOotynrSlTZZPWWueTYO6ca+3hDVbGNim1lPI/JBEUsv0poqV1+Cs7FwFxgIZA7lzSM6+LuWBjnHCzojDF66JSL+8ESOn5g1aWuAjrH3SDD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5HvPAnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB96C4CEEB;
	Wed, 13 Aug 2025 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755102268;
	bh=711CkjRmnwJ76WtzMyBXRav45YSQZxzUKT8pg05Swec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5HvPAnjcZBJfha+vEnb+EjAMDSOz2xNKzQptbDYiKZErHTFHdprJNtgGIEdHLASs
	 kLr8I9af+uS5xHwREoKp6TovbH/0VwVLouIb54+9QFbcLzKIjBC4xJR2CxOYBVfELi
	 hFnVi69WQCoi2apHqL6aRUHRDf7zPaS8u4ev9clEdyBVpl4b/KY/EVGlcgnnWmTgGe
	 PQ+A+3H5mjssDQIIbWXsze/8LFusUnkWulOzO9vyJhnoei5u3juTHQaKb1gnIh9Cyc
	 AvRxTtH3+wwo9c7uqitK4ugQfxtIytTiMpMMwqiJDKgnxk/kBy98viGv61YeqseEq1
	 idhmj2pmsLQFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] x86/fpu: Delay instruction pointer fixup until after warning
Date: Wed, 13 Aug 2025 12:24:25 -0400
Message-Id: <20250813162425.2060269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081251-sitter-agreed-26a4@gregkh>
References: <2025081251-sitter-agreed-26a4@gregkh>
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
[ Adapted ex_handler_default() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/extable.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd08a7f..1ccf065f7af8 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -60,13 +60,12 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				    unsigned long error_code,
 				    unsigned long fault_addr)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	__copy_kernel_to_fpregs(&init_fpstate, -1);
-	return true;
+
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
-- 
2.39.5


