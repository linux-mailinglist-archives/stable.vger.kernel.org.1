Return-Path: <stable+bounces-140561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0DAAAE28
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7002189CE23
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2235FAEA;
	Mon,  5 May 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnsd71nR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4D30A80A;
	Mon,  5 May 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485152; cv=none; b=nnM9a2oQ5qMESpXDtAAeI172/Gkwul1uih5Xo1AFAXckafo84oTql3qYjg/5P1d8H0GMo5hp8UH2Hmn4hjNMk9XU84a/Bh77ESCsYNGOGbrQc6hppFKWf8mehwlidejnP1VHm0/ikjTCbNvfsX+obxiRqPBw3COj2PVJXKoEUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485152; c=relaxed/simple;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfeMOL/6jy01mtoc20C5o+N1M/glQ688dtf9LyoY970uQGqsORuHXxizDngUmha8okruX8qPBiRXyRHZH8ZKnoNu2z9wp2W/Abol+Ba6QnvOyhoTVfPwqDYgJqE046cPyBWXW6PBmEMMfqFIQaHVoQioSlVEtiT/7326b5s5ALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnsd71nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D805DC4CEE4;
	Mon,  5 May 2025 22:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485151;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnsd71nRjl69w/Fk3pvdCRV58/T+v6oLdiXFHET5N/Ubwlt0cfGzCkleZgxUcyr2c
	 RpvzrWqQm/fZ8a4juJq1XN8Zc3S+qM6Kxo6V0zNvads0/4nl4aNbbF3pS13tLLrgfH
	 Tk9mzb6h9zieZqCXJeZmSXPlLiUYfQNxnqWCmziA98KSAxZf4uWlfEsuUDTjX7gOS+
	 cZvn1sD6YBdySybI1Wm05MuvcnevcYPEDkNOVu6QoiR6Vtzwt0I3nUHJ9fupMpnHlg
	 wViQAXFGOdxGwbB1UGUwEP8CuDjwtOw0ylnvSyN1s9tZMe3D2PsuYvhLo5nEnw8rFD
	 JY0dsiyubNd7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 186/486] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 18:34:22 -0400
Message-Id: <20250505223922.2682012-186-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit 2b3db788f2f614b875b257cdb079adadedc060f3 ]

PLLD is usually used as parent clock for internal video devices, like
DSI for example, while PLLD2 is used as parent for HDMI.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Link: https://lore.kernel.org/r/20250226105615.61087-3-clamor95@gmail.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 86f14e2fd29f3..6c057b5069514 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -139,7 +139,7 @@ dsib: dsi@54400000 {
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
 				 <&tegra_car TEGRA114_CLK_DSIBLP>,
-				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
 			clock-names = "dsi", "lp", "parent";
 			resets = <&tegra_car 82>;
 			reset-names = "dsi";
-- 
2.39.5


