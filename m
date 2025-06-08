Return-Path: <stable+bounces-151885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88EAD1217
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504D47A573C
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9430212B0C;
	Sun,  8 Jun 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9LKHsie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFB20F093;
	Sun,  8 Jun 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387278; cv=none; b=di0WGplo5z1XgF7EAHQ82WZ0hQe/ZU8RoYMOf6mPu4EX1NitmCHF+XciW6gRnJOaL7vrQnkr+zun0PCQP80gT0iv24jB27aaYibPLlYTGvWihr3kI+9SP2sAGQDsC4hsXYlOYVt5SH8NaR3dXylgsDuy1e8OvE5rDxxaLLvpbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387278; c=relaxed/simple;
	bh=Su6MEzddryxbeiYI/tv64G/kaJyM+uOqQAkv3AQOOgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im2Zd7w1bGhAF2VtkPLPlDyBbbdNsInb64LgOi6usrlikwS/jeLQftQN9jFkIm9jpNlFBxZ1pZkEz8t0cnYVWqTy2fmrzudGWbsPpjOBFbIM/TE6poGkjDBBESLF6ufib2OOkD2GwiNF+LhMB4OJRHVbOJ9ei129XwYsCqc6vTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9LKHsie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4C8C4CEF4;
	Sun,  8 Jun 2025 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387276;
	bh=Su6MEzddryxbeiYI/tv64G/kaJyM+uOqQAkv3AQOOgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9LKHsie3ErOLae/IH/L/XU61JvtLzA6s+nDg1JZl4JM8OoJ4ILYc67TB6fLv/1BC
	 nH/LDB8khRrRFRbxStvAr+1WNAqemKM4Q3bBEB09+tOZsfbLeRxULpkkMfGlyfy3sh
	 8zMpY1WDEy632044r+HkTOnc7SZB4MpXEX9W0JfJGZ54uoe9MxdrwvEU0LTuh6N+iF
	 j800/byvQie/MNBgRzn9BvhyeOrRS98JBJ8X5Z6RoodiVTHH7S8Er0tlsnaLByhMGR
	 HPvmcTyVRheOo1E0zkMOZm/Vyr6/44otBfEiavZLDC51B/Swo5nOXH2gQmRF7g0z1c
	 82gdgRHly/f+A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rudraksha Gupta <guptarud@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.gaynor@gmail.com,
	nathan@kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.15 04/10] rust: arm: fix unknown (to Clang) argument '-mno-fdpic'
Date: Sun,  8 Jun 2025 08:54:21 -0400
Message-Id: <20250608125427.933430-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125427.933430-1-sashal@kernel.org>
References: <20250608125427.933430-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rudraksha Gupta <guptarud@gmail.com>

[ Upstream commit 977c4308ee4270cf46e2c66b37de8e04670daa0c ]

Currently rust on arm fails to compile due to '-mno-fdpic'. This flag
disables a GCC feature that we don't want for kernel builds, so let's
skip it as it doesn't apply to Clang.

    UPD     include/generated/asm-offsets.h
    CALL    scripts/checksyscalls.sh
    RUSTC L rust/core.o
    BINDGEN rust/bindings/bindings_generated.rs
    BINDGEN rust/bindings/bindings_helpers_generated.rs
    CC      rust/helpers/helpers.o
    Unable to generate bindings: clang diagnosed error: error: unknown argument: '-mno-fdpic'
    make[2]: *** [rust/Makefile:369: rust/bindings/bindings_helpers_generated.rs] Error 1
    make[2]: *** Deleting file 'rust/bindings/bindings_helpers_generated.rs'
    make[2]: *** Waiting for unfinished jobs....
    Unable to generate bindings: clang diagnosed error: error: unknown argument: '-mno-fdpic'
    make[2]: *** [rust/Makefile:349: rust/bindings/bindings_generated.rs] Error 1
    make[2]: *** Deleting file 'rust/bindings/bindings_generated.rs'
    make[1]: *** [/home/pmos/build/src/linux-next-next-20250521/Makefile:1285: prepare] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

