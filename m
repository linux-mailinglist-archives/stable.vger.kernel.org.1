Return-Path: <stable+bounces-167086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60DB21992
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983121A24013
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF5286411;
	Mon, 11 Aug 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4DraMQJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA22285CBD;
	Mon, 11 Aug 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956345; cv=none; b=YWtRastWHWQG463PiQQV3+AAR+bLPwVVaCX9pIgPOKfzyI6tLlHVaKe0Pp62iKowi9QhI7/X5ITZBbRomrYWbdq85mo4i60cCdNNrE0T+8xgNAXCgEmsUrFpvJ4fpuJzlC62INmrClYBZnzsIR3sAPVwr53bH5tS4Hma26QcyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956345; c=relaxed/simple;
	bh=ixTVEja8nuZcKnLD4jQDARKlZDlmffITVD5GgOh07VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk1nu+OxWnutKoMVCBVURBJO+1mW1ouvIXIZ7PJu7QvwFsD7pfL+PAHZz4L1x0ACW/ck5hFCjj7o75FvhEq5zc158P+4f341zHTbh1sOnDSATE+kOgowd6qUlqq4ZELsZRoCO3hrcZxn7mWu3iSSHxhuSAfoOXDiFl8A7me50XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4DraMQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0CBC4CEED;
	Mon, 11 Aug 2025 23:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956345;
	bh=ixTVEja8nuZcKnLD4jQDARKlZDlmffITVD5GgOh07VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4DraMQJ3gsoHkW1UFss7dsCSP7gVs0Z/Pa6BssfszWh0fDtAtffE7Hyqk1wRW8TP
	 WhdXUGcKkpQWtCAl+gGdI8SzmQ/vy8u7uHr6vYpg/ety+z3OZqn4ImYJjQpjRyCw+8
	 uAXfxL46DJQWY3n+Xi10hWLtRYNHGgsQYqg2jEhRLLWi7lddHYhtYkq8NtbjZzzXVK
	 wI4FTfNBG1TDGgufZC6loX/939wjo7FZSf0Sc3Hr0mQgREzq+CJWibDXCnp6OU4H0d
	 jcLkQPhnWckGgfSM/kXEov+8Suu3ul4LgoVExx+1HwbsQy871S1YGCCkHMVmKGwtaa
	 VgBe9xXjDujqA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 5/6] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
Date: Mon, 11 Aug 2025 16:51:50 -0700
Message-ID: <20250811235151.1108688-6-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811235151.1108688-1-nathan@kernel.org>
References: <20250811235151.1108688-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

commit feb843a469fb0ab00d2d23cfb9bcc379791011bb upstream.

When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.

As a result, the linker script is preprocessed with predefined macros
for the build host instead of the target.

Assuming you use an x86 build machine, compare the following:

 $ clang -dM -E -x c /dev/null
 $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu

There is no actual problem presumably because our linker scripts do not
rely on such predefined macros, but it is better to define correct ones.

Move $(CLANG_FLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
will be processed with the proper target triple.

[Note]
After the patch submission, we got an actual problem that needs this
commit. (CBL issue 1859)

Link: https://github.com/ClangBuiltLinux/linux/issues/1859
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f65e282f4a3f..16a23aaaa547 100644
--- a/Makefile
+++ b/Makefile
@@ -568,8 +568,7 @@ ifneq ($(LLVM_IAS),1)
 CLANG_FLAGS	+= -no-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
-- 
2.50.1


