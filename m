Return-Path: <stable+bounces-172458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4FFB31E32
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C979418868CE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15223D7C9;
	Fri, 22 Aug 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hbc2nBHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D652217F55
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875664; cv=none; b=sOxJdnl2VR49KxIisYR/hY+5fpxq+Tb6/Rt1YSR68P6A4O78qEFkO09Bi0nxQbZ1Io00CyUB1d8woI+8jx/OKpBsG+dMeJzxk2lvc8Z3iD4WSFueTiCJUYNSyi5UBY1sak2LSZf0yrSyMy4u6BEajHESpTgUQvcHyndh/1f0Wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875664; c=relaxed/simple;
	bh=HcAZJhOtsVaISSnFO7DB6nCIXUY4SsI7i7EFLFomZJg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hwQjHmOzjsggGMvzTClAZfu8zB3pewREa+V1hi1SNLKcRQY2IUwE0KQI/kR2/URxi6Yp5YoRl2E1nd8jI2/KPAIxX+rocK4vlOhI+FcupH3ih2tl5in1dDlqIk4WhIiP9KEDWguhTKAwB5LecqKO/EDi+J0nnIacxKCt7tXrZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hbc2nBHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72121C4CEED;
	Fri, 22 Aug 2025 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755875663;
	bh=HcAZJhOtsVaISSnFO7DB6nCIXUY4SsI7i7EFLFomZJg=;
	h=Subject:To:Cc:From:Date:From;
	b=Hbc2nBHp9kBgHh72cA4wIzQ7dW8UN1z7gZa9l0Ikk5Ou5XJsFxtWzkgCHY4SXEqWS
	 c4W3uyLa1r6zjzBWRvUAQn4/ZHS8aNpek4TAwGmaSKwDi0t83ifQ0qt8imJ3i2i6yj
	 zcdSvxD8931pl7g47e/Yi5ia/NJWUPCxDDCGO+Mo=
Subject: FAILED: patch "[PATCH] compiler: remove __ADDRESSABLE_ASM{_STR,}() again" failed to apply to 6.6-stable tree
To: jbeulich@suse.com,jgross@suse.com,jpoimboe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 17:14:17 +0200
Message-ID: <2025082217-neurotic-pointy-9acf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8ea815399c3fcce1889bd951fec25b5b9a3979c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082217-neurotic-pointy-9acf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ea815399c3fcce1889bd951fec25b5b9a3979c1 Mon Sep 17 00:00:00 2001
From: Jan Beulich <jbeulich@suse.com>
Date: Mon, 14 Apr 2025 16:41:07 +0200
Subject: [PATCH] compiler: remove __ADDRESSABLE_ASM{_STR,}() again

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

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 59a62c3780a2..a16d4631547c 100644
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
index 6f04a1d8c720..64ff73c533e5 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -288,14 +288,6 @@ static inline void *offset_to_ptr(const int *off)
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
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.


