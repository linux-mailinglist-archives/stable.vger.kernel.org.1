Return-Path: <stable+bounces-31684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AA88980D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD051C312E6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF2026259C;
	Mon, 25 Mar 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzeOKG3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6901474A2;
	Sun, 24 Mar 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322088; cv=none; b=MbJ5Gq2uOJXlxJYRXMOBMWUN+H4CkGnLDIufBH3QNyet2zNATW3YTAkjGAWinTjbMUjKp0qiIkRikeLwxMceWKkqubM0qXkMqxmsJI6v8YTQWNQnhktlhdcZ2md+mMxqA4cKviE40+Hg9DcKSYcRUUqmYz3p7xa8gPl1nzp5f4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322088; c=relaxed/simple;
	bh=lthKCzVmzbEZRonMzWJu28LZfwWlrNRNz5JWSujoI/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhuxqywtMMB9MI6Md+Z+0t+2obXsnf3UJX/ps8iBluG7zziRpP4Dude+d/jFEdEk0y7505AaRgRCenfDNcmcLmvwWS4xW7Qua1NMYsqEMjkx6PJ3sPcWdmouyFk867N8nqH9PVRKNcHl3BSHhzXrnQDyiWivKcdI8A/HQLYuqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzeOKG3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4861C433F1;
	Sun, 24 Mar 2024 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322088;
	bh=lthKCzVmzbEZRonMzWJu28LZfwWlrNRNz5JWSujoI/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZzeOKG3qtNdFtTdynHrqbUsfmtwfW1VOrLDFDIJHPo2Xj7ou1KzXyEWJQjwyK6UV/
	 55cxfbTN073jnZ8GdZPzFpc8RVPiB3JsbD+HFJkSEPV5M0dmtQOL1hPGbJrt3JpNWv
	 lkEfahGHvt7RMNfEuI9SHpYcaxzi4bUZbXhUPVsEuEvov+4q6MEOEW3zxtDCEI0g6k
	 VyTn0PytJ1nqyPD9KKe6T3QwRy0HNQtHIr2C3RPaQOziUy8WutkbbxUzO6hR+pRg5L
	 Vrn2AC8gd+j7IsVWuARdBOCMvTjHmywyH5wJ2j4JMIyvYVwxsCaP6NIPD8aQQhfcwV
	 pnd1iIUJ82z+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Te Yuan <yuanhsinte@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 162/451] arm64: dts: mt8195-cherry-tomato: change watchdog reset boot flow
Date: Sun, 24 Mar 2024 19:07:18 -0400
Message-ID: <20240324231207.1351418-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hsin-Te Yuan <yuanhsinte@google.com>

[ Upstream commit ef569d5db50e7edd709e482157769a5b3c367e22 ]

The external output reset signal was originally disabled and sent from
firmware. However, an unfixed bug in the firmware on tomato prevents
the signal from being sent, causing the device to fail to boot. To fix
this, enable external output reset signal to allow the device to reboot
normally.

Fixes: 5eb2e303ec6b ("arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240124-send-upstream-v3-1-5097c9862a73@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 3348ba69ff6cf..d86d193e5a75e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -13,3 +13,7 @@ / {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 4669e9d917f8c..5356f53308e24 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -33,3 +33,7 @@ pins-low-power-pcie0-disable {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index 5021edd02f7c1..fca3606cb951e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -34,3 +34,7 @@ pins-low-power-pcie0-disable {
 &ts_10 {
 	status = "okay";
 };
+
+&watchdog {
+	/delete-property/ mediatek,disable-extrst;
+};
-- 
2.43.0


