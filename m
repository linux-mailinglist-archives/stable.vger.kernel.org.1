Return-Path: <stable+bounces-89178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EB9B4653
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11B41C22328
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28F1DFD98;
	Tue, 29 Oct 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrYtOJnE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB7187FE0
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196112; cv=none; b=FpBYuN0xG6x4azeIdCt8v6hW8AkbQoNlQmjEB5DLv3334PHpkyF66W2Z1OM8OYBEV8hUKXiUOtllG2clsfFF1M5acgy1mBTM29CrXfDAv879u0qtGh4yTRPLOC2QBK9ipT8W2Z1o02ieCO0CscW1tqAfnVaQA6Qs+WrnjDEkgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196112; c=relaxed/simple;
	bh=xvQc6uLCr3VyeB4JwHFCfkh+OCYdzGL7ijyxLADW9kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JpAyG5h2CB5xcdjAHWmP1ewlPPOrkIoAq8MGT1I1ymLtk+phfBSp340iOIMUnlsIsyMrF3xudu5r6GigH8LQV7Pqq5i+AQERkZYpXdF9OP5ruvc4eb9PtiD62ZWgT0jy0lvV6xIuDOBebV+deSowEBF/jRN5lQP0MlTn8xlhoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hrYtOJnE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5575999e87.1
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730196108; x=1730800908; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sShaPG3xdYqZx8NS21Tx4E2WgPspFpeskiL3iQyAN2k=;
        b=hrYtOJnEQAJr7iMwJg42kt16yDbjwLpi2ts5XZXWE2HrfM+88PQrmEI80IhHJYdd+f
         4TaslwvTwzrZdNCHstgkinppTUt/vzqFMmaLdufaPN44srdo/yKXYmGsgd2htGkDUMso
         aTPm/KlLP5CNI3AW90WrUJv+ePm+v5Cqal9o0ZKvPvBTdKLhO/FpEEx6vbIPIILqBH1g
         EVrBah5M5loivQnQ8fDOl3Q7LzQjgOhFsHGf2XzCddwShK7L5fY4y1Dun18WWupiYgMb
         jhnh315MLo5p3FVZ6jdaosvTVj6hfTqSMgYj2efh9R+w/sUATwLIWm8mWuqypss1WmoD
         vh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730196108; x=1730800908;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sShaPG3xdYqZx8NS21Tx4E2WgPspFpeskiL3iQyAN2k=;
        b=AtHUzhnYcZXbgkMuI9UOnfUJz8BuYM//8549Dx9LOPJKaDkt+YF7Ww5G5EmOyR0a26
         VqDx5c3vIedkBVVgGYSlpvEnX9xOQzUsd6PUr680sHIE+Sc0spgT7EAd0KdLVTrHq3Uy
         WlelOLNhg6IZaoqqkHcmBYxl1k0oqUf2Wfxw91tFmp+694ZdOlJ5Mp+xnJr6QGD/FFge
         XJGpuQDeLNBOAptKntirPvRLALvMFdRh/h3SU4eUoNAuSCAajjTbgba+Eu1QebS674Rx
         LNwLcfzQSMus0y2GVmfIGozV45620v9tOndOnn8bg6O43M6B+xpAcojgSVmsjc3fqlbL
         pTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnv4tR2N9BDyhGKLvKb3HD8EVPyKJAcGnVHjnIuj0u4OgXkFO6zycf5vCMg3v+AN4rMyAmUTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qflWhtRauwK47WhmK0vbkdPLquTZlkciu1rlT2DYELIm1jVD
	zD6l/zxM8AarIn7txeAHt6hDRovKNvOcD3QmhgERASHc8xa7C26dYrgm/LoxNjs=
X-Google-Smtp-Source: AGHT+IFZWurteNWnsdgtAZX7D7dUGhWH3zAnTTl23mmhHxfsbr0V9Ps8dE6ISzCxpy+Hn8nwroPKag==
X-Received: by 2002:a05:6512:3087:b0:539:fb49:c47d with SMTP id 2adb3069b0e04-53b348b7bfcmr4379852e87.12.1730196107620;
        Tue, 29 Oct 2024 03:01:47 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b48999d30sm172997e87.115.2024.10.29.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:01:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:01:45 +0100
Subject: [PATCH v2] mtd: spi-nor: winbond: fix w25q128 regression
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v6-6-v2-1-04165dcaf177@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIiyIGcC/zXMzQoCIRSG4VsZzjpDxbRpNfcRs/DnNHMgNDSkG
 Lz3bKLl+/HxbFAwExa4DBtkrFQoxR7yMIBfbVyQUegNkksluDSsaqaZwcBPaL13UkK/PjLe6LU
 z17n3SuWZ8ntXq/iuf+D8A6pggo2jUEoHI5wz052izemY8gJza+0DkJ7pPpkAAAA=
To: Russell Senior <russell@personaltelco.net>, stable@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>, Hartmut Birr <e9hack@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>
X-Mailer: b4 0.14.0

From: Michael Walle <mwalle@kernel.org>

Upstream commit d35df77707bf5ae1221b5ba1c8a88cf4fcdd4901

("mtd: spi-nor: winbond: fix w25q128 regression")
however the code has changed a lot after v6.6 so the patch did
not apply to v6.6 or v6.1 which still has the problem.

This patch fixes the issue in the way of the old API and has
been tested on hardware. Please apply it for v6.1 and v6.6.

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
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This fix backported to stable v6.6 and v6.1 after reports
from OpenWrt users:
https://github.com/openwrt/openwrt/issues/16796
---
Changes in v2:
- Use the right upstream committ ID (dunno what happened)
- Put the commit ID on top on the desired format.
- Link to v1: https://lore.kernel.org/r/20241028-v6-6-v1-1-991446d71bb7@linaro.org
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


