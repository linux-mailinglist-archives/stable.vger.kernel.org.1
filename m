Return-Path: <stable+bounces-217645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHJDG1D2mWltXgMAu9opvQ
	(envelope-from <stable+bounces-217645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:15:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA916D76B
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC8F4305205A
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50B30CDAF;
	Sat, 21 Feb 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="iCut6gKZ"
X-Original-To: stable@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C723817E;
	Sat, 21 Feb 2026 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697735; cv=none; b=SvDJZ0j98Hdg+CXKihI9yUzgLIVUHQXL+si9eK0WJgRtQB9RUX0bYXBMs8CiJ5Y3TleNMRFMWhWLJmMaax6vQA26YSXZVAccef4x4KxO+ZXMqJZ1CJb4LOO/VzvKuqiElMTvczryq+5ohtcD2vU3KAwNrPWsXjkvy55EIvYLPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697735; c=relaxed/simple;
	bh=C79fk9buYX7yCvQACmE0txqbxH9EAZk4H/4Pud3Yxv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GynZ6o3W1sIHFoP1Sbpf9VjFuRKVHQzAyLXc+P+JRycGxDpq4s1JNVaVSXSloNMdbMflMSv4Vy0I0nFpQOqyApus1XapM2zjV8tcBLx6cszLljGVCPEwP6QQ4RJ8hPL5PlJnoFIEnMPo9Ufl4U5Zj1VofoEjkYiSktmgOFR68Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=iCut6gKZ; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1771697731; bh=C79fk9buYX7yCvQACmE0txqbxH9EAZk4H/4Pud3Yxv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iCut6gKZCAxoT0OJ8i71jEgKfnnjG6uPjfyTVvAHwNiLcJakc4OkHt2fNaVj8R+yz
	 Vl+iIWoTfnfXNNm6p8n3MMCQ88kaXkYocAni+Zu9dT8KQPelszUVP0eHyLCh//Pr7M
	 na2ObQ80iHTC2V/5ptPBec6bG80k6n+dMsNPTJ5BcZdUSKqKYCprpgzmnETZZ0nz42
	 Y//7Q6AWP6z/vWwDOWogaHsahHm8mlHL8JKN1uNL0EPsbQ6KZ20EzACb4ruX5kJ1Y8
	 Gxh7vJp0hJg1j9DDPLG+vOakRfauXrLFngGiaZL5wWCS61b9mJWeCLMCZ+YeiPdQ31
	 8TndeZS0JV1Mw==
Received: from pliszka.localdomain (79.184.40.11.ipv4.supernova.orange.pl [79.184.40.11])
	by ms.puri.sm (Postfix) with ESMTPSA id 485931F5C0;
	Sat, 21 Feb 2026 10:15:30 -0800 (PST)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sat, 21 Feb 2026 19:15:18 +0100
Subject: [PATCH v2 1/2] Revert "arm64: dts: imx8mq-librem5: Set the DVS
 voltages lower"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-l5-voltages-v2-1-dd8885bb9331@puri.sm>
References: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
In-Reply-To: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Martin Kepplinger <martin.kepplinger@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, "Angus Ainslie (Purism)" <angus@akkea.ca>, 
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: kernel@puri.sm, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=C79fk9buYX7yCvQACmE0txqbxH9EAZk4H/4Pud3Yxv0=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBpmfY/QvYAlXeTzXnItGtg74YubqU9KDhiDujlr
 rybx2UymF2JAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCaZn2PwAKCRDo8jXPO9vD
 /zeqD/9emei1CMfBkgjXYjY2Q0/v76nJPILYxZsNEn5gcA+55aGRX2dMzFuYzpJtN0WdyS9KRbB
 Ky9gosOAlSZ+DkT/iDMlTFEIW8nabbVk3jqWPodwwK9IQEn9NvJ3EJm2lBv0gYyArFjj8ldRxwS
 Cfzr8mXCRYmC22BjHe/reSO08WHG4HjoDTnIUVcuIgF9V3+/a/kNtjreDZTSjvfCSndP7TOUkLi
 5YF30sz1QmiSQCBA9hkEPAdkjmlJetuXUoKbuvBQ6U6psE4Xkl9DgvbJkqMtXT6wwO2ZwbzL7Wb
 5s1RILLkF/jeKZYwUTtYJdR061qKqptdki3FVRxL8mu/h6Ui2ADytRnm5wDRLVun3ladMihlziQ
 WoPEfP8Jvv6LZd2am6HfChQJJNfyPu1SeW9EyFeB02Ao/d7VI7MY+El6RTmH5WbozhaVwrhB6Cc
 pceDzqPx/Fq0+rWUYUDosVQiTOQ4FfNJrQ/hoCau47zBIb+3kJQy5ndEbO73ZHOH9rIuh9H0Aee
 dqc7MwplmCtitzFiBGxxESFsTaNYS61x1f4E9DkMJVqI2n45FyzGqQ3M4akKsJVYaJ/9HJX61fq
 LwRtjD0DqL+mFOPnNEuR+mFmSC8DO5OnfPUgrRRA52eWX7zZKX8AYRscsvUmfc8sGsnRgqc0WAe
 Nsp047insz8ojmg==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217645-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,puri.sm,akkea.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.krzyszkowiak@puri.sm,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[puri.sm:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,puri.sm:mid,puri.sm:dkim,puri.sm:email]
X-Rspamd-Queue-Id: 86BA916D76B
X-Rspamd-Action: no action

This reverts commit c24a9b698fb02cd0723fa8375abab07f94b97b10.

It's been found that there's a significant per-unit variance in accepted
supply voltages and the current set still makes some units unstable.

Revert back to nominal values.

Cc: <stable@vger.kernel.org>
Fixes: c24a9b698fb0 ("arm64: dts: imx8mq-librem5: Set the DVS voltages lower")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 .../arm64/boot/dts/freescale/imx8mq-librem5-r3.dts |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi  | 22 ++++++----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index 077c5cd2586f..4533a84fb0b9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -7,7 +7,7 @@
 
 &a53_opp_table {
 	opp-1000000000 {
-		opp-microvolt = <950000>;
+		opp-microvolt = <1000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index eee390c27210..7818d84f25a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -880,8 +880,8 @@ buck1_reg: BUCK1 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <880000>;
-				rohm,dvs-idle-voltage = <820000>;
+				rohm,dvs-run-voltage = <900000>;
+				rohm,dvs-idle-voltage = <850000>;
 				rohm,dvs-suspend-voltage = <810000>;
 				regulator-always-on;
 			};
@@ -892,8 +892,8 @@ buck2_reg: BUCK2 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <950000>;
-				rohm,dvs-idle-voltage = <850000>;
+				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-idle-voltage = <900000>;
 				regulator-always-on;
 			};
 
@@ -902,14 +902,14 @@ buck3_reg: BUCK3 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
-				rohm,dvs-run-voltage = <850000>;
+				rohm,dvs-run-voltage = <900000>;
 			};
 
 			buck4_reg: BUCK4 {
 				regulator-name = "buck4";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
-				rohm,dvs-run-voltage = <930000>;
+				rohm,dvs-run-voltage = <1000000>;
 			};
 
 			buck5_reg: BUCK5 {
@@ -1448,13 +1448,3 @@ &wdog1 {
 	fsl,ext-reset-output;
 	status = "okay";
 };
-
-&a53_opp_table {
-	opp-1000000000 {
-		opp-microvolt = <850000>;
-	};
-
-	opp-1500000000 {
-		opp-microvolt = <950000>;
-	};
-};

-- 
2.53.0


