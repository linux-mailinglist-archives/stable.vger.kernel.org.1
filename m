Return-Path: <stable+bounces-252479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGHRBYoCDmra5QUAu9opvQ
	(envelope-from <stable+bounces-252479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D595974DA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1758F35D0FE4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4A53C140F;
	Wed, 20 May 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tk++BAFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF603DC4DA;
	Wed, 20 May 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300781; cv=none; b=bDpUpl69B7ieiFP9Mdw0iyf1iOSd0TJpCWZeRH3WW1L7C2HfgXFSF8TjtJigqcLeqj8vAyBzwv2Zf5+dpvjHPtSHQb4z1oHwrpbHwdMrEBmsHnhbDpgz4hsgRuyL/4EtyIlVI/UJNqn9PhsVXTjIv6pn3Ej28gOm2l2diYVp/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300781; c=relaxed/simple;
	bh=33ddhXSqs/FW2rbSy5xGH0IEOqhwXoJY8jjNlDmEt2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0TKJc+jJsd9UiatsQYF6x054c8WjG0QpbkIW2MAu2CI+/nw0BimKCNqDARdJVEA9Miu0zh6f5K44RjDXsxmzZoTVTiGmrf40A8UArxrDDFRA6n+DgEv27KcYDvYTNAdIgmnWHko2BB62gATNo0XVAWkkufce8at8IzsTRSn26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tk++BAFy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1138F1F000E9;
	Wed, 20 May 2026 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300780;
	bh=oU/iEFag4dMSsdZlIAbUEYbhYv1OkZ4Q6fJshkoBFeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tk++BAFyLlGi9oH8QxdrRn82Lv3aEaZ9/0eM+DKZtFuUqXt3Yrg/VsSXJJBW9tw7o
	 GYe6wZJSqXIHgt2fbfUVI59fhJCJduim2WWpDdl6BLa+BuWRvOFsn5/eVnNBw1H2Jj
	 AV+pmYOCa/UmDzSVNJGONjpmt+I3dSb7N91Rl65I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josua Mayer <josua@solid-run.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 298/666] arm64: dts: lx2160a: remove duplicate pinmux nodes
Date: Wed, 20 May 2026 18:18:29 +0200
Message-ID: <20260520162117.675049601@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252479-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.31.149.240:email];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,solid-run.com:email]
X-Rspamd-Queue-Id: 68D595974DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 325ca511ca3dda936207ce737e0afe837d45a674 ]

LX2160A pinmux is done in groups by various length bitfields within
configuration registers.

The pinmux nodes i2c7-scl-pins and i2c7-scl-gpio-pins are duplicates of
i2c6-scl-gpio and i2c6-scl-gpio-pins, writing to the same register and
bits.

These two i2c buses i2c6/i2c7 (IIC7/IIC8) are configured together in
register RCWSR13 bits 3-0.

Drop the duplicate node name and change references to the i2c6 node.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e2c32f5b6a521..599d7d4a4c573 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -862,8 +862,8 @@ i2c7: i2c@2070000 {
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
 			pinctrl-names = "default", "gpio";
-			pinctrl-0 = <&i2c7_scl>;
-			pinctrl-1 = <&i2c7_scl_gpio>;
+			pinctrl-0 = <&i2c6_scl>;
+			pinctrl-1 = <&i2c6_scl_gpio>;
 			scl-gpios = <&gpio1 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
@@ -1781,14 +1781,6 @@ i2c6_scl_gpio: i2c6-scl-gpio-pins {
 				pinctrl-single,bits = <0x4 0x1 0x7>;
 			};
 
-			i2c7_scl: i2c7-scl-pins {
-				pinctrl-single,bits = <0x4 0x2 0x7>;
-			};
-
-			i2c7_scl_gpio: i2c7-scl-gpio-pins {
-				pinctrl-single,bits = <0x4 0x1 0x7>;
-			};
-
 			i2c0_scl: i2c0-scl-pins {
 				pinctrl-single,bits = <0x8 0x0 (0x1 << 10)>;
 			};
-- 
2.53.0




