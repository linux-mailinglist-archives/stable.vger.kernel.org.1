Return-Path: <stable+bounces-172756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E0B33188
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80998200FF5
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4F204F93;
	Sun, 24 Aug 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KioYpsiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299F1BD9D0
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756054187; cv=none; b=jn7XifbkJkNl0/fLzZN50zYrkB1hZ9RD33EBoqOY9X9wyVHiyU6KQahe3z9xiH835Hr6brC7qVLVtwqZmRQR/sjoW6UsrHcbv3HtQhi2gDPRt+yOxbr5teLAXUMZFO0BBtZvyeXWaKTW5Huy2Sra2Aj3bRsz+B+182cArQZvQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756054187; c=relaxed/simple;
	bh=j4IKskiBB1bCe4jJtbu4j6sEW7PuRtglI0crg+LqBLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZKy7IR58135PnaFirLYiXsz8fIuWkqnwNl0N21wrHn3nByq0JF8jvhPxsPAzI7mmPU2dXkkTNSFY2N4K91ibDAFfZrJhLgvnwYlm/3ZBmBN5SUy4wXp37uLWDDA/OhRoNg0oSZ64oDJXT0N16deFv7XK86kq2C2NNtJ2nXf9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KioYpsiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD54AC4CEEB;
	Sun, 24 Aug 2025 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756054184;
	bh=j4IKskiBB1bCe4jJtbu4j6sEW7PuRtglI0crg+LqBLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KioYpsizrVCnKRe0bQYylFEQV72yirdLP6x6vIUiUDKnOaYuiTHCwkTz7SJCEA91H
	 t4QvZeipxrO4CFFlq6+xML5un1q+sVjGMNAfFiVgWuMkQiio1mAeTBPptXJGc4pkpT
	 PZBP5TCB0mheDQjezZSoAzZhWgUnZjtoldFwlXfEO3MZYzrcYFhFywdlY6CoJelssx
	 mwhc/Aw8ATyHX1Orj1HNbhl+UCl+5Rpoiz7E2pk62zpy9kVuwiLl2nrniNYx6HXmqE
	 KROheEcrYycbOSNEYRfeF7Gq2ugysekULzss9wjxWYSAIWH+a+t77wkJzNyfMPPYi0
	 oifFjJsBb+2xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Sun, 24 Aug 2025 12:49:41 -0400
Message-ID: <20250824164941.4151594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082219-mobile-riding-ffd1@gregkh>
References: <2025082219-mobile-riding-ffd1@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/xen/hypercall.h | 6 ++++--
 include/linux/compiler.h             | 8 --------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 89cd98693efc..019fc7f78d53 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -37,6 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
 #include <linux/instrumentation.h>
@@ -94,12 +95,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
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
index 65c9c0d92f49..4f03dfb6de0d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -249,14 +249,6 @@ static inline void *offset_to_ptr(const int *off)
 	static void * __section(".discard.addressable") __used \
 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
 
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


