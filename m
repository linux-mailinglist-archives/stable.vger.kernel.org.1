Return-Path: <stable+bounces-39505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350858A51E8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE8E1F22E1E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E578B4E;
	Mon, 15 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFeH9Hgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332E78676
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188324; cv=none; b=oNTat3df1gyRKE2goLBICq8fBRfFez4GaJGEw2lGvoVoAIEKxGXRKtD/elQdHaDoLJ4KB4r81RBibGvsDZ1al/AcT+zp2oZUNpQ7+V6wrqcrBSMt1iKTFMsvSp0SRRZgd+OD6R0ZwTIavIZrl8nAqNnwS/2gSi7ozHL8rh50Sh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188324; c=relaxed/simple;
	bh=aB3tZ9Dm7Hx04BzqLVF7kUi+UWKO+jEs8GtY7bv3zBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8xhNv3psQBKyZEUXRZEMXg1DGxEJQBzsH47aKhVoOG2aBqCpEg1w2tnK98M2iFefM+aHEuOfCMMLJqdQcZ6rn5g/1WR2KCNoclWpr1KZwPK4uj2SpZ9a825KQOFRzfe2+wwDMoAbPVolhTvJknxrKRk3aw9ojP9aOnTrI6Rpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFeH9Hgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5A9C113CC;
	Mon, 15 Apr 2024 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188324;
	bh=aB3tZ9Dm7Hx04BzqLVF7kUi+UWKO+jEs8GtY7bv3zBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFeH9Hgp2zJgqoLXNfAnxxzNlVEqPf6VRE6lOWlfgMP/vGtBd9sjGgBukBmXFf9Z4
	 Xs8iJNpvOUnIgOgK5ZzdYRA9+nBFs0RV6enGwkWElVUsOb+eHZWMhFnYDcSzEOlLvD
	 Fg3WCIqlZehxD6pBZvayUJUqwQNwe1Jz4L1LX0dWxAnZea2pEJ/2ZIpr7ahx0eO1DN
	 klAOE4TKhAWgcEZom2+yXTK9bVR8fhPP/9oALPirOa6mtLg7mAJLUd5LBScVKZAvXM
	 zwQZdm2wVl11IS7+gKbwRbdmlnvInXfnmEL94E/z73eTibh+HfL/bUL6OFACthQVXp
	 evsRu62ly+wOA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 025/190] arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
Date: Mon, 15 Apr 2024 06:49:15 -0400
Message-ID: <20240415105208.3137874-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 24165c5dad7ba7c7624d05575a5e0cc851396c71 ]

Fix a unit_address_vs_reg warning for the USB VBUS fixed regulators
by renaming the regulator nodes from regulator@{0,1} to regulator-usb-p0
and regulator-usb-p1.

Cc: stable@vger.kernel.org
Fixes: c0891284a74a ("arm64: dts: mediatek: add USB3 DRD driver")
Link: https://lore.kernel.org/r/20231025093816.44327-8-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 1c3634fa94bf4..03ffb331008af 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -51,7 +51,7 @@
 		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-usb-p1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -60,7 +60,7 @@
 		enable-active-high;
 	};
 
-	usb_p0_vbus: regulator@1 {
+	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.43.0


