Return-Path: <stable+bounces-236123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P3rDo8E3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:58:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6B3ED9DE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89244301910C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214313BC677;
	Mon, 13 Apr 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWaAraI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1738361670
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092288; cv=none; b=lYrm3Kebdw29QA6WUnnkHyRc+tWz3I6uDBuGPmHqL3gCH6wH2nfrUu9UljRYTLuzf2ywf4+GoTqemAy0PS4ojJgIK6syz5JxR0eyxa19bZYHuzi6BA+22c9o4mY0gsOpFIRqZ1Z1KVgawy0nk5sKqDX3Vsr3WfdirqJ98qjBDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092288; c=relaxed/simple;
	bh=y9qweU5FJGFYrijzC6bnu2t5Il+Hh3lGQLaDG0cYCZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaCpYQEJxygYeh/aAc2sxYDT3lp6dr6sCNZlnfyAnJX1cc59rXOCYHD4XlLbyruDwxWM5G9xeDQxQr92X6NKVuuZXHpyiroToY4lb1C5Oq3VaQcGB4/Y86s8FbvuhcKjOLp2nx4+k5qHt7wlgtHS8JK38go5gqx0r6nk7/KzXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWaAraI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B482C2BCB0;
	Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092288;
	bh=y9qweU5FJGFYrijzC6bnu2t5Il+Hh3lGQLaDG0cYCZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWaAraI67/ofX4Meqz2ZjEU2NFN7EOW41TI2lkoP22Md9BIf6ia+hztNByK4UCnmL
	 RTdHh0+kWyUUX5hqp+kM8OEWDuarTqDQZSB5UEtN5YXZASN7H6ywtpxmyUK8NqYLZV
	 xJObB5wubtWO8BjsRWk9NZw1WRsrOR4pnD6lJHJ1wk4qTY29sF1/VkqTzaY4UIIZqQ
	 rZ74LMTuQ6ygvvnYNqX+vcKJNiHnDkEtwajYOqwdsvcyaW+i9cT8tIWXf8JgDy3333
	 cZ+5Mwr5Fip6jwrcEDRWvnVaonSEccWAAtAOuxMHITZhAGkHrY7hEKzfuAX1faX7vo
	 Sp3iSw6+ZKqHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] arm64: dts: imx8mq-librem5: Set the DVS voltages lower
Date: Mon, 13 Apr 2026 10:58:01 -0400
Message-ID: <20260413145804.2968471-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413145804.2968471-1-sashal@kernel.org>
References: <2026041310-reluctant-amaretto-6070@gregkh>
 <20260413145804.2968471-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236123-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CF6B3ED9DE
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
index a299e4dfcce7e..39af36f789871 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -651,8 +651,8 @@ buck1_reg: BUCK1 {
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
@@ -663,8 +663,8 @@ buck2_reg: BUCK2 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <1000000>;
-				rohm,dvs-idle-voltage = <900000>;
+				rohm,dvs-run-voltage = <950000>;
+				rohm,dvs-idle-voltage = <850000>;
 				regulator-always-on;
 			};
 
@@ -673,14 +673,14 @@ buck3_reg: BUCK3 {
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
@@ -1117,3 +1117,13 @@ &wdog1 {
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


