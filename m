Return-Path: <stable+bounces-160488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC068AFCB9D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CEA3B3104
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F12DF3F2;
	Tue,  8 Jul 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrtwo9sJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8B1EBA19;
	Tue,  8 Jul 2025 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980271; cv=none; b=VGHaUlxIDrcRKPae49nAoHWVTMotVBE49RT4//7XE0k60N5K2Isvy/ivDjwPUg5xdCGKnk5Tt0AOGlUh6Fy8CZNXid0Tt29KQkUyot/FOIIW8K/9pa6Mizyjz1+jmGMP9XW2ttL/ySFkzFmo8OXM9bq38Rl7AFfs7EZVFh7gnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980271; c=relaxed/simple;
	bh=03g+MRQD6Xu7ZjYmMziTj+MjO3Y7yjNKx0GkHmEDe64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cGuYROZbLK9G4b8rWalaYjytUGvntJv/0bdvl0QlJjvC3f0qAkfT7DolEtiOlauh5A/JrD1fh42aBUiuF6SnXKlYmD5gMcUBNT+JGBxqKreKjU7H5TWngqv9tjHcoRknMGEwx5xeP3hCHZTEDBolccZ29tFQQGwGqGxcBJOdVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrtwo9sJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso46814845e9.3;
        Tue, 08 Jul 2025 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751980268; x=1752585068; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CFLZ9hcT/AZXle1Nxn26WgUyX/jArf2iyT38bDQ0Js=;
        b=nrtwo9sJWx+IFVwlX9XD+FhSYZqm1NPY/otzMo1eKH40wWod+lc+Ui6Dvhgk51CQwZ
         KsFY8icO6MCa4n8AXQMlLZuyiFVa+xtbJXX4xbkwdSJ55eBCQe9PU2WUkUh2IG2UQ069
         xnkYd2kVjP0xb5d485xYiByeELqFnDtbWlxdZIZeLh86GigA9p327JhOo/9Z1KdxkNBm
         2zGnF4Hxj9JA/KYo+5uehRaH9+N8bJDpS4fRcCuSH/CpPg95BRxaZhDa1lILNARmxW7X
         DyHCWB0GoYNS/QWoEoKU1xmXkHmgf6iXYhjCshp5p2YOgNS4XqvucQJZuQoOrFfFfTRp
         O1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980268; x=1752585068;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CFLZ9hcT/AZXle1Nxn26WgUyX/jArf2iyT38bDQ0Js=;
        b=JrxjXchoFy9Fbxt88gs+tLBGG95zO4jFKFK1ji/L+X8Xfft4GWseywqQKCDKI9p7RN
         /VlQHvDIoshTeAfTXVwtaIylKSA7EwXR3NQg3ACILLXdgNF7W370ND5uIX8q9xziNYx3
         zDENnRhitcByn/dJoKrUuj73iRqnHBJgBGMfuibJW+KlJQzC865OWaBcdNBElneNLLmT
         GbSvZab/S6NabdKg2s7XSc0AoTamcUwpCgT5Ns/O2VQ/5jRRNKPHUxOh5DO60+VYugWX
         aEC/5qozoTvRDqUAPICb78AYFKnuNN9d9NILxId3tt7g9Nw0lMx5IicZ7XIbSZh7ZBqN
         A+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVseiVz4Gg+hzGIHyXpQNc93rzNcvhacFHwjLDbw89OQitJycUqTIaAQcv2ab9/OTBAR3Ey4OZgy4HjO9s=@vger.kernel.org, AJvYcCWTMf9nZHOQjJSyYRkJQtRFMRLAb/eB6Y58EEBevpDVFrCAiv4YEbsOdBXcofU1u4hKOwbvqOD0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBJXiePUAbB/qdKxMxjyMQa4Vdm/OYgc8EzMRHzzlNWABz8l5
	HHjThoze6ip9VqkKm72W26Z4Ev4ZwHp21wkUlNNGvHxOdq+Glhx/JHpTUfTCpg==
X-Gm-Gg: ASbGncubdjc/jrqtCzdO+x0yJnjK80oZ/Op6LniAjQOeKz8HRHwfQgi8ogkpir0Qj0t
	o+o0yTO1BCLLk6gA3xcy6p54hXaLxLRgrVXASOMaH7YXigTX2Q6S32Ot6NpSNG1L9vJ76PrrZ2U
	REnE3NGqE/hAf3J1WToC8fW5g4zjGLTkbDrGD4cWpsAjmGsoezvpQCAs89eo/nnK2P5snkLwEBX
	oJa1raEIrY1hB3GH2QdoNct7s3V6YWslJSG75lJDTeQf0UhD9VRNdm0zwhEWQBOIUGV8fVVCapg
	adFTdoNs5b6e1NXRzmduEtjbC5LuBZKd80XhqVYgKuk7XZxAOxz+KaUSbptFbvI09c4T6z5w9Ih
	/ZyqmA6gctkfJHgs=
X-Google-Smtp-Source: AGHT+IEw8waJ1n6TchLNXUJJCQV+wy9/oOutx8uhq1vVBJiT8Q8NsUcWDS8GrB5YyK2e0IKXMjNFMQ==
X-Received: by 2002:a05:6000:41f8:b0:3b3:a0f6:e8d0 with SMTP id ffacd0b85a97d-3b5ddecceb2mr2682773f8f.54.1751980267698;
        Tue, 08 Jul 2025 06:11:07 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b471b97339sm13123119f8f.64.2025.07.08.06.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:11:07 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 08 Jul 2025 15:11:00 +0200
Subject: [PATCH] mtd: spinand: propagate spinand_wait() errors from
 spinand_write_page()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-spinand-propagate-wait-timeout-v1-1-76f8c14ea2d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOMYbWgC/x3NwQqDMAyA4VeRnBfIMqTiqwwPQaPLYW1p6xxI3
 93i8bv8/wlZk2mGsTsh6c+yBd/wfHQwf8RvirY0AxP35GjAHM2LXzCmEGWToniIFSz21bAXFGI
 mFTe/mKFFYtLV/vfgPdV6AbziQeBwAAAA
X-Change-ID: 20250708-spinand-propagate-wait-timeout-a0220ea7c322
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

Cc: stable@vger.kernel.org
Fixes: 3d1f08b032dc ("mtd: spinand: Use the external ECC engine logic")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7099db7a62be61f563380b724ac849057a834211..8cce63aef1b5ad7cda2f6ab28d29565aa979498f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -688,7 +688,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250708-spinand-propagate-wait-timeout-a0220ea7c322

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


