Return-Path: <stable+bounces-251804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BFdIx4eDmoa6QUAu9opvQ
	(envelope-from <stable+bounces-251804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:48:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1059A220
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B653C3766D26
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0223E123F;
	Wed, 20 May 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jvl/r2H1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08041363C4C;
	Wed, 20 May 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298934; cv=none; b=R5LqxCKd5g+VR64kUDpz5bQzm6SA+tRyw4tJKebQ9hd/QC/+TkTZ2cuXHznATkAc0oJXVc/3DhPEVAbIfl+pasfb4T1nNIh2QSC3Hv1EKpjQhCjdeY1bmEvoXR6tX2NDW+UVRH/2Z5ssBVcxpG1K/7G/Z/d5Ae44wCZRb0+0fzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298934; c=relaxed/simple;
	bh=4iLhsXE9gfnzOeDxCRCbDeL4wa/EMr6yQ4Z6Lzsl/7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5NIHoG/iY/kb55er561SfgbsWK1iAwRuUdOitIqOjmbtCzCUTvtCplR6WTQhzf97BWLvZj/x6dV7QoNPkqQotsno6ZmVWc4Vhz+9nw9cTxdcJxZjCggnfR1DrrRAK+lz5f6hRLCMDaGlrfX4w2g2Pkf5ALX8CXICROm/nCjLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jvl/r2H1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9421F000E9;
	Wed, 20 May 2026 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298932;
	bh=nB/Ec3iL7auuexAiSONsBeaOSv6T9FW14wOi9txcDco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jvl/r2H1mdPpKHpSvclMo/VDbl09MOeFmeaNb2k4qNB3GxrgU8f6sHEg6nYC6vWXb
	 boj/py0uoO5RXkKNjgBlsuCtUO2p422K/S1GusEFnFa3KHXKn9DSnJBTB5XCRUWXbz
	 ZRwc7y/RJfpFjp2RPech6yZB7Y2ZNxplUKaO5MYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 599/957] arm64: dts: imx8mp-navqp: Correct PAD settings for PMIC_nINT
Date: Wed, 20 May 2026 18:18:02 +0200
Message-ID: <20260520162147.523610514@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251804-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 11E1059A220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 741d6ac1a2a2e0f3e2cae5eef3516cdd75119e83 ]

With commit 5d0efaf47ee90 ("regulator: pca9450: Correct interrupt type"),
there will be interrupt storm for i.MX8MP NAVQP. Per schematic, there
is no on board PULL-UP resistors for GPIO1_IO03, so need to set PAD
PUE and PU together to make pull up work properly.

Fixes: 682729a9d506d ("arm64: dts: freescale: Add device tree for Emcraft Systems NavQ+ Kit")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-navqp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-navqp.dts b/arch/arm64/boot/dts/freescale/imx8mp-navqp.dts
index 4a4f7c1adc23f..9dedb9f11145e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-navqp.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-navqp.dts
@@ -356,7 +356,7 @@ MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA					0x400001c3
 
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03				0x41
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03				0x1c0
 		>;
 	};
 
-- 
2.53.0




