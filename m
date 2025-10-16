Return-Path: <stable+bounces-186004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A3BE305A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E5E4FA00F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440A30EF96;
	Thu, 16 Oct 2025 11:12:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61830DD23;
	Thu, 16 Oct 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613143; cv=none; b=UiBdfVCRF+RsfbyikO08Pk6S3P+uCJ5t/7yRI4HVnUTGOn+/L352rBVQ+5Ec2j4WHWSvfo2kJXWSJkfYOY9Zwu+GMzXmNCI7F2GZYvpf4GiCR02icY5tAptWcp++tjp8CSvTM1tUcdwl1+lDWmn56OryvlEWAFsUJ/gif1L29Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613143; c=relaxed/simple;
	bh=MjMFhOg2NxY99XAzsKP3cJh9TYZGAQpjPijW9FlBDEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp+XYStTwRJE28juotbK53PeFGC6lgeRhm6icM87MlIlh1yuad1o47tbPwoEvEe07tkjj4G+ZFZDLyyt9TGwOXmsskt8FEQ1HGUGkb3jSR53zA9yKnoNDc9cEFP1nDputyxAXQzmYYtgu5lzxyu2dgPyGrK4egaaUg/SyuULVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FCE263D;
	Thu, 16 Oct 2025 04:12:12 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D733F6A8;
	Thu, 16 Oct 2025 04:12:19 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>
Subject: [PATCH 5.4-6.17 2/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Thu, 16 Oct 2025 12:12:06 +0100
Message-ID: <20251016111208.3983300-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016111208.3983300-1-ryan.roberts@arm.com>
References: <20251016111208.3983300-1-ryan.roberts@arm.com>
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
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 1 +
 arch/arm64/kernel/cpu_errata.c              | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index b42fea07c5ce..b6dacd012539 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -198,6 +198,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7887d18cce3e..40ae4dd961b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1111,6 +1111,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
+	  * ARM Neoverse-V3AE erratum 3312417

 	  On affected cores "MSR SSBS, #0" instructions may not affect
 	  subsequent speculative instructions, which may permit unexepected
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a78f247029ae..3f675ae57d09 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -455,6 +455,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 	{}
 };
 #endif
--
2.43.0


