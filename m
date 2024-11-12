Return-Path: <stable+bounces-92419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC6F9C53E5
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776FE28298D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5D21314C;
	Tue, 12 Nov 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gj4gediD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF020D4FC;
	Tue, 12 Nov 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407599; cv=none; b=dN0Zv4qeyYff+Hv0kvJZqRd9+lE1/azJbgY8tD71GcdDAkbbLKa9ySozvHiipRQMvwytHzNqjQRF9AYlMz/iXXqdvM5tvJKGnsZVIKwc42AsUlIauTDQ9bvhQVIMf7didiJBCTEF4OVIKKFuCCktQI3zwwoRakqMuVZHTgqCf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407599; c=relaxed/simple;
	bh=1Cd/ySkBjS7+Kf5QOUzoF1xvGxtv8y9Ckov25Jlc4ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJZi3btQqF0IClQeiphbRJ/++9Tcn6HLvHvcHb9z1/Du6y7fV/bN0ZD6gUms/TZh9MJMvrAJFimYqlOpIy9Yhp5/cPu5ED0lndfBD6n1lN0V+Hjb3MdI95O5Q3RHFu3TwQVUnUGzJIa8XuhzDu4zx/hYQTy2G2jFJ3JJsi3O5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gj4gediD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33271C4CECD;
	Tue, 12 Nov 2024 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407599;
	bh=1Cd/ySkBjS7+Kf5QOUzoF1xvGxtv8y9Ckov25Jlc4ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gj4gediD2q4Gvhd9n//1jfGC2c/7xliaZE6AuztksbrvnKO9HYDhlAEy2PU/za/Ji
	 jetiStlol8GbDwuT1+zP+Dl8MMzXcFBMVLRFnGUIbHphdYj11MRU2K/6ne80GfmfQx
	 BHsrgfO1/AfbLRhdc7a0jdesXF06314sA9CoJtyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diederik de Haas <didi.debian@cknow.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/119] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
Date: Tue, 12 Nov 2024 11:20:12 +0100
Message-ID: <20241112101848.880013988@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Diederik de Haas <didi.debian@cknow.org>

[ Upstream commit 87299d6ee95a37d2d576dd8077ea6860f77ad8e2 ]

The "brcm,bluetooth.yaml" binding has 'device-wakeup-gpios' and
'host-wakeup-gpios' property names, not '*-wake-gpios'.
Fix the incorrect property names.

Note that the "realtek,bluetooth.yaml" binding does use the
'*-wake-gpios' property names.

Fixes: d449121e5e8a ("arm64: dts: rockchip: Add Pine64 PineNote board")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20241008113344.23957-4-didi.debian@cknow.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index d899087bf0b55..42f9507c01da1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -683,8 +683,8 @@
 		compatible = "brcm,bcm43438-bt";
 		clocks = <&rk817 1>;
 		clock-names = "lpo";
-		device-wake-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
-		host-wake-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
 		pinctrl-names = "default";
-- 
2.43.0




