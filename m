Return-Path: <stable+bounces-158506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88765AE7ACE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708261BC7291
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECC2882C7;
	Wed, 25 Jun 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGAdC1+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046326C3BF
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841309; cv=none; b=XsiRT7IrOu48s4Gp+/N5yDFfcRmZV14cSasw0D2dl7DXK+xqOV4CppV5dkBhMCXhTQHI4kT2Nxg7zn6mylaZkFscu/FWfsAVl4U6Yb/oAmky658A7dDC2o+MHuQRzc80trEODDOec2pICFPCt6Fm4HHBbzsu5OcGaY5hTtHlUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841309; c=relaxed/simple;
	bh=95Au3MAHvNB3VgJCBLb10GCKxv+kuQs4UUKmjk04604=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e7f+FG6lGlGa6nA7BG8mkPrnwxek6Mm1jIudek4UXD8jPGmCwIYiZ/1gFmo/+csvZrfQeHBKabhvlka5Y0ZoSX72FRwzr4XlTtBFYAW8NaUxzIVIZ161fNzSELUhfcQ0Wo29716VsTYCu7NTcLUUuGmPcIlXbn4loXVIJ6uqVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGAdC1+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11773C4CEEA;
	Wed, 25 Jun 2025 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750841309;
	bh=95Au3MAHvNB3VgJCBLb10GCKxv+kuQs4UUKmjk04604=;
	h=Subject:To:Cc:From:Date:From;
	b=OGAdC1+uZMoGYCeLeCPWTdp5FXxEzekk9WRxsYfHt+m/quRpp+5VfUs8PIjxkxnfm
	 Fsd5O0kBTOiXNIHDFziXWb+5Wa3Ipi6c8XvIQryuUJOnCFtLrxsb85CrANRo5bXPff
	 aTJ5hvLhmLZMl/ho1lTHFds3Sjd0Jw9QQA+BbMhE=
Subject: FAILED: patch "[PATCH] kbuild: Add CLANG_FLAGS to as-instr" failed to apply to 5.4-stable tree
To: nathan@kernel.org,masahiroy@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Jun 2025 09:48:27 +0100
Message-ID: <2025062527-wobble-barn-4424@gregkh>
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
git cherry-pick -x cff6e7f50bd315e5b39c4e46c704ac587ceb965f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062527-wobble-barn-4424@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cff6e7f50bd315e5b39c4e46c704ac587ceb965f Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 1 Jun 2023 12:50:39 -0700
Subject: [PATCH] kbuild: Add CLANG_FLAGS to as-instr

A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
When that occurs, the following errors appear multiple times when
building ARCH=powerpc powernv_defconfig:

  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717520 is not in [-2147483648, 2147483647]; references '__start___soft_mask_table'
  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717392 is not in [-2147483648, 2147483647]; references '__stop___soft_mask_table'

Diffing the .o.cmd files reveals that -DHAVE_AS_ATHIGH=1 is not present
anymore, because as-instr only uses KBUILD_AFLAGS, which will no longer
contain '--target'.

Mirror Kconfig's as-instr and add CLANG_FLAGS explicitly to the
invocation to ensure the target information is always present.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 7aa1fbc4aafe..437013f8def3 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -38,7 +38,7 @@ as-option = $(call try-run,\
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)


