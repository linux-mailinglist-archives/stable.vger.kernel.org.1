Return-Path: <stable+bounces-235391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FJPAtCW12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE73CA27F
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55282306B9C8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5263C456D;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/rBVe8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A173BB9FC;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=nvjxT8IfNzRJ81M2nxR26oLYJC/ZZoPsOrpkF+HwopeZ7Y7WkEHGDuTC+aM/ttSQrVkeB8YkgwL4vfRfhp6PVCC5acNC5aXus81yP0UKtu4BuSMqiFj9ZcH7TONms8Es0rNAFxwx43rHA6kHZ8S4bkqOQFL7Gfr6X0CSnK0ME0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=2uxiTHf7+/Jq9Yfc9KZLO7wTUuJPnmq2OheP+99yRUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arq77VjadJPK/2QLpQF0STOWoTa13dhiw3yroMV7DHUbNEgwzAGz2ghbP4qRT7sAzgEJJmQGmNT/o5h8euCnUlsVPoO0axqyHpmNSDcRxhDGJbq6ImznwyoGLx4EE3TC7vC7dKZbDDINiedSoGeFUdj+mgDN1A38FkHc1BASe6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/rBVe8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3B6C2BCB8;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=2uxiTHf7+/Jq9Yfc9KZLO7wTUuJPnmq2OheP+99yRUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/rBVe8wc6VfAWlBoPfgX8EzDkI9BQK8Wwp4cxxpBvtNR3bieUGR7Oy++nCM0qMyu
	 AIv4HefHJn95pz79VMahvHbvOVpJDaNRaZnYruEBSd9m7Gz8wTLLHhJ8DrtcgrM4NM
	 acY0HfoXUHvjYcaVdrfKX9ri3wHY1davvVxeG8MlQVcvqwqpm8LaBI/8DmCt6ie4sK
	 4YjlLY50fII1BijPt18AU+4qOTkFGTRbcKxqDOBGeLmlIgSbJM+HMUbuVZjRBPglht
	 a2bmBkZesYVUp/kdp4r0C+erKDXEw/XfgjHvS7UeF+LP3a058ewCpl8Pr/B3V7gEmH
	 LTynMjDiYfofw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d7H-0YU0;
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
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Subject: [PATCH 19/20] spi: microchip-core-spi: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:18 +0200
Message-ID: <20260409120419.388546-20-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235391-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 7DCE73CA27F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Cc: stable@vger.kernel.org	# 6.19
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-microchip-core-spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index a4c128ae391b..be01c178e2b0 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -384,7 +384,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	mchp_corespi_init(host, spi);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mchp_corespi_disable_ints(spi);
 		mchp_corespi_disable(spi);
@@ -399,6 +399,8 @@ static void mchp_corespi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mchp_corespi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mchp_corespi_disable_ints(spi);
 	mchp_corespi_disable(spi);
 }
-- 
2.52.0


