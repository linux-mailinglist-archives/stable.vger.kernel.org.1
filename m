Return-Path: <stable+bounces-93145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A679CD78E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C991F2267B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028917E015;
	Fri, 15 Nov 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pqYDnev3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C9154C00;
	Fri, 15 Nov 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652956; cv=none; b=CvnPtm3QM+H3dzpuTzbYvb8w7HTqH2wbFMHba5lwU4985uoU2AHmGYCWlZ96ZCYmyLL44kVkXJxDAyt/SkPk/XFI8IOdeAas0gK63LnQXBgwOWdA1VsJV40QCwPfdvEBGbsD+SQF5WoSYHy9rUEwwBrUV2AXC893aBaMzTW/mGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652956; c=relaxed/simple;
	bh=eIHITQ+IBPz02yI67ScZs8J4X9GEtBVZlDNeRnZpJ08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVxXbC9pYIM1HUDnHLus38O+s2QNvev9LJv1aFvK+/0NCBd85BCyPX7fyiLmhQozD1WC7oUSSehiv+LHhCMpfdBUVt598XK58lgLQHa/RMxNeduMnjpRD/wwhgxA5BX8/z04cxplKJeQ5G5P/zZEe2Spzp19in6cjtjTUe9Pd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pqYDnev3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD97C4CECF;
	Fri, 15 Nov 2024 06:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731652955;
	bh=eIHITQ+IBPz02yI67ScZs8J4X9GEtBVZlDNeRnZpJ08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqYDnev3kye/cS5wERAi4o1pqdfiPm4p/hMhCoSUzCddHPYA4b7EKQ2Hk0Lx4anEW
	 ZMQvlbFx6bx4o5o+YREhUumx26o0d4anoO/NgcTO3XvfnpgosBH+j3rNfM7DnwDHdF
	 Yb6un3pbBZxyFgBUtjwLpyGh4kmBouFdTKWhlb4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 04/66] arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
Date: Fri, 15 Nov 2024 07:37:13 +0100
Message-ID: <20241115063722.997802352@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 5ed96580568c4f79a0aff11a67f10b3e9229ba86 ]

All Theobroma boards use a ti,amc6821 as fan controller.
It normally runs in an automatically controlled way and while it may be
possible to use it as part of a dt-based thermal management, this is
not yet specified in the binding, nor implemented in any kernel.

Newer boards already don't contain that #cooling-cells property, but
older ones do. So remove them for now, they can be re-added if thermal
integration gets implemented in the future.

There are two further occurences in v6.12-rc in px30-ringneck and
rk3399-puma, but those already get removed by the i2c-mux conversion
scheduled for 6.13 . As the undocumented property is in the kernel so
long, I opted for not causing extra merge conflicts between 6.12 and 6.13

Fixes: d99a02bcfa81 ("arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM")
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20241008203940.2573684-7-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
index 216aafd90e7f1..08a8e35cd7d6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -56,7 +56,6 @@
 			fan: fan@18 {
 				compatible = "ti,amc6821";
 				reg = <0x18>;
-				#cooling-cells = <2>;
 			};
 
 			rtc_twi: rtc@6f {
-- 
2.43.0




