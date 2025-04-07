Return-Path: <stable+bounces-128695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC9A7EA9E
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58ABA7A1705
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42412676E5;
	Mon,  7 Apr 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifWBVfZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81048267728;
	Mon,  7 Apr 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049687; cv=none; b=e9ZKBK6ReANF7vUrTXGpNOmpUbNgslpk0ZAtDSIB34mt4wTLI9VVN51Dnb3RsPkuH/PI6ENMLJoaFznbS5hJ8XCXQADClMSLkDRUXOFNUgMcfVWGpsem138WPOWuoZ5cUCLCeJ09PslesL1MQIr+pr1Wvvx9HTfNWuweKKn0k8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049687; c=relaxed/simple;
	bh=HUUon//Jhnm++nSXg4SODznjq7cHjuBfxI2rWh8ozpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImDbC4NhOaxilOEIRaAAFxipxU0NTQCfEd+JTWZBwvkqnsTo8qOPTntnotpWerHYBAZORjCl3lSCJLKGENSi+LqrMKzJKqAKSKdhLgOfKzkL+DOML+Mdf+t/ojyHSiA1S79CI7YKYO/aqPj1dKOSRTlQS9EngatOTcc0boRnZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifWBVfZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD56C4CEE7;
	Mon,  7 Apr 2025 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049687;
	bh=HUUon//Jhnm++nSXg4SODznjq7cHjuBfxI2rWh8ozpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifWBVfZao/U9jaQ9KniEXlg0GXEMLf39OVJUTK/I0aSHJAw/twZh86O+jrLGf5Pnf
	 4sLOr1s46FMxT74T6U8p6mh51xPHt/QyIsv7b4/vE573/2rWULa8rvwH1ZOwPe4pm6
	 QJ9VP5MQmlkUMyOFwx3z6ZdO/90bUh7d0GltDXrtG6vqKZYUDCVC5Aa4bDo23Xiwr8
	 4H4qZKMxxP7VKpLV4ArTwsNOMTZpB7zjlz/q9GIcBhVjezRmht4Fy9xhoTNpEzKD06
	 i55mHocTWiPjjwWPKiWyoMq1F4d04W0P9DD/nwceDm6hzZk2qFkypsgAuvUZhFaaiH
	 z7Aiw+9KbrRDg==
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
Subject: [PATCH AUTOSEL 6.6 15/15] objtool, lkdtm: Obfuscate the do_nothing() pointer
Date: Mon,  7 Apr 2025 14:14:15 -0400
Message-Id: <20250407181417.3183475-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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


