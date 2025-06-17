Return-Path: <stable+bounces-153143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A19ADD29E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EDE17CCEB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD082ECD2F;
	Tue, 17 Jun 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LsnWMKus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49D2EA487;
	Tue, 17 Jun 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175016; cv=none; b=Ax1+oOGHmZbxyoU+9eLLDq+YXP8G4V9EUEbHMhiugxlFmfxWySBVTavIw3e/Prp4lBMmiFFvnigvmkgcL3o/fUOcA0qy/UFQ7wl78gPLVwLsQpwYgdUpg60w/WaX9cfcxCmHOfqC2rN0EQLN3ghxemW3mEhNNZmOEs89O+IJLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175016; c=relaxed/simple;
	bh=QEnjEcXByIBu+ufQaljjLPeRBeLG6pdbfivCx221t1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCnW442p0ltVyt3MDxLvKtYddnPHWtN4k8dg+mCt0qnCWwkk246wdOoTBGhn1+OGJe4m8pc0t4+yT1KZXKx+jxMYxNzqvNNbaRcEWvtF/oKmPjkOGnwenE56f7KfDiB3ou+svpss/56JqpMUpgHyeFspO1SiFSghb1MFptPKjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LsnWMKus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED00AC4CEE3;
	Tue, 17 Jun 2025 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175016;
	bh=QEnjEcXByIBu+ufQaljjLPeRBeLG6pdbfivCx221t1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsnWMKusgHoN000wDU65t4h8tKDDs6pqznpUMt/hyFaqLjrX6OcaU4pIpg3fxzgM9
	 RfpxnPOIxEV8L2+aqR7XBc5+hgaSymCXiICOiaFKEKdgKf/J+Kt94UQs901sAPbklq
	 143SxJNuAPJs+2R8UAi8PwCV8nMmnQzcGtF3zML4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 084/512] arm64: Support ARM64_VA_BITS=52 when setting ARCH_MMAP_RND_BITS_MAX
Date: Tue, 17 Jun 2025 17:20:50 +0200
Message-ID: <20250617152422.978391734@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kornel Dulęba <korneld@google.com>

[ Upstream commit f101c56447717c595d803894ba0e215f56c6fba4 ]

When the 52-bit virtual addressing was introduced the select like
ARCH_MMAP_RND_BITS_MAX logic was never updated to account for it.
Because of that the rnd max bits knob is set to the default value of 18
when ARM64_VA_BITS=52.
Fix this by setting ARCH_MMAP_RND_BITS_MAX to the same value that would
be used if 48-bit addressing was used. Higher values can't used here
because 52-bit addressing is used only if the caller provides a hint to
mmap, with a fallback to 48-bit. The knob in question is an upper bound
for what the user can set in /proc/sys/vm/mmap_rnd_bits, which in turn
is used to determine how many random bits can be inserted into the base
address used for mmap allocations. Since 48-bit allocations are legal
with ARM64_VA_BITS=52, we need to make sure that the base address is
small enough to facilitate this.

Fixes: b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel VAs")
Signed-off-by: Kornel Dulęba <korneld@google.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250417114754.3238273-1-korneld@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a11a7a42edbfb..7887d18cce3e4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -322,9 +322,9 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 24 if ARM64_VA_BITS=39
 	default 27 if ARM64_VA_BITS=42
 	default 30 if ARM64_VA_BITS=47
-	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
-	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
-	default 33 if ARM64_VA_BITS=48
+	default 29 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
+	default 31 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
+	default 33 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
 	default 14 if ARM64_64K_PAGES
 	default 16 if ARM64_16K_PAGES
 	default 18
-- 
2.39.5




