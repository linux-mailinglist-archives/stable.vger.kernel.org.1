Return-Path: <stable+bounces-220696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEdEJlhCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C11C711F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D59EC3192241
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226623F9AA7;
	Sat, 28 Feb 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn5jF9OA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867048C415;
	Sat, 28 Feb 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300576; cv=none; b=s/JrcLpEx5Kkw1qsttCC9sQ6NbiJ6vfYEmJeGS6wMgWYtSWJ31kkxQSnUbgLmrurwy0U14l3CB1v1pB0uNdBu3pu04QaztczDRttark6HwEsgQNvL2XTDNoQX4EPUBdYHmAZ5mOZHrSTFGxK7z15jasr3r3VIOBzuoVTOMqAwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300576; c=relaxed/simple;
	bh=yTTyB47Ztk/N1dRwdYvfAmvLvNR6akIwIhIhlTILdN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIhmJs+3zER8WWeJAw9BuQnkOI+CRpRfqEoePmoCPYmSBV8qfGVZqOHr9GgRkINJi5ooz29b/SX7Q4ParY+MrEEt1lk4mnzBNKlNgRlScLZ+EfJ+apGQcVkTqcoUZnKUSnPK/H1PjyIDcQWH6uglTah74aLOBQZJPW4ZiWDY7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn5jF9OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FDFC19423;
	Sat, 28 Feb 2026 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300576;
	bh=yTTyB47Ztk/N1dRwdYvfAmvLvNR6akIwIhIhlTILdN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn5jF9OAdSXd3Fj6jnMGJUDe46zpChAconJcJcylfK6p1BP+9Wh0bqn+nFlgSrWPp
	 d8XwgISHglNSK7c8PUynZh0QW/RcP6xM03BnyZaIgzJmJQaoCPRwU53vKt0bTp+L3m
	 f5mDiSZFjkSSU7JvVQPjBnxK2yx9jZiFNEzqOpnc+M1FauL0LPGGOzFO533I/QWERg
	 yEuVX3MTxvwCQH+BSV2WOETgwhzHvEXoC3V2Z/tCoVd04/Wd6sN0vlMr4jWyQd76/I
	 SvNWb5GQQxUScbtdcX/sKj5rxgdB9qU4gJGiuZRjrjZH9UG99DcQvXLozL60ZbtGqG
	 bb5A8yXRUgXJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 617/844] arm64: dts: rockchip: Fix SD card support for RK3576 EVB1
Date: Sat, 28 Feb 2026 12:28:50 -0500
Message-ID: <20260228173244.1509663-618-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220696-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,rock-chips.com:email]
X-Rspamd-Queue-Id: CB0C11C711F
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 7226664bf952c4cfddccd74b154a7d994608d153 ]

When runtime suspend is enabled, the associated power domain is powered
off, which resets the registers, including the power control bit. As a result,
the card loses power during runtime suspend. The card should still be able
to process I/O with the help of mmc_blk_mq_rw_recovery(), which is suboptimal.
To address this issue, we must use vmmc-supply with a GPIO based method to
maintain power to the card. Also, add cd-gpios method to make hot-plug work
correctly during idle periods.

Fixes: f135a1a07352 ("arm64: dts: rockchip: Add rk3576 evb1 board")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/1768524932-163929-5-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3576-evb1-v10.dts     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index db8fef7a4f1b9..ffe55f970f461 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -223,6 +223,18 @@ vcc_3v3_s0: regulator-vcc-3v3-s0 {
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
+	vcc3v3_sd: regulator-vcc-3v3-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren>;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s0>;
+	};
+
 	vcc_ufs_s0: regulator-vcc-ufs-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_ufs_s0";
@@ -810,6 +822,12 @@ pcie0_rst: pcie0-rst {
 		};
 	};
 
+	sdmmc {
+		sdmmc_pwren: sdmmc-pwren {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		usb_host_pwren: usb-host-pwren {
 			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -851,11 +869,15 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	max-frequency = <200000000>;
 	no-sdio;
 	no-mmc;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
 	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
 	vqmmc-supply = <&vccio_sd_s0>;
 	status = "okay";
 };
-- 
2.51.0


