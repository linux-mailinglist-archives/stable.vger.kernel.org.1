Return-Path: <stable+bounces-195043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ED6C670AA
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 03:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09B45355E11
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985F30597C;
	Tue, 18 Nov 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aXNfm6i9";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="yeQFfXUI"
X-Original-To: stable@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27726A1AF;
	Tue, 18 Nov 2025 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433423; cv=none; b=kgEBIK9lTH7pP/QWxJOtyIp6H4bi0PV45ATVhOMTPOS6GU78tX1+deYIbxPaLOTUPELJsAG3xlEzQNED958rKuMHH1FnU8veJ/9JFpVNLO0d7bBbU18w2OXaMmR0NEN5D6lnnhIDRQPQKhcKs9raIMhJu4fZhFbRITnIEn63ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433423; c=relaxed/simple;
	bh=ujPW9yg87PcqhgrVlK+bXGSlNI3uLpBnuSRQV2ZuFjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nhs5qmwsUVGUXxH2g/fAlG2d9duljPeJx2etvj24JXO3Rctac1lHou+tnLHpvGB+UJuImn4YKGPy8MfwlsVKAlPrz53QJFYh3LlzYywYUo7cwCG6THVzhhCS9gMtz/wvAM0qSWlL/242YuHihJp5ECTA5DFoZj3SF5xxNrTb8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aXNfm6i9; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=yeQFfXUI; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1763433356; bh=sCKuHgHWUgcOfEQfIFqPn+9
	wVr1eVaiBHZJNU2USNOE=; b=aXNfm6i9a+xNKVRDoAAAnNPv/z/RLlIaA2od6QUldPcFWr8u/d
	tteq5UDfGe7zsSMhN3QOzHamKKRsuMOZaB8Ppusw2l/ug7wqqrOfNG3/HBSJQY1zoVn/txBlF/x
	mUOWUSWhLpK8b9KcrdFZvz8cO/FkOPbyha7XZhQXOzpbeuLLe8YWzAH4nyKlzhCAvvUCOyd5jPi
	Wey7L0RWkUXs9r1tYu07IPKFqZvx1gmAjfZF4ql9MtuoURYrhF2JpncDy6TgvphmhEl+eGITcx8
	3IAmT0fQbfdOfEpt5Tx3ACUvX/de+Rv+0yw1Oo++ltkuRr5r1UEiv9mhy+M6Tz5peig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1763433356; bh=sCKuHgHWUgcOfEQfIFqPn+9
	wVr1eVaiBHZJNU2USNOE=; b=yeQFfXUIHQmZiH13f2XPEaDPnjvXqwOKE2GcVOhfd8dvdoNreA
	Q0SRx0xG+ffvSuFVdXDHgQbkUDYzyuRu2+BQ==;
From: Jens Reidel <adrian@mainlining.org>
Date: Tue, 18 Nov 2025 03:35:25 +0100
Subject: [PATCH] nvmem: apple-spmi-nvmem: wrap regmap calls to satisfy CFI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-apple-spmi-nvmem-cfi-v1-1-75b9ced0a2c2@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtojH7oKtHCbKyBNFGQILp70
 vJbvPdA4iicYKoeiJwlyeULqK7AHNrvjLIVg2pUR0Qj6hBOxhScoM+OHRor2DftYEivdiMFJQ2
 Rrdz/dl7e9wMXpd1MZgAAAA==
X-Change-ID: 20251118-apple-spmi-nvmem-cfi-6037c1abfd12
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Srinivas Kandagatla <srini@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jens Reidel <adrian@mainlining.org>, 
 Clayton Craft <craftyguy@postmarketos.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

The Apple SPMI NVMEM driver previously cast regmap_bulk_read/write to
void * when assigning them to nvmem_config's reg_read/reg_write
function pointers.

This cast breaks the expected function signature of nvmem_reg_read_t
and nvmem_reg_write_t. With CFI enabled, indirect calls through
these pointers fail:

  CFI failure at nvmem_reg_write+0x194/0x1e4 (target: regmap_bulk_write+0x0/0x2c8; expected type: 0x83a189c3)
  ...
  Call trace:
   nvmem_reg_write+0x194/0x1e4 (P)
   __nvmem_cell_entry_write+0x298/0x2e8
   nvmem_cell_write+0x24/0x34
   macsmc_reboot_probe+0x1dc/0x454 [macsmc_reboot]
  ...

Introduce thin wrapper functions with the correct nvmem function
pointer types to satisfy the CFI checks.

Fixes: fe91c24a551c ("nvmem: Add apple-spmi-nvmem driver")
Signed-off-by: Jens Reidel <adrian@mainlining.org>
Reported-by: Clayton Craft <craftyguy@postmarketos.org>
Tested-by: Clayton Craft <craftyguy@postmarketos.org>
Cc: stable@vger.kernel.org
---
 drivers/nvmem/apple-spmi-nvmem.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/apple-spmi-nvmem.c b/drivers/nvmem/apple-spmi-nvmem.c
index 88614005d5ce1dc2d1cafcb89ac66d8376ffcc96..7acb0c07d6abe9e9984908f5ea2f4e2e9c10bb06 100644
--- a/drivers/nvmem/apple-spmi-nvmem.c
+++ b/drivers/nvmem/apple-spmi-nvmem.c
@@ -18,6 +18,22 @@ static const struct regmap_config apple_spmi_regmap_config = {
 	.max_register	= 0xffff,
 };
 
+static int apple_spmi_nvmem_read(void *priv, unsigned int offset, void *val,
+				 size_t bytes)
+{
+	struct regmap *map = priv;
+
+	return regmap_bulk_read(map, offset, val, bytes);
+}
+
+static int apple_spmi_nvmem_write(void *priv, unsigned int offset, void *val,
+				  size_t bytes)
+{
+	struct regmap *map = priv;
+
+	return regmap_bulk_write(map, offset, val, bytes);
+}
+
 static int apple_spmi_nvmem_probe(struct spmi_device *sdev)
 {
 	struct regmap *regmap;
@@ -28,8 +44,8 @@ static int apple_spmi_nvmem_probe(struct spmi_device *sdev)
 		.word_size = 1,
 		.stride = 1,
 		.size = 0xffff,
-		.reg_read = (void *)regmap_bulk_read,
-		.reg_write = (void *)regmap_bulk_write,
+		.reg_read = apple_spmi_nvmem_read,
+		.reg_write = apple_spmi_nvmem_write,
 	};
 
 	regmap = devm_regmap_init_spmi_ext(sdev, &apple_spmi_regmap_config);

---
base-commit: 0c1c7a6a83feaf2cf182c52983ffe330ffb50280
change-id: 20251118-apple-spmi-nvmem-cfi-6037c1abfd12

Best regards,
-- 
Jens Reidel <adrian@mainlining.org>


