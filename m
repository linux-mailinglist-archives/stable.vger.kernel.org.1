Return-Path: <stable+bounces-89060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C19B2F1F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6B51F22315
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904C1D88CA;
	Mon, 28 Oct 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLyrIzyp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180E1D7999
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115878; cv=none; b=nZBK6yQl/Wr1MS4eh2Up7kEMVvxhGS+VvfB12G4bdxVmgzDy8eGpEdW9lLehG3c1MhVPom1KeNIkkQQnObrES/f7VrIm8qe7U7Ff3W8IWtJbs72K+ZQuXVqKnoWeI2rtzGuWJOLG1HX6A4f7sbCq9kv310kiEdB9xj3tLMHNWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115878; c=relaxed/simple;
	bh=PlunfiWnVSxl9X+cvfoMI7q94EgaxAbb/+hsp7rLFbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DynAQA8HVBuYx7XH7Ydn8cTP4uMtkdvXbrACwkTUtUzEFKJ6Y8da+JBzrV1BhRHIpslxPokAe6HFTg7L/RtOrGYpnKWID2dsmha5LXLm0MCX4A0gFr3nRgRtz6jB4GXWP+I7CFbxzjl4UyktKWG1S/flzWk4+NbJAJlFcQzc29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nLyrIzyp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb443746b8so38479871fa.0
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115874; x=1730720674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnj7zGJsDpoJP16432EF6s8lqntq/KJugJDG+wut7TU=;
        b=nLyrIzyp7f13etwQQcbt9JtvJ03e6M93GQ7EeDsg47E3d8eyeWYvzZZK1ARg1to7Gx
         8cURdynqupb0rHPLtGMuzXid1JmfQQKayqiBoyNB+ceNBFCPx/IHWb3fEjbtv81LlIYJ
         MQ5jJXKBttgCWlwR3r7Hj6NQVHWGF1tfT750bkchAk0gSfYItWBEkPziQCQTiCTXB45c
         zkDgmSotX3uDcTuaXI/DI70pLjhqifUg9ZrR3V6Zsy64mMRxwhdprM7jcSj6A3e20wxY
         1H3bX5WHYxNZhP7RpgKGhLLua/e64jqKFGt5StlI9ItNfWuH5ZsYhvpn8e3vQxALDvOy
         +xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115874; x=1730720674;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnj7zGJsDpoJP16432EF6s8lqntq/KJugJDG+wut7TU=;
        b=USugyZaVtOIkosa+01uwBRTN/KO3sNu2ABg/wNBSfuThw1AIsxX4v0O6rI6dDJK3ZH
         qqn87Bbh0vZdxAVWnoYTMdJduuGjj0c9ictFBk2bMjTtzv1LpohGRZ+e9fHR0OVcgW1G
         iM9+1kNS8tAHugeXnRIwk71r2aZkivzV08FOUh6Lfs0/oDyo68XSeh8JGdFH9AXOZj7/
         bu7ir7IfuLpLbgrcnchRG8oKeGHe92vH1K2ZNy3fz4X5LGcCXxdo2lcK9McWXWeZ+051
         LBvyn+ndiU31poV4R47lJTzq2wpeOJh0+lGMdcCxAoWQAXivF/sJkCaUR7QqCzZatFIf
         ohNA==
X-Forwarded-Encrypted: i=1; AJvYcCVXt3S3wemnNek7HkAojVqilKVUCz0Uz6qYO3hDbPmedAqZWLpUZinlzZO+Fcb51RDMfmr2y/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdYlYjCnnh4MAV31/bEOZapdDxXKfdqBPO2bsur2fVfeQ0vEq
	g3HwXwiPRM5yUHjQRPqulCrXYKrgGO+VUZV8n4bCB84CmZ5d9iDHbLsLP70hHdA=
X-Google-Smtp-Source: AGHT+IGQP3BSS8j6DEDJ8y3jyanPjKickEnLzWOUS1sJwqVv/hc9MXkihSN+YM6VWtDdk84NFIDivw==
X-Received: by 2002:a2e:381a:0:b0:2fb:3c16:a44a with SMTP id 38308e7fff4ca-2fcbdfd85b8mr25857831fa.19.1730115874245;
        Mon, 28 Oct 2024 04:44:34 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb461846bsm11351941fa.137.2024.10.28.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:44:33 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 12:44:25 +0100
Subject: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-v6-6-v1-1-991446d71bb7@linaro.org>
X-B4-Tracking: v=1; b=H4sIABh5H2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNz3TIzXTNd89QUA9PUxOTkJCMjJaDSgqLUtMwKsDHRsbW1ABqiIP9
 WAAAA
To: Russell Senior <russell@personaltelco.net>, stable@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>, Hartmut Birr <e9hack@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>
X-Mailer: b4 0.14.0

From: Michael Walle <mwalle@kernel.org>

Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
removed the flags for non-SFDP devices. It was assumed that it wasn't in
use anymore. This wasn't true. Add the no_sfdp_flags as well as the size
again.

We add the additional flags for dual and quad read because they have
been reported to work properly by Hartmut using both older and newer
versions of this flash, the similar flashes with 64Mbit and 256Mbit
already have these flags and because it will (luckily) trigger our
legacy SFDP parsing, so newer versions with SFDP support will still get
the parameters from the SFDP tables.

This was applied to mainline as
commit e49b2731c396 ("mtd: spi-nor: winbond: fix w25q128 regression")
however the code has changed a lot after v6.6 so the patch did
not apply to v6.6 or v6.1 which still has the problem.

This patch fixes the issue in the way of the old API and has
been tested on hardware. Please apply it for v6.1 and v6.6.

Reported-by: Hartmut Birr <e9hack@gmail.com>
Closes: https://lore.kernel.org/r/CALxbwRo_-9CaJmt7r7ELgu+vOcgk=xZcGHobnKf=oT2=u4d4aA@mail.gmail.com/
Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Esben Haabendal <esben@geanix.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20240621120929.2670185-1-mwalle@kernel.org
[Backported to v6.6 - vastly different due to upstream changes]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This fix backported to stable v6.6 and v6.1 after reports
from OpenWrt users:
https://github.com/openwrt/openwrt/issues/16796
---
 drivers/mtd/spi-nor/winbond.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index cd99c9a1c568..95dd28b9bf14 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -120,9 +120,10 @@ static const struct flash_info winbond_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 0, 0)
-		PARSE_SFDP
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &w25q256_fixups },

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20241027-v6-6-7ed05eaccb22

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


