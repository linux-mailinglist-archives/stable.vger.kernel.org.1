Return-Path: <stable+bounces-81255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B6992B05
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742F4281487
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0A1D1F7B;
	Mon,  7 Oct 2024 12:04:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4B18B483
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302673; cv=none; b=lvcrzQ8AXuFIvh2UKpiAuJFzqMshGrLow+x+7tZUPnOTXZB4id7cmt5XwsYd072Y+4CPRpAUvrEn9wKHrc9wyWMpijRf2gCWxKjXULee3e09tnTtYllYSmwCtvfXMZArop5/c1mjhhbsjaUYAaQQD3DgXUso5jxfY1OXCQf1XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302673; c=relaxed/simple;
	bh=ORjnhy9Y2pQYRhE52dFAePJ+NpRKmxte3MBf0i8biiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jA9wKPDPEPxDtC1VEfZ/WYiWKRbQk+5f0hneWX4OlMO+zi2t22f3UoUTEO81IAX4AdWZ+oOtzsFhg5w60sp+Ok5UwTivexczP0nDj7SZl0pZSZ9z47dQBOOCKQOKZc2MaRDhZDvZAmC0iS1jBiuSK4bcFcMJ0hD/+YHPY4HDdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 136E61007;
	Mon,  7 Oct 2024 05:05:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5F8A3F640;
	Mon,  7 Oct 2024 05:04:29 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.11 3/3] arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386
Date: Mon,  7 Oct 2024 13:04:21 +0100
Message-Id: <20241007120421.547274-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007120421.547274-1-mark.rutland@arm.com>
References: <20241007120421.547274-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Easwar Hariharan <eahariha@linux.microsoft.com>

[ Upstream commit 3eddb108abe3de6723cc4b77e8558ce1b3047987 ]

Add the Microsoft Azure Cobalt 100 CPU to the list of CPUs suffering
from erratum 3194386 added in commit 75b3c43eab59 ("arm64: errata:
Expand speculative SSBS workaround")

CC: Mark Rutland <mark.rutland@arm.com>
CC: James More <james.morse@arm.com>
CC: Will Deacon <will@kernel.org>
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Link: https://lore.kernel.org/r/20241003225239.321774-1-eahariha@linux.microsoft.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ Mark: trivial backport ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 5eefda2f7182b..8cd4f365044b6 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -293,3 +293,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #3324339        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index d9b9ec2bd6ff4..a78f247029aec 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -448,6 +448,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
-- 
2.30.2


