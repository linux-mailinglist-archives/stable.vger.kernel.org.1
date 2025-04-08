Return-Path: <stable+bounces-129730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFEA800EA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7100118943E5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D056224239;
	Tue,  8 Apr 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYdnQVD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E0264A76;
	Tue,  8 Apr 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111826; cv=none; b=SUWm209fzdOUkkgxyW9g6B21+RFdW9wk6EQ5CjqPaPtJMsSCXAiz4PCJq37JUafs0f9bC9HT/W07+l9L8vDr4+WDa3KM25KZp4WPrkLNAOtG0sxdVBgkRQY8BmCE/WQuAQYg3Meb3uVnzoIWBHsqHgR0R/XiuuCMc15q4szXfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111826; c=relaxed/simple;
	bh=OZIUCiWbAiqBOaagHTBu3qgnWLN0HW8iD/CiCl+yUvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5aFVNtewxvZ+KQ6N+Zqes3lpbgQXiG5RRqetC0K7GhJYbTVRCM+Ka9user7ADxqhWKjP97dSE7S+0S7rFo+nWeA8vdZUN0EOny456Um8R945aUMRxeKRYg5LNHEHchAZ/xnl4qJMNPDQcUv/LUA6pue6ssvwifKSJE6WIc7Y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYdnQVD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC28EC4CEE5;
	Tue,  8 Apr 2025 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111826;
	bh=OZIUCiWbAiqBOaagHTBu3qgnWLN0HW8iD/CiCl+yUvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYdnQVD1cjuHSWr+VzVSEg9tEtxBZWWRySD45pu0rT+fhYfeOpUVquhJUjioM+vOQ
	 nU4KCpaE1/oXNlcUZJQ/bV9vfh+4Gsuu44O/ppE2vmU8W3V+z43+dBMScdOycHUYu0
	 3aw6B1vToxbFEaGlwMoGMk5ikF0aQig6VdrlpJv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 574/731] objtool/loongarch: Add unwind hints in prepare_frametrace()
Date: Tue,  8 Apr 2025 12:47:51 +0200
Message-ID: <20250408104927.625268312@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 7c977393b8277ed319e92e4b598b26598c9d30c0 ]

If 'regs' points to a local stack variable, prepare_frametrace() stores
all registers to the stack.  This confuses objtool as it expects them to
be restored from the stack later.

The stores don't affect stack tracing, so use unwind hints to hide them
from objtool.

Fixes the following warnings:

  arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-160
  arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[23]=-1+0 reg2[23]=-2-152

Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/270cadd8040dda74db2307f23497bb68e65db98d.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503280703.OARM8SrY-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/stacktrace.h   |  3 +++
 arch/loongarch/include/asm/unwind_hints.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index f23adb15f418f..fc8b64773794a 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -8,6 +8,7 @@
 #include <asm/asm.h>
 #include <asm/ptrace.h>
 #include <asm/loongarch.h>
+#include <asm/unwind_hints.h>
 #include <linux/stringify.h>
 
 enum stack_type {
@@ -43,6 +44,7 @@ int get_stack_info(unsigned long stack, struct task_struct *task, struct stack_i
 static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 	__asm__ __volatile__(
+		UNWIND_HINT_SAVE
 		/* Save $ra */
 		STORE_ONE_REG(1)
 		/* Use $ra to save PC */
@@ -80,6 +82,7 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 		STORE_ONE_REG(29)
 		STORE_ONE_REG(30)
 		STORE_ONE_REG(31)
+		UNWIND_HINT_RESTORE
 		: "=m" (regs->csr_era)
 		: "r" (regs->regs)
 		: "memory");
diff --git a/arch/loongarch/include/asm/unwind_hints.h b/arch/loongarch/include/asm/unwind_hints.h
index a01086ad9ddea..2c68bc72736c9 100644
--- a/arch/loongarch/include/asm/unwind_hints.h
+++ b/arch/loongarch/include/asm/unwind_hints.h
@@ -23,6 +23,14 @@
 	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_CALL
 .endm
 
-#endif /* __ASSEMBLY__ */
+#else /* !__ASSEMBLY__ */
+
+#define UNWIND_HINT_SAVE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+
+#define UNWIND_HINT_RESTORE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_LOONGARCH_UNWIND_HINTS_H */
-- 
2.39.5




