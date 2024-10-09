Return-Path: <stable+bounces-83203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45139996AC6
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5D5B25635
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E9191F7F;
	Wed,  9 Oct 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hiNCMZYq"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E1194C86
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478209; cv=none; b=rM2x+AyhsmsKkNkPyX6Y7TRxRysmx0dW6ruUeUpMpB7azGev1W8bYGooSk3e3IUtE1lC36TlGoQetAsTwq6FBdv1hmjvwfw3WIhTe+tMEcM7KhsApUHya6pn4UzYjv5DA+eRpLl1zfsy4cJL7LYw24HbJmhGx3eDjr+8i6JGQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478209; c=relaxed/simple;
	bh=RQPLf82AyyDEmovHDKcyZCdomr0WEGTOh9r3PJXRo0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfSfsCo84wJvdHTgSc6gvufHZIrJWud6CbZwXLYoF7aGhlY3BVq0aoXkLGXwkIXQjcpLEcopEL6jLprHh1y5HxVmAowbx/szAlEwJh+qXuysAMi1locg0uGrsO/hzC1roKwnL0L1sgJxDcQUeA09/Tn7ZLUDy0Z1Rs8HnM4zAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hiNCMZYq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 199251C000A;
	Wed,  9 Oct 2024 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728478204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mium5UPs3hxCmP4znQTZCQCZtM1o02IGqGj2nlYd6Jc=;
	b=hiNCMZYqjK/QBIsaBqW7CeKhdmhFWf6T2nvNad+5O+OXWntyZSy+EvnR+3CVDrZ8cr6CkC
	LoHrpggFA8lpE632Jjdc+ZN0iUbasTLLUri/ji0eMX2J9J/E5O93F5tCEosEFNw02V3leU
	B4NA+hfreuFgoX+pza2myDpOOVnjxCYpzo3sKi50NnUvA+C+KjVLZHs33ELyBlbjVfntZ6
	Ir9IEtRsNGMk9sZf3y2GqnUBCvB9cLjvHiys5cvlAGgcuGOmY3MXp0+D1+/udowcsWV7lx
	tEeoTmu7LEoe+PX2vWGEmk08V9SJF2L/b7VfMffK/dgyr/Anbh2DrEVQ7w9TCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] mtd: spi-nand: winbond: Fix 512GW and 02JW OOB layout
Date: Wed,  9 Oct 2024 14:49:59 +0200
Message-ID: <20241009125002.191109-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009125002.191109-1-miquel.raynal@bootlin.com>
References: <20241009125002.191109-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Both W25N512GW and W25N02JW chips have 64 bytes of OOB and thus cannot
use the layout for 128 bytes OOB. Reference the correct layout instead.

Fixes: 6a804fb72de5 ("mtd: spinand: winbond: add support for serial NAND flash")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 6b520b68407e..4e765cec0a3b 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -189,7 +189,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
 	SPINAND_INFO("W25N512GW",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
 		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
@@ -198,7 +198,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
 	SPINAND_INFO("W25N02KWZEIR",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.43.0


