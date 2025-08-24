Return-Path: <stable+bounces-172671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F2B32CB9
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B921B27425
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F3CA5E;
	Sun, 24 Aug 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scIKzGSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A451FB3
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995545; cv=none; b=S1X6URdppMHxUpmIZ7L8pTaE8Etu/bVs+u2W9QLJm7ZTP4TDlVAkGbbrcIyJhiwcRrddLdRVkKtDKiddsXdmsYPRRbexG9N5v2Z3mtTiULZDimgy4KfEyISlUR1p2M/3AlNFZdFuUCIfld/X9oz3NGBkVAsk+7fWWYgGSXAuguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995545; c=relaxed/simple;
	bh=b4q7ghWsdOUPJuEEvtTHEmSDjmDeKfrsCREviA+kOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpAEV8AGXtXiHdKFr8sW+CuFZmX6QTLsvxNvErbiaW2x5axlGhlyg8I1cjbERiMlCSMDeim241tSnxtDtvceMHazVKJoNfMnTs2o1BOJIU/xXRnPUmNQzSMXNubwNfVMVqrN/aSPa0Ekyz99yTy0vjkjYuUVz6iMGiKDRZ6hoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scIKzGSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B9C4CEE7;
	Sun, 24 Aug 2025 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755995544;
	bh=b4q7ghWsdOUPJuEEvtTHEmSDjmDeKfrsCREviA+kOkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scIKzGSV1cTg467nElyhPQt2BqjcKwUB7AswS+t4tldpuLK5PZ17htZ8BlP037tfK
	 oI74G/ke8JSRk3V0wrXrsG8j6CBKQ1cl31dZ4EvlN6pSbXpRP47ujR91q3UTj/kyg/
	 1imskGNzCMbj+NM7zkjgFQALnULDyZPj/1EIkdaiXqgWOp+oiO5n8TPMs9qrbwT6OK
	 UQwR/aGo84WI4tj5S+mhcKWhBKvpmz1Zy5f01+6Sosf3Ow9RW4y66gwAt4eAleq7iU
	 NAQFMY/4tImTrsfZRSHepLqiCbap/KtWYYxcht/kk/MmYPAGHPId5fLbHR0apjTv4t
	 tj3AhsjkhmZwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Sat, 23 Aug 2025 20:32:21 -0400
Message-ID: <20250824003221.2541871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082217-neurotic-pointy-9acf@gregkh>
References: <2025082217-neurotic-pointy-9acf@gregkh>
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
index 5a4054f17cbc..e84ed3a43f1f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -234,14 +234,6 @@ static inline void *offset_to_ptr(const int *off)
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


