Return-Path: <stable+bounces-176299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD5B36C9D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5A098051D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D83469F4;
	Tue, 26 Aug 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vC6ibowQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F94280CC9;
	Tue, 26 Aug 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219297; cv=none; b=noK8jFLlRT6X+4ukhd/cKKzX49cYF1ncc3VkLP9oyQ1fnD3rh39tjS7cLxUtpi8dkKt1uDYP09M1/6xCOeGwrIdp8m6hphKMvh0lF4nqvWIh9L6Zi6ZklSImtq582ticTXjjJPoYiNjAiINtu3waQcDypoSr+mUboRRRpp2/D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219297; c=relaxed/simple;
	bh=ZO/QK1a9EvOT5zkinLRjXWeEpGFVcs/lDTMqfO+Rab4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyarffEsBPLTVXRM7Qezj3rByqS+rWohEhSAcMMLhuAvf9OckUxsaxWhsQcmCBCyAW+3oh/LVtnS3xBs/TsMEjBaNEKcTXO92h96RWJJUyqvT2mUmTzmTmmBRgwWC8zw4s1lODKAtbDTROVoo6VDcTotwoSui5+4cxoTadt/Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vC6ibowQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DCCC4CEF1;
	Tue, 26 Aug 2025 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219296;
	bh=ZO/QK1a9EvOT5zkinLRjXWeEpGFVcs/lDTMqfO+Rab4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vC6ibowQohNUu5WPKUdaak+A/iERb+7pm9fMJ3A06Pwdck3v4/vWcy6YFPcBJ1ssv
	 QiQ0NcHVyigR8qTDijAtYMLzVYv2Cq7gGAw8VABbxzCZCJDv8Lbi7lpoNGNO8oLQKY
	 kYVC0DS0hwUxBSuSW2hbyJ9zAmbvc66gtCArog1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.4 328/403] kbuild: Add KBUILD_CPPFLAGS to as-option invocation
Date: Tue, 26 Aug 2025 13:10:54 +0200
Message-ID: <20250826110915.889248637@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Kbuild.include |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -102,7 +102,7 @@ try-run = $(shell set -e;		\
 # Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)



