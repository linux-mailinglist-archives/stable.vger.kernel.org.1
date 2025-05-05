Return-Path: <stable+bounces-140700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBCAAAAAC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE71E4A28D6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE743991A4;
	Mon,  5 May 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmHhZPYq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A938096C;
	Mon,  5 May 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486016; cv=none; b=jpd9dGj74VhGdZ3OXy6i/SQnDKUcYhuV3Zf78Unejby+WToUxnZea+O/cxOzdMF0ecIMNb2mfLFDKA6ukDvigLYhB4TXK27fFbOAs++T6g2DATjz8OJfR48I18Sj8/zq4RPGidJ+JwfJ6k55BMtqU/HGNtgx9+t7DVWR6df6/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486016; c=relaxed/simple;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ba1U+0CjRH6mEoY7E2mHPqqah7KXhumromwiyxuQ4iKxCPTBLyaWyx/si2RbjxYQ3ouwNbou8VfGqLeUpDT7nmWXa8fghCfYJEik6eQ5eJfz2faPEXxIG0kkKsvYr4ywJ+ozup9uUc2BXZxs7Uk83E2dlT6SFukCHaT5CDf7xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmHhZPYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FE2C4CEE4;
	Mon,  5 May 2025 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486016;
	bh=o2nRDv428v4MvnR0vHSeeoTJRiIo3h6mJurHS12K5IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmHhZPYqgOs8HEuDWREKfbRyxeqgC61+REak2puecNrbM+w4qTwCTbcVNzUW5dQmF
	 y9kHQ2OyHh2hrG6MerZdUa3Iqh8hNMQ060yDzAwPn8u1U6WkFZ2hvke5NR/msF9fl4
	 Sc8s7UECzFs4WLP2t1DPjiHHDY9JX17312dNk0KpgKE8WeSnZ+Fv84jqXVbFDD0eXv
	 xOVR+EEgavuruSmYANQA1iJGyP+9XhibTZuU94CRa6QuOI4oaj8Wl1XwiM7gF8n1Kp
	 v2/jQ7cLNw08hPhXPVTjTDSspHfh9AeWu/1eGjkJH9LFxB8KVcoKASmU4bdthCc1MO
	 8Hbc5g2ncvjtw==
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
Subject: [PATCH AUTOSEL 6.6 111/294] ARM: tegra: Switch DSI-B clock parent to PLLD on Tegra114
Date: Mon,  5 May 2025 18:53:31 -0400
Message-Id: <20250505225634.2688578-111-sashal@kernel.org>
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


