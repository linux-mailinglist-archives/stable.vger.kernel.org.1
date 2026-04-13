Return-Path: <stable+bounces-236097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJBdE+n63GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF63ED33D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DB53033211
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242C3D6CC7;
	Mon, 13 Apr 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK3dVb8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672913D6CD7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089266; cv=none; b=TsEwKK+kUAHep5F4w0KRxGFonRFPEgtwfaUN7OWr5XY3wPz2m2bMfBNaLvus8zkisArmVC3KfBq/fr99WEDgZ83G8X/jAMRotYKs1q0BaHCwcxNFJtObtf0ju6YHdwBHqErAIJ1lbKDELbcc1af7P4w0PWr0yXc1H4xwASMpqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089266; c=relaxed/simple;
	bh=y/ic9qAun2AFV7kIcyHOO5YsAZcINZUe/NpyQghgcrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+oW6VgGSfqJJ0Ov4aBi/DPi7JBmbeILqXIUNa6DHpzT0th5D2dsqAjSpCXx7nUk6OGaKVGvASwgBBtYS+HSadxdTfYhlMmpwJPVTyQpXl0s0+nzMW3ZA/ufrmL1h11AVBkIJmYyItoiEQl79HXDFtXAMr8Lxs2aPBaTRBpseX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK3dVb8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51363C2BCAF;
	Mon, 13 Apr 2026 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089265;
	bh=y/ic9qAun2AFV7kIcyHOO5YsAZcINZUe/NpyQghgcrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WK3dVb8Q8KGeAkqKsfrv+mbGmntA9GeWOZzymXQrgF0On0DOK+A9pxMxaAzqEjY02
	 3JSuNeVz8z/lc8Ml5nEkumV7tEu79ZoqyB8cwiSixcp56lksDRSLqC+rOdRUx5Se14
	 O2TS90qh5461udEgvoaDdY1PrZ0exAJjeCGzDp4WJ+AntxA5eZ5IwX1hK9POTQOEjv
	 lZf3ZsN8gQOXwg/gDwuwynNW4S8YmaFHhZp2sgf+UXI1auyuNEeRRL5BAYmysTdIFg
	 pMQO6tRCjXEpuWf6H9gBoPd2kUcdw5HdY4HcSI0Mz6+MEEm36e6bv0lBjX8777Q+ga
	 KvYM+HZg0l2WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage to 0.81V
Date: Mon, 13 Apr 2026 10:07:40 -0400
Message-ID: <20260413140742.2903986-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413140742.2903986-1-sashal@kernel.org>
References: <2026041309-reheat-frenzy-98e8@gregkh>
 <20260413140742.2903986-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236097-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1FF63ED33D
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
index 855f8f7cb4e79..39c4a08ff7c13 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -821,7 +821,7 @@ buck1_reg: BUCK1 {
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <880000>;
 				rohm,dvs-idle-voltage = <820000>;
-				rohm,dvs-suspend-voltage = <800000>;
+				rohm,dvs-suspend-voltage = <810000>;
 				regulator-always-on;
 			};
 
-- 
2.53.0


