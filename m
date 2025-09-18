Return-Path: <stable+bounces-166169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E1EB1981E
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6821895E7D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00241CCEE9;
	Mon,  4 Aug 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP8Io/cB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC21C1ADB;
	Mon,  4 Aug 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267560; cv=none; b=rDLULeW7qLl1xX/LsklMh92Njm3CQdLnnMgAcDpVn95VhcWdfbe93n8zHgp0ABCIY7dpph+UyPWSi76m9JhQAs1h8yw7afaj5dMKMmnkpQzg3wyrgkteDrI41VCeSI3b1j6bxrPjYC5bp1Wr+rrmqz2Wam+hT/OeSmb8pDAYMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267560; c=relaxed/simple;
	bh=c14/7h2BR8AnkqUWruedKzxdC1c/Vm1opCnop1/jvqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBKSLuXBIrbn/mS4k4KEHq8OdEp2NTHCSnkjgTKtQMvugqnKSF7GEjYRxmr0EVzLZZyiCeNvjT4O6BrPjcXgtoq0uROlM5tldLTg+J+jjedFdV45qiaHYabIMiuBwMsTCNwaA6PK8soLpjrBuOsembinN0f3BUscne7HEcH4E3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP8Io/cB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E59BC4CEEB;
	Mon,  4 Aug 2025 00:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267560;
	bh=c14/7h2BR8AnkqUWruedKzxdC1c/Vm1opCnop1/jvqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FP8Io/cBB+Q6MvUbdMWv6monSbbiJrJ/LiEWYNxtXT8wAHrG0PdqiX/+I6obC+MgI
	 hSPAwRS1V3iRAKk0ZzI7FduAy/L5tciLsCguTXpNj1090VthU8l7bzfiYdXnvh9TpQ
	 gd85e9n2sl4fl+SzMm3aQOq7YLBKoyIiPcINcFUnxD75Fg5xk64bF+hck37tmZfs6c
	 jjqR0omp2d8EQYlrYEGN40yHg3jl6OaZ/r+zFMamvIrLt1lc/DqclcKy6zHvGUBHdH
	 StGM7NVOLfWp/gG8r2YwwE2UvMGxrnJeSrNk/YjGD8k7qVrU8hC7FmbnbRP3yfEuLC
	 ph6BaU7wsmSbg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 33/69] firmware: tegra: Fix IVC dependency problems
Date: Sun,  3 Aug 2025 20:30:43 -0400
Message-Id: <20250804003119.3620476-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003119.3620476-1-sashal@kernel.org>
References: <20250804003119.3620476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 78eb18020a88a4eed15f5af7700ed570642ff8f1 ]

The IVC code is library code that other drivers need to select if they
need that library. However, if the symbol is user-selectable this can
lead to conflicts.

Fix this by making the symbol only selectable for COMPILE_TEST and add
a select TEGRA_IVC to TEGRA_BPMP, which is currently the only user.

Link: https://lore.kernel.org/r/20250506133118.1011777-10-thierry.reding@gmail.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit is suitable for backporting to stable kernel trees. Here's
an extensive analysis based on the commit message and code changes:

## Analysis

### 1. Bug Fix Nature
The commit fixes a genuine Kconfig dependency problem where TEGRA_IVC
being user-selectable can lead to configuration conflicts. The commit
message explicitly states "The IVC code is library code that other
drivers need to select if they need that library. However, if the symbol
is user-selectable this can lead to conflicts."

### 2. Size and Scope
The fix is minimal and contained - only 4 lines changed in a single
Kconfig file:
- Line 5: Changed `bool "Tegra IVC protocol"` to `bool "Tegra IVC
  protocol" if COMPILE_TEST`
- Line 16: Removed `TEGRA_IVC` from the depends line
- Line 18: Added `select TEGRA_IVC`

### 3. No Major Side Effects
The change doesn't introduce any functional modifications to the code
itself. It only changes how the Kconfig symbol is selected:
- TEGRA_IVC becomes non-user-selectable (except for COMPILE_TEST)
- TEGRA_BPMP now explicitly selects TEGRA_IVC instead of depending on it

### 4. No Architectural Changes
This is purely a Kconfig dependency fix with no changes to the actual
driver implementation or kernel architecture.

### 5. Critical Subsystem Impact
While this touches firmware drivers, the change is limited to
configuration logic and doesn't modify any runtime behavior.

### 6. Stable Tree Considerations
Based on my investigation:
- TEGRA_IVC is indeed library code (as seen in
  drivers/firmware/tegra/ivc.c)
- Multiple SoC configs (ARCH_TEGRA_186_SOC, ARCH_TEGRA_194_SOC,
  ARCH_TEGRA_234_SOC) also select TEGRA_IVC
- Currently, TEGRA_BPMP appears to be the only driver module using the
  IVC library functions directly
- The library exports functions like `tegra_ivc_*` that are used by BPMP

### 7. Risk Assessment
The risk is minimal because:
- The change converts a user-visible dependency into an automatic
  selection
- This prevents users from creating invalid configurations
- The actual IVC and BPMP code remains unchanged
- The fix aligns with standard kernel practice for library code (should
  be selected, not user-configurable)

This is a classic example of a good stable backport candidate: it fixes
a real configuration issue that could cause build problems, the fix is
small and contained, and it doesn't introduce any functional changes or
risks to the kernel operation.

 drivers/firmware/tegra/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
index cde1ab8bd9d1..91f2320c0d0f 100644
--- a/drivers/firmware/tegra/Kconfig
+++ b/drivers/firmware/tegra/Kconfig
@@ -2,7 +2,7 @@
 menu "Tegra firmware driver"
 
 config TEGRA_IVC
-	bool "Tegra IVC protocol"
+	bool "Tegra IVC protocol" if COMPILE_TEST
 	depends on ARCH_TEGRA
 	help
 	  IVC (Inter-VM Communication) protocol is part of the IPC
@@ -13,8 +13,9 @@ config TEGRA_IVC
 
 config TEGRA_BPMP
 	bool "Tegra BPMP driver"
-	depends on ARCH_TEGRA && TEGRA_HSP_MBOX && TEGRA_IVC
+	depends on ARCH_TEGRA && TEGRA_HSP_MBOX
 	depends on !CPU_BIG_ENDIAN
+	select TEGRA_IVC
 	help
 	  BPMP (Boot and Power Management Processor) is designed to off-loading
 	  the PM functions which include clock/DVFS/thermal/power from the CPU.
-- 
2.39.5


