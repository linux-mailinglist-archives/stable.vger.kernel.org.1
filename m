Return-Path: <stable+bounces-192532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0CC371D1
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6FF250053D
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01501337B96;
	Wed,  5 Nov 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sowDF5Kj"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A09332EDF
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363650; cv=none; b=a34/xTcMT05Kw04klhlk68cibOJ6DauZYBCi/w8UN4HivJBQT016xBREOOKMpNyE7n55w4e9Vsn6ppgAnOivjhpVev5+WfBu5KVS5iyOQsJBsXu+F61+QYhMZnhoSRGO8s5po4eHC2HWY0y/Eewec0CgZ++fkKDZwyRAB+qVmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363650; c=relaxed/simple;
	bh=PDHeyhSFkN1NE5+EzQZsoHUN6DwdZBzqYeRRH3/Hpe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DV9FrBcCEEF9Do6sJxa8JoaI1XOMpDKX5ywdgFbjTKnLzSLCH7E2Td5YUZh5w7X8GntT+EAeypmaqeZQTDsQScxGzfJhDMHTRv0B3hH5M3uECOGWoRp6s/kHjK31bQcQA1+HuVkwoznEcg0fJcr8DM3vIgcDgDLTCOxGAhyZdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sowDF5Kj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7F219C0E63B;
	Wed,  5 Nov 2025 17:27:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7CA1160693;
	Wed,  5 Nov 2025 17:27:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC08310B5046E;
	Wed,  5 Nov 2025 18:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762363645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hE30IJHBPucIqGUOi/BeIDKqU3CP+dx4/YEUzSuHQ7I=;
	b=sowDF5KjSpJ7lYzwvGGw8b3wrOelf21WJzudwb519RJJhdkU8bh+zuy20ZW8SdTLZnx5s1
	r86FO7gqQwf+vF6xG5NhdJ5zkXvi/nCBeXaZl+VvCaXyKStPdF2zKDefnus2L+a9zU0CCP
	maMb+5v6+c3mAp3exncq6gR5q6D1MsCzIno7G8Yg8Y9RcX+1Lp8dDUpceZ8Ifp4n4gFObD
	Arb07iphhTEBOG+HNKvI6l7cxfdRtQ0lvzCNW/EDWWdbGpI4bX1bD/3LrPFfosCuZ2/ggA
	z8YeZBMTC9eiLolm9MeBFJgQlv25rsIwiyAQO5H7AIxS8ALLVq//VapuNwlAeA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 05 Nov 2025 18:27:00 +0100
Subject: [PATCH 1/6] mtd: spi-nor: winbond: Add support for W25Q01NWxxIQ
 chips
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-winbond-v6-18-rc1-spi-nor-v1-1-42cc9fb46e1b@bootlin.com>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This chip must be described as none of the block protection information
are discoverable. This chip supports 4 bits plus the top/bottom
addressing capability to identify the protected blocks.

Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
cat: can't open '/sys/bus/spi/devices/spi0.0/spi-nor/partname': No
such file or directory
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
ef6021
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
winbond
$ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060101ff00060110800000ff84000102d00000ffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffe520fbffffffff3f44eb086b083b42bbfeffffffffff
0000ffff40eb0c200f5210d800003652b50082ea14e2e96376337a757a75
f7bdd55c19f75dffe970f9a5ffffffffffffffffffffffffffffffffff0a
f0ff21ffdcff
$ sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
d70b64bfa72dad202ff6881f92676b3a79b1e634b60653cd15f1820b7f3acaea
/sys/bus/spi     /devices/spi0.0/spi-nor/sfdp
$ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode	0x13
  mode cycles	0
  dummy cycles	0
 1S-1S-2S
  opcode	0x3c
  mode cycles	0
  dummy cycles	8
 1S-2S-2S
  opcode	0xbc
  mode cycles	2
  dummy cycles	2
 1S-1S-4S
  opcode	0x6c
  mode cycles	0
  dummy cycles	8
 1S-4S-4S
  opcode	0xec
  mode cycles	2
  dummy cycles	4
 4S-4S-4S
  opcode	0xec
  mode cycles	2
  dummy cycles	0

Supported page program modes by the flash
 1S-1S-1S
  opcode	0x12
 1S-1S-4S
  opcode	0x34
$ cat /sys/kernel/debug/spi-nor/spi0.0/params

name		(null)
id		ef 60 21 00 00 00
size		128 MiB
write size	1
page size	256
address nbytes	4
flags		HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_16BIT_SR | HAS_SR_TB_BIT6 | HAS_4BIT_BP | SOFT_RESET | NO_WP

opcodes
 read		0xec
  dummy cycles	6
 erase		0xdc
 program	0x34
 8D extension	none

protocols
 read		1S-4S-4S
 write		1S-1S-4S
 register	1S-1S-1S

erase commands
 21 (4.00 KiB) [1]
 dc (64.0 KiB) [3]
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | overlaid
 ------------------+------------+---------
 00000000-07ffffff |     [   3] | no
$ dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
$ sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
$ mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
743a6228f6b523c54ee6670aac049b28b5ba5b70341815d50e5cb5a21d59cb8b  spi_read
743a6228f6b523c54ee6670aac049b28b5ba5b70341815d50e5cb5a21d59cb8b  spi_test
$ mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
$ mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
$ sha256sum spi*
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
743a6228f6b523c54ee6670aac049b28b5ba5b70341815d50e5cb5a21d59cb8b  spi_test
$ mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 65536 (64K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0
---
 drivers/mtd/spi-nor/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 63a93c9eb9174b073e19c41eeada33b23a99b184..a13a1201eae92233091dde644d590baa57e97046 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -343,6 +343,10 @@ static const struct flash_info winbond_nor_parts[] = {
 		.id = SNOR_ID(0xef, 0x80, 0x20),
 		.name = "w25q512nwm",
 		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
+	}, {
+		/* W25Q01NWxxIQ */
+		.id = SNOR_ID(0xef, 0x60, 0x21),
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6 | SPI_NOR_4BIT_BP,
 	},
 };
 

-- 
2.51.0


