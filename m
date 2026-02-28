Return-Path: <stable+bounces-221049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLuENHZNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2FC1C82AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F34230B1713
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FAA47CC85;
	Sat, 28 Feb 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrs79DPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A121175A7E;
	Sat, 28 Feb 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301393; cv=none; b=LcekX2m51cNtNNoN/YBp/oQKLF/M9INXtMaqdYtulhVkoWG3hefOLra54bQib7cphbnM3XPjELF+RuuzB7nliPVm3UmOYQIFGn9sJqiXspegb7stmQA7K37+sYvJQXfWw5Hn7B5AVCl2si+dEbZlQspTkBEmMO1S+cxk4a2qKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301393; c=relaxed/simple;
	bh=3N2WL6347zenZWHoCxHm+ZIceA41zQD5jFthGbV551c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOU5Ng5rv6DTiI9TD9tupk8XiFlB8yLsCs4qRtKDz1sKtZuRTjWKBOJ7e2m4eLRBYU7lyNg0NRFuuUPcXGVLB/hIBfpGYgF8o4p1n4FCAYP7U7qgk95T1v133Rpm6/ODLnxWCqlOaqzeQC/SQ69cbdaaWI5oEE0K3pTI9JifzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrs79DPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852B1C116D0;
	Sat, 28 Feb 2026 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301393;
	bh=3N2WL6347zenZWHoCxHm+ZIceA41zQD5jFthGbV551c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrs79DPHHjnu6GCvuNhQtVJXcCMSpFZfOs9WQgOddp9pK1eh548osfEANu7cFpERh
	 OQHuoYcX74OZxSQnepnnh7gGcAC6134eX8SS738ztfj4/W2oYXo6VwDzl040TLqudB
	 kqDipvzTIjQwAafEWA5g97UJvOkTg8OWsUJoG8dDd4+ykmvmBmXhf2zLXrY847mPrI
	 NoLLFN9f1ri2l8DffFmOxI3fMEOMiOMiq1TpCRidGsMEWxg50MVYrF0REKn87Nygm9
	 44LSU1suoFWrnRjfEBQ5TlJR2RRFsaHPcRQB18SHCWX1lIzo70JLiarTUGxv6MZSzH
	 pPEfuKUzvOwvA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 581/752] phy: fsl-imx8mq-usb: set platform driver data
Date: Sat, 28 Feb 2026 12:44:52 -0500
Message-ID: <20260228174750.1542406-581-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-221049-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 4B2FC1C82AF
X-Rspamd-Action: no action

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit debf8326a435ac746f48173e4742a574810f1ff4 ]

Add missing platform_set_drvdata() as the data will be used in remove().

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260120111646.3159766-1-xu.yang_2@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index bd37b6cb69cdc..8e7b6e10e1f0b 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -662,6 +662,8 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 	if (!imx_phy)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, imx_phy);
+
 	imx_phy->clk = devm_clk_get(dev, "phy");
 	if (IS_ERR(imx_phy->clk)) {
 		dev_err(dev, "failed to get imx8mq usb phy clock\n");
-- 
2.51.0


