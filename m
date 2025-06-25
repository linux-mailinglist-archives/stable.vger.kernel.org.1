Return-Path: <stable+bounces-158507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45393AE7AFA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75C27B76D4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98697288CBE;
	Wed, 25 Jun 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrTWxfLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2127F73D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841341; cv=none; b=jxgliNqjD5W4IzyNgflidYno6DSM6stq6oyiHp5FjpEk4pJ71W+86fXpLkE3GLVfZ2X/irA/GPdGoDESTD7g5QTxQJuWJieWfgZU28Sv9kmu4WzqjiGvQOdBlgKAjbzb3vGPMSYewUwVtj0dgNUO/9i5nlFeu7CmYSIlRteLSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841341; c=relaxed/simple;
	bh=ervAp5FHigDC+01l3Ubu7wLMsMpxCS0B3pHHy0lOFEE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ygiu+9KjrpxLvkR5fNj+eUjECQOHCOQKZ/xVMAPW5Qu7dgl5y48q2KG6wKO3PJzjK0yN0Quvw33SflaEubGX9qKbqChNcqVppcHVfzHClsSZwlqzU3aBuR8asM766L64Fqad7ct9N5diOHF7qmAlQoGTe9LewpVVEd2Dy98xd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrTWxfLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC88C4CEEA;
	Wed, 25 Jun 2025 08:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750841340;
	bh=ervAp5FHigDC+01l3Ubu7wLMsMpxCS0B3pHHy0lOFEE=;
	h=Subject:To:Cc:From:Date:From;
	b=VrTWxfLQMZ9RaQQu35TEAQlKRb5oU+hVsWdpz7LdbBL3VkX2rhuayei0ZlLMvzSzY
	 3K26wyFnnm7rOFdg9DqS0mRKOld88bxeIS2TltLM0fn8Xt5i6P4/K54bK1m/kg1lOc
	 Y5TI36sv8hTe0nvBx+YHCJdg7VRJ/AEamlVGV/R4=
Subject: FAILED: patch "[PATCH] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation" failed to apply to 5.4-stable tree
To: nathan@kernel.org,masahiroy@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Jun 2025 09:48:58 +0100
Message-ID: <2025062558-erupt-quack-32ad@gregkh>
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
git cherry-pick -x 08f6554ff90ef189e6b8f0303e57005bddfdd6a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062558-erupt-quack-32ad@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 1 Jun 2023 11:38:24 -0700
Subject: [PATCH] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation

A future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to
KBUILD_CPPFLAGS so that '--target' is available while preprocessing.
When that occurs, the following error appears when building ARCH=mips
with clang (tip of tree error shown):

  clang: error: unsupported option '-mabi=' for target 'x86_64-pc-linux-gnu'

Add KBUILD_CPPFLAGS in the CHECKFLAGS invocation to keep everything
working after the move.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a7a4ee66a9d3..ef7b05ae92ce 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -346,7 +346,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif


