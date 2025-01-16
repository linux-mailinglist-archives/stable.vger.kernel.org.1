Return-Path: <stable+bounces-109216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3CA13371
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A553A4936
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031C1CF96;
	Thu, 16 Jan 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/A0onfg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389B1C695;
	Thu, 16 Jan 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010661; cv=none; b=pLZ3sXUIE0CctsbXUknqwjoQWydA5CQYB/MRAz9dXoq/JATo08vOeSNJoCneL+WHj98gllAVfC0ARMyjpwsZDQhriDy34xIYjr2clW2KwvIEBTah8IiIY2M3G5BUlE9tCP9cnQrjXcVSWEaevK1GZ2P7OHLyzv+Xv1bHtxqh4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010661; c=relaxed/simple;
	bh=MvD2J1oZPwkIygePCQJT7XRxl/xiw0lmZYjX7R6nLFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jt44vJxibrQ/JjhRBkdhh5SGmfRAPWkbnc2+k4CrgYgnQinfaLnL+dHS1n2Ha7dXapI5xaEBNA3GSt7qqJPIl1qe8HZPjTnw/WV4xril7m7oXhtAEeC33nZ5cjVf2/GwW1GZltLYLcT81R0zcjGi8F23nfoBMqjiQHzpv9TmGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/A0onfg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737010659; x=1768546659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MvD2J1oZPwkIygePCQJT7XRxl/xiw0lmZYjX7R6nLFo=;
  b=a/A0onfgY9YDj2Y/2ORuisC8m9Efo7hNlgP++cY3nUytgRvqBlzTYDBi
   x1OAb2micnFiCrCQDbPceo7MNvb+2PFuQgdsnUhIi3cDQmj8RThrN3aL/
   8TX7uu94/fIzeWIeilysuLrljKTI9WcDKJTy3HHgfibTeVhPC+x/+PX6G
   tqTVQgF8wavjMqExVBYkpJFYUdxALtcJQDCTmdxNlDKOoOtmWbRwjykP/
   k5vnlBcsCgiSNcDf/ceKrXZgJ4lZmaTz4fUEhuSG3WGEOlxOmDKG9vsb/
   Lm/pFjcMtFrOiJbLezAbLGkPU0UCLq5Vi/0b0bxVDLPDx0/yniATVlJ/l
   g==;
X-CSE-ConnectionGUID: i/oydVynQlq2JNBpJP4xbA==
X-CSE-MsgGUID: +zNLlSE/Tt+X/kbzHVvnTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48796528"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48796528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 22:57:39 -0800
X-CSE-ConnectionGUID: eLi/E/HeQLqWrG4jWw+lAg==
X-CSE-MsgGUID: sJktBkrmTQuhWd2CEZH8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="110365616"
Received: from unknown (HELO HaiSPR.bj.intel.com) ([10.240.192.152])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jan 2025 22:57:34 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	xin@zytor.com,
	andrew.cooper3@citrix.com,
	mingo@redhat.com,
	bp@alien8.de,
	etzhao@outlook.com
Subject: [PATCH] x86/fred: Optimize the FRED entry by prioritizing high-probability event dispatching
Date: Thu, 16 Jan 2025 14:51:45 +0800
Message-Id: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

External interrupts (EVENT_TYPE_EXTINT) and system calls (EVENT_TYPE_OTHER)
occur more frequently than other events in a typical system. Prioritizing
these events saves CPU cycles and optimizes the efficiency of performance-
critical paths.

When examining the compiler-generated assembly code for event dispatching
in the functions fred_entry_from_user() and fred_entry_from_kernel(), it
was observed that the compiler intelligently uses a binary search to match
all event type values (0-7) and perform dispatching. As a result, even if
the following cases:

	case EVENT_TYPE_EXTINT:
		return fred_extint(regs);
	case EVENT_TYPE_OTHER:
		return fred_other(regs);

are placed at the beginning of the switch() statement, the generated
assembly code would remain the same, and the expected prioritization would
not be achieved.

Command line to check the assembly code generated by the compiler for
fred_entry_from_user():

$objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'

00000000000015a0 <fred_entry_from_user>:
15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
15ab:       55                      push   %rbp
15ac:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
15b3:       ff
15b4:       83 e0 0f                and    $0xf,%eax
15b7:       48 89 e5                mov    %rsp,%rbp
15ba:       3c 04                   cmp    $0x4,%al
-->>			            /* match 4(EVENT_TYPE_SWINT) first */
15bc:       74 78                   je     1636 <fred_entry_from_user+0x96>
15be:       77 15                   ja     15d5 <fred_entry_from_user+0x35>
15c0:       3c 02                   cmp    $0x2,%al
15c2:       74 53                   je     1617 <fred_entry_from_user+0x77>
15c4:       77 65                   ja     162b <fred_entry_from_user+0x8b>
15c6:       84 c0                   test   %al,%al
15c8:       75 42                   jne    160c <fred_entry_from_user+0x6c>
15ca:       e8 71 fc ff ff          callq  1240 <fred_extint>
15cf:       5d                      pop    %rbp
15d0:       e9 00 00 00 00          jmpq   15d5 <fred_entry_from_user+0x35>
15d5:       3c 06                   cmp    $0x6,%al
15d7:       74 7c                   je     1655 <fred_entry_from_user+0xb5>
15d9:       72 66                   jb     1641 <fred_entry_from_user+0xa1>
15db:       3c 07                   cmp    $0x7,%al
15dd:       75 2d                   jne    160c <fred_entry_from_user+0x6c>
15df:       8b 87 a4 00 00 00       mov    0xa4(%rdi),%eax
15e5:       25 ff 00 00 02          and    $0x20000ff,%eax
15ea:       3d 01 00 00 02          cmp    $0x2000001,%eax
15ef:       75 6f                   jne    1660 <fred_entry_from_user+0xc0>
15f1:       48 8b 77 50             mov    0x50(%rdi),%rsi
15f5:       48 c7 47 50 da ff ff    movq   $0xffffffffffffffda,0x50(%rdi)
... ...

