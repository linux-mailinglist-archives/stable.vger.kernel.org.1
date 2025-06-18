Return-Path: <stable+bounces-154644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BAADE60F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECC0189799D
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DF1D86FF;
	Wed, 18 Jun 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Owen+bOr"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7081E25F8
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236494; cv=none; b=ps+TSaKb0rq7KSCT9f0Q69XuoBPQHk3+UyrCB8EHeyBNefoDtpUAvyBfpgYjPv+ISU+oLBhI8c16wFn/JayO99fSOqajsoKCViVyndU5hOnfyS7a8QDLBDCSZONINTBQCjUUQwY54tN6zNYb7Myb6k7DE2pOLVaqhnY2I9xPGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236494; c=relaxed/simple;
	bh=/21KfSGf5kewRZOgx7Pvs00Jp0aZ0SxfWor4+YYwWiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSz+6evCUsl7wi7RIXxmOrqwetclV6bI99whHFKOQzhd1yzkghdPOI6rJNVrzMlv+Prv4HTrOeeuUpOYvqg3Q92aKqlB2+CnsHc+Yc85lEVeu9RaMXBAM5+IYfVBYz2EnysRNKqjjLpWBe8CDU6AISertpM7kIYhX/rqcf0d0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Owen+bOr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD8362044C;
	Wed, 18 Jun 2025 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750236484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6FU6SDX17aNoN9IEiJOQ14OoPG5LsdEowjWPMC4qis=;
	b=Owen+bOr8Ao+naIB9j/EiRrAlULlUhOgUFl6I52R9m0Zv34rM+IqEqiXgpvgwcI768LHaz
	HjBl8GyUeU7FWf0QOI0mcrtQlqlXUIc/ZO4NBcWP/KdKUd/uXhKoGmUsdH47ZwSrZLMtmy
	Ry5W60QztuSAytymv6Hp96Xm+OOBEjKHiKtJSnn/zSpNGP8j9Q2jdgtBHC5nsWUjTABuqI
	IIyRatTUmUrnU9b3kP5ILFEuLdhF9Geg8lXs3ha7CW2qZMzFYuIZYblVXfE37iX5+6cYL+
	G8wOMXtnBdbecO2aGa2HB0H26gZ3j+vCZJ/JuyxxQu7EqSLZ0HqjIH66bwHwaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mtd: spinand: winbond: Fix W35N number of planes/LUN
Date: Wed, 18 Jun 2025 10:47:58 +0200
Message-ID: <20250618084800.1644246-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618084800.1644246-1-miquel.raynal@bootlin.com>
References: <20250618084800.1644246-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueffgeevteevkeegkeehleetteffhffffefgleeuleevjedtgeelgeeutdekgeelnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlseifrghllhgvrdgttgdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgru
 ggvrggurdhorhhgpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

There's been a mistake when extracting the geometry of the W35N02 and
W35N04 chips from the datasheet. There is a single plane, however there
are respectively 2 and 4 LUNs. They are actually referred in the
datasheet as dies (equivalent of target), but as there is no die select
operation and the chips only feature a single configuration register for
the entire chip (instead of one per die), we can reasonably assume we
are talking about LUNs and not dies.

Reported-by: Andreas Dannenberg <dannenberg@ti.com>
Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Fixes: 25e08bf66660 ("mtd: spinand: winbond: Add support for W35N02JW and W35N04JW chips")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 19f8dd4a6370..2808bbd7a16e 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -289,7 +289,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
 	SPINAND_INFO("W35N02JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 2, 1, 1),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
@@ -298,7 +298,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
 	SPINAND_INFO("W35N04JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 4, 1, 1),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
-- 
2.48.1


