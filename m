Return-Path: <stable+bounces-172666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDFB32C93
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 01:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2353A564002
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974D228C9D;
	Sat, 23 Aug 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/OuGmvE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F404D599
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755992854; cv=none; b=a7xMZAaQi5R42rtKcyPKaz3k2W3lCFkXXtWxypg9AKHmKTD/YLxuEaXlfr8cmPW446Q8OBDq8Pc48l0Ofqlq+WIybSuYYTp7XCSc8Skb2sSI0CQJ0evWQXRy1GHGuDGaO2wUEOElkLYr0x5ODng40yOkKyq8evkQMprdoFvuFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755992854; c=relaxed/simple;
	bh=Qpkt5JVV+oBYQOMxaK/jKNeMW+OePPbavAjUMj2XQqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw8eb6ENQF2VZoJiOFkWFVxbOprz0m92u8NvVcdsKHTkhPpl9E+5cElIuSw/h1cD8CKPqF6rRiWFPcuJ7OB3cTEnNVMoIiwwMMNHkiW7chSUELyFD3iWN9ftpEijpqfeQp/aA7CGvZ8pPwaUeMbdyDTr/q/jg2Ds22bnckJ14HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/OuGmvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3850AC4CEE7;
	Sat, 23 Aug 2025 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755992853;
	bh=Qpkt5JVV+oBYQOMxaK/jKNeMW+OePPbavAjUMj2XQqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/OuGmvEy/dWVFXuFg4zVcQn0Clgi2j0XWqCiUrB9AfGTVxE4b48obhTDSeh1JSrz
	 SngE7afSYS9mfVjRxr60VNutMYUhUQ7wtKRg3cm6ykedyPa4H0MQYpDcbM5vf2GgW1
	 FhTSSP77LCVncxNo9YZv+geZzmvx2Al37dikdURV4TFxwZgxrKIPAel5xRNKb3GT6w
	 YO+ORelEg5+hKBYufnBPvb4uj9zx4QVJK4tO7gFIDWrjvg7PQEMpm0fqwGdjP3edXn
	 kz3jDw0QAYrc6Opodtdg2Wt6CcDf9MJ/X89yzIr+n1xwJ1pKsBU1TAgM90nYiY0f0b
	 PF/fLbioJ1AWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Sat, 23 Aug 2025 19:47:31 -0400
Message-ID: <20250823234731.2467994-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082216-dripping-prompter-8939@gregkh>
References: <2025082216-dripping-prompter-8939@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Beulich <jbeulich@suse.com>

[ Upstream commit 8ea815399c3fcce1889bd951fec25b5b9a3979c1 ]

__ADDRESSABLE_ASM_STR() is where the necessary stringification happens.
As long as "sym" doesn't contain any odd characters, no quoting is
required for its use with .quad / .long. In fact the quotation gets in
the way with gas 2.25; it's only from 2.26 onwards that quoted symbols
are half-way properly supported.

However, assembly being different from C anyway, drop
__ADDRESSABLE_ASM_STR() and its helper macro altogether. A simple
.global directive will suffice to get the symbol "declared", i.e. into
the symbol table. While there also stop open-coding STATIC_CALL_TRAMP()
and STATIC_CALL_KEY().

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <609d2c74-de13-4fae-ab1a-1ec44afb948d@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/xen/hypercall.h | 5 +++--
 include/linux/compiler.h             | 8 --------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af..2759524b8ffc 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -94,12 +94,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 #ifdef MODULE
 #define __ADDRESSABLE_xen_hypercall
 #else
-#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#define __ADDRESSABLE_xen_hypercall \
+	__stringify(.global STATIC_CALL_KEY(xen_hypercall);)
 #endif
 
 #define __HYPERCALL					\
 	__ADDRESSABLE_xen_hypercall			\
-	"call __SCT__xen_hypercall"
+	__stringify(call STATIC_CALL_TRAMP(xen_hypercall))
 
 #define __HYPERCALL_ENTRY(x)	"a" (x)
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b15911e201bf..d18542d7e17b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -223,14 +223,6 @@ static inline void *offset_to_ptr(const int *off)
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
-#define __ADDRESSABLE_ASM(sym)						\
-	.pushsection .discard.addressable,"aw";				\
-	.align ARCH_SEL(8,4);						\
-	ARCH_SEL(.quad, .long) __stringify(sym);			\
-	.popsection;
-
-#define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
-
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
-- 
2.50.1


