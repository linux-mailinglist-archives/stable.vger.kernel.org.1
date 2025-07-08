Return-Path: <stable+bounces-160715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFCAFD183
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45755583627
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C52E2F0D;
	Tue,  8 Jul 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w4RASzx0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351D1548C;
	Tue,  8 Jul 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992481; cv=none; b=oC362gNnxq6YWe4ttQlWSX4n0M8aZgV6ynjgu5IcpulhREwr0gHEduLcpg5pkt/Jj67wY/3DMNd9K/cz+GwubgygXlhgegM+bqK1FjHlHbemUqXSbJkcV0nR3T0QMxZYR3GNLkTvCqWewPjPGxwy0pu0FABBRlFh13MGaURzEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992481; c=relaxed/simple;
	bh=wxlIqMcCSdiv9wsepa58iCX3RVydZkMT5FBxgjxpTn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4FZtfSRssCCy2sdRmzmVQP4RbKfQ1SLlRyPMCv9xd5SMML6S3PMi/L2natcKhdizKKnk+Ui37PWeMuvtSKF5fQvgj1j/pIZeGI/p904UFLbZ+XCbzAb+eppdrh+T1JWHHs2SIsWze+sX4qb/z+34a7S0iviAmvywxKZAfUmsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w4RASzx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7D2C4CEED;
	Tue,  8 Jul 2025 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992480;
	bh=wxlIqMcCSdiv9wsepa58iCX3RVydZkMT5FBxgjxpTn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w4RASzx0ziqBRZbhCL01qEpOCOpJHQEgm84kwYKxqvu+QygUUsp3SgZy9ZXwoQnIU
	 M+WhgulzNYzGnBb8neViVI98HeUWp/FyE5NfHULGoP7xq9wTUDtzaWITcCm8UenJ4u
	 rwUAbZtLK0NbCTf4sZZq50r+CYm8tv05XBmPW93I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/132] module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper
Date: Tue,  8 Jul 2025 18:23:36 +0200
Message-ID: <20250708162233.674213797@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 707f853d7fa3ce323a6875487890c213e34d81a0 ]

Helper macro to more easily limit the export of a symbol to a given
list of modules.

Eg:

  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm");

will limit the use of said function to kvm.ko, any other module trying
to use this symbol will refure to load (and get modpost build
failures).

Requested-by: Masahiro Yamada <masahiroy@kernel.org>
Requested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Stable-dep-of: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/core-api/symbol-namespaces.rst | 22 ++++++++++++++++++++
 include/linux/export.h                       | 12 +++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 12e4aecdae945..29875e25e376f 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -28,6 +28,9 @@ kernel. As of today, modules that make use of symbols exported into namespaces,
 are required to import the namespace. Otherwise the kernel will, depending on
 its configuration, reject loading the module or warn about a missing import.
 
+Additionally, it is possible to put symbols into a module namespace, strictly
+limiting which modules are allowed to use these symbols.
+
 2. How to define Symbol Namespaces
 ==================================
 
@@ -84,6 +87,22 @@ unit as preprocessor statement. The above example would then read::
 within the corresponding compilation unit before any EXPORT_SYMBOL macro is
 used.
 
+2.3 Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
+===================================================
+
+Symbols exported using this macro are put into a module namespace. This
+namespace cannot be imported.
+
+The macro takes a comma separated list of module names, allowing only those
+modules to access this symbol. Simple tail-globs are supported.
+
+For example:
+
+  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
+
+will limit usage of this symbol to modules whoes name matches the given
+patterns.
+
 3. How to use Symbols exported in Namespaces
 ============================================
 
@@ -155,3 +174,6 @@ in-tree modules::
 You can also run nsdeps for external module builds. A typical usage is::
 
 	$ make -C <path_to_kernel_src> M=$PWD nsdeps
+
+Note: it will happily generate an import statement for the module namespace;
+which will not work and generates build and runtime failures.
diff --git a/include/linux/export.h b/include/linux/export.h
index 9911508a9604f..06f7a4eb64928 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -42,11 +42,17 @@ extern struct module __this_module;
 	.long sym
 #endif
 
-#define ___EXPORT_SYMBOL(sym, license, ns)		\
+/*
+ * LLVM integrated assembler cam merge adjacent string literals (like
+ * C and GNU-as) passed to '.ascii', but not to '.asciz' and chokes on:
+ *
+ *   .asciz "MODULE_" "kvm" ;
+ */
+#define ___EXPORT_SYMBOL(sym, license, ns...)		\
 	.section ".export_symbol","a"		ASM_NL	\
 	__export_symbol_##sym:			ASM_NL	\
 		.asciz license			ASM_NL	\
-		.asciz ns			ASM_NL	\
+		.ascii ns "\0"			ASM_NL	\
 		__EXPORT_SYMBOL_REF(sym)	ASM_NL	\
 	.previous
 
@@ -88,4 +94,6 @@ extern struct module __this_module;
 #define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", __stringify(ns))
 #define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "GPL", __stringify(ns))
 
+#define EXPORT_SYMBOL_GPL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
+
 #endif /* _LINUX_EXPORT_H */
-- 
2.39.5




