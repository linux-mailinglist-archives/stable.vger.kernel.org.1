Return-Path: <stable+bounces-172216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE5FB30216
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5E7A88DB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363A25A352;
	Thu, 21 Aug 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6OMP8Ht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148D20F07C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801051; cv=none; b=kAHxZYEZ/UJVRoXSiE9lEdpzQ8vWDBrWYjcWntXKbabn1MNPLNoF2cTrqf9fNftIZhYIUumTZPf1B9V9khxv5xUarRtYQshL655yBNb1t8yvwKRn1D4GekTJRY5MwQxoHsiHOs+yEX9dt4PBvsxNIxwNkj3EJRoCpNVJ6DY22uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801051; c=relaxed/simple;
	bh=U3jb9iv5x2ZG1pm8ucegnwEyHvReeDLm/Bwku8ijtNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcpt1m8Uv460KEW/ZjG9/DGbqWp8hwbW7ju0JdBzmV+vr+E7VchVYO5q2VHDi8LjM4FPkT8DUoib9GYEApJ7ynkxAUMKLVFZ/XQb9TgaYdsiVVuEguTi+WPQeJTp9/uakESkZWZVYRcjzFeQT2hE/1p99oLQY0aR0oKdniQDYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6OMP8Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E090BC4CEEB;
	Thu, 21 Aug 2025 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801051;
	bh=U3jb9iv5x2ZG1pm8ucegnwEyHvReeDLm/Bwku8ijtNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6OMP8HtkPGkVsfftVudb06XDwhkDr2Cn9M/eQlfacO1Z8pn4RadeehszH2jYleS3
	 7qkIcbYbuL3mfU5wFJPC6DM5igvWSOJswgXWcHXoCgvSsarqOexbeokf8cePvRcHJJ
	 /gGy5sXsRrAl/ltBs4Hf38ceR0pnkOCl8VxOv6f1tjb0+yvM1QUrgwzA/vI5lVkiz0
	 aYv/2YSeNfK4NK+ULG3bPVQ57kewF8s37hyoIcFJdJ+As4MbU82xUuYvuwoW/gzArz
	 sgGFcDdcz6b6yn7vIgNF+pwM6QBFl+PxFGgFL+c2hyGXkfuPbjRaeCkYG90DZpiR1e
	 goJoidbYcrllA==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 6.6] kbuild: userprogs: use correct linker when mixing clang and GNU ld
Date: Thu, 21 Aug 2025 11:29:49 -0700
Message-ID: <20250821182949.1216551-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082104-shadow-nutlike-7f81@gregkh>
References: <2025082104-shadow-nutlike-7f81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit 936599ca514973d44a766b7376c6bbdc96b6a8cc upstream.

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
[nathan: Work around wrapping '--ld-path' in cc-option in older stable
         branches due to older minimum LLVM version]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 685a65992449..59e31545b35c 100644
--- a/Makefile
+++ b/Makefile
@@ -1061,7 +1061,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 

base-commit: bb9c90ab9c5a1a933a0dfd302a3fde73642b2b06
-- 
2.50.1


