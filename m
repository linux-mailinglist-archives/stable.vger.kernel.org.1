Return-Path: <stable+bounces-139971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C3AAA325
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A012416AACA
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAB2EEBC5;
	Mon,  5 May 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+3LDNR+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365272836A1;
	Mon,  5 May 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483803; cv=none; b=AkDH97HDg07wQU9AGF9qPrOv5EmOpwV+O88UuvsngSld448Bsgd+YAXoECgAtjTTIssLLwyOVdxcHdka3rMeR7jb9Hs6DFXq6DoFxdZGWpY5gGLojd0sh3PmetMbIWeAA+SgJirkEm8x9bsRfWNbctvCvWe+boDqtPdn5wsGGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483803; c=relaxed/simple;
	bh=pmor54l4XCngCgD85lLEsbS8WfQxEScnVxwUdAVvBSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWt1EwciaJQ23k7kc2ngNs/BvEyX6QE0gPc4xmsCdYeKscoTG0ADJDk3+qW3swTJ4tka0rUQcJl4rd9GX/C+Yb9Cj2eARyPeyRjALg08KHfgE3+02fibrVKrmsRFTJxejoW5hgYJtNiAnjuRQKOsZ5XynKOO3dikv+4FqDHXll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+3LDNR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46E2C4CEEE;
	Mon,  5 May 2025 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483803;
	bh=pmor54l4XCngCgD85lLEsbS8WfQxEScnVxwUdAVvBSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+3LDNR+akqEYRiQASanm5dPTDwzO0qFieQrWkjYCpjPWrgIdyZmW6p/BeVD+n8/4
	 E9wnt9RjczA1zAA7tg5g9vIIiNVuxU5/PrmEUC5x3VvOjTuWJ4FA4Ba+n4HJr7LblF
	 k+fx2STBLds/ISlaviFxejgD4jQWkQw+EAOpFN9V+jN5zCSZUo5p0kUTy5pWEvYkej
	 0/YaoIbw9Lp22Z0hKvz8eqyBNfQbGhFsqNtOeM2NlAIYEbztqQOaseA/t6Au2y74/i
	 XD/OqLl0VSfmBswZyaiqluupuN+rwvlVwSPO2JcLk0y7tFaGh37Lq3YwUBmpY3UQca
	 G9bLobo9tH0uQ==
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
Subject: [PATCH AUTOSEL 6.14 224/642] arm64: tegra: Resize aperture for the IGX PCIe C5 slot
Date: Mon,  5 May 2025 18:07:20 -0400
Message-Id: <20250505221419.2672473-224-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 36e8880537460..9ce55b4d2de89 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
@@ -302,6 +302,16 @@ pcie@14160000 {
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


