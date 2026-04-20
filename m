Return-Path: <stable+bounces-238795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBh/H7Yx5ml6tAEAu9opvQ
	(envelope-from <stable+bounces-238795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD542C880
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747CB3119927
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62943A7849;
	Mon, 20 Apr 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/pe2Vsm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F03A7835;
	Mon, 20 Apr 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690969; cv=none; b=oLP7lIgsMdsggCEhTem4Y6g7y/nQ7POVxbH10hcn9SkUVHOyT6frdTZ1Ln3qVOy4772R3OacUWZKkgFcOu62zRCLjMEVOQVb68YnJ/SMB/nqkv6OLfr+8GK33yfN5Gj+2miz1hBcmn/wKBdX2jKsmPGkpDJVSLcgPk+pRO9Zfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690969; c=relaxed/simple;
	bh=Ay9q0/FUsQz7RmljwSk+IzFgJ1vCF0iwCGHEp+gCZmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlrKQALMbJr/UVR7bZ/zqpKXe96wJgwK2Jb5LzNdN4qYPUrypKGIaxp1kAWgGQwmY1StHgmRPyWIT/1MYa2q2qOa1b2DSrS+mv4PPRfO7+O0ga4cTVvfm8u6EW2EwH8Leau8DEmbqj0jqgfuiG9+NUicH13pFHld587bqlbSZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/pe2Vsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C7C2BCB8;
	Mon, 20 Apr 2026 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690969;
	bh=Ay9q0/FUsQz7RmljwSk+IzFgJ1vCF0iwCGHEp+gCZmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/pe2Vsm9qFA926oOcTkVg4ZH7FBXX8LM4A4Mv/denKUs8Zy2D7ZvrA8f21935fJa
	 Bsr80c1LQhaOi2jZNncsiBzg2LvwD23JYIMWWL4kz4LukjRM/RNqOrw5wnZfbR29xt
	 a8IusQ2s71EeMoJ2B6iNVw4W53o5Hj9NF3IFS7QEvMOnoDTiV0rytz0pEMHkAQmQeJ
	 aP3lz7q0Yuqn9qZkAhGE/lJ2EnTDtstKaQ0AnXSG2GbkDloiBoYk8qhIt0lVD/UR9+
	 JR6SWwa2Ry+zP1B6KOBNtRQL6/uUGf0NT2eL9vtITf2HhNMJu/pviJ6U2VMSPlP4Dv
	 4t9ISmqhHVmLA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] arm64: dts: imx93-tqma9352: improve eMMC pad configuration
Date: Mon, 20 Apr 2026 09:08:03 -0400
Message-ID: <20260420131539.986432-17-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238795-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email]
X-Rspamd-Queue-Id: ADBD542C880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

[ Upstream commit b6c94c71f349479b76fcc0ef0dc7147f3f326dff ]

Use DSE x4 an PullUp for CMD an DAT, DSE x4 and PullDown for CLK to improve
stability and detection at low temperatures under -25°C.

Fixes: 0b5fdfaa8e45 ("arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data pad of USDHC")
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 82914ca148d3a..c095d7f115c21 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -270,21 +270,21 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x106
 	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			/* PD | FSEL 3 | DSE X5 */
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x5be
+			/* PD | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x59e
 			/* HYS | FSEL 0 | no drive */
 			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1000
-			/* HYS | FSEL 3 | X5 */
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400011be
-			/* HYS | FSEL 3 | X4 */
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000119e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000119e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000119e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000119e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000119e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000119e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000119e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000119e
+			/* HYS | PU | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000139e
+			/* HYS | PU | FSEL 3 | DSE X4 */
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000139e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000139e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000139e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000139e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000139e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000139e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000139e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000139e
 		>;
 	};
 
-- 
2.53.0


