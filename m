Return-Path: <stable+bounces-6816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131181483F
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBCB23031
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54822C6B3;
	Fri, 15 Dec 2023 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SozWTb0z"
X-Original-To: stable@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C62C6AA
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7856EC28A6
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 12:32:23 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2544F1BF20C;
	Fri, 15 Dec 2023 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702643536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4wAJjOtMwRJpleuVu6zvruceyKn7/iAuSicntgwqL4=;
	b=SozWTb0zPOyITokCNrYUhEqkuAOWhyRd8yoa9k+bdyShhtziyY6q3Y++LT6RJazuDtc4SW
	/1unSj7r6mTQl1qxq/EApqiRS9r/WqCy2DpWmUWXOlZxXuigwIK0NjaiuI1SOAiGGCpw+I
	dQP2Zfn59eTs8JLb99GV1s+6lw+9/DUPiGVlpJkA2JnIGDslkV1kCIgtk+RGC2ZTJ+JnXW
	Wkgugdd+ZNhgp6tDdBnc/5qgi05S095bP1WjMAT/wvPck8XwkWbzZJbTKgA1vOhM6jwnqX
	O4CQTkAlqXPJAZtnRKnaLC6OjvoCLT9qtoAs5zQjpmiIBChDSfTMBsxqpMaFUA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Julien Su <juliensu@mxic.com.tw>,
	Jaime Liao <jaimeliao@mxic.com.tw>,
	Jaime Liao <jaimeliao.tw@gmail.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	eagle.alexander923@gmail.com,
	mans@mansr.com,
	martin@geanix.com,
	=?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mtd: rawnand: Fix core interference with sequential reads
Date: Fri, 15 Dec 2023 13:32:06 +0100
Message-Id: <20231215123208.516590-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215123208.516590-1-miquel.raynal@bootlin.com>
References: <20231215123208.516590-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

A couple of reports pointed at some strange failures happening a bit
randomly since the introduction of sequential page reads support. After
investigation it turned out the most likely reason for these issues was
the fact that sometimes a (longer) read might happen, starting at the
same page that was read previously. This is optimized by the raw NAND
core, by not sending the READ_PAGE command to the NAND device and just
reading out the data in a local cache. When this page is also flagged as
being the starting point for a sequential read, it means the page right
next will be accessed without the right instructions. The NAND chip will
be confused and will not output correct data. In order to avoid such
situation from happening anymore, we can however handle this case with a
bit of additional logic, to postpone the initialization of the read
sequence by one page.

Reported-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Closes: https://lore.kernel.org/linux-mtd/CAP1tNvS=NVAm-vfvYWbc3k9Cx9YxMc2uZZkmXk8h1NhGX877Zg@mail.gmail.com/
Reported-by: Måns Rullgård <mans@mansr.com>
Closes: https://lore.kernel.org/linux-mtd/yw1xfs6j4k6q.fsf@mansr.com/
Reported-by: Martin Hundebøll <martin@geanix.com>
Closes: https://lore.kernel.org/linux-mtd/9d0c42fcde79bfedfe5b05d6a4e9fdef71d3dd52.camel@geanix.com/
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 04e80ace4182..1b0a984d181d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3478,6 +3478,18 @@ static void rawnand_enable_cont_reads(struct nand_chip *chip, unsigned int page,
 	rawnand_cap_cont_reads(chip);
 }
 
+static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned int page)
+{
+	if (!chip->cont_read.ongoing || page != chip->cont_read.first_page)
+		return;
+
+	chip->cont_read.first_page++;
+	if (chip->cont_read.first_page == chip->cont_read.pause_page)
+		chip->cont_read.first_page++;
+	if (chip->cont_read.first_page >= chip->cont_read.last_page)
+		chip->cont_read.ongoing = false;
+}
+
 /**
  * nand_setup_read_retry - [INTERN] Set the READ RETRY mode
  * @chip: NAND chip object
@@ -3652,6 +3664,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 			buf += bytes;
 			max_bitflips = max_t(unsigned int, max_bitflips,
 					     chip->pagecache.bitflips);
+
+			rawnand_cont_read_skip_first_page(chip, page);
 		}
 
 		readlen -= bytes;
-- 
2.34.1


