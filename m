Return-Path: <stable+bounces-225801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFvzK+4quWmVtQEAu9opvQ
	(envelope-from <stable+bounces-225801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:20:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2D2A7BF0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 033DB3072A46
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904143A5424;
	Tue, 17 Mar 2026 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fkCP15LE"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113E3A5E76
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742737; cv=none; b=a4I4zhX7QD/6rvVzNdMud7srEEQqQDgTfTDGkjHT4G7GDyKf0yu1YMkAbr7SGyw4IcC9n/A4s6zem9FZFzCDGEprk/QrTUqXxq/CaT2fI3BTlhSw5K8qctaYfmFAdIdxz7CRthJ6/BEhKCyLTkKBNrK0uPCZ0149XQZouB20Yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742737; c=relaxed/simple;
	bh=O1KwwbQkeH+m9sbzmbA7ooBcgtVHpXC4vbD2iXTWTjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKMgZIZd0LnVBq4gzuKAP1g/abhzi/2ZCM2ocnb69jQs/6Tz/F4GufxdLTjqrSwvWXaDaL3N/2oQeCqPb1BB4m+7wMMzcLwgYvLXn+xLclWR7/e95NNRWH4G5EjiEEg84DdMBORi2GCIUCxVoBmFTT+Hap0mdoprY9w+c+9q5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fkCP15LE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DDD6F1A2DE6;
	Tue, 17 Mar 2026 10:18:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8A095FC9A;
	Tue, 17 Mar 2026 10:18:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2620104503AE;
	Tue, 17 Mar 2026 11:18:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742732; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=4431+403VgIMOFb1WnJXNwOIWwdeLzJGBbwjHIdj18M=;
	b=fkCP15LEhQo8MK56RIRXFqlDzhkbVTelzf1BlfscgR4iwwc5mdRvPbItLYg9/oUJF7it5a
	H8JeGJMpAdgida0koLDGy3aoxq1hRyJ0msVJ17Xap7ZutsO8ayh2+q/vVyj/wm2hcleW0D
	Uf4ZrFNso1jSQA6/BjmQqMH8H+fl/GdpDAj+CQfVqKd3o3f5OWrlJT0n9mTisQptEOnfJw
	OIboTUBBoHwV4VzXjrmn/RmzHz7DTut4kavbgBM5ZjH7KJKMihAxGLaHhWf9yp53HwIt/E
	mcWAVqpqHl/Ea/rn5h/BEaK5xr3mAje7IYC5eWSyPp2jfoml0Zjps61oW/WGgw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>
Subject: [PATCH v2] mtd: spi-nor: Fix RDCR controller capability core check
Date: Tue, 17 Mar 2026 11:18:42 +0100
Message-ID: <20260317101842.319656-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.51.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225801-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infineon.com:email]
X-Rspamd-Queue-Id: 2AB2D2A7BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 5008c3ec3f89 ("mtd: spi-nor: core: Check read CR support") adds a
controller check to make sure the core will not use CR reads on
controllers not supporting them. The approach is valid but the fix is
incorrect. Unfortunately, the author could not catch it, because the
expected behavior was met. The patch indeed drops the RDCR capability,
but it does it for all controllers!

The issue comes from the use of spi_nor_spimem_check_op() which is an
internal helper dedicated to check read/write operations only, despite
its generic name.

This helper looks for the biggest number of address bytes that can be
used for a page operation and tries 4 then 3. It then calls the usual
spi-mem helpers to do the checks. These will always fail because there
is now an inconsistency: the address cycles are forced to 4 (then 3)
bytes, but the bus width during the address cycles rightfully remains
0. There is a non-zero address length but a zero address bus width,
which is an invalid combination.

The correct check in this case is to directly call spi_mem_supports_op()
which doesn't messes up with the operation content.

Fixes: 5008c3ec3f89 ("mtd: spi-nor: core: Check read CR support")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Acked-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
Changes in v2:
* Add precisions about how it fails.
* Collect tags.
* Mention reads/writes instead of page reads/page writes.
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8ffeb41c3e08..13201908a69f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2466,7 +2466,7 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
-		if (spi_nor_spimem_check_op(nor, &op))
+		if (!spi_mem_supports_op(nor->spimem, &op))
 			nor->flags |= SNOR_F_NO_READ_CR;
 	}
 }
-- 
2.51.1


