Return-Path: <stable+bounces-177671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33DB42D01
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2E51BC14F6
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6832ECEAE;
	Wed,  3 Sep 2025 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="m7RGyHmk"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFF29C339
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939903; cv=none; b=G2FEAj4ag+ioukAelBBj99OgJ909mYErEcrjMVQbW15zSZs8yjuYqtE1u0NeEUw1HVsbXjJAd//imqsr2jWiBpELyrrVdREho0lujU2DJnJuKnHSzhBAyD4ZH5etq7egoYJw99tY/PKK1c5bKj2QDvmLNW2U1RslcZCLtkZipDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939903; c=relaxed/simple;
	bh=Mpu7eWr7e8AOmHVsG/NBMiQWqc8On9aiMPdRPFQ+LUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhfvTs2ripqYojTjJHlmJyAh6RcbHCGJ6dl5MfQVMO8JCif3kuOjn6ZvdBX0gW+Y4psdOrO7PGaoQjJnWBhM0bpzhde81c167XOm3bibA1G25fBuSumlSKVWwaVY76QQnoXXp7HO3Q9B1PSh+wG2pMTDk4vQblsIuNYbA4hesc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=m7RGyHmk; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756939902; x=1788475902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYt/1WmUJEXBJPCKZSD5kih/ive7DLQ1VEhGnJMOn6c=;
  b=m7RGyHmkBobqDX5kxEBy7DA6nRLP9UqafFPNytFR2CXfeCMy+7Vrvd2V
   N1Ydf6VimxWehtvC4BZGZ7qmNNNePKuN8AsNmXZC7ef2vDp+hRgkq1aVd
   4S2seIGKdosWjQWfRa0ch4n9Zpspw92WZpAkg4iLxwneK+gFNwfOLOewy
   +ZLHtHyKc4plWldBAmAseQ6/G5IZfpH0PW8IpsFyAJiQNmZO1N/4VYcYo
   7vhnZo4rIAjTp3s6ZNU1GoBbURADzbS1s9ul5ZwuWUIgqpnmSbNP9KjH9
   7JvAO1zEKH4q3rYkhc1oREDpyrzVXlQbRqFDK/CroXz2cY7YQ4WWmv5VR
   g==;
X-CSE-ConnectionGUID: jrYR8khYQoeC4/Ur/4C3hg==
X-CSE-MsgGUID: 8XwGbdpeT2iChsXP2LNeCA==
X-IronPort-AV: E=Sophos;i="6.16,229,1744070400"; 
   d="scan'208";a="2352089"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 22:51:41 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:42275]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.7:2525] with esmtp (Farcaster)
 id 64a8fb41-9078-4bba-8d97-0a81a3a93d48; Wed, 3 Sep 2025 22:51:41 +0000 (UTC)
X-Farcaster-Flow-ID: 64a8fb41-9078-4bba-8d97-0a81a3a93d48
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:51:41 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.254.121) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	"Suraj Jitindar Singh" <surajjs@amazon.com>
Subject: [PATCH 5.10 3/4] x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
Date: Wed, 3 Sep 2025 15:50:02 -0700
Message-ID: <20250903225003.50346-4-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903225003.50346-1-surajjs@amazon.com>
References: <20250903225003.50346-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 052040e34c08428a5a388b85787e8531970c0c67 upstream.

Retpoline mitigation for spectre-v2 uses thunks for indirect branches. To
support this mitigation compilers add a CS prefix with
-mindirect-branch-cs-prefix. For an indirect branch in asm, this needs to
be added manually.

CS prefix is already being added to indirect branches in asm files, but not
in inline asm. Add CS prefix to CALL_NOSPEC for inline asm as well. There
is no JMP_NOSPEC for inline asm.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-2-96599fed0f33@linux.intel.com
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.10.x
---
 arch/x86/include/asm/nospec-branch.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bb7dd09dc295..2cade6749322 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -119,9 +119,8 @@
 .endm
 
 /*
- * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
- * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -281,12 +280,24 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
+ */
+#define __CS_PREFIX(reg)				\
+	".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
+	".ifc \\rs," reg "\n"				\
+	".byte 0x2e\n"					\
+	".endif\n"					\
+	".endr\n"
+
 /*
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 #ifdef CONFIG_RETPOLINE
-#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
 #else
 #define CALL_NOSPEC	"call *%[thunk_target]\n"
 #endif
-- 
2.34.1


