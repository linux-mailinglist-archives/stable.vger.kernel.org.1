Return-Path: <stable+bounces-172096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D67B2FAA1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379EB1BA421C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EF3375C1;
	Thu, 21 Aug 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1LX6gZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C372C0F91
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783067; cv=none; b=evM97dM4rEV1YCRPR10DtlKZkt0vE7u2Agg2Xc6C18pdjDKLOdwqVq9XPZ6FeB183BG+uMtk8UGDjWbxykNtjfib7FSQYL0OKSNhS/EUtE2B/JFAwTKWkrFAt/yS8VjuSlVtr33lMj0Rq7notwF5esa7siFwbvxatCIVEgEqNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783067; c=relaxed/simple;
	bh=hetGsY8ZWwAsIgz/NSoroPev1LkcKH3MOzT1pDWNVts=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i5duby+NoAh3hbMKx6rvQCeJH8q862bV7do7djnGEitEcoWhVcD3gplzPNYKAtax7SpWwx2ecfKZUAT75hL0MZde/OOt/4dgvIQVe41X2sdvCZBhKeYI15y5BLV+uxMhq/8JByNrrmu8Yx/9w9IJCJEVwLi3kdWpk1938tBnVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a1LX6gZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E4C4CEEB;
	Thu, 21 Aug 2025 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783067;
	bh=hetGsY8ZWwAsIgz/NSoroPev1LkcKH3MOzT1pDWNVts=;
	h=Subject:To:Cc:From:Date:From;
	b=a1LX6gZrJr1SpneL1lDevUOZKuh3O2FP3Ny9v5PjH3D+5ECjG3ReUfok8oIocQrX/
	 zraM462HMp/IYr0yV5bO8HE2f5RYSF1GS0Tb7p1O25wAFLOssFgGsSurrrLDWRMahN
	 jdsXk4+mssXT0X5XEq/PEreR/0Ov7BhKth/iab8I=
Subject: FAILED: patch "[PATCH] kbuild: userprogs: use correct linker when mixing clang and" failed to apply to 6.6-stable tree
To: thomas.weissschuh@linutronix.de,masahiroy@kernel.org,nathan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:31:04 +0200
Message-ID: <2025082104-shadow-nutlike-7f81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 936599ca514973d44a766b7376c6bbdc96b6a8cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082104-shadow-nutlike-7f81@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 936599ca514973d44a766b7376c6bbdc96b6a8cc Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Date: Mon, 28 Jul 2025 15:47:37 +0200
Subject: [PATCH] kbuild: userprogs: use correct linker when mixing clang and
 GNU ld
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The userprogs infrastructure does not expect clang being used with GNU ld
and in that case uses /usr/bin/ld for linking, not the configured $(LD).
This fallback is problematic as it will break when cross-compiling.
Mixing clang and GNU ld is used for example when building for SPARC64,
as ld.lld is not sufficient; see Documentation/kbuild/llvm.rst.

Relax the check around --ld-path so it gets used for all linkers.

Fixes: dfc1b168a8c4 ("kbuild: userprogs: use correct lld when linking through clang")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/Makefile b/Makefile
index ba0827a1fccd..f4009f7238c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1134,7 +1134,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += --ld-path=$(LD)
 endif
 


