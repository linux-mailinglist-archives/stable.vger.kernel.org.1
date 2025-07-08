Return-Path: <stable+bounces-160884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A4AFD214
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E82B7AA585
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6192DFF04;
	Tue,  8 Jul 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iJSPtOR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8138F5B;
	Tue,  8 Jul 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992970; cv=none; b=IjgWfj07xOwMGHEWwT3+tA11cFWyiEd5NO58UN9JRfZgknTOQw81Tof7m3zsYBFcFYnd5Pvh8cm17n0oFwmgGll4aL1sD/pVfFu8sCgCElkZcv2EMxrFSWwQsfFf4RQZ9yN87RDmGcYy1Lu/GrqRHq8zLBNWyT8T2OT+qPtcIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992970; c=relaxed/simple;
	bh=YBatTsqo9WkKGzhIoHTYfZBJPgjDmfXnCLhoKasCH7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1pC0PPR6pThO3+9swAH64CHVnBmT8M61Ko1rh755wTW1nG64PWFiwVTF/KK5qB0N3rW9GznuaUTYzCxEJjjaXjM7qiOa68oP52tD0sA8P9CkVH1nGVZ0/EXJlILtIxJAwqf4Wr5wOit0HpakrslLTszjp6MmeX7JHVv0mWORqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iJSPtOR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FDC4CEED;
	Tue,  8 Jul 2025 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992970;
	bh=YBatTsqo9WkKGzhIoHTYfZBJPgjDmfXnCLhoKasCH7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJSPtOR9Ct/e8acRmnF+XUQeRDYUgaoBR4joYoVRDvfO6n4yBzG/MlaRaABepfnBP
	 9V2S8Ou7beKiohUOKYCb0C1FstLk/twETa3zkuBIrES6NXdKiTJa/Egh8Tcth4bGxl
	 WBdulknS8W+L7AS5DkfNHDyCACS8HvBPdWcwq7qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 144/232] ubsan: integer-overflow: depend on BROKEN to keep this out of CI
Date: Tue,  8 Jul 2025 18:22:20 +0200
Message-ID: <20250708162245.211448753@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <kees@kernel.org>

[ Upstream commit d6a0e0bfecccdcecb08defe75a137c7262352102 ]

Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
CI because we can't stop it from being included in randconfig builds.
This feature is still highly experimental, and is developed in lock-step
with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
from being enabled by anyone not expecting it.

Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202505281024.f42beaa7-lkp@intel.com
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Acked-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/r/20250528182616.work.296-kees@kernel.org
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.ubsan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 37655f58b8554..4e4dc430614a4 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,6 +118,8 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
+	# This is very experimental so drop the next line if you really want it
+	depends on BROKEN
 	depends on !COMPILE_TEST
 	# The no_sanitize attribute was introduced in GCC with version 8.
 	depends on !CC_IS_GCC || GCC_VERSION >= 80000
-- 
2.39.5




