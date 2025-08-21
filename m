Return-Path: <stable+bounces-172218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39074B30219
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581901764F8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43600285C8D;
	Thu, 21 Aug 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ8uVqpG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE62580CF
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801067; cv=none; b=Uj1/gn6YipJn31sVAaZJiMGLpb3UMTnz48GbWUd1S/ciJibtGiXqLnuz16fFxXy3bdFKflZHQjPtzyz35p6AY8XTWPdMUGIBMWxquca9z46gWTconsaXjNBKISg3wohULPhjDsTu9ZI3izvxfQG3nAjMtLCaBFEBZRXaPNkr17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801067; c=relaxed/simple;
	bh=jW9psQDYGSGucDdWKd0ZMvCQCOy4hrOSEgQoNjfJMzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZYD/Uphbjk15+5oAxrGxNlB6w7kgTXc/s4N3t8ZPDqdRlXTuQxUwxqE7xQqmU/u4KXBGusHuR48lKcaouPAV5L/CSoqyqh0byH2kUoAfiuhQiQ8hx19iz+eRNQeV/aYkkw1ckG140Cts1E4/Q6sUy+5sC3C3FfJDRDD6tvZ+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ8uVqpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3379CC4CEEB;
	Thu, 21 Aug 2025 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801065;
	bh=jW9psQDYGSGucDdWKd0ZMvCQCOy4hrOSEgQoNjfJMzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZ8uVqpGSidjHqt8xpyHF1KzEfJv5QEitUsQj6OyNjM71QvUgn3mbbf5H0FI+p2No
	 yPJPB9tIkNuWRkKXDcTKOhTIAzF1bP9EeVys2laIHXNytQMSPRdO1CgpHnnykGwytZ
	 tXhvKZkn/x3a/sVIQ35CdchXduJri0Jy6lBVvdxsHOCCcREV7CNB4/vPbp4QkpZSAD
	 CN4bfXwTSEPcuHv9kJcdFNP4hRVHATxTyOFZLC/BCXZevjsGM3PAGKvuX685tzcrPX
	 82rRlCcGFejmzO0LeIn1OMjQ6EJve/JV7Vw6m4l6tg2zMEV+mGaA0E2WqgrltxVrQh
	 nDuV/fAhfZ/9Q==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 5.15] kbuild: userprogs: use correct linker when mixing clang and GNU ld
Date: Thu, 21 Aug 2025 11:30:58 -0700
Message-ID: <20250821183058.1264091-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082105-sessions-superhero-9a5f@gregkh>
References: <2025082105-sessions-superhero-9a5f@gregkh>
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
index 6bc80f4cfd7e..8658e402988c 100644
--- a/Makefile
+++ b/Makefile
@@ -1130,7 +1130,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 

base-commit: c79648372d02944bf4a54d87e3901db05d0ac82e
-- 
2.50.1


