Return-Path: <stable+bounces-83111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B283F995B10
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC1D28A85D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DB3219CB7;
	Tue,  8 Oct 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBt/OjTn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kFJF4NVm"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44721503B;
	Tue,  8 Oct 2024 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427541; cv=none; b=EG0IKNxTmXVzZtz6Re0pgnoaIdUOFLUoxGZyJJdLyQxyFdk7IMaeIba0OgxJGCnOPyKN/ERwmpJR21pLZXScXc5pPMbycdrf99eNNOJQx9n7ZP7Ndkh2hxwDjNeCaw50aPFd/J1pJxDO1gmbS84YHZqo5xmoa7OL2d0IKtMacqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427541; c=relaxed/simple;
	bh=54l9PdCjEhlyVQ9zi0cjUikc7X1idmX1Xtop4sXdpnI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f+U+s4KkY5YGPWvTuzPLXY3Sr5qC2sq5nvhGO7zFLQyeZWjF9wIec06IRkqohMVGoqLhmUFHtglCc6FDs4iwpCVdv9r6daxyMIz5jQiXIF7syNozE1nz7hxd/VkkIOGobbe1KfBLHRVSxHIeHtpogMiGuMCOjO0jOM8pcZ4EwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBt/OjTn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kFJF4NVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 22:45:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728427537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AC0y1WHTZBjHlakJ3w0/wY/0LfmAquvOys7NVDN5Wg4=;
	b=TBt/OjTnw2Rr+mA+qbHy2zQm4ZRuDpMMKQvbk1h+x5h1nEPjew3VxL+ngq4F4v9Apb9ANm
	U99U4jLz3frMDkKhICSp4XHf3zmdvKgh7Rm8O/bBdstNIwYEykNxTZZV4P0lYDpkdP3Lg/
	UFzMqIDU1AiqIGnGyQt9JKaktklHemd/TwzkldqQVzf0ePte0RSQdoitGW3yIg/gHKu7OC
	Khp0KKDH0dcRI602ze7smr/gIUJLFBbFeGxR0wMthOBQa2zgphG3Mu00dCwCGhLvgu5S35
	r/WScEQM65UTU47AiGnELvGNbtF5lSArx0aVJk/moJmJhewgPIXHV03JOLp74A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728427537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AC0y1WHTZBjHlakJ3w0/wY/0LfmAquvOys7NVDN5Wg4=;
	b=kFJF4NVmXHH9y9urCZlkQDTEhIrk8AYaAIPYpKrjjPy7na9IKuyx3dtcQEmo+qDqmHaNRz
	ZnlAoHmx6sLwC9Cw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/bugs: Use code segment selector for VERW operand
Cc: Robert Gill <rtgill82@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 5.10+@tip-bot2.tec.linutronix.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172842753652.1442.15253433006014560776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     785bf1ab58aa1f89a5dfcb17b682b7089d69c34f
Gitweb:        https://git.kernel.org/tip/785bf1ab58aa1f89a5dfcb17b682b7089d69c34f
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Thu, 26 Sep 2024 09:10:31 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Oct 2024 15:19:21 -07:00

x86/bugs: Use code segment selector for VERW operand

Robert Gill reported below #GP in 32-bit mode when dosemu software was
executing vm86() system call:

  general protection fault: 0000 [#1] PREEMPT SMP
  CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
  Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
  EIP: restore_all_switch_stack+0xbe/0xcf
  EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
  DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
  CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
  Call Trace:
   show_regs+0x70/0x78
   die_addr+0x29/0x70
   exc_general_protection+0x13c/0x348
   exc_bounds+0x98/0x98
   handle_exception+0x14d/0x14d
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf
   exc_bounds+0x98/0x98
   restore_all_switch_stack+0xbe/0xcf

This only happens in 32-bit mode when VERW based mitigations like MDS/RFDS
are enabled. This is because segment registers with an arbitrary user value
can result in #GP when executing VERW. Intel SDM vol. 2C documents the
following behavior for VERW instruction:

  #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
	   FS, or GS segment limit.

CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
space. Use %cs selector to reference VERW operand. This ensures VERW will
not #GP for an arbitrary user %ds.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Robert Gill <rtgill82@gmail.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com
Cc: stable@vger.kernel.org # 5.10+
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ec..96b410b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,16 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+#ifdef CONFIG_X86_64
+	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+#endif
 .endm
 
 #ifdef CONFIG_X86_64

