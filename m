Return-Path: <stable+bounces-141388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA2AAB6C1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEDB46524E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108029824C;
	Tue,  6 May 2025 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiMEVYEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BB2DB4D8;
	Mon,  5 May 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486004; cv=none; b=QCh9tFSA1QiR7Dnm2as2oiassqwOrHwHK6M2W0q3HukmFg++9pDXUER3LQhLK+YqWUj0h9Q1/t8jxodbuOp7XjsJkHQw6mUhUxCnLktnTDzdquCL2jb6a4W/YWJJhl0SbMlQP6Y9WJf0XlMrOAIdY/JdvFzyarvbWG9OkUorrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486004; c=relaxed/simple;
	bh=saZcNE4gx1D8gXuI1rjqKPbKSg93sYLrQS8kBHPgNcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqSfa+osEGNJN3RoGlszjd5k/0jSY9KR3PuVchJUfrwodnxQCMZo6Gn6TS0kh5IoDyd/q9mGWoGHucKJog5206sN+/z1izIMmu2Bra4rguy5PUSl+03OZACylLYlwOD2zRQNT8AgZayTfYCj7gP0oMU6Qp0N+wG/txW15x+rfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiMEVYEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18000C4CEED;
	Mon,  5 May 2025 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486004;
	bh=saZcNE4gx1D8gXuI1rjqKPbKSg93sYLrQS8kBHPgNcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LiMEVYEzenkOW7jQXGeGEWViGcTqjPd1NgfkuXTNy4tlEybRlPILCybZJA2QnjEi2
	 DfdnU06f/CSqTehgeNfsrCWmab7P4crKYYZ7DELY6Y9LoLX6EypikEj/LouYL0ueDx
	 OMZaTN3uhrkFK5y2nmenaLXJyKoSQr4rSESPOGX7Ks9pOSYXCDnExQRp+tjufqrH2j
	 Hx4xoCEVa3ZeggJlNkz2Yx3gKf346ejpkmQ07KPFBNOrlkUZ9IWEswziC3prJF07Yy
	 iX1FZW9BzvNd2dc0FHCcGf8ygPMCVL3T4zdrUo73mcHordrpjeciC0xqAUhl9kuWew
	 Wm3rha3CIiBVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	dstotland@nvidia.com,
	bgriffis@nvidia.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 105/294] arm64: tegra: Resize aperture for the IGX PCIe C5 slot
Date: Mon,  5 May 2025 18:53:25 -0400
Message-Id: <20250505225634.2688578-105-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 6d4bfe6d86af1ef52bdb4592c9afb2037f24f2c4 ]

Some discrete graphics cards such as the NVIDIA RTX A6000 support
resizable BARs. When connecting an A6000 card to the NVIDIA IGX Orin
platform, resizing the BAR1 aperture to 8GB fails because the current
device-tree configuration for the PCIe C5 slot cannot support this.
Fix this by updating the device-tree 'reg' and 'ranges' properties for
the PCIe C5 slot to support this.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20250116151903.476047-1-jonathanh@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
index bac611d735c58..2fa48972b2a91 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
@@ -102,6 +102,16 @@ pcie@14160000 {
 		};
 
 		pcie@141a0000 {
+			reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
+			       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
+			       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+			       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
+			       0x2e 0x20000000 0x0 0x10000000>; /* ECAM (256MB)               */
+
+			ranges = <0x81000000 0x00 0x3a100000 0x00 0x3a100000 0x0 0x00100000      /* downstream I/O (1MB) */
+				  0x82000000 0x00 0x40000000 0x2e 0x30000000 0x0 0x08000000      /* non-prefetchable memory (128MB) */
+				  0xc3000000 0x28 0x00000000 0x28 0x00000000 0x6 0x20000000>;    /* prefetchable memory (25088MB) */
+
 			status = "okay";
 			vddio-pex-ctl-supply = <&vdd_1v8_ls>;
 			phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
-- 
2.39.5


