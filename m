Return-Path: <stable+bounces-174202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7DB36215
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AE1200D27
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E233CE88;
	Tue, 26 Aug 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rhe45Voj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722C312803;
	Tue, 26 Aug 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213764; cv=none; b=DlwWDD9AX+1h0I4YbrkoNOL5Z2Jn5sv9GTBa6xVgj+EP4s2h8sRTMrI9/sv4BHe2gwkHPzZqRvdJGpa2XRgCN6hqMc8If/2K8bxsQAhDk+XGpK58nRZAqMNyoyBEi5q22VTzD/tB3m5vaMTzRsrrZuFKMKCh/UXgCwk2E90dgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213764; c=relaxed/simple;
	bh=FToD9ysu1iCZY1EEs2zA0f0tkQmhRxBry9SptAdTMBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvGq/yGzKWfj+h5xrCJlme9rSEVORqGu5qIkIoO8WLS1cU7/CmneEGrZ+FkmsEQjWvmZ6nqeVHzQFLCdgDdqp1d4F4GylK4hvTrhaPEd+uwanlDs6+2LB6jvA6PWI2ZBqacHVXC/vUefH4DXJ3OjX5cK1PYo5mut1ann+YmXnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rhe45Voj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C539C4CEF1;
	Tue, 26 Aug 2025 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213764;
	bh=FToD9ysu1iCZY1EEs2zA0f0tkQmhRxBry9SptAdTMBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rhe45VojRkETA18RAkh7sOCCy9t8k7fyxpKSdlSfLBGKclR2oWZJo1/eBfPzc6waH
	 0vb8ymZZZs6Pr91mR+hyaGn3loPG3lrWQ5eFgmToLPrnhsn3v9RkWe76OFSVBt+Ou0
	 P9iUMzyXBk/9yV7newnQZG+M52vKR123BYf2dBRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.6 470/587] kbuild: userprogs: use correct linker when mixing clang and GNU ld
Date: Tue, 26 Aug 2025 13:10:19 +0200
Message-ID: <20250826111004.931105136@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Makefile
+++ b/Makefile
@@ -1061,7 +1061,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 



