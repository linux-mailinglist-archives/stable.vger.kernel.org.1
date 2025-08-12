Return-Path: <stable+bounces-167716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE8B2319A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EC217536B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69602FDC5D;
	Tue, 12 Aug 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dijQFAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810422F5E;
	Tue, 12 Aug 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021755; cv=none; b=fVGqf46rC83pp5z4YSroOtRLC4eJt/y1Gzm+cXI1ntjK/hGTsoY1+PepbP7GTeym0bcKQK//Q7BaWHSk65Ocb5dzWZxTKD2SLo0r72YsHCyqq73iLjhn+kT2RN616uop63SA6eVkIreJhtF/tYRE8l5NRBQ+wIO6O3fBI52GcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021755; c=relaxed/simple;
	bh=oxWGq7Ofg//f3GGhrYrIMB4c4mq3/Yi52Dr0lDVL8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe4ZXrnDIKqeYi+WeUD3pVjZz0b3pAFvc2gH7JPam3pj1CtyRPs74iDAiXmoLfHMCRHD9hWcE2LToE0LbqiPYgrxWvMP/1r55qj1V5RuhnmEtXXS+nxlbtYYzNsXnL6jK7ej1CRL/9ahqi2hNZovn69UJtRSsYfG/fx9D4/wHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2dijQFAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B3C4CEF0;
	Tue, 12 Aug 2025 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021755;
	bh=oxWGq7Ofg//f3GGhrYrIMB4c4mq3/Yi52Dr0lDVL8yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2dijQFAU4LZrAk0npnCKYnZ1te2QG9xzGbUPHQB06njXPU40b6bDGE5GRLhvxDFay
	 HA5zblostoxtrxTZzPBerg5jPZGNHJqP+qPKwngSNkEVHa0bkZFUosvqXZcKnQ5/a6
	 Hh0Dbwkx7f7c+sJU+66mrLXlwGuvsKLsnHbVT16g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 215/262] irqchip: Build IMX_MU_MSI only on ARM
Date: Tue, 12 Aug 2025 19:30:03 +0200
Message-ID: <20250812173002.303825135@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3b6a18f0da8720d612d8a682ea5c55870da068e0 ]

Compile-testing IMX_MU_MSI on x86 without PCI_MSI support results in a
build failure:

drivers/gpio/gpio-sprd.c:8:
include/linux/gpio/driver.h:41:33: error: field 'msiinfo' has incomplete type
drivers/iommu/iommufd/viommu.c:4:
include/linux/msi.h:528:33: error: field 'alloc_info' has incomplete type

Tighten the dependency further to only allow compile testing on Arm.
This could be refined further to allow certain x86 configs.

This was submitted before to address a different build failure, which was
fixed differently, but the problem has now returned in a different form.

Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250805160952.4006075-1-arnd@kernel.org
Link: https://lore.kernel.org/all/20221215164109.761427-1-arnd@kernel.org/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e7b736800dd0..4ff91df76947 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -483,6 +483,7 @@ config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on ARM || ARM64
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-- 
2.39.5




