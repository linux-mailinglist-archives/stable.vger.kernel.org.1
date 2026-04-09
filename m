Return-Path: <stable+bounces-235398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLyfMdmW12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255D3CA297
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1669C3070AF8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7E3C73E1;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAjG3276"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE63C1970;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=BA6vPIf3WL8kB79pzG5p1D4VxbPb6KyfQ45WLcVyXux7vFdICPNyAVa6sDnlLr1k47QAexCViUdEMQROjb61SAtBlAkdW3WCLi1t/5zDT6TSsCX8zt4Deysz8LRen+SeE65Dk/pdte54b5F09SMQM35RmvfHm7Ghs/J2QVdR7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=tMFCgvOy4LcT3UQdLxzcCVWCGk2e5r9f9re3+JZhWVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAxl1O0F+nGPmB6td6phsmIVggdyFYfG05XAC/GTfOJarAiXrhfUZvp9xyStCzroE/L4DT2FGJ4NHXyehJcIBDr6FG2DTa81vrMuchkHCgwAdRBEwAr3KXSsQosB78nBtstDS/O6DESo4cRUnu3pdrddpslTb+c7/LWHdRpBQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAjG3276; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C5C4AF10;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=tMFCgvOy4LcT3UQdLxzcCVWCGk2e5r9f9re3+JZhWVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAjG3276gO6Px2fz2ch4CMWK2FjzMNZdpVTAfIIGqXBH0yenAbsvH+7/E864mCwBO
	 skLjtGOyXqfDfUtdIRyWI8T8uRsYl2695ALn7lo8nab5NIkkg2yLLAI3N2Zd+Dxbow
	 aXPEfNNLPEI8DW9N+lQWqrh1aFXs6QbLOC19A0DdOfqoMoSwOWVesAAIPuL4JquYfQ
	 Gmre0ROmQ2iVcQ+/WM3vmfTNm8JBvuV5ZkraO9H1OaIBpyVuKFljUn8WiWbPVc/hVJ
	 ZOYYxXan035W5v3gf8Et0+tilesxwrhIlYlY3wFg+m0Udz0WqHLIbEt6jFUr7rasdO
	 LYwLahsiiKPeg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d6x-0ATP;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Jan Glauber <jan.glauber@gmail.com>
Subject: [PATCH 09/20] spi: cavium-thunderx: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:08 +0200
Message-ID: <20260409120419.388546-10-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235398-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5255D3CA297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling it to avoid
hanging or leaking resources associated with the queue when the queue
non-empty.

Fixes: 7347a6c7af8d ("spi: octeon: Add ThunderX driver")
Cc: stable@vger.kernel.org	# 4.9
Cc: Jan Glauber <jan.glauber@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cavium-thunderx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 99aac40a1bba..f1a9aa696c87 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -70,7 +70,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto error;
 
@@ -90,8 +90,14 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct pci_device_id thunderx_spi_pci_id_table[] = {
-- 
2.52.0


