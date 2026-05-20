Return-Path: <stable+bounces-250517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNH4GV/nDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D05929EF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71A9630316EA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1EB31A575;
	Wed, 20 May 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Py4cUysW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513C3403FA;
	Wed, 20 May 2026 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295619; cv=none; b=PLbKqoeFlz9GiJXcsW/0TWINPoOV7CCI0S1ahIDNhTBoZv38H87JuFr204m3b6TjKLc4kgMFak7AiTa+vAxN6HieRIPlU+SVCzcN/oFnAu960s4rKL39Mz5Y+PNZcZO0Zfow1mKsCs7yWKe88gdlGCjeO6G9j6qpY/+hR9AjRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295619; c=relaxed/simple;
	bh=2K2HY4jRwPyaI4BGL7AlWVN8JLyCYKNwF5y+gnKpcUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQrSd0IoCZu6p5zjk8zKKZ2zXPoB93pEaakI60ZWqIl6BYng61LI4INFHLJvhjQIACbZle+yor2O9rsM1mWHcC06GLKbkUcvnF+RAbdnmqSJFW71Y0t+QUVHoS57ijX+08gJpOtBVucLLwP78Y64O32Ce2ut1fRDL7OpLCMmM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Py4cUysW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B187C1F000E9;
	Wed, 20 May 2026 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295616;
	bh=8ysita/pXNaSvo74CYrFIq/WS5wVN4MjnR/8rT7a7oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Py4cUysW2tYIaHG5NWgC3bT+zbwbNpeClrjKN5DleiKZasMSA0dVeqJMpSo5lxi27
	 LVqK7gBshctKEIjk3C53pVUGZSvds/7k15XVk/RZ2/joyy+ob/CqiX4OSF6nbLG2fg
	 gSUgavmleqid23FGnRg8ufoGCCH/YI9W7gkPE8AQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0488/1146] arm64: dts: imx8mp-kontron: Fix touch reset configuration on DL devices
Date: Wed, 20 May 2026 18:12:18 +0200
Message-ID: <20260520162159.238224249@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250517-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D42D05929EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 058c53476dde9937877e93d964a283bbb5e1e4c7 ]

The reset signal needs a pullup, but there is no hardware pullup.
As a workaround, enable the internal pullup to fix the touchscreen.

As this deviates from the default generic GPIO settings in the OSM
devicetree, add a new node for the touch pinctrl and redefine the
generic gpio1 pinctrl.

Fixes: 946ab10e3f40f ("arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier board")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
index a3cba41d2b531..7131e9a499ae1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
@@ -77,6 +77,8 @@
 	touchscreen@5d {
 		compatible = "goodix,gt928";
 		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <6 8>;
 		irq-gpios = <&gpio1 6 0>;
@@ -98,6 +100,16 @@
 	status = "okay";
 };
 
+/* redefine to remove touch controller GPIOs */
+&pinctrl_gpio1 {
+	fsl,pins = <
+		MX8MP_IOMUXC_GPIO1_IO00__GPIO1_IO00		0x19 /* GPIO_A_0 */
+		MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x19 /* GPIO_A_1 */
+		MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x19 /* GPIO_A_2 */
+		MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x19 /* GPIO_A_5 */
+	>;
+};
+
 &pwm1 {
 	status = "okay";
 };
@@ -108,4 +120,11 @@
 			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x19
 		>;
 	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x19
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x150
+		>;
+	};
 };
-- 
2.53.0