Command line to check the assembly code generated by the compiler for
fred_entry_from_kernel():

$objdump -d vmlinux.o | awk '/<fred_entry_from_kernel>:/{c=65} c&&c--'

00000000000016b0 <fred_entry_from_kernel>:
16b0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
16b7:       48 8b 77 78             mov    0x78(%rdi),%rsi
16bb:       55                      push   %rbp
16bc:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
16c3:       ff
16c4:       83 e0 0f                and    $0xf,%eax
16c7:       48 89 e5                mov    %rsp,%rbp
16ca:       3c 03                   cmp    $0x3,%al
-->>                                /* match 3(EVENT_TYPE_HWEXC) first */
16cc:       74 3c                 je     170a <fred_entry_from_kernel+0x5a>
16ce:       76 13                 jbe    16e3 <fred_entry_from_kernel+0x33>
16d0:       3c 05                 cmp    $0x5,%al
16d2:       74 41                 je     1715 <fred_entry_from_kernel+0x65>
16d4:       3c 06                 cmp    $0x6,%al
16d6:       75 27                 jne    16ff <fred_entry_from_kernel+0x4f>
16d8:       e8 73 fe ff ff        callq  1550 <fred_swexc.isra.3>
16dd:       5d                    pop    %rbp
... ...

Therefore, it is necessary to handle EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER
before the switch statement using if-else syntax to ensure the compiler
generates the desired code. After applying the patch, the verification
results are as follows:

$objdump -d vmlinux.o | awk '/<fred_entry_from_user>:/{c=65} c&&c--'

00000000000015a0 <fred_entry_from_user>:
15a0:       0f b6 87 a6 00 00 00    movzbl 0xa6(%rdi),%eax
15a7:       48 8b 77 78             mov    0x78(%rdi),%rsi
15ab:       55                      push   %rbp
15ac:       48 c7 47 78 ff ff ff    movq   $0xffffffffffffffff,0x78(%rdi)
15b3:       ff
15b4:       48 89 e5                mov    %rsp,%rbp
15b7:       83 e0 0f                and    $0xf,%eax
15ba:       74 34                   je     15f0 <fred_entry_from_user+0x50>
-->>				    /* match 0(EVENT_TYPE_EXTINT) first */
15bc:       3c 07                   cmp    $0x7,%al
-->>                                /* match 7(EVENT_TYPE_OTHER) second *
15be:       74 6e                   je     162e <fred_entry_from_user+0x8e>
15c0:       3c 04                   cmp    $0x4,%al
15c2:       0f 84 93 00 00 00       je     165b <fred_entry_from_user+0xbb>
15c8:       76 13                   jbe    15dd <fred_entry_from_user+0x3d>
15ca:       3c 05                   cmp    $0x5,%al
15cc:       74 41                   je     160f <fred_entry_from_user+0x6f>
15ce:       3c 06                   cmp    $0x6,%al
15d0:       75 51                   jne    1623 <fred_entry_from_user+0x83>
15d2:       e8 79 ff ff ff          callq  1550 <fred_swexc.isra.3>
15d7:       5d                      pop    %rbp
15d8:       e9 00 00 00 00          jmpq   15dd <fred_entry_from_user+0x3d>
15dd:       3c 02                   cmp    $0x2,%al
15df:       74 1a                   je     15fb <fred_entry_from_user+0x5b>
15e1:       3c 03                   cmp    $0x3,%al
15e3:       75 3e                   jne    1623 <fred_entry_from_user+0x83>
... ...

The same desired code in fred_entry_from_kernel is no longer repeated.

While the C code with if-else placed before switch() may appear ugly, it
works. Additionally, using a jump table is not advisable; even if the jump
table resides in the L1 cache, the cost of loading it is over 10 times the
latency of a cmp instruction.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
---
 arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..591f47771ecf 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -228,9 +228,18 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
 	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
 	regs->orig_ax = -1;
 
-	switch (regs->fred_ss.type) {
-	case EVENT_TYPE_EXTINT:
+	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
 		return fred_extint(regs);
+	else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
+		return fred_other(regs);
+
+	/*
+	 * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type events
+	 * first due to their high probability and let the compiler create binary search
+	 * dispatching for the remaining events
+	 */
+
+	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_NMI:
 		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
 			return fred_exc_nmi(regs);
@@ -245,8 +254,6 @@ __visible noinstr void fred_entry_from_user(struct pt_regs *regs)
 		break;
 	case EVENT_TYPE_SWEXC:
 		return fred_swexc(regs, error_code);
-	case EVENT_TYPE_OTHER:
-		return fred_other(regs);
 	default: break;
 	}
 
@@ -260,9 +267,15 @@ __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
 	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
 	regs->orig_ax = -1;
 
-	switch (regs->fred_ss.type) {
-	case EVENT_TYPE_EXTINT:
+	if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
 		return fred_extint(regs);
+
+	/*
+	 * Dispatch EVENT_TYPE_EXTINT type event first due to its high probability
+	 * and let the compiler do binary search dispatching for the other events
+	 */
+
+	switch (regs->fred_ss.type) {
 	case EVENT_TYPE_NMI:
 		if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
 			return fred_exc_nmi(regs);
-- 
2.31.1


