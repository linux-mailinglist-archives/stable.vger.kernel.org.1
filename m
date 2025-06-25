Return-Path: <stable+bounces-158648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C18AE92C0
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 01:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759403B1224
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 23:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853D280309;
	Wed, 25 Jun 2025 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K0le9pP0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6/ywN16I"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA312D3EE2;
	Wed, 25 Jun 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750894542; cv=none; b=m9wbE0AN3bU40AYSj1Ht9nOzSuHawEuwQK/MbXLcz6osKL0OvJDBs/9HTiKaXxyNcwa2kcyQWPuMBJYnk7+2aAFD1qDjgBI+8a+XnO2eiBzZ4yH7qB+zzhYyUS9xzMn1jFU4mm81Q2IiLPpAD9P5ApGsFsLOFcq0QeXjYx0P2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750894542; c=relaxed/simple;
	bh=3ja5VUcCu5TfcEUx7TbMSX/9RYS5fQQvz0cAl8mf0YU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T6ICcBR3QpV7yp9WAY+6bcwraXNjUa7VBoUYGXzR5qbwucUE2wMb5kBpp7+3rbkOAbvNwikqCRe3yG8aM9/8HnYtNAwHSvmq+6Cee/9hBi6gUkzXaPCU+gk4nY+0X7IMGFAr6rrdZatw9qJ6gIUxDO87NDLuhi95RdYbd1drXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K0le9pP0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6/ywN16I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 23:35:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750894538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dQpZtUpSSZaTBNjpxlHxxKngkRDVK/dGOcEWsb9wGqo=;
	b=K0le9pP0eMCHKK7PbYW32r1sScPhxpsyd3MiF7ZD0Dkl2QGQY6mxZbgOOK6rgMj58dOUS5
	RKPJxT+ThYOvZGFnvGZvU7xOOI+k5frlTu+31jjWGjBgOKAEoqLJpLIUjZN/aVy8M/hGYW
	77M+96IjT/OLkjMTWXnmWishjaqbo1GqJaXlrYShIr+D/ZGNcHQel8vffLJZZPE7ny/Iaq
	JAaXpIsUYu4OJvhZumDxaqka7c/3H1cQclGOBM/H6xgvRFp3WYr8b5pJx6tpopDq164CyU
	ZG3iKeL0qclvcMmHhS+Yd7wq4bVJ6tXP+5YyykT1GfNm86RyztE+AeBCpVOd8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750894538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dQpZtUpSSZaTBNjpxlHxxKngkRDVK/dGOcEWsb9wGqo=;
	b=6/ywN16Ipiv6vgFLoLD0u5XqKU0l1PGf+qDoyM4RnzZW0pMZvUcHrxT7tlmQe/RwJW4KTt
	wd9AGxGy50BmnRAw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Delay instruction pointer fixup until after warning
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175089453700.406.1518104364215542733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1cec9ac2d071cfd2da562241aab0ef701355762a
Gitweb:        https://git.kernel.org/tip/1cec9ac2d071cfd2da562241aab0ef701355762a
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 24 Jun 2025 14:01:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 25 Jun 2025 16:28:06 -07:00

x86/fpu: Delay instruction pointer fixup until after warning

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
---
 arch/x86/mm/extable.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index bf8dab1..2fdc1f1 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -122,13 +122,12 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	fpu_reset_from_exception_fixup();
-	return true;
+
+	return ex_handler_default(fixup, regs);
 }
 
 /*

