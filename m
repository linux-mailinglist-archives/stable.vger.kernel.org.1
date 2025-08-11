Return-Path: <stable+bounces-167087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFAB21995
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244593AB9F6
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F4285CBD;
	Mon, 11 Aug 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGzuwPBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DC285CA8;
	Mon, 11 Aug 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956348; cv=none; b=dKRS7GfC+2VyG1nC574CDLpDVua7V68HF/F5Ip1SpXP6zeF4777jBfqEpZIoFSPJnm1heU2kpE+LVQF9seLM94NyIaY0XHM7TFmslSepVQjvDT4YMLeavmKyOwyDf3TPiZkEra9W7DWAL52H5nvBnE3JA7/oiLQIM0IPSPtwt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956348; c=relaxed/simple;
	bh=QMVS6xjjWSfWAyltc4OMPe+GpRXwKfGMSJH5gg6XvlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCucGGbH+hPJGFT9+rV1IaVbDKE/VhOGNq1Gkrv2tM8RkwLAHPLDy7oIovl3UCm1dkACFyEjBm1KQEiU9LlYVXWx0CgZOqWv8ezIezTVsxe7LWYf/KGuHCW16lOQn5E+ELy+Ri1If9TDEWohLmCbM7eobqUDCxnpRLj+gJaY1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGzuwPBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782CC4CEED;
	Mon, 11 Aug 2025 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956347;
	bh=QMVS6xjjWSfWAyltc4OMPe+GpRXwKfGMSJH5gg6XvlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGzuwPBz0tlfKGAyWjj7pNiq0TuluWIyt92IIellpI5h0aWQn+sN0uQw3tJMgVIPU
	 BK69qd1xttiZ/yP9ogIx3f6jrsCmmdcuTrjCLYeuwqMEzV903f6yNgJMAkov0PTbVz
	 wI9ji0lfgxUWWzgpenv3KinaNP8ccr0uudAMPs9sKzmpHuHhhJ0WFYVvwc+GEo6/G/
	 WGzfhAc8gMNBW8fyCL6xeSRqPScpmMp4uRh07GEwf5voDP9iwgA062QWEaYywkkH7K
	 oTeb12F0gs2vBmPr+QpMBN4xJP+2jgiinfM9CYtOevzf3Xi0UPT83swGzfouza2itu
	 RjTpl6AGKgLKg==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 6/6] kbuild: Add KBUILD_CPPFLAGS to as-option invocation
Date: Mon, 11 Aug 2025 16:51:51 -0700
Message-ID: <20250811235151.1108688-7-nathan@kernel.org>
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

commit 43fc0a99906e04792786edf8534d8d58d1e9de0c upstream.

After commit feb843a469fb ("kbuild: add $(CLANG_FLAGS) to
KBUILD_CPPFLAGS"), there is an error while building certain PowerPC
assembly files with clang:

  arch/powerpc/lib/copypage_power7.S: Assembler messages:
  arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b01000'
  arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010'
  arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b01000'
  arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010'
  arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b01010'
  clang: error: assembler command failed with exit code 1 (use -v to see invocation)

as-option only uses KBUILD_AFLAGS, so after removing CLANG_FLAGS from
KBUILD_AFLAGS, there is no more '--target=' or '--prefix=' flags. As a
result of those missing flags, the host target
will be tested during as-option calls and likely fail, meaning necessary
flags may not get added when building assembly files, resulting in
errors like seen above.

Add KBUILD_CPPFLAGS to as-option invocations to clear up the errors.
This should have been done in commit d5c8d6e0fa61 ("kbuild: Update
assembler calls to use proper flags and language target"), which
switched from using the assembler target to the assembler-with-cpp
target, so flags that affect preprocessing are passed along in all
relevant tests. as-option now mirrors cc-option.

Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/CA+G9fYs=koW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b01d3108596b..4d2b8e659747 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -102,7 +102,7 @@ try-run = $(shell set -e;		\
 # Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
-- 
2.50.1


