Return-Path: <stable+bounces-210507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKR8C+JpcGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:53:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D69851BDC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F15EC8A4DCD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622AE42B723;
	Tue, 20 Jan 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heUv2y+T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CD429829
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913644; cv=none; b=NuenOfj/aZYnTcHG40sgGSIdIgiT99Hxxx8EgO4qTUMp8Ss5lI3HSd5bj813YRNf5TEyzsW+e1IU5zpO+7Gt1ksC89SszW/gQMZQrck2DJu0VjlhXuVqAZwdqMobAMoIW63ix+Ay7whIZSru3Zb+N0p8P+4L5jFQyy5o6GoewoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913644; c=relaxed/simple;
	bh=rfOiA6dgd2q0nYUa0afVp2YzXs7KfO8y6Iz2Tj9FhBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cgh90dhtBpoX10l8AUN9nGYZLyy7cTQLbpEGd8iT0jbakLJMj8O1aj7Dz+OmoQB7rF+zz99RYZxxrFzKimIRw3zweemsj/tmv1D1nPxFYJfO0s4Xj3cCSbW+kIJvylGOSmw3rOADzdHEBGZi7ZSFldbi/4WbLcReu8fsRhO49us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heUv2y+T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so3677992f8f.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913640; x=1769518440; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upZyTdYXHRuOjxM2BwCRC4m8vkbpnnQvQrullGYrig8=;
        b=heUv2y+TMHiWn6IA7nGdNuGL/S8dk2BDaRhb7KvKxravXK/9Dbc6gLzlKjDaVHFH3k
         UWD+gRKMf930f9ByccAZENXFA6hdOQ3l8b2xVpbuI3e+EXwlwvDVWuoyDzQfYP9RxoEL
         2J0flEEBJN+cNkdLj/PQ9VGA48ee1Rn5HuAh69gXYPETfl93ehQyfIlsfoZzftDXRcnt
         dyL3B4qUGOuRildIetl6LeYHqMGdM4DPSQbvVVPF4/MigyBpHRrVJIUrQru8s5hlZ74b
         ZUksKlkArtDJGVskoODKawrZ5rQ4KSVWmRqlxy1qKm0Ok19hcLJJ7Iu7gkyd4D7tsjl3
         NFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913640; x=1769518440;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upZyTdYXHRuOjxM2BwCRC4m8vkbpnnQvQrullGYrig8=;
        b=K41fAJaVtrLeucfIpt+cbEYtQvBm4m7Fh5SLoea86Hgktu64cmFiRqIEUdQO2fiYff
         SrB4D/Rc2GVrUXHZnKSBOLEwrXCDKAArfJH2tqXVQPLPGUvMk/joeIy9+Ft+cvmZTAKg
         HZ1B9RgpdcBjCMkEkYcUMjx2dO3UMFsdeYArUjMo+MO/5ZFvIojQosYCtnfZNPwHQjtW
         vd2XjDlHTYM74VWSJG/3+8AYu74F/ApkUbm/WuewyRY3NQyeuRP83mgu/gnpBwIgUOLD
         6UMjJMhRhaLUkXlNpH0qlH4kJZ+NipFK64PWYQqmHzYu0uhB+BxWZ1A81PvB7sfagrUR
         dvVg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnbn6aUVFUoYRT5hAiLceByAsnzMfcX8Ki95Shm+4CcRRS+5SVG9Wd8J7T1Wdyig0CMTOEEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlxlVFY+hHOpq/oC7ncx7OADVRwUgk8I2fjd8zFACr1R/PpNh
	6sP88Ip/nioiIrCrTQ1hjn7EGOqFkcTwSX1wju3fUAelPIlYRkjnMz0g
X-Gm-Gg: AZuq6aL3XrkG8DnIMefDwh8YMw9eOP2Brv0qhjXL1lGfivMxDkT+aeHrEZI0ioJ3Vqq
	/DsNOvexDis3GrcEPjqaJtuvNNXZ1hNvC3E2mY+grVl/2XkYalNFf2jZRM8GDII8TXxr5G7BclV
	Uqy012Pqg/VNI1Jg4XVcpqRssIXASGC7oCP3wWjMSO8BeWbUWucEaIe360gtrWgqHQw1rq4PTZn
	7V9XaCZz3ZqGXcruIyXCflHEdy/IRfFiKVD6R8axIqFsPVZ9fzriscrey+C108jHe72IasHHmL2
	bRYMkuJbyBnkLfI2sw/yHHxkox+FirzbfbgfIXLLpIdNh5dBUrMG+fs2779RYqvfkuGeNXFxyCl
	3pCf4JitYxGjliY0+zyf8jaHySpApr8WEoL5y4mhm383PivPig4wf4NwYTNelCeo1N9QSus5KkJ
	5G5ChZRm4W26luaizTQYWxOdmjFMH8YZPvY1pfZBYgD++MoAm9xYR+kruNcqbHaA4=
