Return-Path: <stable+bounces-4277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABB8046D0
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82455B20C75
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1708A59;
	Tue,  5 Dec 2023 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JX2kH57p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB46FB1;
	Tue,  5 Dec 2023 03:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11D3C433C7;
	Tue,  5 Dec 2023 03:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747110;
	bh=2PHNkkB/AecQOvty3x82+68bKGKZe5/+HshK2Y3znpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JX2kH57pJvHCvmKENuOxnUcDNdRX0OLtKsv+jEh5dSsDrevDvP8Qbtroi+/fgXzG/
	 +wEA2gNvONceRA78fJXPFZ89i+SIM8t5SxcQYyP39D8LAfMwbPcHxOydeAGt60FvWr
	 GbZ2Sa3OVcjLaYnYCfUjpdXg/pzvkgNYe2gZ7muc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 038/107] parisc: Use natural CPU alignment for bug_table
Date: Tue,  5 Dec 2023 12:16:13 +0900
Message-ID: <20231205031533.824542180@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit fe76a1349f235969381832c83d703bc911021eb6 upstream.

Make sure that the __bug_table section gets 32- or 64-bit aligned,
depending if a 32- or 64-bit kernel is being built.
Mark it non-writeable and use .blockz instead of the .org assembler
directive to pad the struct.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org   # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/bug.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 4b6d60b94124..b9cad0bb4461 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -28,13 +28,15 @@
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %4\n"				\
 			     "2:\t" ASM_WORD_INSN "1b, %c0\n"		\
-			     "\t.short %c1, %c2\n"			\
-			     "\t.org 2b+%c3\n"				\
+			     "\t.short %1, %2\n"			\
+			     "\t.blockz %3-2*%4-2*2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (__FILE__), "i" (__LINE__),	\
-			     "i" (0), "i" (sizeof(struct bug_entry)) ); \
+			     "i" (0), "i" (sizeof(struct bug_entry)),	\
+			     "i" (sizeof(long)) );			\
 		unreachable();						\
 	} while(0)
 
@@ -51,27 +53,31 @@
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %4\n"				\
 			     "2:\t" ASM_WORD_INSN "1b, %c0\n"		\
-			     "\t.short %c1, %c2\n"			\
-			     "\t.org 2b+%c3\n"				\
+			     "\t.short %1, %2\n"			\
+			     "\t.blockz %3-2*%4-2*2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (__FILE__), "i" (__LINE__),	\
 			     "i" (BUGFLAG_WARNING|(flags)),		\
-			     "i" (sizeof(struct bug_entry)) );		\
+			     "i" (sizeof(struct bug_entry)),		\
+			     "i" (sizeof(long)) );			\
 	} while(0)
 #else
 #define __WARN_FLAGS(flags)						\
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
-			     "\t.pushsection __bug_table,\"aw\"\n"	\
+			     "\t.pushsection __bug_table,\"a\"\n"	\
+			     "\t.align %2\n"				\
 			     "2:\t" ASM_WORD_INSN "1b\n"		\
-			     "\t.short %c0\n"				\
-			     "\t.org 2b+%c1\n"				\
+			     "\t.short %0\n"				\
+			     "\t.blockz %1-%2-2\n"			\
 			     "\t.popsection"				\
 			     : : "i" (BUGFLAG_WARNING|(flags)),		\
-			     "i" (sizeof(struct bug_entry)) );		\
+			     "i" (sizeof(struct bug_entry)),		\
+			     "i" (sizeof(long)) );			\
 	} while(0)
 #endif
 
-- 
2.43.0




