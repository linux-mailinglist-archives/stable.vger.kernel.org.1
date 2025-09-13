Return-Path: <stable+bounces-179533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E2B5639A
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647AF189C94F
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2E2C0275;
	Sat, 13 Sep 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmvVRAce"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D41991BF
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757802945; cv=none; b=pHJWWUW8R02YUGnOU4ZQ99fI61wVpkOUjjKGrLtto0ANDL+/Jrb01eO3lM4SRyjCjTCqDEUre+eYYcW6U0rNdO3rpqyIzTTmP6n3aUPyJm+sxSvBNA3bcAtef4fwhWDff7RXmQzQIGJa0oZcooJ8Vqdd95CsIxZzodikxwW5z7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757802945; c=relaxed/simple;
	bh=bxkTo892vdQibw6Y+dU1bm7G2e5WJ94fbyz+KRIrNrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o82abVMr3ys/N6YSFz01hHqmloUorsynYIYXMp8AeRbqqRNe4uvbvK8PBGCfFIMdCS8qxZX5Glv0nGMWD4hYeT6+9Gdk/AplORBHLkvBnCJ8hKUH02gKEgZfRORxIIgqV1+p+QsoqS79yBH5E851sS2+YdmPyBQeI1hGd2SgkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EmvVRAce; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f98e7782bso3627252e87.0
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757802941; x=1758407741; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPeYvUoQ1NKFCYRNefeIpOFBJ+jeYICQ3irzWivgov0=;
        b=EmvVRAcehCctGzklWfTyTbSVrr+hz07SYWNJ0rw4d+KRYTHwaJ3BR03NTiKb/5A25R
         nD9quoXiFcP91YCydTYxIvwp/gCyRg5BNdM9RioTquCXyo/gkHbugUxpfYkU+ANhdJKD
         xHydESNXpe83yDup8ot+hCfSC5OpPbgxEB9ML/732l7AHD5zxEI09EzpYrSxA8tCyDJo
         3zuQrtNt99RC7cRMkr6Z3LBOqEfDqsSXVT0M4QBkfZlJHnH8QVmPWbrXVMSPa+eyxN7B
         cenGLPg0NTihHsiNIz7Bg92KV0+uvHu0syJX0g9KWuQYkDkh/+draq8Eo2a9O+oVIxXu
         XK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757802941; x=1758407741;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPeYvUoQ1NKFCYRNefeIpOFBJ+jeYICQ3irzWivgov0=;
        b=eDRLOGLk6Kre5jmQmTZqhGxKXrjvRYrdBsfgdnQSXvl6MXyjZ+OCoSpap3Z4Z9rT+K
         UldfLKVHMK4ZPy6YraB4l5Trsj2hgpn9HcOMsTtAQKQJIeFWSkZa9zvSCoMcFo5gRtH8
         IMMs6n9YDlMD4M4PD543nuekMPrhHiNgJqxdzoz82DroKMcXj0li7kZgMwVSTYyU0r+h
         NhWKOLZAwA2CevSdGw8eEH2MaQSJeCzaMWEGxOTtJnvmCKsaNVnxPOx0IWRSN7yWhkqe
         Wri4I+4fHNU6XJZFhtC13zgOvhENh3SbUhVZulhiHLLZLVzhNpFEB6dacwg7KXRr1ca8
         NWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhWSXYwZIYaNMUdeeWQcyu60F2k3ZaJp2YgXwx8f9PQvSIHw9L+CGHo3o+tPYekPGZSZRgeI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVH37Eizc/4ym7Fo7aiiDBqobHDtx+SZyl6tFCJqjJa8PtInJC
	Bp1fB3208vg6pd8alCkWTkM59Ph6w6cDKX8cNdOxxZ9IYBM1ZpIYaZX5V0fQbDJ1QzQ=
X-Gm-Gg: ASbGncv1L8/zetrFryiPk/hvWPhAEAYGX2SVmJ2HXugD5I/i8HDrk2exxHQ1MI3FfLF
	Z/7ttPqKJwq3C8xVBqJOim1Rhn96GCgGKCLembm5iigay50ONAIEJPL7H51X8CRxkw2oxslqXos
	mcARPInL9/8mqaBy0A64xnCXy66MfjLk1mAqI2+LOraP6r8MkQxP5U2RvmPvH6qMEjJHH41SYor
	z3r8rH8TH0D1UDKqBq3cufHkzqVwQl5oa/Kg5lT6UJIQ9L1zVBYHnRE/aCGB5SGAXwCm+fhEgmH
	b7x7uQhV3A7D7yucrIwa1KBTYW1ITp4As1IABOR5RVodSlpEcQ8FOFJlVNyijwbbv8/TKaZhi+1
	U8rijdOWI98nW6iO5OWNbaMp7zIRxrHVAlrm2t/khhIsreMvnrs0PbWCmnMopTSjNfQ==
X-Google-Smtp-Source: AGHT+IEC7QVwutEBVn3PNNKxOZQMmGKOLggaNtpBBMBtCsBA3oalYyv7QE4vI2wtXu/RuCfEjabwcg==
X-Received: by 2002:a05:6512:3f20:b0:570:4a6c:902e with SMTP id 2adb3069b0e04-57062589811mr1999144e87.26.1757802940364;
        Sat, 13 Sep 2025 15:35:40 -0700 (PDT)
Received: from [192.168.1.2] (c-92-34-217-190.bbcust.telenor.se. [92.34.217.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63c87sm2324559e87.69.2025.09.13.15.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 15:35:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 14 Sep 2025 00:35:37 +0200
Subject: [PATCH] mtd: rawnand: fsmc: Default to autodetect buswidth
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-fsmc-v1-1-6d86d8b48552@linaro.org>
X-B4-Tracking: v=1; b=H4sIALjxxWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MT3bTi3GTdpBRDi1TDRAtDQ7M0JaDSgqLUtMwKsDHRsbW1ALgXGbx
 WAAAA
X-Change-ID: 20250914-fsmc-bd18e1a8116f
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

If you don't specify buswidth 2 (16 bits) in the device
tree, FSMC doesn't even probe anymore:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro 10100000.flash
nand: bus width 8 instead of 16 bits
nand: No NAND device found
fsmc-nand 10100000.flash: probe with driver fsmc-nand failed
  with error -22

With this patch to use autodetection unless buswidth is
specified, the device is properly detected again:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro NAND 128MiB 1,8V 16-bit
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
fsmc-nand 10100000.flash: Using 1-bit HW ECC scheme
Scanning device for bad blocks

I don't know where or how this happened, I think some change
in the nand core.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index df61db8ce466593d533e617c141a8d2498b3a180..154fd9bea3016b2fa7fa720a41ef9eeed6063fd5 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -879,7 +879,9 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 		} else if (val != 1) {
 			dev_err(&pdev->dev, "invalid bank-width %u\n", val);
 			return -EINVAL;
-		}
+		};
+	} else {
+		nand->options |= NAND_BUSWIDTH_AUTO;
 	}
 
 	if (of_property_read_bool(np, "nand-skip-bbtscan"))

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250914-fsmc-bd18e1a8116f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


