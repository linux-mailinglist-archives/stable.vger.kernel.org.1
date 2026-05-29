Return-Path: <stable+bounces-256654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICcrLiG/GWoqywgAu9opvQ
	(envelope-from <stable+bounces-256654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:30:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E36059F5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEC83004F23
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43803E5EF6;
	Fri, 29 May 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q1oBqM7R"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA603C1F51;
	Fri, 29 May 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072219; cv=none; b=LYyC3Vfc4xmPRk6c3IDCLKQW1FkZKcUT6q50m6WV74l8iYs2EuYL/ZNPv5Po+qYCDoPK3xQpNiF+CU1LUFWmUvF/yuklLlN6USE2CEz1UVgfTwmjdcpmsDnUqOq9Z4AZvg35JoY9PI4EzGfGEQrwzU0tDKynk6O2tthc1QrgbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072219; c=relaxed/simple;
	bh=hRYfS/xuIXS19UiGCTT9NEYcZcMQH0Ss29BpG/c9hHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bij8VTtGeXCFr1nHjyub48vFss2s63T/nTiU/2Zn5WLr+Z3E2NQSYb4nFwDtikdA5kXUO0eBDBvuaBTRcsZbymWMUy0UepreQOeSpLHxS1/1HeBgR9YP+DYaFbhMLLt7JGfpNt+L2bp4O2k9cC05LlvIRaCpmFCFKvdRh9HTJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q1oBqM7R; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 77F2C4E42D90;
	Fri, 29 May 2026 16:30:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CC5C601FA;
	Fri, 29 May 2026 16:30:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 039FF10888CBC;
	Fri, 29 May 2026 18:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780072214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=A921mLH0JqRfFm/ItjWBfzjKFogCJh8RaPYNqPJ3KdE=;
	b=Q1oBqM7Rhkv91vloUok38+YF8d02P+qKEvQ2hobw5b5GnwD1QpJ3q5rGieDD67WECxSJxJ
	PqjLMHDAaNAgkPkJkUReajlQxgaG0phVN/jwiz+x2p2XndkfSpKQg5vtt9q1Db+htqGDzp
	DVbUH6aHU3BzzURNMPx2MrU1SCIbCpnKKEVuf0kRh2JBMEt35RzjwoyF0sLD3YbNomTI33
	D9VlPIswse515pcVdTDLoWdTclBmIfztiDCOequEe+d2xqhScbkzZR2znotB3hf1NDw8dN
	GhHNkpsDrEbCpN3D9Ng4W5X7ElgccmWFsZtYOE4jfEMNPwB2L4BgS57udK/VdQ==
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Subject: [PATCH 0/3] mtd: rawnand: pl353: Fixes and software ECC support
Date: Fri, 29 May 2026 18:29:55 +0200
Message-Id: <20260529-dave-upstream-nand-fixes-v1-0-8c72aa23aee2@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqDMBBG4avIrDsQI0bwKuJiMH/bWTRKxkoh5
 O4NLj8er5AhK4zmrlDGpaZ7augfHW1vSS+wxmbyzgc3es9RLvD3sDNDPpwkRX7qD8ajSIi9C5i
 2gdp+ZNyh3cta6x/s1qhIagAAAA==
X-Change-ID: 20260522-dave-upstream-nand-fixes-5aa6d106e7c3
To: Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrea Scian <andrea.scian@dave.eu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Olivier Sobrie <olivier@sobrie.be>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-256654-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 561E36059F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following the previous reports from Andrea, here are a couple of fixes,
making sure the software ECC support works flawlessly and is compatible
with U-Boot.

Link: https://lore.kernel.org/linux-mtd/MI2P293MB02644DC5515E56A2539C65739765A@MI2P293MB0264.ITAP293.PROD.OUTLOOK.COM/

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (DAVE) (3):
      mtd: rawnand: pl353: Update timings at the right moment
      mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
      mtd: rawnand: pl353: Fix debug prints

 drivers/mtd/nand/raw/pl35x-nand-controller.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)
---
base-commit: 4691d2a70b587e94717820d96a5b55f2b10942b9
change-id: 20260522-dave-upstream-nand-fixes-5aa6d106e7c3

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


