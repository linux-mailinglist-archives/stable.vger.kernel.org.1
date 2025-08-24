Return-Path: <stable+bounces-172761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AFCB33211
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A7E189D2D1
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959C1A8F6D;
	Sun, 24 Aug 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv7MyUXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7022CCC5
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060256; cv=none; b=YjaXreKvLTw9fvxFIKGEwEalStDlsEB7U/xiPc14D0+4GHMc8rzQw0nk5oxaUtwo0sZdd9FMXfxe9k6R/4vWvGzLNksk49Ba3MW8Z/KfJmFqZHCzSCHtCFqLbnakZb9XBcJsyYflyULsccB+jrAZLz3+U4RpxFak0AvjsP+ZdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060256; c=relaxed/simple;
	bh=e8cIdAuE1Jwf7gNVadEPdnsurf8I2qiXIYP03F+h9QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIs2pV82Uii4cRS4XrH6X/HQ301udDttBuasmmTbfyQvsec0rXM9BJIxTGqCMhY61uNWOhLb1/IVYAm4oPjcH4lJUn/ky7s1K2vX8p9JYZOZw4ZfNRnJxwVcYisA+1quMtaOpGZcOcHeSsDOdI+1FMGxaytgRZ2OqpX2KUPtThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv7MyUXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA6FC4CEEB;
	Sun, 24 Aug 2025 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756060255;
	bh=e8cIdAuE1Jwf7gNVadEPdnsurf8I2qiXIYP03F+h9QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bv7MyUXNFQJKFu78s7uUkHDBDOWg7Z0QuRKNx4q+tKW6SoW5Q5sumf+PVzvT0ADKn
	 V3oDIBmUj2WUUFlMFhk7R837FVnfe7VBNI2nTfrVgUCODxo1Q0PVUYB+psZ8mCkg4c
	 aL8CtF9KIgpnY0cGBGUW2e1FlV38bQmgNpi39KdM2CLFGMTxglz0mvTOfRwFMzgT2o
	 7K+MRM719buHWunIEe+5c1p/8lM8Mj9KosqVFYz4yPtHsO2y8w1s37uwHOEkFOkyBw
	 XTMsFCIvJuNSlJG/liYkLPOk4hFesorFO1vYI9GTJLI8ahiNKZEPX/zfLQuKfYFWJW
	 5VIvgyPU7DgZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] compiler: remove __ADDRESSABLE_ASM{_STR,}() again
Date: Sun, 24 Aug 2025 14:30:52 -0400
Message-ID: <20250824183052.717912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082220-surfboard-widget-ac5d@gregkh>
References: <2025082220-surfboard-widget-ac5d@gregkh>
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
index 13a43651984f..bbd74420fa21 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -242,14 +242,6 @@ static inline void *offset_to_ptr(const int *off)
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


