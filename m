Return-Path: <stable+bounces-31702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62288982D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C4F1C31396
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CAF378C7C;
	Mon, 25 Mar 2024 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+NP8EU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F11474D6;
	Sun, 24 Mar 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322101; cv=none; b=BwjuH8OhKFtjqNtweGZ/bWWoPTNkKg+UwpH5CjvALvm9qYX/KSGveoI/jOTFeUoo1ojvYVos0Q/JA/HmGBRQUIAEzUsFr99c8T9dDddVf9qMCuRbEI1st0Am+91jNRgFY3jItCO3greaWcWNoC8pDYyj6h0FJno5860kJyyIS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322101; c=relaxed/simple;
	bh=SAn/tLgeSLUD3wp0VC/x3bw16DmDfH3DFah+D7EV1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6XfNS0fbkvdyD1BfWuXrhp3ozWeeGTHMQtYBJDWJcgYnD26tVTB26ANnytsSSMUCWB/T/l22IdUfsC9+CM+7TX0xGNSz+wST/dZrV8XuavC3ODUjognzYEBF8fREscRz/7tnjARVh4XQL2LvhhjhFgFJjAdUlcxH5nsR5Qk25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+NP8EU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E9C43399;
	Sun, 24 Mar 2024 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322101;
	bh=SAn/tLgeSLUD3wp0VC/x3bw16DmDfH3DFah+D7EV1po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+NP8EU5wW5Yb9isouumurva2zguQXBASbU3GfOlm268W0x3nW/ygVVYK/ELrH9z7
	 YtdX4zlB31MNyq6lOMPzchLhiQ1sE4QGjhrQI9d73UFBOjE2Qj3RR0gyRXxgakIpxi
	 flN5zayiPNs69FyuLL11RfdecMLRTiiCHdGP/Jp0ROzLWPTqtVCHG2tZIXTbh3vmwa
	 caGcBFZ7aPFwx+qgGaDOEuSzCkyc2E2uMB7as8c8EVv6IRvAld+Z8WHF6ADNg77nFl
	 AVWNjEa/KW1YLBVFBbtEY9TFygTrMuUiJycGVWAoW/7pAUuVze3bdNxdUsQqog41BZ
	 jR/JQEa9TpbTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 176/451] ARM: dts: imx6dl-yapp4: Move phy reset into switch node
Date: Sun, 24 Mar 2024 19:07:32 -0400
Message-ID: <20240324231207.1351418-177-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 7da7b84fee58c85a6075022023d31edea40e81a1 ]

Drop the phy-reset-duration and phy-reset-gpios deprecated properties and
move reset-gpios under the switch node.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 023bd910d3ab ("ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index aacbf317feea6..cb1972f8e8d27 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -106,8 +106,6 @@ &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <20>;
 	phy-supply = <&sw2_reg>;
 	status = "okay";
 
@@ -131,6 +129,7 @@ phy_port3: phy@2 {
 		switch@10 {
 			compatible = "qca,qca8334";
 			reg = <10>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
 				#address-cells = <1>;
-- 
2.43.0


