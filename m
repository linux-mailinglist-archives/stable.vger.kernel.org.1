Return-Path: <stable+bounces-254253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGP4AwBIFWqLUAcAu9opvQ
	(envelope-from <stable+bounces-254253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:13:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F45D18C8
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18374304C067
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826117745;
	Tue, 26 May 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dY0bbH4H"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EC3C5823
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779412; cv=none; b=DIqfAHpXWND3TNHU87bxvECjV4+3VjszoaM9Hubz9UeX0MpEpjOOeGlODgumTp9AexbkGGTnMdYu4+dNefQ26po3FFDRm5yEyKHMeYZg2UWqTybPw0Ogr3O4RHGs4LjNAE4iObgafjTVTYxz7DEFrwPA/UeFfBRcj2h+1DrOf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779412; c=relaxed/simple;
	bh=tLCJW0BMBOO9ftyqIGYBQrmFVQQ1pG8xdh4+h2u6Vw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IT5VrA7rfnasEdBQdH+F6mFlkOpZ4T7GKBl5YvrVJS7Ev0U5JInpAQ/q/uFf28d8Yf9AnwGstYZXvPa5IcPUdTfsCmQRdBAJCjLPgIKUCOz66B9MjPYojMfdQR03GU8TUstk+f8Su5D6+vFcE8t6u3TCd9fYdrTuVG/jKzzuNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dY0bbH4H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 61A224E411D3;
	Tue, 26 May 2026 07:10:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B6FA60732;
	Tue, 26 May 2026 07:10:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47F571088837C;
	Tue, 26 May 2026 09:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779779404; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sjEQBOO1EyR0cLJj1QKDelX8CN8+HmKMIJ0PENvy3gY=;
	b=dY0bbH4HjD8ezQZJwdA/VkzXbxcw48znO8YabyPrfMd2eF0WR+yONliT+muxVu7XIrwVtC
	Wi+g8fz6SDn3AEsHg+GXHxtAd7/6e94RuHvWj4BxAEBKsDggwkwCjHKfRZbGhcOeuxPWiB
	PX+NFAgYvX7yv8Y1LY/L/ll3JfcXkiwN6udx4jrL6EBOLMW/i61pztHDDglVHk6AKW8N2N
	44B7YIWgUzrDzTIYoAVMmblRU01msMxcQC5Rs5ETr58GnXF32yRHHUXPet2tFk0WRMs2d7
	Mxk3KkrXwTL2LkHufEj9dKg2/gePt+K2I0eKGEX+nqhjj+e3N4R/Jgnn+xmcrA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 26 May 2026 09:10:00 +0200
Subject: [PATCH] mtd: rawnand: pl353: fix probe resource allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-fix-pl35x-probe-v1-1-3baad4f527f2@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3bTMCt2CHGNTIFmUn5Sqa25oaZyUnJZsnmRhogTUVVCUClQCNjE
 6trYWAL4TWK9hAAAA
X-Change-ID: 20260526-fix-pl35x-probe-7193bcfc7b84
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-254253-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 736F45D18C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During probe(), the devm_ioremap() is called with the parent device
instead of the current one. So when the module is unloaded, the register
area isn't released.

Target the pl35x device in the devm_ioremap() instead of its parent.

Cc: stable@vger.kernel.org
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index f2c65eb7a8d9..06f8f1e14b9c 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -1155,7 +1155,7 @@ static int pl35x_nand_probe(struct platform_device *pdev)
 	nfc->controller.ops = &pl35x_nandc_ops;
 	INIT_LIST_HEAD(&nfc->chips);
 
-	nfc->conf_regs = devm_ioremap_resource(&smc_amba->dev, &smc_amba->res);
+	nfc->conf_regs = devm_ioremap_resource(nfc->dev, &smc_amba->res);
 	if (IS_ERR(nfc->conf_regs))
 		return PTR_ERR(nfc->conf_regs);
 

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260526-fix-pl35x-probe-7193bcfc7b84

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>


