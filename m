Return-Path: <stable+bounces-150693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D094ACC522
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4344D3A39DB
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224022F389;
	Tue,  3 Jun 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYMk8pEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CF22F177;
	Tue,  3 Jun 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949299; cv=none; b=O/CwV2Ie3Gz4nA0b10R+kNmp5X8S3uSq1J0F8EXdKOsGuVIWNJPbrGz3McUhh1rom3YPtUVLeljxl5nCK/ecGNiJtAmRW5E2DNbpqL1cF/SYY/v5FJObrhjCeO3qCqwAAyrrvP1CuLSzeuvO32hMhmYEst0rTRRWNrgyh8GVO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949299; c=relaxed/simple;
	bh=fg/7iOtD0q+oXAfzTdiN2IWPV8JX8fDJ3zTvmvvUFo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El0+cBCFFjap8Igx6PmfjNnhWPoINyi/+d6e9+VD76xIc8a898IShnNNmFLgl7fq3Y6uVmT/Jtw/9Wn5D2DjIWgi9XyEjzxv8ylOjBj/YkP14hW1JoSjKomCaAKt22Hcz3692BE+Ag2CI8qc6dmmN0SUUX2b+KwAq4oaie0eIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYMk8pEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD39C4CEED;
	Tue,  3 Jun 2025 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748949299;
	bh=fg/7iOtD0q+oXAfzTdiN2IWPV8JX8fDJ3zTvmvvUFo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYMk8pEVTrPQg8Dcer7okTfaNOQIaAsXRT5zM5JyEN5HrmZVob4XvGIN+3DdEvEJD
	 i5VjdAcDd4wULm2OmetdEq4s50xATht+4CN0LImN9te2i8KbL6ebCHOozkxzlUndmN
	 s1+TRlYWWCHkSc/KxToQXvLkNP8l3WL1s0zeSDiAmMqHK9qVuypvIp7/ghwLBFk9zF
	 omdIzrXQkNYwzoGDr/ZuGtLWvDQYvSL3m/doEaTOuL6Ywmcqvv3RhN5t9gyPU7gK3c
	 3qcpdgDxR6FwPfwIc/i2PiCTUNGTwZvJ+uBJGYP50biAYNbPvmwb7BR/U0Djaor4N5
	 xLat8CP70j8eQ==
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	=?UTF-8?q?J=FCrgen=20Gro=DF?= <jgross@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/5] x86/Kconfig: only enable ROX cache in execmem when STRICT_MODULE_RWX is set
Date: Tue,  3 Jun 2025 14:14:42 +0300
Message-ID: <20250603111446.2609381-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603111446.2609381-1-rppt@kernel.org>
References: <20250603111446.2609381-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Currently ROX cache in execmem is enabled regardless of
STRICT_MODULE_RWX setting. This breaks an assumption that module memory
is writable when STRICT_MODULE_RWX is disabled, for instance for kernel
debuggin.

Only enable ROX cache in execmem when STRICT_MODULE_RWX is set to
restore the original behaviour of module text permissions.

Fixes: 64f6a4e10c05 ("x86: re-enable EXECMEM_ROX support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e21cca404943..47932d5f4499 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,7 +88,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
-- 
2.47.2


