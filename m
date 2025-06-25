Return-Path: <stable+bounces-158509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6ABAE7B02
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADFD7B72FE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616127C158;
	Wed, 25 Jun 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q4k5AuAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DB272812
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841383; cv=none; b=E1kXG5H9c2NCYSlF/WGee6eOyKsDMCbiflU7i2w7nQ9gDmO59UsP8Xv411obguooVwA4p9Mfq4ZEcWE1VdwqZ9hoyo8KmXBZjC3OR1vuEmNvToFe9tX8sf+1fWTOoo6yHwOXRoB5h9vM8UzjLh5iitMtogyXJ/Og8C5yRurK/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841383; c=relaxed/simple;
	bh=6vtvXMSMuMIpYGNOsLEcBhzfU5VUP3g6iJxtmfWHGPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rh30yO/wPym7imqo0CxbU3e/7TQd6HbLzVecZSduyKoztFxz5JRVl4b6OUyyz1lNdG+/cXQpb5edY0BFsL93LAOMmb23Rhk/wKNPcBTmr64ckEVMwgOhGzR3XYZKcjrHgeKnhjDa+xJo5sWAXQG9jLXWXx/lsG4tQeEkv5KHaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4k5AuAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E73C4CEEA;
	Wed, 25 Jun 2025 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750841383;
	bh=6vtvXMSMuMIpYGNOsLEcBhzfU5VUP3g6iJxtmfWHGPE=;
	h=Subject:To:Cc:From:Date:From;
	b=q4k5AuAUBhv0zXgiV426Vg1LCXSTgJVVx3huTsiGCvqjiiVL9Be0Z/4rNQnhUEHV+
	 I2F301247oALgaodgaIIFaMtJB4uKissjWmf/Sid6Mr8Zm7+eAorAvkTDhLLpo672C
	 kCNGMURXFWhvscc/r9GOBbNQzemt6+/mteFdhrkc=
Subject: FAILED: patch "[PATCH] kbuild: Add KBUILD_CPPFLAGS to as-option invocation" failed to apply to 5.4-stable tree
To: nathan@kernel.org,lkft@linaro.org,masahiroy@kernel.org,naresh.kamboju@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Jun 2025 09:49:41 +0100
Message-ID: <2025062540-splashing-opacity-acc3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 43fc0a99906e04792786edf8534d8d58d1e9de0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062540-splashing-opacity-acc3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43fc0a99906e04792786edf8534d8d58d1e9de0c Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 6 Jun 2023 15:40:35 -0700
Subject: [PATCH] kbuild: Add KBUILD_CPPFLAGS to as-option invocation

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

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 437013f8def3..e31f18625fcf 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -32,7 +32,7 @@ try-run = $(shell set -e;		\
 # Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)


