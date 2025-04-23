Return-Path: <stable+bounces-136315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B66DA99311
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE8816635D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1828A1FA;
	Wed, 23 Apr 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2pk3Lob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00360284678;
	Wed, 23 Apr 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422223; cv=none; b=SSrJWDLKpoPUU65SXuhKPuj/h5JcY6Bkcxw0Qr5AItMB2PtZOw0pKh8D0/yO8st42iguGMOndLbTeFXReZtrK0XB6KXxmQ3tXtY7kgG0e9Rh8jvppAT1FPZVxluZ4S8dAdu01FJHCHj3MZBiv5DKdsfYoC1X1NbEIP81wxVbYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422223; c=relaxed/simple;
	bh=IJJzpA54TdpPB0hyJyoiQdPelyK+hAPjeKeVq8wE9EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbOFmEcCGxwk9O63/o2pZEWH6yxHqvX9F6rKbtcU0I1ilarjbgOOmKQMosn2fXpogRBUVKm6yTICwGGRBVUf+ZCvWb9Thf+enFPtwfwrkuW+hxpZ+9yRdKSprQTa319FbB1wO11DllYtj65Vq2uuVjyGBzviiZl2tiABcMDXek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2pk3Lob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6929AC4CEE2;
	Wed, 23 Apr 2025 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422222;
	bh=IJJzpA54TdpPB0hyJyoiQdPelyK+hAPjeKeVq8wE9EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2pk3LobsY+nQIjI6Dvj7KF+BxI0OZ85NCFHhAkWUXF/oXLNoV8FwUkEeXdRhqVlk
	 KHcfP0xmN8uX3AmBEnqqxzzSQya39MMaVGkiGphpudB6ammNwghRgrqvpNphRBcXFD
	 3txZLClfJAHvj4FN0I1OEbYxjSgm6Ah6KQ9jFEDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 258/291] kbuild: Add -fno-builtin-wcslen
Date: Wed, 23 Apr 2025 16:44:07 +0200
Message-ID: <20250423142634.972284573@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 84ffc79bfbf70c779e60218563f2f3ad45288671 upstream.

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

Disable this optimization with '-fno-builtin-wcslen', which prevents the
compiler from assuming that wcslen() is available in the kernel's C
library.

[ More to the point - it's not that we couldn't implement wcslen(), it's
  that this isn't an optimization at all in the context of the kernel.

  Replacing a simple inlined loop with a function call to the same loop
  is just stupid and pointless if you don't have long strings and fancy
  libraries with vectorization support etc.

  For the regular 'strlen()' cases, we want the compiler to do this in
  order to handle the trivial case of constant strings. And we do have
  optimized versions of 'strlen()' on some architectures. But for
  wcslen? Just no.    - Linus ]

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[nathan: Resolve small conflict in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -1075,6 +1075,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Wer
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# Ensure compilers do not transform certain loops into calls to wcslen()
+KBUILD_CFLAGS += -fno-builtin-wcslen
+
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 



