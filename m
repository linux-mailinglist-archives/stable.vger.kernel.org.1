Return-Path: <stable+bounces-169440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD265B25014
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36D33B2EF5
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A40428727D;
	Wed, 13 Aug 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLS9tCBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A322F389
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103342; cv=none; b=DNvcGBdRGxFUURxpThP14y37G9d0A8M/NQETFQp5R5Rj+BuRd5fEkTOwPeqIc+hM1Umh3NQDVKBwbr0P/bNWG480WJdQ5E81VCW45w+5HVjkPJoOtVHcGYFLPktJEDKaHcKV+EE4wNYwgd92uCVP2WnNtNuyh7AIrdJxcTeedS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103342; c=relaxed/simple;
	bh=d6SiTJ2gPPy7G0mF3ymCpTx9GLLSlFcB78dVhbHCsCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYfX9jgGOqrHZIHTVuY+haOQBNYYr3En2jExdzSHHkaqTu3dWxM5yaSwJ5KsbZboqHqdKO65WCSmgPkjASfcwE9Q4pJUNYV6J9vG4pk7ejKTXSknhnBvSs90wKsPfogEVNATRtQI1XjyzPRbuabz1JngkWi2aCAgDYClxe9mPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLS9tCBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F324C4CEEB;
	Wed, 13 Aug 2025 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103341;
	bh=d6SiTJ2gPPy7G0mF3ymCpTx9GLLSlFcB78dVhbHCsCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLS9tCBm65Cao2Myml8WGKHH6TXYKM60JeuwtbmSW4pyk/3gma8i69bNv2ekrP6ym
	 5bgPtW5intn58V9eR6/F3GZmIl2wu/7nz21aikUgzxPHxLgA07s2pR/2SVW85p3FS3
	 if//CezUYG1Mv1zsnjyiF+92ty9t9EErV4+QECqyXig4XBUKo6ipF5rOHgial/4B8z
	 LoZGLudT4o1VMzHbCLnrulYL1CUMlUvnfSflEI82PN7rzaFdCabzUoCcvSAzX0atVQ
	 DUgMir5x2GoTkULN95Rd8tpGSEBSHS3CNevC2l3SaQy9BR6lpEvHPNgsoCXawQ2K8O
	 i6X/Bcko53/0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] x86/fpu: Delay instruction pointer fixup until after warning
Date: Wed, 13 Aug 2025 12:42:19 -0400
Message-Id: <20250813164219.2063341-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081252-serotonin-cranium-3e92@gregkh>
References: <2025081252-serotonin-cranium-3e92@gregkh>
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
[ adapted ex_handler_default() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/extable.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 30bb0bd3b1b8..ae7e056d0007 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -59,13 +59,12 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
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


