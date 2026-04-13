Return-Path: <stable+bounces-236108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFMeFTr83Gk3YwkAu9opvQ
	(envelope-from <stable+bounces-236108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:22:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D53ED451
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690593013BBB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018683DC4AD;
	Mon, 13 Apr 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0KZvq19"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE13DBD62
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090060; cv=none; b=Jo2Ffp75eD7mlBAhUF11ZKhZdFrr3naJYZvauhA6et6LuzvQpjDyoUPazouBwVeeaUVOS3NascQAmGEpne7WKdkgfw4bwlnwABMxbBZQMi/+kfrrEx4HVzzDHMeaAmhls48qOAQjXjXGE+xdYhvbLDzYCLlqe+BdYreIayZBiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090060; c=relaxed/simple;
	bh=O5fu+IZe+fAiQFuKYeq44QfA7N8sgg8Vmho9KVGRYyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9qeBq6kuFRJrvEb8SeD5b2XOX7kt+pDwHjwvPBxa8IoUAW2SeCyABZ0K8h7lf3hrbCFaxTvoNloDOz3ReJDtBXpnqXxgkt0qw4+RLtl48Oo1TYqsWdEu5ZAnByfWzPdscaxPeQpJlx5CwuqcA3eWKn3xfToTsXxVJLltkEG4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0KZvq19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41471C2BCAF;
	Mon, 13 Apr 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776090059;
	bh=O5fu+IZe+fAiQFuKYeq44QfA7N8sgg8Vmho9KVGRYyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0KZvq19xcTHXqMjzeEj3smqjvnucmol8hDNI08xZnk3SEmJNA34abl8Swlx8aOUm
	 rdeJSeF9LHWdlgXJNnd0SUo4v949oiMNxG0rjrDQK7sLt0NA7nL0G6O/PL/WdjO1rX
	 K/PlU2JYMgYGyGIpr9ePgmVzqSk3WFXTHr0gCpdWjYoQFJ9Ciby+Y1O5Jq3flUqNcm
	 rCyHg8dz6Ovjn96DUYIRRP73G3ZMCG44UTH+Cdj/Gx7GSSYGJ4HbrTgpZjyxu7iy5F
	 SEeju1bNw4KTQW51ketNtqMEK59792G91eDENpmzXOIjOci4mHA+Ix3q9h3OW1rIAk
	 TWLA0vK7927OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] arm64: dts: imx8mq-librem5: Set the DVS voltages lower
Date: Mon, 13 Apr 2026 10:20:54 -0400
Message-ID: <20260413142057.2909222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041309-growing-ground-4131@gregkh>
References: <2026041309-growing-ground-4131@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236108-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,puri.sm:email]
X-Rspamd-Queue-Id: D09D53ED451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit c24a9b698fb02cd0723fa8375abab07f94b97b10 ]

They're still in the operating range according to i.MX 8M Quad
datasheet. There's some headroom added over minimal values to
account for voltage drop.

Operational ranges (min - typ - max [selected]):
 - VDD_SOC (BUCK1): 0.81 - 0.9 - 0.99 [0.88]
 - VDD_ARM (BUCK2): 0.81 - 0.9 - 1.05 [0.84] (1000MHz)
                    0.90 - 1.0 - 1.05 [0.93] (1500MHz)
 - VDD_GPU (BUCK3): 0.81 - 0.9 - 1.05 [0.85] (800MHz)
                    0.90 - 1.0 - 1.05 [ -- ] (1000MHz)
 - VDD_VPU (BUCK4): 0.81 - 0.9 - 1.05 [ -- ] (550/500/588MHz)
                    0.90 - 1.0 - 1.05 [0.93] (660/600/800MHz)

Idle power consumption doesn't appear to be influenced much,
but a simple load test (`cat /dev/urandom | pigz - > /dev/null`
combined with running Animatch) seems to show about 0.3W of
difference.

Care is advised, as there may be differences between each
units in how low can they be undervolted - in my experience,
reaching that point usually makes the phone fail to boot.
In my case, it appears that my Birch phone can go down the most.

This is a somewhat conservative set of values that I've seen
working well on all my devices; I haven't tried very hard to
optimize it, so more experiments are welcome.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mq-librem5-r3.dts  |  2 +-
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 22 ++++++++++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index cd3c3edd48fa3..425f4ef7cb2dd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -12,7 +12,7 @@ / {
 
 &a53_opp_table {
 	opp-1000000000 {
-		opp-microvolt = <1000000>;
+		opp-microvolt = <950000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c86cd20d4e709..8e4ec54ce3adc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -704,8 +704,8 @@ buck1_reg: BUCK1 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <900000>;
-				rohm,dvs-idle-voltage = <850000>;
+				rohm,dvs-run-voltage = <880000>;
+				rohm,dvs-idle-voltage = <820000>;
 				rohm,dvs-suspend-voltage = <800000>;
 				regulator-always-on;
 			};
@@ -716,8 +716,8 @@ buck2_reg: BUCK2 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
+				rohm,dvs-run-voltage = <950000>;
+				rohm,dvs-idle-voltage = <850000>;
 				regulator-always-on;
 			};
 
@@ -726,14 +726,14 @@ buck3_reg: BUCK3 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
-				rohm,dvs-run-voltage = <900000>;
+				rohm,dvs-run-voltage = <850000>;
 			};
 
 			buck4_reg: BUCK4 {
 				regulator-name = "buck4";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
-				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-run-voltage = <930000>;
 			};
 
 			buck5_reg: BUCK5 {
@@ -1214,3 +1214,13 @@ &wdog1 {
 	fsl,ext-reset-output;
 	status = "okay";
 };
+
+&a53_opp_table {
+	opp-1000000000 {
+		opp-microvolt = <850000>;
+	};
+
+	opp-1500000000 {
+		opp-microvolt = <950000>;
+	};
+};
-- 
2.53.0


