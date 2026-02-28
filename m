Return-Path: <stable+bounces-220747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANayDbdCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:32:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D54381C7190
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C1AD3142C3E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4335F5E0;
	Sat, 28 Feb 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoptyfAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08047401D2B;
	Sat, 28 Feb 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300628; cv=none; b=n6ur+Wg3evtyDEKI/ZWtkcdUMgOiOUAatA54qInxqo30i8of1K0wqvnwHK3zRQukgLBcRWA2Iu2rQE+IY4C6zmVz/StcYI72kJjYiW1lvAcwfLv3T8qvUpfY6RxqHUHG2sI/6DPTaI6tH4uNwG93euObXCe3m5u2QibiYXFbApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300628; c=relaxed/simple;
	bh=ztlT3saRJbDT5bqLP6NFt7aq6pAsT7FeK9qce3Gfwuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9w9lzpnsWXI7Yihl8sKsAzrBrCQNdz29k/w0tsOj+hdoaci1Tcw/rCkgiqkiJSQaHuvtCVP7KDW61lHORL3Ky1Du11gQOBLz7s8KE4k3zoIxBLCqUIoFBacIQYj/urrIa4ArNExIHVRSc8N0I3bQG7TAUWOn91fiKrLY00a6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoptyfAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC8AC116D0;
	Sat, 28 Feb 2026 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300627;
	bh=ztlT3saRJbDT5bqLP6NFt7aq6pAsT7FeK9qce3Gfwuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoptyfAWfUuylq6kNLWJte0xaLdhVi1V+6q/ZPsXoEL58N2U48nNy5luYGFhXV0YP
	 Fy4+Dbm8uSoAl4bP0wcXXDI3qg21sVlSAee8asYXlqsHAsJvTjvyslkjVRNB4mgG8h
	 K7nKpk14eKXw1wkUf1kk3BXK6HvW46IB3iFVSfI5nJz1DO9wiHy6sZLI2uzMMHBvdq
	 kmn1eLkrMr+zVVs9fjd+2xmWBB7ELGcOzh2EeGjThkP8IiBfWuar7JjSTH+GIneXL2
	 5OKl/eSWIVBODVheo0LePXCDJ5FqObhDmXejpIg+Ik7eFY7XPqcA3Hu/M4HaEX/2za
	 6tceS9HlkWZwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Charkov <alchark@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 668/844] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
Date: Sat, 28 Feb 2026 12:29:41 -0500
Message-ID: <20260228173244.1509663-669-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cherry.de,sntech.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220747-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sntech.de:email,2a2d0000:email,cherry.de:email]
X-Rspamd-Queue-Id: D54381C7190
X-Rspamd-Action: no action

From: Alexey Charkov <alchark@gmail.com>

[ Upstream commit 79a3286e61829fc43abdd6e3beb31b24930c7af6 ]

Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
UFS device, which can operate either in a hardware controlled mode or as a
GPIO pin.

Power-on default is GPIO mode, but the boot ROM reconfigures it to a
hardware controlled mode if it uses UFS to load the next boot stage.

Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
device reset, request the required pin config explicitly.

The pin is requested with pull-down enabled, which is in line with the
SoC power-on default and helps ensure that the attached UFS chip stays
in reset until the driver takes over the control of the respective
GPIO line.

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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20260121-ufs-rst-v3-1-35839bcb4ca7@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
index 0b0851a7e4ea9..98c9f8013158c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
@@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
 				/* ufs_rstn */
 				<4 RK_PD0 1 &pcfg_pull_none>;
 		};
+
+		/omit-if-no-ref/
+		ufs_rstgpio: ufs-rstgpio {
+			rockchip,pins =
+				/* ufs_rstn */
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
 	};
 
 	ufs_testdata0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index c72343e7a0456..70e67d4dccb8a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1826,7 +1826,7 @@ ufshc: ufshc@2a2d0000 {
 			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&power RK3576_PD_USB>;
-			pinctrl-0 = <&ufs_refclk>;
+			pinctrl-0 = <&ufs_refclk &ufs_rstgpio>;
 			pinctrl-names = "default";
 			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
 				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;
-- 
2.51.0


