Return-Path: <stable+bounces-251586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ/NHXbyDWro4wUAu9opvQ
	(envelope-from <stable+bounces-251586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55559458D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4652B3114B80
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14AF36F421;
	Wed, 20 May 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVZSVmL0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067629D26E;
	Wed, 20 May 2026 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298366; cv=none; b=Sr+Nw93ZBBGY7PkIsQ4Yg0A/k7vsP1IrDzoboxfdsPoeNhSQheqfNk2zLOunPCVKIQl7k/QmFTEnSoB+oDyjorAzF9Wi22Ma/QDu3QjZ9xyhdKGJxRb9aPEwd5gsARii5mWn7rRxPw7Sxn90RXzk0ER8oHiuYuX+QgQNUi0zs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298366; c=relaxed/simple;
	bh=ymW61Lfqjwv6huhgAJPvZi/+43w5pZLwBJjYslT2y4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deMAuuZM9H0h7tm0MqU2qb31sks1NjjTBns2453PthwzPQO4fLoLYEHLN0wzKZIxIBFDPasFTK4fDl39O1nIVsfmP8WJM7K4UrZdY4lnJHAqggzx8KFmG3bxHgG/PZm3jX8bN738/hhI70F86FHXbKU3zQ3Zmr9LnqpcSgHY7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVZSVmL0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE1E1F00893;
	Wed, 20 May 2026 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298365;
	bh=Df16oEIAGAMp5V/+FNyDhzqL/U1FoVM5E+HuvBY85kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yVZSVmL0JrcfqVK9k+Uysg9ttNxabm7jEVBgiYLnVw7EsLMeP9evTwYBFjGTIHy8G
	 wcvMa85mgG4xdzvJNTFpNGdeQTVa6cyDaFpjYmCPYPUs2/Yocs7sqeyaffuhbG3IJM
	 SOkOG/fpLlvp5TrSmMq7F9JbdTIotR2awidG2CIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josua Mayer <josua@solid-run.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 382/957] arm64: dts: imx8mp-hummingboard-pulse: fix mini-hdmi dsi port reference
Date: Wed, 20 May 2026 18:14:25 +0200
Message-ID: <20260520162142.812420017@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251586-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,0.0.0.0:email,0.0.0.1:email]
X-Rspamd-Queue-Id: DD55559458D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 1d1d14d4253e6f373c247e67f3716768910be81e ]

imx8mp.dtsi includes a default port@1 node with an empty placeholder
endpoint intended for linking to a dsi bridge or panel.

HummingBoard Pulse mini-hdmi dtsi described a new endpoint node with a
different label attached.

This duplicate label causes confusion and is suspected to also cause
errors during dsi_attach.

Remove the duplicate node and link to the one defined in soc dtsi.
Further remove the unnecessary attach-bridge property.

Fixes: 2a222aa2bee9 ("arm64: dts: add description for solidrun imx8mp hummingboard variants")
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi          | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
index 46916ddc05335..0e5f4607c7c1b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
@@ -41,7 +41,7 @@ port@0 {
 				reg = <0>;
 
 				adv7535_from_dsim: endpoint {
-					remote-endpoint = <&dsim_to_adv7535>;
+					remote-endpoint = <&mipi_dsi_out>;
 				};
 			};
 
@@ -71,11 +71,8 @@ &lcdif1 {
 &mipi_dsi {
 	samsung,esc-clock-frequency = <10000000>;
 	status = "okay";
+};
 
-	port@1 {
-		dsim_to_adv7535: endpoint {
-			remote-endpoint = <&adv7535_from_dsim>;
-			attach-bridge;
-		};
-	};
+&mipi_dsi_out {
+	remote-endpoint = <&adv7535_from_dsim>;
 };
-- 
2.53.0




