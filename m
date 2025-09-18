Return-Path: <stable+bounces-174264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADEB3626E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4865516B238
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADC25DB0A;
	Tue, 26 Aug 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZWYh0pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D115624D;
	Tue, 26 Aug 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213928; cv=none; b=P1cB6ixqNaiKBj8efiGPxtZCA/AvFbw9WbVGSq9TqIIK4W8OACLWqndAojH+OtOIU5DH2+GX6MIw+Agbez++wpOTTHvkL9V0hrbZm2DyBYq0w6qVxsF7RHqWy3nkhu+58XX0cvVIiwfyzqL+TRtkCsmLiAGTOUdoaMtVQa7/eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213928; c=relaxed/simple;
	bh=Z/i0B2UIaQQnN3alfS/cgcwi7azn4IPofkydlDWVWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxECtMLXZakRjdGNhIErmLoVFDcX1yaV/i4GJOUsFd80GfHtIIiUVogvO9hfWYMpR77uZMr6pSMEahjpfdQXyItQOqz5E4ZTd4jC6BftUgIANghliDv/g03KsLU/jCeXCZ+NhjM8G8skL+XkXuEYZ83S2s9Dy2W98dhonr0In9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZWYh0pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537DAC116D0;
	Tue, 26 Aug 2025 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213927;
	bh=Z/i0B2UIaQQnN3alfS/cgcwi7azn4IPofkydlDWVWLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZWYh0pLHHJ6ArJkGwajd64h38FnLVOjX6y7MOArhCKDHKU6Wl0/GPfGgjXBnQ3LI
	 zpO77pWNZy27fvLKFwaFWpd7Ht8XpGoASsq9HeEjGorBEVEogYvIpNQ4bVJHklrPX5
	 UlkT/JD8U8S3JO6ZJTSsiSEiS12iwQowUsH2NWQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 532/587] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Tue, 26 Aug 2025 13:11:21 +0200
Message-ID: <20250826111006.538916673@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/xen/hypercall.h |    5 +++--
 include/linux/compiler.h             |    8 --------
 2 files changed, 3 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -94,12 +94,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
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
 
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -234,14 +234,6 @@ static inline void *offset_to_ptr(const
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
 



