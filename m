Return-Path: <stable+bounces-206575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31506D0926F
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D05830AFA99
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289932BF21;
	Fri,  9 Jan 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+iMD2H/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B72F12D4;
	Fri,  9 Jan 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959596; cv=none; b=nlJfmvbQYI4N6dK249fesFpclqjT379PfFCOPi+GDPpesUWJHnkYDKKwQYDlonCsjiYjn3fsr9XPOkn8e9SwTUEVI1oYl5VyRtiimC/VhJUGXCsvV4peDVpvy6qMuNa6empMAYS0XbojMNFgZbww0bRB6bmWcInlP/+ttr1B480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959596; c=relaxed/simple;
	bh=HQraHoUUiQ1iwP1NGLnMR7KMKw3fSeJZQw78rd9gE1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt0EuHon04DXaAzez46iwra2xnS3cSkNuksna2uI6X4QnABGwO/jq1uenfDvKRB84tt9bFE0gw856Vw51+uQiHVZ7QqPfoBFVy2PJf87traXsW5En1OROqYGA2/oZDUG0UYeZpMooYPh0RGc1f7oYyZg2O6jDT0PeI2Do5lQdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+iMD2H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700C0C4CEF1;
	Fri,  9 Jan 2026 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959595;
	bh=HQraHoUUiQ1iwP1NGLnMR7KMKw3fSeJZQw78rd9gE1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+iMD2H/Rc0YGPY7Q0TvFyeubkzaL5iBYI9VRLZqLbaV9quN80S49OSta8YPE4KRS
	 ir3xUecI61NxF4lfdH/I+k9cP4LWYAGYdDGFA7eX12Ol5ZOzFEg5wAAmgOXHVVHqCD
	 UTSk0b7xYgvEkNhR3YaiCWAUW0A7qIW/uzVxwRf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Harvey <tharvey@gateworks.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 074/737] arm64: dts: freescale: imx8mp-venice-gw7905-2x: remove duplicate usdhc1 props
Date: Fri,  9 Jan 2026 12:33:33 +0100
Message-ID: <20260109112136.779993701@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit 8b7e58ab4a02601a0e86e9f9701d4612038d8b29 ]

Remove the un-intended duplicate properties from usdhc1.

Fixes: 0d5b288c2110e ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index 560c68e4da6dc..f541360cb5548 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -401,9 +401,6 @@ &usdhc1 {
 	bus-width = <4>;
 	non-removable;
 	status = "okay";
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
 };
 
 /* eMMC */
-- 
2.51.0