[ Naresh provided the draft diff [1].

  Ben explained [2]:

    FDPIC is only relevant with no-MMU targets, and then only for userspace.
    When configured for the arm-*-uclinuxfdpiceabi target, GCC enables FDPIC
    by default to facilitate compiling userspace programs. FDPIC is never
    used for the kernel, and we pass -mno-fdpic when building the kernel to
    override the default and make sure FDPIC is disabled.

  and [3]:

    -mno-fdpic disables a GCC feature that we don't want for kernel builds.
    clang does not support this feature, so it always behaves as though
    -mno-fdpic is passed. Therefore, it should be fine to mix the two, at
    least as far as FDPIC is concerned.

  [1] https://lore.kernel.org/rust-for-linux/CA+G9fYt4otQK4pHv8pJBW9e28yHSGCDncKquwuJiJ_1ou0pq0w@mail.gmail.com/
  [2] https://lore.kernel.org/rust-for-linux/aAKrq2InExQk7f_k@dell-precision-5540/
  [3] https://lore.kernel.org/rust-for-linux/aAo_F_UP1Gd4jHlZ@dell-precision-5540/

    - Miguel ]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYvOanQBYXKSg7C6EU30k8sTRC0JRPJXYu7wWK51w38QUQ@mail.gmail.com/
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
Link: https://lore.kernel.org/r/20250522-rust-mno-fdpic-arm-fix-v2-1-a6f691d9c198@gmail.com
[ Reworded title. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Build Fix Characteristics
This commit fixes a concrete build failure affecting ARM Rust builds.
The error message is clear and specific:
```
Unable to generate bindings: clang diagnosed error: error: unknown
argument: '-mno-fdpic'
```

This represents a fundamental build breakage where Rust compilation
completely fails on ARM when using Clang-based bindgen.

## Code Change Analysis
The fix is surgically precise - it adds `-mno-fdpic` to the
`bindgen_skip_c_flags` list in `/rust/Makefile:276`. This follows the
exact same pattern as numerous other similar fixes that have been
successfully backported.

Looking at the context from `/home/sasha/linux/rust/Makefile:255-277`,
the `bindgen_skip_c_flags` mechanism exists specifically to handle GCC
flags that Clang doesn't understand. The comment explains this is "a
hack" but necessary because "bindgen relies on libclang to parse C" and
there are compatibility issues.

## Historical Precedent from Similar Commits
The provided examples show a clear pattern:

1. **Similar Commit #1 (Backported: YES)** - LoongArch GCC build fix
   adding flags to bindgen skip list
2. **Similar Commit #3 (Backported: NO)** - fstrict-flex-arrays bindgen
   fix
3. **Similar Commit #4 (Backported: YES)** - fzero-init-padding-bits
   bindgen fix

Examining the kernel history, I found additional precedent:
- `a9c621a21712` - Recent commit adding `-fzero-init-padding-bits` to
  bindgen skip flags
- `869b5016e94e` - Added `-fmin-function-alignment` to bindgen skip
  flags

These demonstrate that bindgen compatibility fixes are regularly
backported.

## Technical Context
From `/home/sasha/linux/arch/arm/Makefile:26`, I can see that `-mno-
fdpic` is used in ARM kernel builds:
```makefile
# Disable FDPIC ABI
KBUILD_CFLAGS += $(call cc-option,-mno-fdpic)
```

The commit message explains that FDPIC is a GCC feature for no-MMU
userspace targets that should never be used for kernel builds. Clang
doesn't support this feature and always behaves as if `-mno-fdpic` is
passed. Therefore, filtering it out for bindgen is safe and correct.

## Stable Tree Criteria Compliance
- ✅ **Fixes important bug**: ARM Rust builds completely fail without
  this
- ✅ **Small and contained**: Single line addition to skip flag list
- ✅ **No architectural changes**: Follows established pattern for
  bindgen flag filtering
- ✅ **Minimal regression risk**: Only affects bindgen flag filtering, no
  functional changes
- ✅ **Clear side effects**: None beyond fixing the build failure

## Impact Assessment
This fix enables ARM Rust support to work properly with the standard
toolchain configuration. Without it, any ARM platform wanting to use
Rust features would hit a hard build failure. The change is completely
backward compatible and only affects the flag filtering logic for
bindgen.

The fix matches the exact same pattern as Similar Commits #1 and #4
which were both backported, and addresses the same category of issue -
GCC/Clang toolchain compatibility for Rust builds.

 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 3aca903a7d08c..f207ba0ed466d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -273,7 +273,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
-	-fzero-init-padding-bits=% \
+	-fzero-init-padding-bits=% -mno-fdpic \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
-- 
2.39.5


