Return-Path: <stable+bounces-153278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D83ADD39A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFCB3B5022
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5122DFF08;
	Tue, 17 Jun 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PxWFPPdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE32F2379;
	Tue, 17 Jun 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175444; cv=none; b=JFwtyqnRNnu2Iuor0hJyczg+enBy1jiVmgkbTIhN5B15xrhJtImcerBWGtWnDIN2yqGohChEo0iFnHF6IpphO+/qEKRsyXb5h8XAUgQ8J82yCE/uFaAQl781hbWcBCUyt1T3pZV/W5ZIytgTikOtM4So+JCBOgT+j4cELTZDcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175444; c=relaxed/simple;
	bh=w6T8r/FNm8CW72qLJO4e9TJZqX7QmIUnA8JQz9kccj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m//VuM3rHK+Q4V2a2EoPFR22Gzobet0ktTLib7+y6MR1tllkUEkQ4b/TMnuAR5Ws5qSe9D+509xYJ8MVl+dbGv0UZULUWIA3ZMT+uCf45w1hJQHdgxPBFfg147jBPAl79mlN/+3nMPa/I3I7BWVc/XBu1+tJfqGCFmuELYIk9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PxWFPPdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924EFC4CEE3;
	Tue, 17 Jun 2025 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175443;
	bh=w6T8r/FNm8CW72qLJO4e9TJZqX7QmIUnA8JQz9kccj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxWFPPdPVaWRkKVBXiUV8eXNkpOwB/4OVhjvPE5Atsf4/wOMpLRy6edFLQmsn9CO7
	 /HjMq09yKCgFsiH/Vv69WfBI7bieAKCbukvh+HrYeitzB3U8DKAKki+2e+2ITX2vKm
	 8Xdfc54W1q2ixjgEXXr5ZbTMFo1zj+1euYYz8bC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Robinson <pbrobinson@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 177/356] arm64: dts: rockchip: Update eMMC for NanoPi R5 series
Date: Tue, 17 Jun 2025 17:24:52 +0200
Message-ID: <20250617152345.337321877@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 8eca9e979a1efbcc3d090f6eb3f4da621e7c87e0 ]

Add the 3.3v and 1.8v regulators that are connected to
the eMMC on the R5 series devices, as well as adding the
eMMC data strobe, and enable eMMC HS200 mode as the
Foresee FEMDNN0xxG-A3A55 modules support it.

Fixes: c8ec73b05a95d ("arm64: dts: rockchip: create common dtsi for NanoPi R5 series")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20250506222531.625157-1-pbrobinson@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
index 93189f8306400..c30354268c8f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi
@@ -486,9 +486,12 @@
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
 	status = "okay";
 };
 
-- 
2.39.5




