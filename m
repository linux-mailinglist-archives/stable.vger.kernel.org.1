Return-Path: <stable+bounces-253725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJZOCHcfEGqjTwYAu9opvQ
	(envelope-from <stable+bounces-253725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:18:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D75B1034
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 212273012877
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEE38423B;
	Fri, 22 May 2026 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UURgC33w"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A233EF
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441476; cv=none; b=kSM369jfZnqhjU5g71zaAiqWzr9zq8OjloIcNKrEx2LE7KmSMVfaV/moOHyMpnF5jft8w8NpTfLhnd47ArLJKLZLqFFD5dGlhpbUgLfICZgK942cDc1Ldye/inF5zI14BQmJiQH4ycGHD7mJOcgjMIWUQBFy+sqmRUlTmTj2kE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441476; c=relaxed/simple;
	bh=/W++ZsBl3CesPboPWMbeRQk2wDpIiu4acfwA0iWwhrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/pFRghkRhOSfRBct8F7ZDFl4B1I0LuSKso53cpwco3Lft84xZLwQTG4SD1s3589sRcVZqAVaNgkkz90mezFrUw3crWeQWnWEUNrottKPIB+abhrAlRorPtZRFzjIjYAZIn+c6kGgHGi5irEHyG5PVoeM34NUvizbbdGdMIm8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UURgC33w; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7D941C2C659;
	Fri, 22 May 2026 09:18:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D57A66003C;
	Fri, 22 May 2026 09:17:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE350107E8CBE;
	Fri, 22 May 2026 11:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779441472; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=FNh9PbUFw0y8n4VZS9elUUNUsx9zmDx7kTYLGF/MKro=;
	b=UURgC33wRCtt1VS8ImlGdysv+4UWxeXOCNYp2bQ0RjApNx3qZFrR27uf6wKSMIE6W9JucL
	ySp7h+tq/Q2YyBiPaEu+dtCyNasbmqtnIle2MdibJFfqWp5pdFPTfQyiYyQaY2QtrKrX1i
	V/hf+mbE5JNVWyfiow424lWsfYMl0NFLICs5RCMLECDjh8LJB0E6UcZzP3F+dhfqvqv0QT
	87Yk5i0AW4IG41VFBOUncoOqyQg45mOgfba7i6ukYI2vm2Jy5Ww5krqMRMbGX731ddMWjW
	xfcG0f7cuzmMOFdWI9LVUBz7EaVnEZsoV/zWaLFn+HXm5AJFBiS7tlXxIuhZiw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrea Scian <andrea.scian@dave.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Pause continuous reads at block boundaries
Date: Fri, 22 May 2026 11:17:39 +0200
Message-ID: <20260522091739.2789664-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253725-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 278D75B1034
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some chips do not support sequential cached reads past block
boundaries, like Winbond. In practice when using UBI, this should very
rarely happen, but let's make sure it never happens.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d6d3e17ab407..cccd5655e638 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1216,32 +1216,32 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
-static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+static unsigned int rawnand_last_page_of_block(unsigned int ppb, unsigned int block)
 {
-	/* lun is expected to be very small */
-	return (lun * pages_per_lun) + pages_per_lun - 1;
+	/* block is expected to be very small */
+	return (block * ppb) + ppb - 1;
 }
 
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int ppl, first_lun, last_lun;
+	unsigned int ppb, first_block, last_block;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / ppl;
-	last_lun = chip->cont_read.last_page / ppl;
+	ppb = memorg->pages_per_eraseblock;
+	first_block = chip->cont_read.first_page / ppb;
+	last_block = chip->cont_read.last_page / ppb;
 
-	/* Prevent sequential cache reads across LUN boundaries */
-	if (first_lun != last_lun)
-		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
+	/* Prevent sequential cache reads across block boundaries */
+	if (first_block != last_block)
+		chip->cont_read.pause_page = rawnand_last_page_of_block(ppb, first_block);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
 
 	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
 		chip->cont_read.first_page++;
 		chip->cont_read.pause_page = min(chip->cont_read.last_page,
-						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+						 rawnand_last_page_of_block(ppb, first_block + 1));
 	}
 
 	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-- 
2.53.0


