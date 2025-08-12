Return-Path: <stable+bounces-167762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14DB23185
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4817AAA7F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5112FD1DA;
	Tue, 12 Aug 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODXoRxfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C02FD1A6;
	Tue, 12 Aug 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021907; cv=none; b=OJoODdN2NWBl4Jx7IDjsSIFong4vi8dAFDHY+f7MeYj4dY1DTuQKqi/ZnjrJ/QDE6auRvdtoR7CX9OAWcm2ryt4NXMWn0pEnQcEK1mu6NeO/l86air85r0hkosSkNt0OlfqagWQkhBCfmmu/mTX/EL75J7Wl+hEqc9BUyx98PNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021907; c=relaxed/simple;
	bh=EtXYQ6vQBAWbroZiwjHS2MRxzqG9MSK56D46F15OGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv8F3Sv5YdLX91DTmXshdlNZ7INip23BZTH+7E7iuMZNsI3ztwJ/t3S21KHgxtelTtzY+Gc9r8JgXUsGvT6OzdgALKrkkt0Fy3lAzPWmrGZojJNluC0lqirI5mi4L0RAH/cVLv6Wi/phIngA/IrXaYuU+Xfd+P9z3SV4QsOfsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ODXoRxfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C83C4CEF0;
	Tue, 12 Aug 2025 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021907;
	bh=EtXYQ6vQBAWbroZiwjHS2MRxzqG9MSK56D46F15OGXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODXoRxfbo1YoI2KGrnWztMd5p7TtqlJtKXNwf834hz/slMb/z0iXnAwSUm5Cda6uJ
	 yz3FKjCTFgEs4eeRaxnb6Uj1+fadrnazDOmd6jtqnKC5+aOFCoF5NxdCK06MYQPgZ0
	 oVONZhv6EyXOxDlAMiwORqA/9ychLSfcTG4Q8BZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.6 259/262] x86/fpu: Delay instruction pointer fixup until after warning
Date: Tue, 12 Aug 2025 19:30:47 +0200
Message-ID: <20250812173004.161735185@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 1cec9ac2d071cfd2da562241aab0ef701355762a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/extable.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -121,13 +121,12 @@ static bool ex_handler_sgx(const struct
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



