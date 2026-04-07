Return-Path: <stable+bounces-233532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BXrAqDR1GlJxwcAu9opvQ
	(envelope-from <stable+bounces-233532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:42:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C13AC392
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A0A1300E245
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BD3A6B8C;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW3wgnem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CF3A5E76;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554967; cv=none; b=YUD/rkKNNwcwYpKQyC3L2yQOANIkmSaWihKy1ly+NT+d1FtUZ92oAAJ8432CBk8ycCKdG6Cps5FbilwtUWJ0gdpJV/VKml4B8XJEQa2c9Snxuj37ctL2/1iBNE3Gbvm7+Jsh+MXj0NlILT7c1l1JzarOX0E3dORSXboON35zG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554967; c=relaxed/simple;
	bh=zmNvE6/0KN3rnr8Lx3KqmuGUV0sLuzke8vWNh+k+5yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phGUIlJSSehogLQ1GS+v9iY8YPmFT2XyvhlSKptr57psGZQxlZfk2+LZS5M2mRQ7gtYV4sP7EMLdiw0+ecjBbSUs/ZMTtRg+2OZHXMDdk+tejKJAFUvpoGgdYv6wDVft1q2A40ZjPNN7vLOJAlEbSetONEI6T28pQ/Tn3Qix/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW3wgnem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1288BC2BCB0;
	Tue,  7 Apr 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775554967;
	bh=zmNvE6/0KN3rnr8Lx3KqmuGUV0sLuzke8vWNh+k+5yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jW3wgnem+R6ZIBuuF7iS9QtfD4woi3kRbG7RGOaTFN/HwaG6vaoi/S4FCIhQ6RKJM
	 We6y0mIHPaUWUVOiBiM8M73tNZV4QU3zpJ+4S89gcHXVTirriV5e/tsVvEEFvf67ts
	 1Yo+v9WLrL7GiLLY2oC0PIT91iqVuv4/E44fU2sqaiss6dVoO1B+2DVBOVjisRKLSa
	 duF+33lwavnV3m/w6Y4AwyU4XYrnikNtx03rl3flAmAd4pIEiDR3nUllUPc+64gfmd
	 yKD104FA2xCDtx65MzK0uXPIfIKl1tr9LvRYyUjZToDd//L63dzhb1WFKiZZCGuSw7
	 yDTggDIr3pn1g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA2xI-0000000AnNN-3j0U;
	Tue, 07 Apr 2026 11:42:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] regulator: bq257xx: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 11:41:55 +0200
Message-ID: <20260407094156.2573027-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407094156.2573027-1-johan@kernel.org>
References: <20260407094156.2573027-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233532-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,vger.kernel.org,kernel.org,hotmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C1C13AC392
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator driver")
Cc: stable@vger.kernel.org	# 6.18
Cc: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/bq257xx-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..711dbe045383 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -142,8 +142,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
-- 
2.52.0


