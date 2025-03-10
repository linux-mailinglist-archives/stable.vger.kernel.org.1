Return-Path: <stable+bounces-122582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AEAA5A04A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E27A3F1E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A622E415;
	Mon, 10 Mar 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xf42muSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0A17CA12;
	Mon, 10 Mar 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628907; cv=none; b=az/u1Qs7WbyUycrQxpUNR7qpVEU6egKoUY1GUKdXvBwkLNY57spHYzbUFkGpZdSZIc6xzfsKImXU8hSB8bQVdf0+o04guM2ubjMJ3S6S5CdboDyfSpVtohvjJDC6RuJpbaz1NSldpFeLSxwe1NrZdiTJ1W24Kd0uYLXOepd4cA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628907; c=relaxed/simple;
	bh=HxGT+4xLPrTMuYvnAFwy6HejmvBeqOFfi24Lnwqr6eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBt2MZrGA0Zkbo7zF9uPuPYyHRAYyHkh7nHLGdewrKFmWYDKYDr1uRXi60gPpFMqt3k7jNq3u5nQpkk23ohtEGRoMa36irqqP7SJexgwgI/EkzffbhpNMzye8KvS6eUcnMs7alz1oV7uaJ05JU6TX3CcviSa/p6zor2Hq2xKPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xf42muSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AE8C4CEE5;
	Mon, 10 Mar 2025 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628907;
	bh=HxGT+4xLPrTMuYvnAFwy6HejmvBeqOFfi24Lnwqr6eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf42muSPZJRz5AcOXnb0hawgi2XSeFZAW+E0TmAT9fpYiqA/tkqMTqsSm9Jb1RD9F
	 ZImwvykjPGahpHcKQFxgELXtG0QZ76mbbr5ORMa5+0vuLyVC0XCz6MvUPb2QeuT+UY
	 73SBFwwyufSSIXoPVmWzV/7ZIuxaX09NUuivKn1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/620] arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC sub-node names
Date: Mon, 10 Mar 2025 17:59:15 +0100
Message-ID: <20250310170549.908923847@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit beb06b727194f68b0a4b5183e50c88265ce185af ]

The MT6397 PMIC bindings specify exact names for its sub-nodes. The
names used in the current dts don't match, causing a validation error.

Fix up the names. Also drop the label for the regulators node, since
any reference should be against the individual regulator sub-nodes.

Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://lore.kernel.org/r/20241210092614.3951748-1-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index ed82a3feb789b..7d15be690894c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -914,7 +914,7 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		clock: mt6397clock {
+		clock: clocks {
 			compatible = "mediatek,mt6397-clk";
 			#clock-cells = <1>;
 		};
@@ -926,7 +926,7 @@
 			#gpio-cells = <2>;
 		};
 
-		regulator: mt6397regulator {
+		regulators {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
@@ -1092,7 +1092,7 @@
 			};
 		};
 
-		rtc: mt6397rtc {
+		rtc: rtc {
 			compatible = "mediatek,mt6397-rtc";
 		};
 
-- 
2.39.5




