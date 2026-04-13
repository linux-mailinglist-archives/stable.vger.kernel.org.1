Return-Path: <stable+bounces-236122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DtaJ9sF3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2623EDAB5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E3A3022973
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F793B3C18;
	Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+h3kTOJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3A3BBA0E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092288; cv=none; b=Ti4qS4A8LBp1CpTlJZg6cvJJ9wSjgNrzj2LOrAnM5C/pzNc4L9WFrGnAwJdQHBpf+2JWA9mPsSG3et3fDtxJr00hZuE+q0wRTrivkQYoXjVfT/D3blDeS+A/5fVQ6M8tbYVqTJ+dlIX24yNGR/eG8T8BA9yRXeUFCuSMB8MebeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092288; c=relaxed/simple;
	bh=Xy9mdoexEmqEhdfZ2rW2bDtHzshw7r9iircLjuJqM4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbe+hMRSz66h/HXfjo0McXmQXakAAP8/n0THfTEB8jk7fFp4IKoYDO0YmX7D/UwkG0s/uVuIOOyovn8PSJqWkhuyn68F7NqxG1zk9SnHMJ2UhDWmQBi7wPpXgX7OL0c9UatoDCnYv+TAtGzBSJ5VGra4YMdsHC4/wN7y9c6y/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+h3kTOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B664C2BCB6;
	Mon, 13 Apr 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092287;
	bh=Xy9mdoexEmqEhdfZ2rW2bDtHzshw7r9iircLjuJqM4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+h3kTOJrb1Mgx6VSFE+uzaYFFDKRr9ArA0p55fEdyNevjBPYMPXPXG5zZo3dLz3U
	 osb9Y1ySkPKdpUrxXPoL8PluW8ysaWi4MlUmAuny1xjk9oeVJBHXCccN1DcXsOOcpT
	 oiVNL0eTU/EQXh3TspcOmlb+ktie9jXP5swaudMJwMmpaMsfm+wqSOjPJU+NMYYUzF
	 2dlEn+45qaqHtBRkWYoyVoi6uZvtXllBikJiKC5wi0D5M5jfvl6diKl+fmS+VSMrKT
	 5J1hqBoQeGIU6CfPqBup0drYt6S/arb8E9HbdgIJzcZ4wKrJJOsIo2V+ft2UBBA5L/
	 c/l8qHt2OGIdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] arm64: dts: imx8mq-librem5: set regulators boot-on
Date: Mon, 13 Apr 2026 10:58:00 -0400
Message-ID: <20260413145804.2968471-3-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236122-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,puri.sm:email]
X-Rspamd-Queue-Id: 1A2623EDAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin Kepplinger <martin.kepplinger@puri.sm>

[ Upstream commit a8bb83c8c7a17e83e04801d0678e93654f9bfaee ]

Expect all those regulators to be turned on initially.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f333335363100..a299e4dfcce7e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -649,6 +649,7 @@ buck1_reg: BUCK1 {
 				regulator-name = "buck1";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
@@ -660,6 +661,7 @@ buck2_reg: BUCK2 {
 				regulator-name = "buck2";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <1000000>;
 				rohm,dvs-idle-voltage = <900000>;
@@ -670,6 +672,7 @@ buck3_reg: BUCK3 {
 				regulator-name = "buck3";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
 				rohm,dvs-run-voltage = <900000>;
 			};
 
@@ -684,6 +687,7 @@ buck5_reg: BUCK5 {
 				regulator-name = "buck5";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -691,6 +695,7 @@ buck6_reg: BUCK6 {
 				regulator-name = "buck6";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -698,6 +703,7 @@ buck7_reg: BUCK7 {
 				regulator-name = "buck7";
 				regulator-min-microvolt = <1605000>;
 				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -705,6 +711,7 @@ buck8_reg: BUCK8 {
 				regulator-name = "buck8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -712,6 +719,7 @@ ldo1_reg: LDO1 {
 				regulator-name = "ldo1";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				/* leave on for snvs power button */
 				regulator-always-on;
 			};
@@ -720,6 +728,7 @@ ldo2_reg: LDO2 {
 				regulator-name = "ldo2";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
 				/* leave on for snvs power button */
 				regulator-always-on;
 			};
@@ -728,6 +737,7 @@ ldo3_reg: LDO3 {
 				regulator-name = "ldo3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -735,6 +745,7 @@ ldo4_reg: LDO4 {
 				regulator-name = "ldo4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -751,6 +762,7 @@ ldo6_reg: LDO6 {
 				regulator-name = "ldo6";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 
@@ -759,6 +771,7 @@ ldo7_reg: LDO7 {
 				regulator-name = "ldo7";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
 				regulator-always-on;
 			};
 		};
-- 
2.53.0


