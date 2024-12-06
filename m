Return-Path: <stable+bounces-98997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3D9E6BBB
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2578287EB7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365301FF7AF;
	Fri,  6 Dec 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITN8QqlY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D01FCF60
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480206; cv=none; b=Fgi5BPYEIa4HHZRY5cPDa+7lSbYnWF8lourIyIMiTnaco+45CWvn2CCnmRw20F+RjbXM04ZR/q6xMETfwALBsB/t2bqBUZsYiwI3TBMLAWLeG0UJK3aJFUOdiSaTdJKk/CRXsyQMueJQHjzO2s95QP/K5psNLxqNGi534fqLBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480206; c=relaxed/simple;
	bh=8LGbm5SpGpkiaEP9TI8NovNONE+f01rOc2qkuHycv8Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FhwSoLy2iv5BwkDe3JyNn/nGnHzddeV7UoMsEu5ddcFMSemu+ZFTwhRmlB3RDji/ywYEzlyz6wYq5Qx+TFxNV0TqVSr6iCbKzgtaK9MdL7xJNOh5u1Lg2Ifipj+C+qiknLQO8xEi5Qu+w9oNYHaY7ybClaO1cZXEDObEY288vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITN8QqlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF73C4CEDE;
	Fri,  6 Dec 2024 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733480205;
	bh=8LGbm5SpGpkiaEP9TI8NovNONE+f01rOc2qkuHycv8Y=;
	h=Subject:To:Cc:From:Date:From;
	b=ITN8QqlY25fhw92f9oE4dOPFnHA4/yL+HpaB2TzBb+7dwA0HEUDNv1JSRXc9174Bj
	 loCmHjB5uhaRtRNGRcKB0bLXqqrkABr0IHBEujv1em2Js820XqvmKCS/XwOcBiSChE
	 Ca/FOKw4k6ppLxIzNSLtW06tNFLAqpWOcQxQRZf8=
Subject: FAILED: patch "[PATCH] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit" failed to apply to 6.6-stable tree
To: nathan@kernel.org,mpe@ellerman.id.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:16:42 +0100
Message-ID: <2024120641-patriarch-wiring-1eed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d677ce521334d8f1f327cafc8b1b7854b0833158
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120641-patriarch-wiring-1eed@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d677ce521334d8f1f327cafc8b1b7854b0833158 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 30 Oct 2024 11:41:37 -0700
Subject: [PATCH] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit
 files with clang

Under certain conditions, the 64-bit '-mstack-protector-guard' flags may
end up in the 32-bit vDSO flags, resulting in build failures due to the
structure of clang's argument parsing of the stack protector options,
which validates the arguments of the stack protector guard flags
unconditionally in the frontend, choking on the 64-bit values when
targeting 32-bit:

  clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', expected one of: r2
  clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', expected one of: r2
  make[3]: *** [arch/powerpc/kernel/vdso/Makefile:85: arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
  make[3]: *** [arch/powerpc/kernel/vdso/Makefile:87: arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1

Remove these flags by adding them to the CC32FLAGSREMOVE variable, which
already handles situations similar to this. Additionally, reformat and
align a comment better for the expanding CONFIG_CC_IS_CLANG block.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 31ca5a547004..c568cad6a22e 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -54,10 +54,14 @@ ldflags-y += $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRACE) -W
 
 CC32FLAGS := -m32
 CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
-  # This flag is supported by clang for 64-bit but not 32-bit so it will cause
-  # an unused command line flag warning for this file.
 ifdef CONFIG_CC_IS_CLANG
+# This flag is supported by clang for 64-bit but not 32-bit so it will cause
+# an unused command line flag warning for this file.
 CC32FLAGSREMOVE += -fno-stack-clash-protection
+# -mstack-protector-guard values from the 64-bit build are not valid for the
+# 32-bit one. clang validates the values passed to these arguments during
+# parsing, even when -fno-stack-protector is passed afterwards.
+CC32FLAGSREMOVE += -mstack-protector-guard%
 endif
 LD32FLAGS := -Wl,-soname=linux-vdso32.so.1
 AS32FLAGS := -D__VDSO32__


