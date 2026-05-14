Return-Path: <stable+bounces-247118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB5GKKZbBWomVQIAu9opvQ
	(envelope-from <stable+bounces-247118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:20:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE653DF8A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D8693036E9C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF73B8BC6;
	Thu, 14 May 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn+C6GW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955F35E529
	for <stable@vger.kernel.org>; Thu, 14 May 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736036; cv=none; b=OyGjs6MJFdMvndIOpF8ZIVZu7ux8DM9Zq+14G/V/jG0PEyNpnNd9kcJpnLOjanPj0s3ainopPhlmtPoh6WuMz8/tfrqGcPVp1TqdPBMczK7kwpfcnrsSPgri2CuPM3jUwPnQsSK8A0/7R/H1Rte7l/OGdWBAcwVAeYe2nkOun6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736036; c=relaxed/simple;
	bh=Yy8uAF5xbAzgLczsyU3pDFe0CeoB25cN0GFEK2JlmjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pc1a3DE5Hww4kAZV6C9e0I5WifS8K4rdbmdsNee2RKCYgimqdSQWnds8hiQ9iGn84f6YHXJK1PxRv+54ov+ByWESPeFfDWObVx9DeXDGljp7aNHBxCW141WbqBM5SO69LKPX3Q5nWeA5kH7VNEh0vyYtVDhSUTiDFlsUI8Aa8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn+C6GW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A07FC2BCC9;
	Thu, 14 May 2026 05:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736035;
	bh=Yy8uAF5xbAzgLczsyU3pDFe0CeoB25cN0GFEK2JlmjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn+C6GW+bSCN4RKD5CuUuMTeeJ/QtAL1YjHt9GX1ta1IH5iZUUKs3K8ifcaskWWuF
	 s3+RmoqTeRDG0Ok3c9npxOJvlm3gIEvES1o1b5BsVXm3sh7FHOF8rBqjFPU3SgciFD
	 jPPFeZaZs7Zb7Dp5niAiX+tanOmtidBUE07Y0dvJ++pDxceu3TJzeiOp3yS3JGVHxb
	 7ewqKopXtIScDIBft4bT1ySDd70gUlE6t/Pn9qLsnBWXtnsvb1aa4MBwRhAMCRcfhX
	 s8e2fZ97/SfFixiZFbyoEj17sODVWIWkSOqPc2q6o6qiBDf9VF2KEDESyjs/uHBJ2H
	 ev2bDCULbLTAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Adithya K V <adithya.kv@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] spi: s3c64xx: fix NULL-deref on driver unbind
Date: Thu, 14 May 2026 01:20:32 -0400
Message-ID: <20260514052032.41196-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514052032.41196-1-sashal@kernel.org>
References: <2026051226-composure-saffron-d0fa@gregkh>
 <20260514052032.41196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14AE653DF8A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-247118-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,sashiko.dev:url,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 45daacbead8a009844bd5dba6cfa731332184d17 ]

A change moving DMA channel allocation from probe() back to
s3c64xx_spi_prepare_transfer() failed to remove the corresponding
deallocation from remove().

Drop the bogus DMA channel release from remove() to avoid triggering a
NULL-pointer dereference on driver unbind.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only during data transfer")
Cc: stable@vger.kernel.org	# 6.0
Cc: Adithya K V <adithya.kv@samsung.com>
Link: https://sashiko.dev/#/patchset/20260410081757.503099-1-johan%40kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410094925.518343-1-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 995c03d1ddcf0..77676d2a9e7d5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1274,11 +1274,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
-	if (!is_polling(sdd)) {
-		dma_release_channel(sdd->rx_dma.ch);
-		dma_release_channel(sdd->tx_dma.ch);
-	}
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.53.0


