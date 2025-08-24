Return-Path: <stable+bounces-172725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31862B32FFD
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB570189D4D2
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC72CCC0;
	Sun, 24 Aug 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ6I6B1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93063CF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040506; cv=none; b=GomtvjCWd8kJVlIobFI/5orKaE0sM1SD96Wv9I0YUyfuOW5H61sF7RKfXvRx7Jgj4B7nJbcGNNAdULyw/U4AzREjenap38K+CCre2dNF3HZmIhg9dip5Qhs6L5BCluduuNBgCXGimzyABZZJ5cv+t+kHWXO4GanZCC6QlnFM0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040506; c=relaxed/simple;
	bh=jTSF2YHv5xgrBimIRCwB0TpAavp2BSJgsVxTcp3AX7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPBvou6j+2DrReQACoTDz1q4cQca6fkvftnG6fCEnxdGx7J0nfIkeNM3zfV9J0Pp8yVUof88QwguRVuEUJoWe3MOJfveD6fFC0/qSh3ebpKQFNzqcgwxcSdcim4wSwXf9RbIQRL2hR/Q+z4rKyTUh8m8SqkbNeYmxxUVg+zWBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ6I6B1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADC0C4CEEB;
	Sun, 24 Aug 2025 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756040505;
	bh=jTSF2YHv5xgrBimIRCwB0TpAavp2BSJgsVxTcp3AX7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZ6I6B1//Q731b8EqMTqpYF/8KBWYzWEFxA7U9s+SUsmiZeur67TXiZTekXZTgV7j
	 BrkmypgXnNLa7rg2dtHfOvICyvmY30Et5j6Y5Hz/ua80Ggg5z9bzMHpErsrBfRx+Fh
	 dpUnQOaK5BsyJEiJhCTvQl7Uk8sYR/QNZz1ZJbxp+SV7b7C3ENnHrMDJkX9NyG2PvW
	 VyUDhvF23fwfv7BfhCFQmBQVZAgLSVtuH+3ffCRjnXDslLrKtwYYlnFDmAekGCNS9X
	 eZp+vEtkTip1EBmVmoZ2536g7Ub6S1JBbkZ5DFcCSrO/6sXvhUmdx8GDCukmYE4UNc
	 nZEPolQIgRlSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Sun, 24 Aug 2025 09:01:43 -0400
Message-ID: <20250824130143.2748139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082218-headed-visitor-b1a2@gregkh>
References: <2025082218-headed-visitor-b1a2@gregkh>
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
index 9b4eddd5833a..a54c4d3633e9 100644
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
index fdfe8e6ff0b2..f6ea15821cea 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -235,14 +235,6 @@ static inline void *offset_to_ptr(const int *off)
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


