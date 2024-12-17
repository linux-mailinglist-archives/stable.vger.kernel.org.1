Return-Path: <stable+bounces-104834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AF9F5332
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86481636DA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C151EF085;
	Tue, 17 Dec 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lABtF0p2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B08615A;
	Tue, 17 Dec 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456244; cv=none; b=O0pw2VpMvYJuf2LUvL5BOZUTXXDrck8a/JYoJ5yFNy1S0g0WV2Qt1EC/fN8KhLMAqj/qHBzMCqwFuQ4/+X2UZdC2BGTaMEgyR/hlT/2bfH6P34+tpzDU9XmOnG/UWKoA9GzpEnZuI5RQ79zLlRfzUVdL08OPt3kBzjnBmqsO0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456244; c=relaxed/simple;
	bh=xtYVzo21dtN4vdLOCAWakhqxBrZzssqJ5Tbngbh1/IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSfoYhkmvLhdcuimop3duxZ5GCSrBiHkzdIsY0NMFXDqpcoj31dclY4xjRySDBEZN/oP4MYKhuGcfuFvJO9RJ/u5A/bth+E85Eajk10Wr/88b3j6V6HeTak9tXyGYaHn1QU54OJG5dImAY/HZZ7n4RUp+CHEdw0jW8QB4p2bSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lABtF0p2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C72C4CED3;
	Tue, 17 Dec 2024 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456244;
	bh=xtYVzo21dtN4vdLOCAWakhqxBrZzssqJ5Tbngbh1/IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lABtF0p2zLAx5r2LHhuwYWqIq36bgW6Swtnly5wfsyQDrcJj28bYEzJ/RJE0ngsCv
	 l3X60kiqDG8MfKkOtth/71k3FFbmPhkfwgdGQ1LJUQkJy83+UxugxY02AfxrySJBcB
	 SRK17AfewWJ3+ZLIKGDYrfLvENAe6agA/2KL6F/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 6.6 107/109] x86/xen: use new hypercall functions instead of hypercall page
Date: Tue, 17 Dec 2024 18:08:31 +0100
Message-ID: <20241217170537.872732328@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
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

From: Juergen Gross <jgross@suse.com>

commit b1c2cb86f4a7861480ad54bb9a58df3cbebf8e92 upstream.

Call the Xen hypervisor via the new xen_hypercall_func static-call
instead of the hypercall page.

This is part of XSA-466 / CVE-2024-53241.

Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/xen/hypercall.h |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -39,9 +39,11 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
+#include <linux/instrumentation.h>
 
 #include <trace/events/xen.h>
 
+#include <asm/alternative.h>
 #include <asm/page.h>
 #include <asm/smap.h>
 #include <asm/nospec-branch.h>
@@ -91,9 +93,17 @@ extern struct { char _entry[32]; } hyper
 void xen_hypercall_func(void);
 DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 
-#define __HYPERCALL		"call hypercall_page+%c[offset]"
-#define __HYPERCALL_ENTRY(x)						\
-	[offset] "i" (__HYPERVISOR_##x * sizeof(hypercall_page[0]))
+#ifdef MODULE
+#define __ADDRESSABLE_xen_hypercall
+#else
+#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#endif
+
+#define __HYPERCALL					\
+	__ADDRESSABLE_xen_hypercall			\
+	"call __SCT__xen_hypercall"
+
+#define __HYPERCALL_ENTRY(x)	"a" (x)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -151,7 +161,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 	__HYPERCALL_0ARG();						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_0PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER0);				\
 	(type)__res;							\
 })
@@ -162,7 +172,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 	__HYPERCALL_1ARG(a1);						\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_1PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER1);				\
 	(type)__res;							\
 })
@@ -173,7 +183,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 	__HYPERCALL_2ARG(a1, a2);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_2PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER2);				\
 	(type)__res;							\
 })
@@ -184,7 +194,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 	__HYPERCALL_3ARG(a1, a2, a3);					\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_3PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER3);				\
 	(type)__res;							\
 })
@@ -195,7 +205,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_h
 	__HYPERCALL_4ARG(a1, a2, a3, a4);				\
 	asm volatile (__HYPERCALL					\
 		      : __HYPERCALL_4PARAM				\
-		      : __HYPERCALL_ENTRY(name)				\
+		      : __HYPERCALL_ENTRY(__HYPERVISOR_ ## name)	\
 		      : __HYPERCALL_CLOBBER4);				\
 	(type)__res;							\
 })
@@ -209,12 +219,9 @@ xen_single_call(unsigned int call,
 	__HYPERCALL_DECLS;
 	__HYPERCALL_5ARG(a1, a2, a3, a4, a5);
 
-	if (call >= PAGE_SIZE / sizeof(hypercall_page[0]))
-		return -EINVAL;
-
-	asm volatile(CALL_NOSPEC
+	asm volatile(__HYPERCALL
 		     : __HYPERCALL_5PARAM
-		     : [thunk_target] "a" (&hypercall_page[call])
+		     : __HYPERCALL_ENTRY(call)
 		     : __HYPERCALL_CLOBBER5);
 
 	return (long)__res;



