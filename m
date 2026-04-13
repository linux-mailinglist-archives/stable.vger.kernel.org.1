Return-Path: <stable+bounces-236124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH+4BAMG3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BED63EDACB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D273031EAD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AF3B774B;
	Mon, 13 Apr 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPZCUqVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF23B95E4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092289; cv=none; b=mWnZ4vnQ9yhGQ43GfU+sRI//K5NMEmH023T9JG2wypRhycp+HXaEbTF7XgbmHOkK3qrSgNS7OD7jyoXvT2cskg2B4X7MVSngnQoxLQlVdqWQT25UMeKQUkgDpFY2dJzWtmYoIym72J5l50/xXMGoysm0LCZwPBaHeMBXqwaxPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092289; c=relaxed/simple;
	bh=0k8508xYLzNHYl2wOdXTifhkG8pEVxTFlNOmW4VDacc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3vJDSKmvB+PLSBCTRZ4pnFP+q9PHP2ZL3ukn2SXs7lIO5GjProHRRf3QVmhpdTuQ32YEErOrtGqsSO1wYiUqFPdNlSGzmwCbRAoJxG5g00AMP6njfs09Tb92I9NH1GPQgSnHqOerNzVj67ILGM3hOf/tthLCC9gUos7qBVrCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPZCUqVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F146EC2BCB0;
	Mon, 13 Apr 2026 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092289;
	bh=0k8508xYLzNHYl2wOdXTifhkG8pEVxTFlNOmW4VDacc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPZCUqVAfbDEWEMCILV4EO8VOuKCCF4Lb2e7LjZxCSiixl8yhgncRsBkvvCAMdlhJ
	 zTqKg9AqDEWdTYn1MJO6LbCj6j8cIe8bDgDVG8UcnpuFbX3bE+9+mbAx4FYJF7D9MK
	 ZvDA4dTVvEfLgzEM7nECHGizyzYKh11HIp00r7FxaRHcSiQevI0f8lWgLwTDwmQDZr
	 3gcIT0oA4l4AC3Xqdb/GtPJ+Y152bcE0oQZTiL86FCvU4sW4UA00Vbsv6JFdra8Zrf
	 bufcmHDZ176VnJajaKGDcaWj4twxkJar1mipvYmkAu/6tcte6NbIBbqa9Lzxi3VcSP
	 0KHSJMYEqstMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage to 0.81V
Date: Mon, 13 Apr 2026 10:58:02 -0400
Message-ID: <20260413145804.2968471-5-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236124-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,puri.sm:email]
X-Rspamd-Queue-Id: 5BED63EDACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit 94b91e3ca6688fafd6a5dd70bd89fe9d3aee88da ]

0.8V is outside of the operating voltage specified for imx8mq, see
chapter 3.1.4 "Operating ranges" of the IMX8MDQLQCEC document.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 39af36f789871..2f9bb8d042e38 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -653,7 +653,7 @@ buck1_reg: BUCK1 {
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <880000>;
 				rohm,dvs-idle-voltage = <820000>;
-				rohm,dvs-suspend-voltage = <800000>;
+				rohm,dvs-suspend-voltage = <810000>;
 				regulator-always-on;
 			};
 
-- 
2.53.0


