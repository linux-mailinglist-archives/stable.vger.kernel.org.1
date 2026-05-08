Return-Path: <stable+bounces-244657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBRoLlVM/WmUaAAAu9opvQ
	(envelope-from <stable+bounces-244657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2C4F0DE0
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC069302B762
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21526B973;
	Fri,  8 May 2026 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ROqM9PqC"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E6C2441A6;
	Fri,  8 May 2026 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207633; cv=none; b=Ju4s9b/RGzQCHY3topzwALsyt23Pk0mWHxEMM695NR7FkZeYEyl60khys3VIGcUspN1WjfQEZYAPvgIXZU7MSaWCCsao/SWwUiXjVsxZPM9ICUPKMeCy4VdfO2QT0JgCUQteWRCGOd3m6j06TMcyzWkOXJMZMtqY3foF0pvSfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207633; c=relaxed/simple;
	bh=8NKQLZyxLYJhm4hbC4TfIcKmlDPEwzaEFkeoWOvMZVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2EV1lIE5Fo9H56uXZF//6dRy2r5pZpZIkLHoyhu3qJvXclLpwZ/ZC9n17N3tNdjr5ynD2BD2Hdzs6GI+3jVTaAth8PDRULV2R1PDBPC25MnbuJ5TsgiGunoLtAMRc7aKRx/edr4B98mE/LNK2VxUrng29WgPIFxdKWVWqikJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ROqM9PqC; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=up
	iyFN9xB0gGThE5jme1YoDuEuYuq9j3gkqu1lXH5+g=; b=ROqM9PqCkxxPbO1H5N
	sPEnIS8ofOKZWLtL/PBeKBY16urFeIVOmXD2RRaiVVVEIMS2ljCGXP/viS/zMGKN
	SVrE30Y2f3Kds72GrJaBeuAEpuOz9WvTChkkjHjq1lvWIq6+ZOasLfLVa4Li9RyW
	hFTrYaLcwiX2wSok48r4cc2W8=
Received: from China-163-team (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnT0lNS_1pEpSiCw--.108S2;
	Fri, 08 May 2026 10:32:52 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] spi: meson-spicc: Fix double-put in remove path
Date: Fri,  8 May 2026 10:32:15 +0800
Message-ID: <20260508023215.10480-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnT0lNS_1pEpSiCw--.108S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45Xr1DWF4furyUArWUJwb_yoW8WryfpF
	4xGr45urZ7JrsYkF1UJw43uFW5ta47XFyDXay3KanxurnaqFy5tr9FqF4fZr1YvF48Cay0
	vry5Ja1rKF45ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEXdbnUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCwxXBimn9S1WE3QAA3O
X-Rspamd-Queue-Id: 1FB2C4F0DE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-244657-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 63542bb402b7013171c9f621c28b609eda4dbf1f ]

meson_spicc_probe() registers the controller with
devm_spi_register_controller(), so teardown already drops the
controller reference via devm cleanup.

Calling spi_controller_put() again in meson_spicc_remove()
causes a double-put.

Fixes: 8311ee2164c5 ("spi: meson-spicc: fix memory leak in meson_spicc_remove")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ In v5.15, commit 68bf3288c7eb ("spi: meson-spicc: switch to use modern name")
has not been applied, so the driver still uses the legacy spicc->master field
and spi_master_put() API. The line to remove is spi_master_put(spicc->master)
rather than spi_controller_put(spicc->host) as in the upstream patch.
They are functionally identical. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 6974a1c947aa..ae818e7df791 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -863,8 +863,6 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
-	spi_master_put(spicc->master);
-
 	return 0;
 }
 
-- 
2.43.0


