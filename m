Return-Path: <stable+bounces-241881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLg2IB0C8mmElwEAu9opvQ
	(envelope-from <stable+bounces-241881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:05:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988B494746
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2279330117AF
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A973FADFC;
	Wed, 29 Apr 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="ObJFC/W0"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371D3BED7F;
	Wed, 29 Apr 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467582; cv=none; b=V9J/3V0YW7egbQkGTwFmHIVFxTfIHPLVolJxVlxQzVJ5nja+gsJSNPWrbWOz22/Hq4zDG0Dqj1uBLsUO+iOxMLQk5s1S1y58qFQvUHQoRQzv3DCCogad3Se9UOj520kMA+cVjwgj40nVmTuGNj5Y8IK2+nU5+BHcI98ttK4F7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467582; c=relaxed/simple;
	bh=yUFqmtizZf68TsJODx5f65B8FDi8dsrINukRhWTQF4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAdtRGh80mHLPV+RXGrSm9A2OcfT1tet0v1crRp22AXulFguyGJvNetj/f6GWaBeHIgk/STw8d22WXdxLLUdNhkaVk6+4GBQoKJ9pzrUZgX2iWLxiC4T/FXSiPOTW6xAZ5gKrb7WhQT5qwCaIGgys2U5d6v1oOlBPSmbQZ6K+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=ObJFC/W0; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F4EA14841E0;
	Wed, 29 Apr 2026 14:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1777467573; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qwddamSpISS9kQ0XccY8Pom5+hI9vPTaYag3qzKHulY=;
	b=ObJFC/W0mewdEriwwA7IT9ixFazieJhEYi4CzKknr59WWueuXM6YbeU5uQJVkwBAXFq0Y0
	jmhpW2NZptFKIsEmOG3HA9be/2H4gXuxqTUCgJW/Z2Cyah3ak2kOXxXqolsuM5uQZlQvIK
	XLscspxcBiRo+vis18kYBJkKBjduZKwjnzQzcg/wJxErerVEAlQFt7cGvcS5zNpjsBst+0
	4qGUPRSuyY0DSgLa3Aw8rK2lTW/W/Mk6SPOM9ZW5WahDQNxbwbfLk86gOIHdeugaEvrQ76
	h6Y4v6J5ZX8bZBXHfYLRF7InDvy+8vQG/M6gn7JTPjFb6MqVEuPlYVZUThpJOA==
From: Alexander Dahl <ada@thorsis.com>
To: linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support)
Subject: [PATCH] memory: atmel-ebi: Allow deferred probing
Date: Wed, 29 Apr 2026 14:59:30 +0200
Message-ID: <20260429125930.844790-1-ada@thorsis.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 0988B494746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241881-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[thorsis.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

After removing of_platform_default_populate() calls the atmel-ebi driver
was affected by deferred probing.  platform_driver_probe() is
incompatible with deferred probing.  This led to atmel-ebi driver
eventually not being probed on at91 sam9x60-curiosity and other sam9x60
based boards.  Subsequently the nand-controller driver (nand-controller
being a child node of ebi) on that platform was not probed and thus raw
NAND flash was inaccessible, preventing devices to boot with rootfs on
raw NAND flash (e.g. with UBI/UBIFS).

Fixes: 0b0f7e6539a7 ("ARM: at91: remove unnecessary of_platform_default_populate calls")
Cc: stable@vger.kernel.org
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    Successfully tested on sam9x60-curiosity board,
    and on two custom boards based on sam9x60 and sama5d2.

 drivers/memory/atmel-ebi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8db970da9af96..1e8e8aba2542d 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -628,10 +628,11 @@ static __maybe_unused int atmel_ebi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(atmel_ebi_pm_ops, NULL, atmel_ebi_resume);
 
 static struct platform_driver atmel_ebi_driver = {
+	.probe = atmel_ebi_probe,
 	.driver = {
 		.name = "atmel-ebi",
 		.of_match_table	= atmel_ebi_id_table,
 		.pm = &atmel_ebi_pm_ops,
 	},
 };
-builtin_platform_driver_probe(atmel_ebi_driver, atmel_ebi_probe);
+builtin_platform_driver(atmel_ebi_driver);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


