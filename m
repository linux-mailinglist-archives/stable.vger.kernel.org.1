Return-Path: <stable+bounces-166344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B32B1992A
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CB418981BC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4F1D8E10;
	Mon,  4 Aug 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT8lB2Mr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57531F4703;
	Mon,  4 Aug 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267995; cv=none; b=ZDc6CqTYdq5UsjPnFRGPsYnH6qGPcfMXXJXuPhPzBSeSgomLp8AWBuFGRb8UtOQaXCnzPPJHpEqXgRZprKeRs4CTcgSteCDUZCl8JiF4EP0VXxQ7M44kxxtkGXvHGFEJmGrG00OHeJNnn478uT0/uYbTxIoncWw/e7JP6y8bzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267995; c=relaxed/simple;
	bh=sK+WTN7oh81tSWW6K2wvlz3g5Yin9pmjz+vgi94Uhhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vp59tRwGo2G8EAdioQtnGDP8i5lFPy+opUTCLJ6nZSIsQEsK2u+qCRowNWBM7DV9eRVxCez5+T2fO9v/8iqWPJeaThVDZ8K84oOPdbUiHSIF3Pr9LO5cQT5vcE+OZtACzghwFIBMs+2EJ1i1BMsfXa9CjShEOuwuwO6Nx7yQ16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT8lB2Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CF5C4CEEB;
	Mon,  4 Aug 2025 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267995;
	bh=sK+WTN7oh81tSWW6K2wvlz3g5Yin9pmjz+vgi94Uhhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT8lB2MrYZEFqihyMGEEJ/thNGRkOBVZ0x6GPDoyqlK0Yt5KoTydfNkzFP71fzRzE
	 wjT91IED04qU55Q7OdXrZtKlvyYOJBZRgDb/tm/AhSBYfNBFNCwISbXPKbK4OAOH0c
	 BOg23Hi1rOH/P5V5Hds3JvHgG5YKZzEtpUmcaxCokTVzSUpnmHcw0jWPas2MJHS8g/
	 KzpQQz4wscErW/4N9yG9AeTg7Dxha780p6ZH/L/je1dJjXPpFlQBGBcLbAonM2VGcw
	 P5OAVKnNb+mFg2R8j9DjVf3eB0XNJLAKIlL7Hfy0N2uopetA2fzu0XWkdGAZzW98k7
	 PyzOPHfugU3IQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 28/44] reset: brcmstb: Enable reset drivers for ARCH_BCM2835
Date: Sun,  3 Aug 2025 20:38:33 -0400
Message-Id: <20250804003849.3627024-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 1d99f92f71b6b4b2eee776562c991428490f71ef ]

The BRCMSTB and BRCMSTB_RESCAL reset drivers are also
used in the BCM2712, AKA the RPi5. The RPi platforms
have typically used the ARCH_BCM2835, and the PCIe
support for this SoC can use this config which depends
on these drivers so enable building them when just that
arch option is enabled to ensure the platform works as
expected.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20250630175301.846082-1-pbrobinson@gmail.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Analysis of the Commit

### 1. **Nature of the Change**
The commit makes a simple Kconfig dependency update to enable two
existing reset controller drivers (`RESET_BRCMSTB` and
`RESET_BRCMSTB_RESCAL`) for the `ARCH_BCM2835` platform. The changes
are:
- Lines 54-55: Adds `ARCH_BCM2835` to the depends and default lines for
  `RESET_BRCMSTB`
- Lines 63-64: Adds `ARCH_BCM2835` to the depends and default lines for
  `RESET_BRCMSTB_RESCAL`
- Line 67: Updates the help text to mention BCM2712 alongside BCM7216

### 2. **This is a Bug Fix**
This commit fixes a configuration bug where the Raspberry Pi 5 (BCM2712)
platform, which uses `ARCH_BCM2835`, cannot properly enable critical
reset controllers needed for PCIe functionality. Without this fix, users
building kernels for RPi5 with just `ARCH_BCM2835` enabled would have
non-functional PCIe support.

### 3. **Minimal and Contained Change**
The commit is extremely minimal - it only modifies 6 lines in a single
Kconfig file. It doesn't touch any C code, doesn't change any logic, and
only updates build configuration dependencies. This is the ideal type of
change for stable backporting.

### 4. **No Side Effects**
The change has no negative side effects:
- It only enables building existing drivers for an additional platform
- The drivers themselves are already tested and working (used by BRCMSTB
  platforms)
- The change is additive - it doesn't remove or modify existing
  functionality
- No API/ABI changes

### 5. **Platform-Specific Fix**
While the change is platform-specific (Raspberry Pi 5/BCM2712), it's
important because:
- RPi platforms are widely used
- PCIe support is critical functionality
- The fix enables existing, tested code to be built for a platform that
  needs it

### 6. **Clear Hardware Support Issue**
From the commit message, this addresses a real hardware support issue
where the BCM2712 (RPi5) SoC reuses the same reset controller IP blocks
as other Broadcom STB SoCs but couldn't enable them due to missing
Kconfig dependencies.

### 7. **Low Risk**
The risk of regression is essentially zero because:
- Only affects kernel builds that explicitly enable `ARCH_BCM2835`
- Doesn't change behavior for existing platforms
- The drivers being enabled are mature and already in use

### 8. **Follows Stable Rules**
This perfectly fits the stable kernel criteria:
- Fixes a real bug (missing hardware support)
- Obviously correct (just adding platform to existing dependency)
- Small change (6 lines)
- Already tested (has Acked-by from Broadcom maintainer)

The commit enables essential functionality (PCIe support via reset
controllers) for a popular platform (Raspberry Pi 5) through a minimal,
risk-free configuration change. This is exactly the type of fix that
should be backported to ensure stable kernels properly support current
hardware.

 drivers/reset/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index b0056ae5d463..d1bc691b2900 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -51,8 +51,8 @@ config RESET_BERLIN
 
 config RESET_BRCMSTB
 	tristate "Broadcom STB reset controller"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
-	default ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	default ARCH_BRCMSTB || ARCH_BCM2835
 	help
 	  This enables the reset controller driver for Broadcom STB SoCs using
 	  a SUN_TOP_CTRL_SW_INIT style controller.
@@ -60,11 +60,11 @@ config RESET_BRCMSTB
 config RESET_BRCMSTB_RESCAL
 	bool "Broadcom STB RESCAL reset controller"
 	depends on HAS_IOMEM
-	depends on ARCH_BRCMSTB || COMPILE_TEST
-	default ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	default ARCH_BRCMSTB || ARCH_BCM2835
 	help
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
-	  BCM7216.
+	  BCM7216 or the BCM2712.
 
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
-- 
2.39.5


