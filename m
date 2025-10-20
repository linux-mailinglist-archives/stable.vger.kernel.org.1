Return-Path: <stable+bounces-188011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4ACBF027D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179441892DD8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA42F60C7;
	Mon, 20 Oct 2025 09:26:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F32F5A24;
	Mon, 20 Oct 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952408; cv=none; b=f0tB9pv7clwT9BSOFvvOndSCHO6rzW7sxYUQMHIfaNUlEGyVz5k7T6MwkBt76TH6dHwdFq/6PR8ZRd0j6PBvygy7s4Z5mLcT2krVof2videHBS8j5nq11VYZtlFPtO3eZueQRuQ1r6uIM3jffqnF7t/h0KEOft5IgHsQkcn4DBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952408; c=relaxed/simple;
	bh=4DRBY2Arcub4yI2g1UahSfZxhY/i8ei6Ue1r2W1Xj+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHoW5dzkgEA88tu9oWfla6vfHomxQJ6rS9x9Lg5CJA9eyRO8dZtpYwgw4yB4sBslxeZ2MeU6AeQb+1GOaO5kOEdt2zO6e+ED03405MOaeq/F77P43q+m6mTFQr6XHd/+wipNFtD8lFtlyw0U1PuWvOi1GiAyfp/3GxcRFEd+Dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 735F122C7;
	Mon, 20 Oct 2025 02:26:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3573F66E;
	Mon, 20 Oct 2025 02:26:43 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>
Subject: [PATCH 5.15-6.1 2/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Mon, 20 Oct 2025 10:26:28 +0100
Message-ID: <20251020092630.592033-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020092630.592033-1-ryan.roberts@arm.com>
References: <20251020092630.592033-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 0c33aa1804d101c11ba1992504f17a42233f0e11 ]

Neoverse-V3AE is also affected by erratum #3312417, as described in its
Software Developer Errata Notice (SDEN) document:

  Neoverse V3AE (MP172) SDEN v9.0, erratum 3312417
  https://developer.arm.com/documentation/SDEN-2615521/9-0/

Enable the workaround for Neoverse-V3AE, and document this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ Ryan: Trivial backport ]
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/kernel/cpu_errata.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index e7b50babd0d5..a8eddcf24231 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -181,6 +181,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6bb23a041e32..d889a466468c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1027,6 +1027,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
+	  * ARM Neoverse-V3AE erratum 3312417

 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 78aea409b092..f527e9590e11 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -457,6 +457,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	{}
 };
 #endif
--
2.43.0


