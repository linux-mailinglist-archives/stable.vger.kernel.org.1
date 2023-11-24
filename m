Return-Path: <stable+bounces-1669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB37F80D0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D893A1C215F7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EB3418B;
	Fri, 24 Nov 2023 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6bpJxpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6390321AD;
	Fri, 24 Nov 2023 18:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64437C433C8;
	Fri, 24 Nov 2023 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851979;
	bh=EDQ7paZ9i/Epi/M1VsyzsmWeGeb2VjCdpQEQwJjy4Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x6bpJxpCJcjduX6OTvprm7AONcUkCoU6rCvZnwDBbpSXi7mcVjFij0fp4wcg1O3gO
	 oV+DC6wqowLHYtfCf3WMQ9EAYLi2h9okJ+NDtDrHpieITKhsF43xY5uzFkl0X9M6lo
	 IvkhaVxYQzzRfAB1eFSdqELCucA1aJ6bmkS4TMRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	Julian Andres Klode <julian.klode@canonical.com>,
	Roxana Nicolescu <roxana.nicolescu@canonical.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 172/372] crypto: x86/sha - load modules based on CPU features
Date: Fri, 24 Nov 2023 17:49:19 +0000
Message-ID: <20231124172016.216174022@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roxana Nicolescu <roxana.nicolescu@canonical.com>

commit 1c43c0f1f84aa59dfc98ce66f0a67b2922aa7f9d upstream.

x86 optimized crypto modules are built as modules rather than build-in and
they are not loaded when the crypto API is initialized, resulting in the
generic builtin module (sha1-generic) being used instead.

It was discovered when creating a sha1/sha256 checksum of a 2Gb file by
using kcapi-tools because it would take significantly longer than creating
a sha512 checksum of the same file. trace-cmd showed that for sha1/256 the
generic module was used, whereas for sha512 the optimized module was used
instead.

Add module aliases() for these x86 optimized crypto modules based on CPU
feature bits so udev gets a chance to load them later in the boot
process. This resulted in ~3x decrease in the real-time execution of
kcapi-dsg.

Fix is inspired from commit
aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
where a similar fix was done for sha512.

Cc: stable@vger.kernel.org # 5.15+
Suggested-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Suggested-by: Julian Andres Klode <julian.klode@canonical.com>
Signed-off-by: Roxana Nicolescu <roxana.nicolescu@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/crypto/sha1_ssse3_glue.c   |   12 ++++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c |   12 ++++++++++++
 2 files changed, 24 insertions(+)

--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -24,8 +24,17 @@
 #include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, sha1_block_fn *sha1_xform)
 {
@@ -301,6 +310,9 @@ static inline void unregister_sha1_ni(vo
 
 static int __init sha1_ssse3_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha1_ssse3())
 		goto fail;
 
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -38,11 +38,20 @@
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/string.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, sha256_block_fn *sha256_xform)
 {
@@ -366,6 +375,9 @@ static inline void unregister_sha256_ni(
 
 static int __init sha256_ssse3_mod_init(void)
 {
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 	if (register_sha256_ssse3())
 		goto fail;
 



