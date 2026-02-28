Return-Path: <stable+bounces-220685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PpHLUU/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADB1C6C96
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8503112F99
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E943F6AEF;
	Sat, 28 Feb 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLzKS5xp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB73F73BB;
	Sat, 28 Feb 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300566; cv=none; b=hQzbl/JPzUJ6IMFTEXn2aRHLVfSe6UswvX4xN++C3MPQdlA+s7wTeehX4RnXUvVzcBit8BwkwRhvEf5DapkOJm/rXkQYNP4r/mWL/s7xodTl1Vo+13GH1CIW4TzAVxa41tp/kOOr+ArEJHDBD6xkZ2EvnlEW1atZI8P0THRw6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300566; c=relaxed/simple;
	bh=z/W11taz5qyx+nRC96o5JLotFW31RFx5HMgKlHr4b4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTp57xjPZ6wTU/Pis1oqLKjam/Gjx4quXOOMMUrUZ7Z9+mqc+9ywVnBcJ9BvXFDjNt5WphaIDHRLcsV7ZlfmGCCyYPS0Uq1ePNqiZqle7cYxEqJuIWgFnzpkSYjYMmaYVnR+r2MVKFDEq1YcWQiAbfmM6Jbxwm5AapDrQ0lpoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLzKS5xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59264C116D0;
	Sat, 28 Feb 2026 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300566;
	bh=z/W11taz5qyx+nRC96o5JLotFW31RFx5HMgKlHr4b4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLzKS5xpzDdbi7OWRTaq7yTrubaAz2UldkYeMyGZi06Ymg6cjT/qGsFjsssIy3rPr
	 s4MquKkFwI9wBaAxNMYgoBHbWFVbcdLNTX98Y1TE1Xeoy9wE4j1dAZxF/ZYRRuHnM9
	 AKV3NRzzUKtZHLv/4oH6fIN5rBxmpn6rMB33KXH2iufoTHOOkEpNqgJP8rGdSPm8f0
	 rOXO0I+ab5oZTmRudXjOpb65zDgGKj5265mYdVSTmo9/7F4QZ3ruJ+rIM+3oi4hx6g
	 0p8diI0d/J1pIGrk+a53RoEGzPuXCJ+dxAIgDpQ4HDG78OtB3ALvBV/PjRQM8Nl9eh
	 VvUZyYYjwYirQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vitor Soares <vitor.soares@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 606/844] arm64: dts: ti: k3-am69-aquila: Change main_spi0/2 CS to GPIO mode
Date: Sat, 28 Feb 2026 12:28:39 -0500
Message-ID: <20260228173244.1509663-607-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220685-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 5BADB1C6C96
X-Rspamd-Action: no action

From: Vitor Soares <vitor.soares@toradex.com>

[ Upstream commit 78a123f45a7e9ac2a59f0eff8a37d31773e7a021 ]

Hardware chip select does not work correctly on main_spi0 and
main_spi2 controllers. Testing shows main_spi2 loses CS state
during runtime PM suspend, while main_spi0 cannot drive CS HIGH
when bus is idle.

Use GPIO-based chip select for both controllers.

Fixes: 39ac6623b1d8 ("arm64: dts: ti: Add Aquila AM69 Support")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20260112175350.79270-2-ivitro@gmail.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
index 0866eb8a6f348..5119baf62a4c2 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
@@ -479,7 +479,7 @@ J784S4_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (AM36) SPI0_D1  */ /* AQUILA D17 */
 	/* Aquila SPI_2 CS */
 	pinctrl_main_spi0_cs0: main-spi0-cs0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (AM37) SPI0_CS0 */ /* AQUILA D16 */
+			J784S4_IOPAD(0x0cc, PIN_OUTPUT, 7) /* (AM37) SPI0_CS0.GPIO0_51 */ /* AQUILA D16 */
 		>;
 	};
 
@@ -495,7 +495,7 @@ J784S4_IOPAD(0x0ac, PIN_OUTPUT, 10) /* (AE34) MCASP0_AXR15.SPI2_D1  */ /* AQUILA
 	/* Aquila SPI_1 CS */
 	pinctrl_main_spi2_cs0: main-spi2-cs0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_IOPAD(0x09c, PIN_OUTPUT, 10) /* (AF35) MCASP0_AXR11.SPI2_CS1 */ /* AQUILA D9 */
+			J784S4_IOPAD(0x09c, PIN_OUTPUT, 7) /* (AF35) MCASP0_AXR11.GPIO0_39 */ /* AQUILA D9 */
 		>;
 	};
 
@@ -1204,6 +1204,7 @@ &main_sdhci1 {
 &main_spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_main_spi0>, <&pinctrl_main_spi0_cs0>;
+	cs-gpios = <&main_gpio0 51 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
@@ -1211,6 +1212,7 @@ &main_spi0 {
 &main_spi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
+	cs-gpios = <&main_gpio0 39 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
-- 
2.51.0


