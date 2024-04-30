Return-Path: <stable+bounces-41912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9134C8B706B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25B11C218A4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A02E12C554;
	Tue, 30 Apr 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPCHVQJU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611E12CDAF;
	Tue, 30 Apr 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473934; cv=none; b=UOPQ+GDb9d9YEaN/GkLoxQFDx2PgqaKivM/Qtvrl0ywVHj2DcALToPVWHelt9xjho5ILNNzMXe8nuzA6/zxGz1KIQKSKBNbJLPcvhxc86P5oHQlPpMKXN8z1Wi2dXr6pTFuHh4uWwh9N7p4zgs6FQq55/glAtEOxfWVosmd3M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473934; c=relaxed/simple;
	bh=zG5NiwLrKbtFedl4rprSD9mUHFLp0eTWgcbZHcA8310=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqLXu3U9qkuOw7L7/I/M7YOyQqKML6R/loHkr+1v8zY87WkRVTFkVbvmMwDq1HoXUl+9d/xqOweomPpMQo6IbBr1G5uFCakT0Nd2p+b2sqZXBdLb4OZbzbUi8N+dAzXfBSet6zOLsshaKx+RGudaXhUTr5rNyV+0BeJ3E+DudYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPCHVQJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579FC2BBFC;
	Tue, 30 Apr 2024 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473933;
	bh=zG5NiwLrKbtFedl4rprSD9mUHFLp0eTWgcbZHcA8310=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPCHVQJU4Lmk9mA0g6ZkWMWMndcNQhoHws7Q90G0mzRhs1qKGxNR1T3vDq9B2FFtO
	 XEaDjMu0tDPDknyTBgAricoXnZWQIFWAHybg3G6cOXhq9+63vryx8OXQ88TnJFFcFd
	 lzHYGqtBqN36WZia5xi/mdWQJeIsUH2O84XpKYkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Yan <andyshrk@163.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 010/228] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5
Date: Tue, 30 Apr 2024 12:36:28 +0200
Message-ID: <20240430103104.112287821@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Yan <andyshrk@163.com>

[ Upstream commit 64da060dd4eb625646970d7c96a16de617412ec5 ]

According to the hardware design, the i2c address of audio codec es8316
on Cool Pi CM5 is 0x10.

This fix the read/write error like bellow:
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
Link: https://lore.kernel.org/r/20240324112833.2181961-1-andyshrk@163.com
[also adapted the node name to audio-codec@10]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index cce1c8e835877..94ecb9b4f98f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -216,9 +216,9 @@
 	pinctrl-0 = <&i2c7m0_xfer>;
 	status = "okay";
 
-	es8316: audio-codec@11 {
+	es8316: audio-codec@10 {
 		compatible = "everest,es8316";
-		reg = <0x11>;
+		reg = <0x10>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-- 
2.43.0




