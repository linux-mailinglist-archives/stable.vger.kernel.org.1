Return-Path: <stable+bounces-235402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG8nLOCW12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 510F13CA2B4
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855173074A31
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2EB3C7DE2;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWiGwXaC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1E3C3444;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736327; cv=none; b=ARIuEFW2LEjrBqkjbG+6vdI5ToObextA3UMzHtU2kN28d0pHYfEt5UvO+OTVrl1a0MYJc1BI+xMdr+vdBrWFz5Er5lVmCcstCLdGwBOn5TIhfjFrwdMWpWUuQfWG3F1OQ14GLnB7AYewm9jvvPD+g3dSUmjYtpOtoJ7mKbQw2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736327; c=relaxed/simple;
	bh=+7HUP2x3eChcguKGttuSuj2E873EeFIoS7RjFCEZxvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIOqUsrRilo1ToRaJpD4lH1cx/Jo5uJABGObSYk/tc2mmsNoobs0eGQcmo7VV/2vuf+ga8sYPcA3tmWaoPKcd8Xuu2wHPJCLXmRZep4+CH5+v4MW5vBKDzt9cmKwbrahk+yRHOJPRBAd9KdEhLROy4tQp4XI+c5+aOWG5wSV29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWiGwXaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF8EC2BCFF;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=+7HUP2x3eChcguKGttuSuj2E873EeFIoS7RjFCEZxvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWiGwXaCOCUyBqKfFiionYUWWSkcgdcSEUluduv2VHpqPnrc/tWWkHMICBZc+L72O
	 7gccoy1pzZyV9IjrOKHXHZ626s2nQpB0Ako7z8VgZdgNu/BDcBJ/G0NeXZRht0+mjw
	 FGwmkq7CtXYeYbkFqps2yoT+YrdCwOosUOnkbQnzlcOjuYvgGVz6bsorWRtyKnQ3g+
	 eR5lSSKiXV+gpsp2cXBJvfNbs6xe8jDEKOiJiVrLtKYRX3yv+ge1Co8RLIBw6+FIK8
	 w/4EeUFRPVc7xrWKyUWih2et+oQXG/uOV6/vvrOsihhEbkkmgkl8lXuqfMgXljfg6F
	 R1H37WyTU+96g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d7J-0aoc;
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 20/20] spi: mpfs: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:19 +0200
Message-ID: <20260409120419.388546-21-johan@kernel.org>
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
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235402-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 510F13CA2B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Cc: stable@vger.kernel.org	# 6.0
Cc: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mpfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpfs.c b/drivers/spi/spi-mpfs.c
index 64d15a6188ac..989a379b0700 100644
--- a/drivers/spi/spi-mpfs.c
+++ b/drivers/spi/spi-mpfs.c
@@ -574,7 +574,7 @@ static int mpfs_spi_probe(struct platform_device *pdev)
 
 	mpfs_spi_init(host, spi);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mpfs_spi_disable_ints(spi);
 		mpfs_spi_disable(spi);
@@ -592,6 +592,8 @@ static void mpfs_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host  = platform_get_drvdata(pdev);
 	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mpfs_spi_disable_ints(spi);
 	mpfs_spi_disable(spi);
 }
-- 
2.52.0


