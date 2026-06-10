Return-Path: <stable+bounces-262405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hM3DDpHHKGoeJgMAu9opvQ
	(envelope-from <stable+bounces-262405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:10:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D266567B
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 04:10:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=GE8t70Wj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262405-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262405-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA211301BC17
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 02:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C443002DF;
	Wed, 10 Jun 2026 02:08:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96F3FBA7;
	Wed, 10 Jun 2026 02:08:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057322; cv=none; b=gLX5RZZlEPXHqdZ6Jcl+FvuUnPuCu3/U9A/oMiCxnQlACUxzXDPYIxUeDVDshOCEd+6jC4O8D1MFj0RqmdjjLyJ+owYJ2UMNegORs+HoTRemKFFoF2Pq+WVnsk7Ox2QWDz0jstO4wePAB+FP8X7GgXItoHaGejqZabjkGe0TgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057322; c=relaxed/simple;
	bh=cLfrJfe2amlqfGJu18td+pRR7VgnZs/+mMKr7Mvje3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfJpOADaoHyWJpR90Bg3Rcjy2mLZNR7WgoXb8O4zUqp4+EomkkXLhgn6RM9crv/pBRI9F3hcEJk80veLiQTE8uhHegglTb+QPcXXcvLkE9B+whmQfAfHPzryyVElozA8cKBZCSVGfMIHVWCcNU9Lm3okRDLvfOF7ULx/+g/OBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GE8t70Wj; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d/
	tS08MSBumHtqSKFA4artjeTLd0KLUl4Lxq+fjIwh4=; b=GE8t70WjvgMMJO07Cn
	6oLDedyLzdn2XQuV5TzMaK+vEmWlbXeKbeVk5snIqn8aq4gAitkaTLbu317IUNzV
	rSL1znCepydlIi8apMa/Gv1vWkDiIX3l7sK8zWCY+g5vk2GdDcMFMwyQOyJKf3LE
	vJaHj1Y0kGv1ix1dhT9ZSYaos=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHRv0JxyhqeF_yBQ--.1233S2;
	Wed, 10 Jun 2026 10:08:09 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Wed, 10 Jun 2026 10:08:09 +0800
Message-ID: <20260610020809.2695490-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.44.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHRv0JxyhqeF_yBQ--.1233S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4xArW3Cr48JrWUXw1fWFg_yoW8Ar1DpF
	4xKFyjyFW2qF4jya1kCw4j9FyYg393Ja4qgwsrKw1fZ34agFyvqF1vva4YqF4DCF9rCF42
	kFsrJrsayF15ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_c_-dUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAQqYBGooxwp2HQAA3z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,163.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262405-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:johan@kernel.org,m:broonie@kernel.org,m:d-gole@ti.com,m:a-nandan@ti.com,m:rob_garcia@163.com,m:linux-spi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE3D266567B

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 233db2cb14db8b1935dda52a6affd97276462b82 ]

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid an unclocked register access.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Cc: stable@vger.kernel.org	# 6.7
Cc: Dhruva Gole <d-gole@ti.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=2
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Context adaptation performed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72262b6fb62b..da8401261bbc 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2013,13 +2013,14 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
-	cqspi_controller_enable(cqspi, 0);
 
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+	if (pm_runtime_get_sync(&pdev->dev) >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_disable(cqspi->clk);
+	}
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.44.3


