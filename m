Return-Path: <stable+bounces-250569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCMjOOvzDWoF5AUAu9opvQ
	(envelope-from <stable+bounces-250569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:48:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C35949CA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1139031D0AF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C723BE64B;
	Wed, 20 May 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LrlptJql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89193A3E90;
	Wed, 20 May 2026 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295756; cv=none; b=osem9D0AWABUgftyWzl/0QzxR8XPdVJnoZtpf7QG6qdnj4pNLRT22DXIoPOve7W0Fiz9tNnyYq2ikj9/1QSPybv1lj1Zla3I3rLVpQTDN7HTw2l1L1RB5Y2nkcPXcU3fELyGvinRx0k906q66YUzeCGMeEEikhJF0JaKseWeSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295756; c=relaxed/simple;
	bh=koxleYiYkV+jgvAuoqbabCaCiQb1wnJirJKH1i58r3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAN6vd46TyMyUjywGbYxPpiYo0jAhRHRUZhxKZcDfAX2LoOnjFEHnotnAXGLMBmlEr3QUdciOo2SQRL9Fqc7n9sziNvf0vdOS0iNMCHhf/WcEMpEHgIfIl5Ln6khJfJqHt8TBcsgHpStzUQ7pw2Fcc5GpccakS6Vl+RYtJNfV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LrlptJql; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D763F1F00893;
	Wed, 20 May 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295753;
	bh=rjWZuHSCYSEhf+jMEb0zRUAGgwIggotaEpy6WUgFlVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrlptJqlMm5Duo6T96lkown1K/NOnFmoOVLNA4KgUQimgo7wDij0RZauKj5aOz41s
	 Lv1zO38ew79vWdKbed9EGXIov1fZxJrYBEpdrC4OwEsdd+2o9J2GpLQVK+/YP/Hq0/
	 +EzNbjhmNtW/liEG6P1OOJM+H0qAeVZj939Btn9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0539/1146] arm64: dts: imx8dxl-evk: Use audio-graph-card2 for wm8960-2 and wm8960-3
Date: Wed, 20 May 2026 18:13:09 +0200
Message-ID: <20260520162200.378521798@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250569-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.2:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,1a:email,0.0.0.1:email]
X-Rspamd-Queue-Id: 365C35949CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 5c68d33e19f22..bc62ae5ca812d 100644
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
 
@@ -700,6 +724,27 @@ &sai2 {
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
@@ -712,6 +757,27 @@ &sai3 {
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




