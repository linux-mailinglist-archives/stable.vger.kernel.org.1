Return-Path: <stable+bounces-177673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587AB42D04
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390251BC0EF6
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09E2EAD0B;
	Wed,  3 Sep 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tx6ejJSf"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719329C339
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939942; cv=none; b=GbaJFgUWdbFGyhsw+tz29l/fJbwNC/+d1xE5YEBVTiDKXLhpXpqNAebQdwVPFYKmdU27dwMF/Y+ia/UF0OCwhpHkDkMlabC/gdIsV923mzPpI2VVjL9VCI+mxdBxLHDZX4qlGzRwR08HhJkgdXhpOktdq6nhlEIrB67RaBwxrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939942; c=relaxed/simple;
	bh=pBXRxM1Z+fAthrIdagh0FZOjH9NtH0b0O13XmKjFIhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ildlZiv4miNQRXAQpPHF/CjaHDNlJsECefqzuXZBHFeu9h7ErKEzreO+RcQRuDpBOp028jkMTdVQoRjDkANBdOP071s5izN9JeUTW7eWEhKtLe6SbZohLzojBqImxt9NnFTFIHdpgbWX66Z3yiOcx46gWS7ZQovSD4qCuEl7VlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tx6ejJSf; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756939937; x=1788475937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J2gGrqrwX4qXgKul5u5Fj4Fp/tg9vWFUjVTOxHf5r1Y=;
  b=Tx6ejJSfVzQbMmHXbfYqMWKDQAWW7bHAymuqVvWHxpKc7ooJn+g0xre+
   7rfvk/IoXagVKSZHco2t7HGDEyBKQW1baZNUEMB5oHrsZRzgxILwNhVNp
   ZjfhuXfT+IrC1+p9M3PnzdicIEiwWaBckQVGqAaDgSrrRir+qYusvOHrq
   J3/4OrUJ0zIJocgr/O33rrZkBdlP+G9CZ7IaokGaX/J5JKnynFzr0csJc
   XNVzfC32zmUKQwRPCjfjyL5hUt9Zy9vcvdwPGhL3Nf66Le4TnRWL1V4gf
   2nTc8fFbuXBVxNlvhCGFQ2R8rwSh05rO9sZsDpxBBLLi9451kU7k1UNdp
   g==;
X-CSE-ConnectionGUID: hBX36h1MR9mVh+MomjxG8w==
X-CSE-MsgGUID: a6Z1XYpDSOOuIX/h08F5eg==
X-IronPort-AV: E=Sophos;i="6.18,236,1751241600"; 
   d="scan'208";a="2230117"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 22:52:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:50103]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.144:2525] with esmtp (Farcaster)
 id b61532d4-8783-4f00-8d11-89a30b72e727; Wed, 3 Sep 2025 22:52:15 +0000 (UTC)
X-Farcaster-Flow-ID: b61532d4-8783-4f00-8d11-89a30b72e727
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:51:06 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.254.121) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Suraj Jitindar Singh
	<surajjs@amazon.com>
Subject: [PATCH 5.10 1/4] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Date: Wed, 3 Sep 2025 15:50:00 -0700
Message-ID: <20250903225003.50346-2-surajjs@amazon.com>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 09d09531a51a24635bc3331f56d92ee7092f5516 upstream.

Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
calls and rely on the objtool retpoline patching infrastructure.

There's no reason these should be alternatives while the vast bulk of
compiler generated retpolines are not.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.10.x
---
 arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ce5e6e70d2a4..3434e5ebd3c7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -118,6 +118,19 @@
 #endif
 .endm
 
+/*
+ * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
+ * to the retpoline thunk with a CS prefix when the register requires
+ * a RAX prefix byte to encode. Also see apply_retpolines().
+ */
+.macro __CS_PREFIX reg:req
+	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
+	.ifc \reg,\rs
+	.byte 0x2e
+	.endif
+	.endr
+.endm
+
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -125,19 +138,18 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	jmp	__x86_indirect_thunk_\reg
 #else
 	jmp	*%\reg
+	int3
 #endif
 .endm
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
-		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	call	__x86_indirect_thunk_\reg
 #else
 	call	*%\reg
 #endif
-- 
2.34.1


