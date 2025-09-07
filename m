Return-Path: <stable+bounces-178683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F53B47FA6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5414200482
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D24315A;
	Sun,  7 Sep 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2UkWa6s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6320E00B;
	Sun,  7 Sep 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277622; cv=none; b=T1ZnN4Fpwu6RM7/tRu/c0rGKQwvfdRFkUh23j4uYDvV3MksjAWe0WGwdudfwG4cFs96ud1M6psHOUAOKCOtjNBMWKfMZI9XBEUFAaqNOi2ygFOcF2n0zgImpll97u8Ae4UWpvE20MevDmd+EOT3NgENQnAs16SrWLdpUIN92do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277622; c=relaxed/simple;
	bh=TWfh7j8s7soES57xijcAqQMlSSlKspA/Uy3dFEpb+Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpIC7/okBL+FEEqZsEUoEzQKgYWkcNnRbGLSyxfvkFXgto4uMTNclbmxUOXDAXPUwuCRngv5hI47cBV+8N/LBktNCx2qsw91WPZhbm3qUNKdvdrcHyHcXgZ1pgCTivSraYDAYKaTJbAFENn6+L7NiwPXLyPr5+mPSid56Fmwu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2UkWa6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0736C4CEF0;
	Sun,  7 Sep 2025 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277622;
	bh=TWfh7j8s7soES57xijcAqQMlSSlKspA/Uy3dFEpb+Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2UkWa6sZ4FFydnWS46prNSHoQdM7fFnaoWceaQ5xcHYAsvjuulzthdF2gIqvlUYw
	 su+Cx2aJ1pWAnkqNzqnbZ54WsaFmzXE9GJEL69jqnjYBijFMy4nfIwjYUNUsydgUaC
	 YtWhAYLOgN0ozpTiVn+bjksPyon5fMtj0v+Fuysk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maud Spierings <maud_spierings@hotmail.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 027/183] arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 plus
Date: Sun,  7 Sep 2025 21:57:34 +0200
Message-ID: <20250907195616.420976428@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maud Spierings <maud_spierings@hotmail.com>

[ Upstream commit 8976583832579fe7e450034d6143d74d9f8c8608 ]

The logic of the headphone detect pin seems to be inverted, with this
change headphones actually output sound when plugged in.

Verified by checking /sys/kernel/debug/gpio and by listening.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
Reviewed-by: Ondřej Jirman <megi@xff.cz>
Link: https://lore.kernel.org/r/20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 121e4d1c3fa5d..8222f1fae8fad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -77,7 +77,7 @@ &analog_sound {
 	pinctrl-names = "default";
 	pinctrl-0 = <&hp_detect>;
 	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
-	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
+	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
 	simple-audio-card,widgets =
 		"Microphone", "Onboard Microphone",
 		"Microphone", "Microphone Jack",
-- 
2.50.1