X-Received: by 2002:a05:6000:2504:b0:430:f58d:40cf with SMTP id ffacd0b85a97d-4356a02c4c3mr18942565f8f.16.1768913639446;
        Tue, 20 Jan 2026 04:53:59 -0800 (PST)
Received: from alchark-surface.localdomain (bba-83-110-134-52.alshamil.net.ae. [83.110.134.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4359314bbc6sm2404931f8f.12.2026.01.20.04.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:53:58 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 20 Jan 2026 16:53:54 +0400
Subject: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset pin
 on RK3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOJ6b2kC/2XMQQ6CMBCF4auQWTumrQRbV97DsMA6hUmEkg4SD
 endrWxd/i8v3wZCiUngUm2QaGXhOJUwhwr80E09IT9Kg1GmUVo7fAXBJAuGcPeKvLWkzlDec6L
 A7126taUHliWmzw6v+rf+G6tGjd6Sa2p3crX1137s+Hn0cYQ25/wFnfrYUZ4AAAA=
X-Change-ID: 20260119-ufs-rst-ffbc0ec88e07
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3949; i=alchark@gmail.com;
 h=from:subject:message-id; bh=rfOiA6dgd2q0nYUa0afVp2YzXs7KfO8y6Iz2Tj9FhBc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTmVz3XL1lyvd75GNP0eb61RZziFU95Xl/9JufO+euHZ
 1/TbTO5joksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKZ6kgYjw5mWgCsLt615obBhzdf1sW2hq2tunGW/kRGw+7/1kR2F63QY/ns83rl
 iguGy5HC/X5uftM4tUF5Y53WUyeLuSZFLLwNOczAAAA==
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[cherry.de,vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210507-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8D69851BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
UFS device, which can operate either in a hardware controlled mode or as a
GPIO pin.

Power-on default is GPIO mode, but the boot ROM reconfigures it to a
hardware controlled mode if it uses UFS to load the next boot stage.

Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
device reset, request the required pin config explicitly.

This doesn't appear to affect Linux, but it does affect U-boot:

Before:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ... >
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................

After:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ...>
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000010 00000000 00000000 00000000  ................

(0x2604b398 is the respective pin mux register, with its BIT0 driving the
mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)

This helps ensure that GPIO-driven device reset actually fires when the
system requests it, not when whatever black box magic inside the UFSHC
decides to reset the flash chip.

Cc: stable@vger.kernel.org
Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
This has originally surfaced during the review of UFS patches for U-boot
at [1], where it was found that the UFS reset line is not requested to be
configured as GPIO but used as such. This leads in some cases to the UFS
driver appearing to control device resets, while in fact it is the
internal controller logic that drives the reset line (perhaps in
unexpected ways).

Thanks Quentin Schulz for spotting this issue.

[1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
---
Changes in v2:
- Change default pin pull to pull-down in line with the SoC power-on default
- Link to v1: https://lore.kernel.org/r/20260119-ufs-rst-v1-1-c8e96493948c@gmail.com
---
 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
index 0b0851a7e4ea..7bcfa393416f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
@@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
 				/* ufs_rstn */
 				<4 RK_PD0 1 &pcfg_pull_none>;
 		};
+
+		/omit-if-no-ref/
+		ufs_rst_gpio: ufs-rst-gpio {
+			rockchip,pins =
+				/* ufs_rstn */
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
 	};
 
 	ufs_testdata0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 3a29c627bf6d..db610f57c845 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1865,7 +1865,7 @@ ufshc: ufshc@2a2d0000 {
 			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&power RK3576_PD_USB>;
-			pinctrl-0 = <&ufs_refclk>;
+			pinctrl-0 = <&ufs_refclk &ufs_rst_gpio>;
 			pinctrl-names = "default";
 			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
 				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;

---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20260119-ufs-rst-ffbc0ec88e07

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


