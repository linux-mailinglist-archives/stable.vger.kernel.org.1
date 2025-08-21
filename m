Return-Path: <stable+bounces-172219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A6B30218
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029EB7AD185
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9825A352;
	Thu, 21 Aug 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZH/6Z93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC620F07C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801072; cv=none; b=RmBOS8IoO9mfLGuAoDbzPDxCoK0BiEb9smw55vgpNha6Rnx7gH5CQhIpMUydS3BQATTwvIu+pNkm2VMN7H0OhYVPKHfQWnnN94VUSsZA2XkT9oxQYGoZ9Eaoa5AvD40tYmbiD8/Itx7EZqPBGtLcwzyoRBnifiZdKOZDQGF0+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801072; c=relaxed/simple;
	bh=S6iFDSmmnaVnuhkYLiQAq7VJ++McHm2uphd0bDE5mMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPhxFEWd39z/KLPCYKtAtb7qt/ZQCRCjCDS2eAhukt4Y2t3iUXIC/Jb+63V2H1qfIVlq74Nyjuq+cQacK8nRiKiUmYeiLoCKtqmEbhAqawZ0dvo7fAvIGc/grbs64cRkbl4xQs3SicTbOHDOrdyLte4/5rkcMYc/sWsJKwjlUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZH/6Z93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF58C4CEEB;
	Thu, 21 Aug 2025 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801072;
	bh=S6iFDSmmnaVnuhkYLiQAq7VJ++McHm2uphd0bDE5mMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZH/6Z93FR2xBiNfLcE26bA9dg2Gdxr0F1LtRuq+TLd96yj9FsvqjcUxY4P3phTc1
	 yU714wXk1Ne5+jGrG5pSqoPBNVPZeYdpA2OqAoC0FMDjcdpaIFr93u6rDIdi1yipaC
	 rXWQ7WuQNdiIR6jeHjw5tSyDVZ/J9P4y7qo8oDM//bFl29Xv87SPQ6jdUwGtIKfPef
	 rH1Hl9/tenqaXqxuzPUEc1dOsPIv4bR5FyphmwrKtMM9KwXexyJvGfxy4LlG81RlXV
	 XGky8WN+nwEdNH1JPv+K4N/zJR2epy5db5z7rpXsSbzw5Xu8aRlW/NA6W47fFDf9nP
	 kBJE1q7GdXzAA==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 5.10] kbuild: userprogs: use correct linker when mixing clang and GNU ld
Date: Thu, 21 Aug 2025 11:31:06 -0700
Message-ID: <20250821183106.1268616-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082106-geiger-canister-107c@gregkh>
References: <2025082106-geiger-canister-107c@gregkh>
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
index cff26a5d22bb..698f05ca3e44 100644
--- a/Makefile
+++ b/Makefile
@@ -1037,7 +1037,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += $(call cc-option, --ld-path=$(LD))
 endif
 

base-commit: d5eca7ebcf6f64c4aebf9684c365c130a3a069b3
-- 
2.50.1


