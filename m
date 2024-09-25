Return-Path: <stable+bounces-77175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E89859A5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971921F24B16
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1431189516;
	Wed, 25 Sep 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwU5XQcw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA15188A01;
	Wed, 25 Sep 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264387; cv=none; b=PPurbqYG1XOORrtCYiBkhqMlzWtCvmByzOODIov+aUxcsKI7JMZimZW5pOPr6qRCWsbPBvjO9N33LwGQMtmaQBk4nLVirm9EU39WL1A0AKABtEO+f0606whXNs7uxzocABhi8NhcUEIknoDo/DRsojN6Hmo7zkYHh44H6c5Re+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264387; c=relaxed/simple;
	bh=c5m3Bnbl5dphbPfrSx66MXOe3qY4VE3SBmFhPptmC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTnEMUMcF4cCG3HOG6ApY8JwiX2pLpA1X9Fk9UkwHHTiKB95gIH3fY4HxR2FJ4tp+EqWemyGHI2N/dEMhFV25ZQuL3sU6wdA7WfwS+6I2jLxi0UstK1dAfQKRYeGpcnrgR/1pbIspZGyoa6IZXXI2Zy9Z6Jz5bxk6XG8d14N8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwU5XQcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D37C4CEC7;
	Wed, 25 Sep 2024 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264386;
	bh=c5m3Bnbl5dphbPfrSx66MXOe3qY4VE3SBmFhPptmC+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwU5XQcw1D4njcSnWHfxwg3ylscrJpcZ1F8V3dGToO4CXUcXHvgII6XGZuil8wsin
	 WZrj3Q3bIb2e1DwySDOCNqa79cZVkFrPmZapwFPl7MXwuAE3HIBdjryRJgbHR7Rbbm
	 IyoCe+VpZ1we3vBwkSkGJQY5/wKGLxxYRrYB0W931jVy8Tkxm+PaaWBkjqMSTErnuR
	 tzrSwVxyKcXTi3ngXqzckmS+ogtV42ezqFbmeFgv6P4vwEFOX5QN54+Mloyl27YTjC
	 Uk2lD4JuQ1mFRBiG3Pq9dtP56OB23YEcvgxu6WAeEZvkEtdltMlJfjB5viqIpcpfsC
	 46c2AcFz2ZNQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Shanavas . K . S" <shanavasks@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	peterz@infradead.org,
	vegard.nossum@oracle.com,
	tony.luck@intel.com,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH AUTOSEL 6.11 077/244] x86/bugs: Add missing NO_SSB flag
Date: Wed, 25 Sep 2024 07:24:58 -0400
Message-ID: <20240925113641.1297102-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Daniel Sneddon <daniel.sneddon@linux.intel.com>

[ Upstream commit 23e12b54acf621f4f03381dca91cc5f1334f21fd ]

The Moorefield and Lightning Mountain Atom processors are
missing the NO_SSB flag in the vulnerabilities whitelist.
This will cause unaffected parts to incorrectly be reported
as vulnerable. Add the missing flag.

These parts are currently out of service and were verified
internally with archived documentation that they need the
NO_SSB flag.

Closes: https://lore.kernel.org/lkml/CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com/
Reported-by: Shanavas.K.S <shanavasks@gmail.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240829192437.4074196-1-daniel.sneddon@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158c..be307c9ef263d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1165,8 +1165,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-- 
2.43.0


