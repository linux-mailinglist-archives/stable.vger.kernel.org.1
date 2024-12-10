Return-Path: <stable+bounces-100436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034249EB30E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95377283560
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBD1AAA3B;
	Tue, 10 Dec 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjtYPM3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567278F4E
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840539; cv=none; b=abNwgWTZmpV7yk+AwMpz+Mg4HA11cmE4/Ls6bEy5iVFZJaVFYD6veqFTggUn0W/xe9ch4BJJJOSVeYJ4s2D3jZo9EniWP6A+bdY7khRhf3JIS06TNyRaCWtvlz9RrnWZi7BSDvuINlLonb2Z2Saa1ogfMWOl940VTi4fxlDagOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840539; c=relaxed/simple;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSs+C28FXZcMoN/2KIRxcQh3b0qw3ukcEf+nAA4vMpvxugFGrG+r13pCtX6JzxX9BiwN/u7yU3UTOikOaeDno+aA1LOuZBsJaD+AE3yYoBXobDbwKPPP+wMbHcWJrAOlJEKkn4NxBxAkRkMJGMA9Pdelbaighpq6B2+JXNdWlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjtYPM3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF9AC4CEDF;
	Tue, 10 Dec 2024 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733840539;
	bh=RlkJX0MrhsJeOtYwbzKz9uU11pc4QQCMS9xkZOpuwfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjtYPM3LNQc7Zhm7pUf349QMmkZGGYRJo6ajHpjNqMD23JgZ/EZFRef/1nK3ew2qv
	 unKzTEilzAJDhFUziX/+fx929D0mgrkRQoHlSt6eJF2dYiraDwai1u8I2skVpeIuAo
	 6YOqeGgq5NCRCLOQbBmUq9kmYdRGZypKcMePWhIlogVfW0LRzysPYEOULGO2MoYm3Y
	 d/jh++YzoXpHIU7vUqxT/LLjSpuMoGpXHkJwtuoeue5ooXa66+D+bDf+HFEnnDRsWy
	 Qh2HrWnqPo/MVVel4jZJa49POpjig4HYiOiwc/ZdLbBUNf2K3A8wUe4JAcDQcJ3KCY
	 MHHH7PXtYlBmQ==
From: Arnd Bergmann <arnd@kernel.org>
To: x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/11] x86/Kconfig: Geode CPU has cmpxchg8b
Date: Tue, 10 Dec 2024 15:21:56 +0100
Message-Id: <20241210142206.2311556-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210142206.2311556-1-arnd@kernel.org>
References: <20241210142206.2311556-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An older cleanup of mine inadvertently removed geode-gx1 and geode-lx
from the list of CPUs that are known to support a working cmpxchg8b.

Fixes: 88a2b4edda3d ("x86/Kconfig: Rework CONFIG_X86_PAE dependency")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..42e6a40876ea 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -368,7 +368,7 @@ config X86_HAVE_PAE
 
 config X86_CMPXCHG64
 	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-- 
2.39.5


