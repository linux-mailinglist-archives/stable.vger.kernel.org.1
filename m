Return-Path: <stable+bounces-215495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLrVHFf5iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15AA111B58
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1549730B4E41
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061B36BCE2;
	Mon,  9 Feb 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNPuXZkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C832750E6;
	Mon,  9 Feb 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648983; cv=none; b=nzv4AuqL9hS25opRBUok2eVBTSi1xfnbMK0cMvSSW8IH9Xn55i1ruBEQofiiMqmMQFGVrEtlWma5A/avWQlppwjIJh70DW7ItB8fd0jwon6fHHUdqXNPNwHs0CkvvjJvJQre6iMRnlBuLuGduNDTo4q7mcjWFWtQCFQSut2v8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648983; c=relaxed/simple;
	bh=XqtRaUanYJ8SzDJypulZczusinotMaZYY1165tKNuRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2prDnrXMpIOCNw+OZzYFffrT6hz1zGr4haLnWRFXFBboQAnfHh2fVDI9nhVXPe4Y2F4OdBhdyJTW6b7e0u6gpGXE69BBRnPng7X7w/8aKvB7ZEY++CPDVZgrNvDCQNsfO4Qk6Uy2CMPzmd5NKSik86U9hDuFjYl7zk54gDYsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNPuXZkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC81BC116C6;
	Mon,  9 Feb 2026 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648983;
	bh=XqtRaUanYJ8SzDJypulZczusinotMaZYY1165tKNuRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNPuXZkTtiABX8FmhyAmNdwNIJCAJvuKwthn/JnW/nrHnRsWzcGuGQptohnrTdUzt
	 bVE/sUIC1XZ2GYufECoiiKvUUfegfo0J78NKOmm+0E4KZkSw+lWWxyl3fTBmR2tlzB
	 TxjRrCb5L2oV13E+4hye0/AzAsAONEig8KNx0/T0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 74/75] spi: tegra: Fix a memory leak in tegra_slink_probe()
Date: Mon,  9 Feb 2026 15:25:11 +0100
Message-ID: <20260209142304.520196686@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215495-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E15AA111B58
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 41d9a6795b95d6ea28439ac1e9ce8c95bbca20fc ]

In tegra_slink_probe(), when platform_get_irq() fails, it directly
returns from the function with an error code, which causes a memory leak.

Replace it with a goto label to ensure proper cleanup.

Fixes: eb9913b511f1 ("spi: tegra: Fix missing IRQ check in tegra_slink_probe()")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260202-slink-v1-1-eac50433a6f9@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-slink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index c611fedda7de9..a51310aa2556c 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1087,8 +1087,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
-	if (spi_irq < 0)
-		return spi_irq;
+	if (spi_irq < 0) {
+		ret = spi_irq;
+		goto exit_pm_put;
+	}
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.51.0




