Return-Path: <stable+bounces-93370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5D9CD8E1
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C849B262F1
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30AE189919;
	Fri, 15 Nov 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+jDmDcC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B5153800;
	Fri, 15 Nov 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653695; cv=none; b=u1u3Cc8iKiwSk3FzN/qm/6ZOilx6chqFwWw0PArm/7XI//CRXm//ZyFSmyMsa3KOiNekDLI2pNSAetE5GhIgYQr6MlDXOJZG4QZfUEwDRm96MK/2SmQCdswnprE6UMbGzFtK+uSXiTJII4V66I6rfSGy/9Dt6JqIboeA9clp2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653695; c=relaxed/simple;
	bh=/6HKFjTMNDvfex9AyzBVrGKx0jIGDBcwOS23QtutsZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA6BSob7QVRfff0BxZ14f/T78XxQUwTgi3nR4oAMwySFoQAE6anJz6kikPuhoIG1ZjOXFXzLYmv78uJOqRuOeh08lemPu+gyhf9c65tok22mH17U0hZ2LTFQ7wKQuHUZdwzpscoXmMTUHJVYZOW5amrlYUkER0YLtF91RX4dP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+jDmDcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AF9C4CEDB;
	Fri, 15 Nov 2024 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653695;
	bh=/6HKFjTMNDvfex9AyzBVrGKx0jIGDBcwOS23QtutsZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+jDmDcCpKfp1A1df1zd4q2ZcJQWZ+4RCqtrgOoYv6AhNuXArC5X+jS+2eKulYrwz
	 fJ9AMO+mted5tSdLwuvf3G5rhBDBS5bQGcD6eiyQrZ6gRbgvv5UjKkBGC08eNAJ3JR
	 jyPUgJ3JSk32vA26e/NYksXfqEtQEq47kcab/lys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Caesar Wang <wxt@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 10/82] ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin
Date: Fri, 15 Nov 2024 07:37:47 +0100
Message-ID: <20241115063725.938417466@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>
References: <20241115063725.561151311@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 77a9a7f2d3b94d29d13d71b851114d593a2147cf ]

Both the node name as well as the compatible were not named
according to the binding expectations, fix that.

Fixes: 47bf3a5c9e2a ("ARM: dts: rockchip: add the sound setup for rk3036-kylin board")
Cc: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20241008203940.2573684-15-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index e817eba8c622b..0c8cd25d0ba5c 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -300,8 +300,8 @@
 &i2c2 {
 	status = "okay";
 
-	rt5616: rt5616@1b {
-		compatible = "rt5616";
+	rt5616: audio-codec@1b {
+		compatible = "realtek,rt5616";
 		reg = <0x1b>;
 		clocks = <&cru SCLK_I2S_OUT>;
 		clock-names = "mclk";
-- 
2.43.0




