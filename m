Return-Path: <stable+bounces-251567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIRUBWPyDWrj4wUAu9opvQ
	(envelope-from <stable+bounces-251567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE68594533
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D98931023FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C453A874C;
	Wed, 20 May 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtnxxuGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449336405A;
	Wed, 20 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298316; cv=none; b=EbnGc9YKVlc64perANOX4PDrhzBoBpKK20zqQ2yO354GjeAeUZrHmcFDF238daKsmYRLrZCebO+WoxinukSem7zuoc+pAU2sDyp5eCL0cGKfIn+Wg5iyqdkvnn+XnFTXUXR4AXY99TVXAxlfMYk/0B5Q813NMZOJ7iY6kxSrQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298316; c=relaxed/simple;
	bh=nrkXquzQwblRczCV1OeLTfqQcdeX9+nlKT3EvwkttMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGGC0+Gj7Qc/TwlWKYf/gwdcD40/TBvTIjxlZIvJ1YApCLI5dlRtTMQ/zOh/8ExHUjQMpXs1ntG7vzM+A5TztoYobUreun7/GrfYGP5FILg7AWr7/ZTJZXGqb+boCuiL03BConSzOA87uq6DWL3b9pFZqn8zOMDQoDISdawrloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtnxxuGH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2C91F000E9;
	Wed, 20 May 2026 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298315;
	bh=1UxlbP+OsTEaotfldOf3XDSLk1cztPiPIhGUpN77p1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtnxxuGH8n8DMlOm+SHftbyWMFfNjRlY631ObPF/W88oWcQc4B5SYUVCI3ppJuwY5
	 w/3JYSAKERPDER1tlCzS1Vj+l8+5rzNQP1dbls26GGGisKt60IUaP/4UOgQfqA34V3
	 h1BPxLkvKESn+YmXnaxvUUnxdJN+eOPadWLc5lUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 365/957] arm64: dts: imx8-apalis: Fix LEDs name collision
Date: Wed, 20 May 2026 18:14:08 +0200
Message-ID: <20260520162142.444875624@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251567-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: ACE68594533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 92ab53b9bb2a72581c32073755077af916eb9aee ]

Ixora boards have multiple instances of status leds, to avoid a name
collision add the function-enumerator property.

This fixes the following Linux kernel warnings:

  leds-gpio leds: Led green:status renamed to green:status_1 due to name collision
  leds-gpio leds: Led red:status renamed to red:status_1 due to name collision

Fixes: c083131c9021 ("arm64: dts: freescale: add apalis imx8 aka quadmax carrier board support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index 3d8731504ce15..1e8b6e61e33d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -21,6 +21,7 @@ led-1 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
 			gpios = <&lsio_gpio5 27 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -29,6 +30,7 @@ led-2 {
 			color = <LED_COLOR_ID_RED>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
 			gpios = <&lsio_gpio5 29 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -37,6 +39,7 @@ led-3 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <2>;
 			gpios = <&lsio_gpio5 20 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -45,6 +48,7 @@ led-4 {
 			color = <LED_COLOR_ID_RED>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <2>;
 			gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index 106e802a68ba5..70dcb66f8fda4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -21,6 +21,7 @@ led-1 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
 			gpios = <&lsio_gpio5 27 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -29,6 +30,7 @@ led-2 {
 			color = <LED_COLOR_ID_RED>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
 			gpios = <&lsio_gpio5 29 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -37,6 +39,7 @@ led-3 {
 			color = <LED_COLOR_ID_GREEN>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <2>;
 			gpios = <&lsio_gpio5 20 GPIO_ACTIVE_HIGH>;
 		};
 
@@ -45,6 +48,7 @@ led-4 {
 			color = <LED_COLOR_ID_RED>;
 			default-state = "off";
 			function = LED_FUNCTION_STATUS;
+			function-enumerator = <2>;
 			gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.53.0




