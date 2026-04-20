Return-Path: <stable+bounces-239206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHepCbdA5mlutgEAu9opvQ
	(envelope-from <stable+bounces-239206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:05:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7842DC7E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 397E23315462
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD304D2EC9;
	Mon, 20 Apr 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc6ojOcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286573AE6EB;
	Mon, 20 Apr 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692007; cv=none; b=E8EwnsPsodTyOyN4USDuvkIFeu5wsXmf1HUko4PWYnJ7ibsdC0mICdpuSIDfXhHnaujBjeZRimaGMt3UVLch5RJ3Y7Vvk9RWHPEJGZks5n9uQLtP9vKdkmfPNBKNmDkTn0cKSlch+W9O4s3r+anFYTjk6K5oLsvhVxPrrHD4GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692007; c=relaxed/simple;
	bh=6ElqZfprnWkaD91inJ4k6uvGlxbYDLR08virTftN5es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gODkiS4o6up2q9DoT/pEUW5Ert4mpWsInfcb22Lj6XUw3vzXdl987RNlY8A9aspC0ZtPwQJ15BxWeDLews1voKLPM34peYMwlLmBg14lt5EsaskrwDgjbLMFiHfVkdcpxIAfGQPkmZjazne05cC8dS5NmKGozewriJsb9xGF7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc6ojOcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690C5C2BCB6;
	Mon, 20 Apr 2026 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776692007;
	bh=6ElqZfprnWkaD91inJ4k6uvGlxbYDLR08virTftN5es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pc6ojOcGEEpUZ8UIoR/oUpt84ySN/ytVq0S3X4jd1fhy0Um+uu/hohnPwYQlUFOGv
	 tSgvDrJYkYxuyw/xSl5OG9rEawuztGiaR8ITwWxRhJeLqK0ciEdSmxNgnnkU1HcK4h
	 dRE8iSaqM4QCQ6ECz0wGmnYxicy/pFDUhd30PKtyGhfb+eh63OB+iz0gbgNzmiosjE
	 UJ9W/ybJ+Fvo8OcwqlgIIM9t07YnFVfqQ+x00Fq+vyYVfYPGwxA3akr2OpZ7NCswgR
	 9saBmuJKAWeG1JeLRAHp5f97fkveRZR3i8/HFGOHOcdl7VjUSinabiegX1lZHf6Q1l
	 0zIwCxeTMULzg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de,
	agx@sigxcpu.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] arm64: dts: imx8mq: Set the correct gpu_ahb clock frequency
Date: Mon, 20 Apr 2026 09:21:52 -0400
Message-ID: <20260420132314.1023554-318-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239206-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[puri.sm,nxp.com,gmail.com,kernel.org,pengutronix.de,sigxcpu.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 29E7842DC7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit 1f99b5d93d99ca17d50b386a674d0ce1f20932d8 ]

According to i.MX 8M Quad Reference Manual, GPU_AHB_CLK_ROOT's maximum
frequency is 400MHz.

Fixes: 45d2c84eb3a2 ("arm64: dts: imx8mq: add GPU node")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807beb..6a25e219832ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1632,7 +1632,7 @@ gpu: gpu@38000000 {
 			                         <&clk IMX8MQ_GPU_PLL_OUT>,
 			                         <&clk IMX8MQ_GPU_PLL>;
 			assigned-clock-rates = <800000000>, <800000000>,
-			                       <800000000>, <800000000>, <0>;
+			                       <800000000>, <400000000>, <0>;
 			power-domains = <&pgc_gpu>;
 		};
 
-- 
2.53.0


