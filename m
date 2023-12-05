Return-Path: <stable+bounces-4070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D28045DF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11E61C20C6B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973A6FB0;
	Tue,  5 Dec 2023 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhpoIc6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0506AA0;
	Tue,  5 Dec 2023 03:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6D6C433C8;
	Tue,  5 Dec 2023 03:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746541;
	bh=sOIc1kJeh/kl2qvaTCCoUSOQsjLe4dixBqvtOpuafNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhpoIc6iKSo5t8DveBQE3XslCCY6M9TRd+sD37y77mtALf97DuFCgmncr+R41hRto
	 ZPClwuNOhVp6TRntNqcbDKfyZulJqedWx786VNw8+X7HmysM/WxxrdAFVBiDmpDLZ/
	 FzyzART5P6F/LM9pMjnSnOTI0dccgu7ZEQylcaTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 063/134] parisc: Mark altinstructions read-only and 32-bit aligned
Date: Tue,  5 Dec 2023 12:15:35 +0900
Message-ID: <20231205031539.530017780@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 33f806da2df68606f77d7b892cd1298ba3d463e8 upstream.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org   # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/alternative.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/parisc/include/asm/alternative.h
+++ b/arch/parisc/include/asm/alternative.h
@@ -34,7 +34,8 @@ void apply_alternatives(struct alt_instr
 
 /* Alternative SMP implementation. */
 #define ALTERNATIVE(cond, replacement)		"!0:"	\
-	".section .altinstructions, \"aw\"	!"	\
+	".section .altinstructions, \"a\"	!"	\
+	".align 4				!"	\
 	".word (0b-4-.)				!"	\
 	".hword 1, " __stringify(cond) "	!"	\
 	".word " __stringify(replacement) "	!"	\
@@ -44,7 +45,8 @@ void apply_alternatives(struct alt_instr
 
 /* to replace one single instructions by a new instruction */
 #define ALTERNATIVE(from, to, cond, replacement)\
-	.section .altinstructions, "aw"	!	\
+	.section .altinstructions, "a"	!	\
+	.align 4			!	\
 	.word (from - .)		!	\
 	.hword (to - from)/4, cond	!	\
 	.word replacement		!	\
@@ -52,7 +54,8 @@ void apply_alternatives(struct alt_instr
 
 /* to replace multiple instructions by new code */
 #define ALTERNATIVE_CODE(from, num_instructions, cond, new_instr_ptr)\
-	.section .altinstructions, "aw"	!	\
+	.section .altinstructions, "a"	!	\
+	.align 4			!	\
 	.word (from - .)		!	\
 	.hword -num_instructions, cond	!	\
 	.word (new_instr_ptr - .)	!	\



