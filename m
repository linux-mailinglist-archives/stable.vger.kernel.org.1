Return-Path: <stable+bounces-172217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE9B30217
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25E816B88E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C52580CF;
	Thu, 21 Aug 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3v2OFN7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09220F07C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801058; cv=none; b=st3Qxa82Kna/Cq+Hgx8zhrl34CktgluCJaZr/4zxfR4ZRrBOPbLt3m6CSF3h1JLuzPsUU73wptaJceks+JFnOqiuLQk6iUNw4mc8Cjon/gvFDQZKKb6PqvmkTgx7Wk5PfuBZE7DBFP2fVwcN71pQLaNJPr5VyNSFquuWZanKmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801058; c=relaxed/simple;
	bh=WwByeLa7zWV5DbGMVQbCqhGGIVXP6I0npd/fnMluczY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUnwHDow5Rgki2K98qyAu1E/Ld0lgpOFJasA13NdKcdJL7WA33UR4QOntw73vRr2PVIubKNjFtCQpFgdSFPlpNAKnAW8ln5G/WNxhuYAnCJZl5XIc5JGrdvtdcMj183P+7AZD3qAAenIcvXxEVrCOFCCpr6f2lzVz+8I7RCIYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3v2OFN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D52C4CEEB;
	Thu, 21 Aug 2025 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801058;
	bh=WwByeLa7zWV5DbGMVQbCqhGGIVXP6I0npd/fnMluczY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3v2OFN7YOoqkKE9jlSs5wiIPyUS9fadMrEbBhJvNZRCPut4AY4UU5sNTJkDhPLuU
	 CE37Uw+QMklHaTLwiBTCPJNY+GDIL0cnWdvUr/7kPrMKjM2yz/ys0QbsVmGByu69JT
	 2evEmWoMoSGWuSwr98MlhcC8hJ8k6nBp8xFMm2gZfVd94nUbhRaJS0cy+2V8FaEJJa
	 L8jJpcbqey4NWW5Bu1JfiOUjJIcplveuSH362ERfKsHYXn6SpHUNZ/nlxTV4n5WlYy
	 Qij32lkpEExO0jD0ZDAeL+8GYBT3PykHTmpNPvy9aAXQ/dBE676R/d3J8ldg+AggXf
	 4ZYe8Az849A/Q==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 6.1] kbuild: userprogs: use correct linker when mixing clang and GNU ld
Date: Thu, 21 Aug 2025 11:30:51 -0700
Message-ID: <20250821183051.1259435-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082104-cosigner-parabola-3836@gregkh>
References: <2025082104-cosigner-parabola-3836@gregkh>
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
index dd9e4faf0fd5..bd33eadb047c 100644
--- a/Makefile
+++ b/Makefile
@@ -1143,7 +1143,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 

base-commit: 0bc96de781b4da716c8dbd248af4b26d8d8341f5
-- 
2.50.1


