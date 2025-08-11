Return-Path: <stable+bounces-167083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE78B2198B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28AB7B1752
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897482857C9;
	Mon, 11 Aug 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqpNwmeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452722857D7;
	Mon, 11 Aug 2025 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956338; cv=none; b=eNcOfYL2hOnIpDPmloMsgOi4K2lhjU58Z6WvSg1ZQ6lNEPdviUfmXyXfgt4v/Hli3gruKtoKnx7pTpkz15R16l+UBSgciNbEwYQ6VPGg++yWxGphHLDFqh9u15W8XzhcHuWqxHRN04UGnVS6l+TljvHe93uPH09nkFXzf+vTuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956338; c=relaxed/simple;
	bh=+N9y3lqhGcLSQM0ByQNZrdmMM/1738imoW16RoL3WDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYZaf98kYRkbNW/gRxBdLclQYlqBbFShtuJv3mDb71Ek7qdFfWJSIDtUAb77/B7EhQJp6/+aFL/ASyK2OvDPTwM59KjyAe7p/Q5uzZzSKClKPlWfzEqfvbycMNvm6z+GiIR0ktYqI1T5OcB9Rc/xml9UX334ksijnL2I1pa3G/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqpNwmeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE04C4CEF1;
	Mon, 11 Aug 2025 23:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956337;
	bh=+N9y3lqhGcLSQM0ByQNZrdmMM/1738imoW16RoL3WDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqpNwmegdZ+Uiavl9w9C16e50bzKdrwrv4WU7QbuE58qsT8MtwUpm0Bn/Fv7ASKWi
	 405zOt7B98H2tqD1AkEQhF8A9Y1G53OMbDd7+b9bPa61dZZDvPO3tetVuAZjGne1u0
	 9+TwrYI7Fo1uiYOV8BmjZq+RkAHFi9185dnB1cZwDJwUMAKYXHP1lmwDG+HgLBLY3a
	 O6zhF9uw/5Ftlct1HTUhUI654p4+UIaTkTffrkcD97ozCTrf7S6GlN96SiFe7qzdn8
	 2bOWe94XdUch1TLlVNxDoesdJWokxE/b0f6B3Jq79L92nxFuB9UIG6a9sXtIebm8MF
	 B/V10yv8Qtplg==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 2/6] kbuild: Update assembler calls to use proper flags and language target
Date: Mon, 11 Aug 2025 16:51:47 -0700
Message-ID: <20250811235151.1108688-3-nathan@kernel.org>
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

From: Nick Desaulniers <ndesaulniers@google.com>

commit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.

as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can
cause as-option to fail unexpectedly when CONFIG_WERROR is set, because
clang will emit -Werror,-Wunused-command-line-argument for various -m
and -f flags in KBUILD_CFLAGS for assembler sources.

Callers of as-option and as-instr should be adding flags to
KBUILD_AFLAGS / aflags-y, not KBUILD_CFLAGS / cflags-y. Use
KBUILD_AFLAGS in all macros to clear up the initial problem.

Unfortunately, -Wunused-command-line-argument can still be triggered
with clang by the presence of warning flags or macro definitions because
'-x assembler' is used, instead of '-x assembler-with-cpp', which will
consume these flags. Switch to '-x assembler-with-cpp' in places where
'-x assembler' is used, as the compiler is always used as the driver for
out of line assembler sources in the kernel.

Finally, add -Werror to these macros so that they behave consistently
whether or not CONFIG_WERROR is set.

[nathan: Reworded and expanded on problems in commit message
         Use '-x assembler-with-cpp' in a couple more places]

Link: https://github.com/ClangBuiltLinux/linux/issues/1699
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Kbuild.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 82eb69f07b35..11f905b95e65 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -99,16 +99,16 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
-- 
2.50.1


