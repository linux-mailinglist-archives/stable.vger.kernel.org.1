Return-Path: <stable+bounces-45300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8D8C77F2
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9781C21608
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE0147C62;
	Thu, 16 May 2024 13:52:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D46145B3D
	for <stable@vger.kernel.org>; Thu, 16 May 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867536; cv=none; b=rTL8fZhOpWsW8KG9BgErPuLKgl5ha5Wh8ed8CcVr301OQJr617R7o/xWwFAN48a8E2Dy7oir6TZSbT9xU0K5VLDm4Swd12ca032HtGbP8bF+YJhXNobxuT95VgFOu5hNt4gzXC+TaO4QBMKeIvUIaPZ4D8oU/rNVHpiJ/yM2/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867536; c=relaxed/simple;
	bh=0+4+JxKcsmwKqHvF8AMX4KdtrZ2IByJ5MV7mmULdq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILVaXzxK47Fd/53oNOAHqk/JZqYM6srKKpoee3xNm1ewAmG2dEZGVSbg4qomPWvHE9YoMJDP1f2KYiWqoFdjUPWx4q9gpY6d69CmPs+YmMXWnUdsSdAY4NnTuUUz5aCbhfNYvqTpVmaAGRtu216ASTOhbNfeE7umR33IEo+7P1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s7bWR-0000gt-PM; Thu, 16 May 2024 15:51:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s7bWP-001iuT-RM; Thu, 16 May 2024 15:51:49 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s7bWP-00EtSv-2Q;
	Thu, 16 May 2024 15:51:49 +0200
Date: Thu, 16 May 2024 15:51:49 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Alexander Dahl <ada@thorsis.com>,
	Steven Seeger <steven.seeger@flightsystems.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: rawnand: Bypass a couple of sanity checks
 during NAND identification
Message-ID: <ZkYPdbspX5tc0WRf@pengutronix.de>
References: <20240516131320.579822-1-miquel.raynal@bootlin.com>
 <20240516131320.579822-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516131320.579822-3-miquel.raynal@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Thu, May 16, 2024 at 03:13:20PM +0200, Miquel Raynal wrote:
> Early during NAND identification, mtd_info fields have not yet been
> initialized (namely, writesize and oobsize) and thus cannot be used for
> sanity checks yet. Of course if there is a misuse of
> nand_change_read_column_op() so early we won't be warned, but there is
> anyway no actual check to perform at this stage as we do not yet know
> the NAND geometry.
> 
> So, if the fields are empty, especially mtd->writesize which is *always*
> set quite rapidly after identification, let's skip the sanity checks.
> 
> nand_change_read_column_op() is subject to be used early for ONFI/JEDEC
> identification in the very unlikely case of:
> - bitflips appearing in the parameter page,
> - the controller driver not supporting simple DATA_IN cycles.
> 
> As nand_change_read_column_op() uses nand_fill_column_cycles() the logic
> explaind above also applies in this secondary helper.
> 
> Fixes: c27842e7e11f ("mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers")
> Fixes: daca31765e8b ("mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers")
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Closes: https://lore.kernel.org/linux-mtd/20240306-shaky-bunion-d28b65ea97d7@thorsis.com/
> Reported-by: Steven Seeger <steven.seeger@flightsystems.net>
> Closes: https://lore.kernel.org/linux-mtd/DM6PR05MB4506554457CF95191A670BDEF7062@DM6PR05MB4506.namprd05.prod.outlook.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

With the attached debug patch applied I can confirm that I can now read
all three ONFI parameter pages successfully using
nand_change_read_column_op(), so:

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-----------------------------------8<--------------------------------------

diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index 861975e44b552..ca6b4bf426750 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -180,6 +180,9 @@ int nand_onfi_detect(struct nand_chip *chip)
 			ret = nand_change_read_column_op(chip, sizeof(*pbuf) * i,
 							 &pbuf[i], sizeof(*pbuf),
 							 true);
+
+		print_hex_dump(KERN_INFO, "onfi: ", DUMP_PREFIX_OFFSET, 16, 1, &pbuf[i], sizeof(*pbuf), true);
+
 		if (ret) {
 			ret = 0;
 			goto free_onfi_param_page;
@@ -188,7 +191,6 @@ int nand_onfi_detect(struct nand_chip *chip)
 		crc = onfi_crc16(ONFI_CRC_BASE, (u8 *)&pbuf[i], 254);
 		if (crc == le16_to_cpu(pbuf[i].crc)) {
 			p = &pbuf[i];
-			break;
 		}
 	}
 
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

