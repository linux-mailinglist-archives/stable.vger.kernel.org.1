Return-Path: <stable+bounces-250519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGlWBErnDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:54:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A575929BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 047B1300C80C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F60318EC7;
	Wed, 20 May 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WxlmOTep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982C1E7660;
	Wed, 20 May 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295622; cv=none; b=BWy0nNmkJramHmzPADeWbp+3d1ZL4iQndkFowg7ItdJ7WklI1BRCAeZUMC6HnOibmVSg+levVW6cO8nM4uDCOUAtf4AwNQ65PlQm5AZkywnfvzjy/KxdHEATSj0qRXQdBMWF4+4+z3XXEfTH8RypyXq9WcGiZV6cRe9T1uJp2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295622; c=relaxed/simple;
	bh=Yxh0F7GivV7VVH1B1Q1ojGcLXWlOUq7OQLZVSgpWzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc1zEoEYbAxYrPUc023WBLkwDmjtGlcAV+/DSSgv+jCwN0E5vnY3DnHle4xZ4LfSAGvIDUs/mRuP2/pg5n4t0Tw5r3J6bS2LFQA3oXBp1b1LbBVPIXKAn4u0w6uaYc37ZnWDvjVE8IJUt8UIxGtCZe4UmfsRQib6DMZYbfsppIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WxlmOTep; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF1B1F000E9;
	Wed, 20 May 2026 16:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295621;
	bh=xK6ucfUAI2XZZBqxAOH5Ri13rSWXZQF/csHb7gGJi0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxlmOTepimiHG/IWOtF5xRgndEqobA8D0ulFtKziOZiqjlmljwhhVs4PurLezHHSz
	 tD54si3ygAYLHDAq02o6sX9bks2iAv0qeQCrTWoLpGQWrqeLdVbnCY44G34reQ3PWS
	 Dwyz8zOUnU4UCcbUb4ZHn+kgYQuKynX0/yBEoolY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0490/1146] arm64: dts: imx8mp-hummingboard-pulse/cubox-m: fix vmmc gpio polarity
Date: Wed, 20 May 2026 18:12:20 +0200
Message-ID: <20260520162159.281253463@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250519-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,solid-run.com:email]
X-Rspamd-Queue-Id: A5A575929BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 70ecea46d36b3b0ddcbe71f9cde8d0df00c11f87 ]

Fix the polarity in vmmc regulator node for the gpio from active-high to
active-low. This is a cosmetic change as regulator default to active-low
unless property enable-active-high was also specified - ignoring the
flag on gpio handle.

Fixes: a009c0c66ecb ("arm64: dts: add description for solidrun imx8mp som and cubox-m")
Fixes: 2a222aa2bee9 ("arm64: dts: add description for solidrun imx8mp hummingboard variants")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts                | 2 +-
 .../boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
index 8290f187b79fd..7bc213499f094 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
@@ -68,7 +68,7 @@ vmmc: regulator-mmc {
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <250>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
index fa7cb9759d01c..0b4e5f300eb16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
@@ -73,7 +73,7 @@ vmmc: regulator-mmc {
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <250>;
 	};
 
-- 
2.53.0




