Return-Path: <stable+bounces-251621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCx8OLfyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A27594632
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12FD930ABB18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6536C9D2;
	Wed, 20 May 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsTvN6GJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B46312825;
	Wed, 20 May 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298459; cv=none; b=lw9pxa0LsH+ECIId90vwgPDwuOqZPMyscGP9k1lp2X44y5K8ZmxY2VgNdVVCKfrQEZTYNUEHNm9MHzHM9UJN8tyuh1hq1OeYvvvPL+wptIUKvVprX71JTkUo9wFgM52PU0ShicBtMxuE1F/iu6fUlJyn/MZZ59XZ0OqiBizDB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298459; c=relaxed/simple;
	bh=HUb5vJdyIUrF0aljrzfdPwSTpyFAyv5+rPacrOYc/Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5fvjvimForQSWHInbetkz0raIGNq01XhViBhMJPxCp4Xba7ucva4c+rlmUDO4GYUF/yiqNLFBrlypwMkxsso3d2EwT/f0IvDQ9Xpo6GaM6hPif52joE2ZrC21AlXuJT9BWbnZymnRfbiyZQfGMH+pzsBbv8K5HPTrn4CURv40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsTvN6GJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490061F00893;
	Wed, 20 May 2026 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298457;
	bh=kFvH5Ein2bHsOfFVtjRQTSeBk343P60/OSb8etKFJeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsTvN6GJVPJZhkk1DITeIbS5vmqoy+YhCWeuadgW5KDoUqB8xcZlAgRUfkFuXw/xJ
	 MGOevoL6+tManyXiJTcbCsE0aNlXSKAIk1VRT9DOeu2sPJwMEL9Ywty/3MToRO644V
	 45V8luFokziRpqyXaslBl0GFgdYhFe9YUjwIJbkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 418/957] arm64: dts: imx8dxl-evk: Use audio-graph-card2 for wm8960-2 and wm8960-3
Date: Wed, 20 May 2026 18:15:01 +0200
Message-ID: <20260520162143.587375509@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251621-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.2:email,1a:email]
X-Rspamd-Queue-Id: 53A27594632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit e8341b0245736619f8d6a2cc311c9e8ad8e82390 ]

The sound card wm8960-2 and wm8960-3 only support capture mode for the
reason of connection on the EVK board. But fsl-asoc-card don't support
capture_only setting, the sound card creation will fail.

fsl-sai 59060000.sai: Missing dma channel for stream: 0
fsl-sai 59060000.sai: ASoC error (-22): at snd_soc_pcm_component_new() on 59060000.sai
fsl-sai 59070000.sai: Missing dma channel for stream: 0
fsl-sai 59070000.sai: ASoC error (-22): at snd_soc_pcm_component_new() on 59070000.sai

so switch to use audio-graph-card2 which supports 'capture_only'
property for wm8960-2 and wm8960-3 cards.

Fixes: b41c45eb990a ("arm64: dts: imx8dxl-evk: add audio nodes")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 114 ++++++++++++++----
 1 file changed, 90 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 25a77cac6f0b5..b75ab1e010f0c 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -259,33 +259,37 @@ sound-wm8960-1 {
 	};
 
 	sound-wm8960-2 {
-		compatible = "fsl,imx-audio-wm8960";
-		model = "wm8960-audio-2";
-		audio-cpu = <&sai2>;
-		audio-codec = <&wm8960_2>;
-		audio-routing = "Headphone Jack", "HP_L",
-				"Headphone Jack", "HP_R",
-				"Ext Spk", "SPK_LP",
-				"Ext Spk", "SPK_LN",
-				"Ext Spk", "SPK_RP",
-				"Ext Spk", "SPK_RN",
-				"LINPUT1", "Mic Jack",
-				"Mic Jack", "MICB";
+		compatible = "audio-graph-card2";
+		label = "wm8960-audio-2";
+		links = <&sai2_port2>;
+		routing = "Headphones", "HP_L",
+			"Headphones", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+		widgets = "Headphone", "Headphones",
+			"Speaker", "Ext Spk",
+			"Microphone", "Mic Jack";
 	};
 
 	sound-wm8960-3 {
-		compatible = "fsl,imx-audio-wm8960";
-		model = "wm8960-audio-3";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8960_3>;
-		audio-routing = "Headphone Jack", "HP_L",
-				"Headphone Jack", "HP_R",
-				"Ext Spk", "SPK_LP",
-				"Ext Spk", "SPK_LN",
-				"Ext Spk", "SPK_RP",
-				"Ext Spk", "SPK_RN",
-				"LINPUT1", "Mic Jack",
-				"Mic Jack", "MICB";
+		compatible = "audio-graph-card2";
+		label = "wm8960-audio-3";
+		links = <&sai3_port2>;
+		routing = "Headphones", "HP_L",
+			"Headphones", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+		widgets = "Headphone", "Headphones",
+			"Speaker", "Ext Spk",
+			"Microphone", "Mic Jack";
 	};
 };
 
@@ -481,6 +485,16 @@ wm8960_2: audio-codec@1a {
 				DCVDD-supply = <&reg_audio_1v8>;
 				SPKVDD1-supply = <&reg_audio_5v>;
 				SPKVDD2-supply = <&reg_audio_5v>;
+
+				port {
+					capture-only;
+
+					wm8960_2_ep: endpoint {
+						bitclock-master;
+						frame-master;
+						remote-endpoint = <&sai2_endpoint2>;
+					};
+				};
 			};
 		};
 
@@ -510,6 +524,16 @@ wm8960_3: audio-codec@1a {
 				DCVDD-supply = <&reg_audio_1v8>;
 				SPKVDD1-supply = <&reg_audio_5v>;
 				SPKVDD2-supply = <&reg_audio_5v>;
+
+				port {
+					capture-only;
+
+					wm8960_3_ep: endpoint {
+						bitclock-master;
+						frame-master;
+						remote-endpoint = <&sai3_endpoint2>;
+					};
+				};
 			};
 		};
 
@@ -695,6 +719,27 @@ &sai2 {
 	pinctrl-0 = <&pinctrl_sai2>;
 	fsl,sai-asynchronous;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sai2_port1: port@1 {
+			reg = <1>;
+			endpoint { /* not used */ };
+		};
+
+		sai2_port2: port@2 {
+			reg = <2>;
+			capture-only;
+
+			sai2_endpoint2: endpoint {
+				dai-format = "i2s";
+				remote-endpoint = <&wm8960_2_ep>;
+				system-clock-direction-out;
+			};
+		};
+	};
 };
 
 &sai3 {
@@ -707,6 +752,27 @@ &sai3 {
 	pinctrl-0 = <&pinctrl_sai3>;
 	fsl,sai-asynchronous;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sai3_port1: port@1 {
+			reg = <1>;
+			endpoint { /* not used */ };
+		};
+
+		sai3_port2: port@2 {
+			reg = <2>;
+			capture-only;
+
+			sai3_endpoint2: endpoint {
+				dai-format = "i2s";
+				remote-endpoint = <&wm8960_3_ep>;
+				system-clock-direction-out;
+			};
+		};
+	};
 };
 
 &thermal_zones {
-- 
2.53.0




