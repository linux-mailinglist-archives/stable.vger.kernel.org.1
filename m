Return-Path: <stable+bounces-128657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35844A7EA7D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2693BD362
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7725EF9B;
	Mon,  7 Apr 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTireBY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBF2222C4;
	Mon,  7 Apr 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049611; cv=none; b=NrWAf9Kw9Fd5lIgziPKIWDdBgICp61SbWmWMNrsSQTbb3hC6PPgKMvDrquWGqRcNfdKUduj1b1LKsYszHrINAz1n4zFyVemPqMSI0q2+rgsvfOU0ojZZuTDVXbn01leHz5rfSvbJZYP+E5HzeyMySQcfq0kVU2bkjyWpLg8ffY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049611; c=relaxed/simple;
	bh=HUUon//Jhnm++nSXg4SODznjq7cHjuBfxI2rWh8ozpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akAyxS+dSX/kWlbQUtSVRwxTY4nR0QvQv2GCAylVG5SWJOMv540v53EZzXI8BSySIAETXt7SzDhJtojwjbdWGBPJjlQKyVXPwsRRynB67wo6PHf6aLzFHNTqweP+u65FZdnztzlfGrGfNdTzyhUz9cvNC5SdbAVOAW1TO4EXAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTireBY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3A3C4CEDD;
	Mon,  7 Apr 2025 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049611;
	bh=HUUon//Jhnm++nSXg4SODznjq7cHjuBfxI2rWh8ozpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTireBY7GHTxdThW/4/fYIiRoUo/Vom3BLErvKlf/cDuIIWeOQ6+iSX1aR6+TxF/b
	 nKtwu3xHRrRupQu7+7stZjSX0BK/JtO1I0u9L/c1/AQarxkATgel2djVfcQ6Xgubkq
	 f9uPZ5yJae75r9l6BEeX+vkCiKqvdcwZ7SU2lPRb/aG4KfPwosPVSaeiQR8IzTM+Fj
	 /0J0CsuQ3iSpWjoxgFT6E/JYOHIHoMIUo84OPPAhGIMX2QZ6fbf/QtF3DNsvb7PcGZ
	 dy9kF9nQRkdfwDqTV3odoXgraqpbqbH66j+Ztcy/cqgYBMUcRsjYd2Fp8quJaSh0oG
	 Idkidf95XP+3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.13 28/28] objtool, lkdtm: Obfuscate the do_nothing() pointer
Date: Mon,  7 Apr 2025 14:12:18 -0400
Message-Id: <20250407181224.3180941-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 05026ea01e95ffdeb0e5ac8fb7fb1b551e3a8726 ]

If execute_location()'s memcpy of do_nothing() gets inlined and unrolled
by the compiler, it copies one word at a time:

    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x1374
    mov    %rax,0x38(%rbx)
    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x136c
    mov    %rax,0x30(%rbx)
    ...

Those .text references point to the middle of the function, causing
objtool to complain about their lack of ENDBR.

Prevent that by resolving the function pointer at runtime rather than
build time.  This fixes the following warning:

  drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x23: relocation to !ENDBR: .text+0x1378

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503191453.uFfxQy5R-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lkdtm/perms.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5b861dbff27e9..6c24426104ba6 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -28,6 +28,13 @@ static const unsigned long rodata = 0xAA55AA55;
 /* This is marked __ro_after_init, so it should ultimately be .rodata. */
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
+/*
+ * This is a pointer to do_nothing() which is initialized at runtime rather
+ * than build time to avoid objtool IBT validation warnings caused by an
+ * inlined unrolled memcpy() in execute_location().
+ */
+static void __ro_after_init *do_nothing_ptr;
+
 /*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
@@ -65,13 +72,12 @@ static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing_text);
+	pr_info("attempting ok execution at %px\n", do_nothing_ptr);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing_text, EXEC_SIZE);
+		memcpy(dst, do_nothing_ptr, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
@@ -267,6 +273,8 @@ static void lkdtm_ACCESS_NULL(void)
 
 void __init lkdtm_perms_init(void)
 {
+	do_nothing_ptr = dereference_function_descriptor(do_nothing);
+
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }
-- 
2.39.5


