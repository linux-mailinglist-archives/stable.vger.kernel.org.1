Return-Path: <stable+bounces-236125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA7BBBAG3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF633EDAD2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64D73038A44
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FF3B892D;
	Mon, 13 Apr 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4U8rdhu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CC3BA248
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092290; cv=none; b=iHXWGFJ5XKZkLfrTDP4XAbxemVHTrj6gP/K0/zXZpLwtfe/s9kmbPDfTrkIvbBnKGuUht/hGFmTDz6Gn9yNOUVwumSiEfut9ur39kfC7VHFqguYLZEALJaplrF4ikjl0TrFMudD52x/HmPynzvNDSlYxw6rir4M5aem0LC3ym44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092290; c=relaxed/simple;
	bh=Z8uD2JGT1P/nFLFv2hwfahYQzouni2GqZjPuM6s/KSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quIA6ASfjFH4NcihYhyS+FwP+vq9qVMenQfS4b9nw+xhjse5YhDCXnesGJRhxCFDMdJnTir3JlL3L7tHdRCW8YCcIA8TeYsdP33lY9hqO+dF/lv9MZf2oanWotZQX25JAJLt5Vn8XNdYDLNTBA6PCuUHj/0MqKidFpmsGr4+8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4U8rdhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE5C2BCAF;
	Mon, 13 Apr 2026 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092290;
	bh=Z8uD2JGT1P/nFLFv2hwfahYQzouni2GqZjPuM6s/KSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4U8rdhu9xGGrOiMSic9m+OygO6byxC/86zCQOvkP9eyNLk8G3S3mkYe70tTrNWQs
	 5P55k2yiAQMH14W44ZK9f5L/M1FeExQvnogTk2E7U9ppBqjB9L5QigN3weovD9W1BQ
	 VifrKj8XVT/H7gk0KiFqK0oj8hpPXV75IfwddqXjc6KR6kwC+MO8LlHIeAXsURaMbd
	 dn1EpezggEJRbizEXDYVHymqDxKy32SDO7IdrJEMkTjOKHw0BLlzRa4DDM/5oiW0kW
	 OzGDRNuFpMvS4fkLhFEaFdjT96zv4p9DbughaoNKtslnDqcDBipZY79GhTYWq2p16U
	 iSwrM7vWAQofw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
Date: Mon, 13 Apr 2026 10:58:03 -0400
Message-ID: <20260413145804.2968471-6-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-236125-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 5CF633EDAD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit 4cd46ea0eb4504f7f4fea92cb4601c5c9a3e545e ]

This reverts commit c24a9b698fb02cd0723fa8375abab07f94b97b10.

It's been found that there's a significant per-unit variance in accepted
supply voltages and the current set still makes some units unstable.

Revert back to nominal values.

Cc: stable@vger.kernel.org
Fixes: c24a9b698fb0 ("arm64: dts: imx8mq-librem5: Set the DVS voltages lower")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mq-librem5-r3.dts  |  2 +-
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 22 +++++--------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index 425f4ef7cb2dd..cd3c3edd48fa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -12,7 +12,7 @@ / {
 
 &a53_opp_table {
 	opp-1000000000 {
-		opp-microvolt = <950000>;
+		opp-microvolt = <1000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 2f9bb8d042e38..251504dba3f04 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -651,8 +651,8 @@ buck1_reg: BUCK1 {
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
@@ -663,8 +663,8 @@ buck2_reg: BUCK2 {
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
 				regulator-ramp-delay = <1250>;
-				rohm,dvs-run-voltage = <950000>;
-				rohm,dvs-idle-voltage = <850000>;
+				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-idle-voltage = <900000>;
 				regulator-always-on;
 			};
 
@@ -673,14 +673,14 @@ buck3_reg: BUCK3 {
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
@@ -1117,13 +1117,3 @@ &wdog1 {
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


