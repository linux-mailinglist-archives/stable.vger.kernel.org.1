Return-Path: <stable+bounces-244527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFreCVFL/Gm2NwAAu9opvQ
	(envelope-from <stable+bounces-244527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:20:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC794E4AAA
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1AB3045AA7
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136D33F368;
	Thu,  7 May 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RYj2wY+h"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C3270EDF;
	Thu,  7 May 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141767; cv=none; b=ld9CV1thHXoOfp9Fc/YDP32Q2MS5X7UrFrSj9QAYDxlausvQMG5UOTtHz0B9uY1T9FA7ySHx2+wTHCxW2ICESH2DZV83g4wZ45qJre2qcuI5ZfYlrpEq5dPJgiHAS5a3x2GJAZoLh9XrMl1pU/cRN8UeD3SSMURtPO6vbNQx5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141767; c=relaxed/simple;
	bh=9XFno+8ra+vnOi9DfbjVJc4j5v8PzbR4IvkPxvTZCPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qORBBLSaQlwxOHenspR1wFAdmqp65tdnOz2WiNU+i0L8IJ8oZMnVN2s8LeTYw3yZELXNOpJXE8jxBSsUq/XnZ+zLNd6bsDucR3se7/Rafmg+HcE5wwnw0o4SiAO1CdLRfM4Yz+nTdP7ptpkwepsqR4BKXCND25FEpmuvACNzZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RYj2wY+h; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=64
	KtdPlVFqcFm2xI1lWzcH5A3NJfvI7w7DZbQTUXlQA=; b=RYj2wY+hQ95i3wZAoa
	tP3U+74Ev0rT1Cpfp4kHOTZGMDJRoiJcqBs5CLmHgJPD8NHGrFkzp1SL/zLH9zki
	RevqqWbER1XnsZI/lqhqqbkWObaQfSHXJyoHogP39/YDCYY5Hr6mnFWbrg5UTjiz
	R3PJbhJbptNdiXFxvUeXEP8LA=
Received: from China-163-team (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3qe4bSvxpub5CCg--.148S2;
	Thu, 07 May 2026 16:15:42 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] spi: meson-spicc: Fix double-put in remove path
Date: Thu,  7 May 2026 16:14:57 +0800
Message-ID: <20260507081457.19427-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3qe4bSvxpub5CCg--.148S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45Xr1DWF4furyUArWUJwb_yoW8WFWrpF
	4xGr45urZ7trnYkF1UJw43uFW5KasrJFyqqay7Kan3uwn2qa4YqF9rtFWfZr1YvF4kCay0
	vrW5Ww4rKF4fZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWrW7UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6xA4AWn8SjB6YgAA31
X-Rspamd-Queue-Id: 7AC794E4AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244527-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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
[ In v6.6, commit 68bf3288c7eb ("spi: meson-spicc: switch to use modern name")
has not been applied, so the driver still uses the legacy spicc->master field
and spi_master_put() API. The line to remove is spi_master_put(spicc->master)
rather than spi_controller_put(spicc->host) as in the upstream patch.
They are functionally identical. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 43d134f4b42b..de8cf91658fd 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -918,8 +918,6 @@ static void meson_spicc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
-
-	spi_master_put(spicc->master);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
-- 
2.43.0


