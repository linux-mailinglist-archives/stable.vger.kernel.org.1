Return-Path: <stable+bounces-244539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMwxNeld/Gm7OwAAu9opvQ
	(envelope-from <stable+bounces-244539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:39:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FE4E61B3
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93FA43019809
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F13C5535;
	Thu,  7 May 2026 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jlzrk4L8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31171374E5B;
	Thu,  7 May 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146419; cv=none; b=XTEiUJ5XbGezTuWEPBYyWkbqrlimAEkrfE9TY5Dcx1mS6wogu0h3co3TZYP5yJzvQ5bILCh9a0RUM433RrwYd7srdOnYbffa/Ip8QjLG5Rlgp3Gqiy3a6JgWo3i/QRPeoVlHvIUdpt2ISdK8JBOFQLwxDfSeBRviUNZa+2KaInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146419; c=relaxed/simple;
	bh=HjBz0daVSvJTIK4vf+BEyI0kV/wZEHBouGtWdcwr/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgIuKBvLufIpFh5iDwyP3vWFBrevQuTC67y1cwVzdE1LVI8+04S41Lvmy+AYB0wSc2equ9H4aM1BIzqAWWEzf9vyjrnWbkDKQscjbP5/2FWdGo8AKtbZ9kDRMISDxslBijitTUPuUpa4m0XXLg1QANSFEFnecB8KvIguZnqVNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jlzrk4L8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vB
	EYfloUkqbYP4kc/VlHpKeVw3Une5Q83h2xY7DNHvg=; b=Jlzrk4L87R9qHOoDu6
	fNHS2nB9XzNRDvpWYatcBiAetTLXVjtqM8kmpuqAXgx79YI1XXHrXT1m5FQOhoaE
	KFPH59vrAdb204n8Up07eOtYfYDsDTiEnmsrCYcop3zPp9EqjmtrUtsXa+1iAJel
	+FgevNBREEZET29CpEvsfyRw0=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnyulIXPxpURmcDw--.9190S2;
	Thu, 07 May 2026 17:33:11 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] spi: meson-spicc: Fix double-put in remove path
Date: Thu,  7 May 2026 17:32:46 +0800
Message-ID: <20260507093246.25388-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnyulIXPxpURmcDw--.9190S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45Xr1DWF4furyUArWUJwb_yoW8Wry3pF
	4xGr45urZ7JrnYkF1UGw43uFW5Ka47JFyDX3y3Kanxuwn3XFy5tr9FqFWfZr1YvF48Cay0
	vry5Ja1rKa1rZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWrW7UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC6xnGj2n8XFlQCwAA3w
X-Rspamd-Queue-Id: 536FE4E61B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-244539-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
[ In v6.1, commit 68bf3288c7eb ("spi: meson-spicc: switch to use modern name")
has not been applied, so the driver still uses the legacy spicc->master field
and spi_master_put() API. The line to remove is spi_master_put(spicc->master)
rather than spi_controller_put(spicc->host) as in the upstream patch.
They are functionally identical. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 1b4195c54ee2..04cf8489dd56 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -883,8 +883,6 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
-	spi_master_put(spicc->master);
-
 	return 0;
 }
 
-- 
2.43.0


