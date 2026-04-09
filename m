Return-Path: <stable+bounces-235401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NSQFN6W12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A333CA2A6
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D31730733A9
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD13C73FB;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8v0G51I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869A3C276B;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736327; cv=none; b=kEJMxZkgg+3xJaQvURgK7UyYx+x0m4ZTIuSh/X/LHXDFKMcVq2Z9OdR9R1fb6NeFf3WYSAjVBrHMP75faAD0cGX1cwSRC7jDFAobxz9xSYGW+5cgarVYxhK+cQIoOagpGBOBq5gY20EaNmaY847/OTgS60Ln/Ayq499J5LITra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736327; c=relaxed/simple;
	bh=wuZDVHmIHpg4emeVoxEEiPHCm40raWJLH8pnoqP/UOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fq1StYSTPKidwTMdI23C21u8yj+e2Iknm9cessSUD+EBtw7JhBNWM6p2vqynsU0X1we24QjLtoah4Uq73SWsFNpx6wY07SlQ+8I4KuyXA8uIBGF5fEKMoQWNwmYZPaPpDQsDYk0FUmv0AT0vZOMzZ1JpjKyMSwoOHXU/K+kX9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8v0G51I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D041C4AF0D;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=wuZDVHmIHpg4emeVoxEEiPHCm40raWJLH8pnoqP/UOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8v0G51I+vDqXHFH+4ezmkSOD/xS+OMRnRhVguvb6Q5SdK37+C6klJl/Yq/LITzXV
	 J/RrxJ98IScK1+p9Te8um78djbO6meKSxDtUl+88h2vDsE6b6teRRUFtKqfrYRyiOc
	 F0W7sDHdso76fnUwssF+pLsBdQ75p9KSPMH4zAX2wgnSsWlryXBOFqQo/5rt+2XzWc
	 zlmXowsUTpB5JTtH+GEC7PpaAyq2IDADj9/iAic9TKgmtvQ4pjR0MOv++wwugcnzC3
	 XMr7VN6T9k2f8b6kHoPFuZRlkTDNBAgTtoZwH2JLQXMsPzPmXdhuKe03uhh4x1Kzm3
	 osdaRcYSCc71w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d6v-084Q;
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
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 08/20] spi: octeon: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:07 +0200
Message-ID: <20260409120419.388546-9-johan@kernel.org>
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
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235401-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2A333CA2A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling it to avoid
hanging or leaking resources associated with the queue when the queue is
non-empty.

Fixes: 22ad2d8df77d ("spi: octeon: use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.13
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cavium-octeon.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 155085a053a1..b95bfa6a3013 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -54,7 +54,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	err = devm_spi_register_controller(&pdev->dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "register host failed: %d\n", err);
 		goto fail;
@@ -73,8 +73,14 @@ static void octeon_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id octeon_spi_match[] = {
-- 
2.52.0


