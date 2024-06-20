Return-Path: <stable+bounces-54714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79691058A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30741F21C10
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67771ACE65;
	Thu, 20 Jun 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="TECxJkAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp68.iad3b.emailsrvr.com (smtp68.iad3b.emailsrvr.com [146.20.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D081A3BD1;
	Thu, 20 Jun 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889124; cv=none; b=ZJ4AMqUbMANZ5MrDAiahmqHa7wrMtLEE1zGQMFcoEkBkA9Y24Qj8jSUFO/6m95Im370FeWoJBTKsbHI0JhA7s/BIld33/qqupkNarFMFgWP4IcJqhXlDNt9OKG6/K4zx0XGMICTie3SpSwkeLhj1fUtLcMiDuKa/0HlJUqYeQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889124; c=relaxed/simple;
	bh=HoXdi8YDPzKPfOk1K5QZ/YKUnApGodxvc1GCh+obPAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcDB7GRasJov6d1Q/JK/5PIyOnnCJPR/bKMislwm00muvePIDZjeMnel4ztOVfq0BdgbUfNe8e+ORXTGIgzkou4iUqCiKS0SpU3E9D94yixEa+L8w+5D0tRU0IECi78/ywAmixkrZ238lqbrSrT+epFwIk6ni3S0P9R5u4m2e1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=TECxJkAU; arc=none smtp.client-ip=146.20.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1718888732;
	bh=HoXdi8YDPzKPfOk1K5QZ/YKUnApGodxvc1GCh+obPAw=;
	h=From:To:Subject:Date:From;
	b=TECxJkAUhfOnkyBBG9EzZbRLXNJPdWxo6jiuwOj/PgyqgbnHhVLwp60G+wf7I5IhT
	 +n0Row+sswvq3d+bCzNaSQuC64B9skUvoP0yUr1ZOfcg62LiLN+YjVOKnwuwzyFlhN
	 xDUqGzu1di2PRwYA1T8Y7EwP5WUzniVNSeBG1B5Q=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5A368602EE;
	Thu, 20 Jun 2024 09:05:31 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] rtc: ds1343: Force SPI chip select to be active high
Date: Thu, 20 Jun 2024 14:05:14 +0100
Message-ID: <20240620130514.14875-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 69f7c04b-1112-4442-97ad-644fb5228c58-1-1

Commit 3b52093dc917 ("rtc: ds1343: Do not hardcode SPI mode flags")
bit-flips (^=) the existing SPI_CS_HIGH setting in the SPI mode during
device probe.  This will set it to the wrong value if the spi-cs-high
property has been set in the devicetree node.  Just force it to be set
active high and get rid of some commentary that attempted to explain why
flipping the bit was the correct choice.

Fixes: 3b52093dc917 ("rtc: ds1343: Do not hardcode SPI mode flags")
Cc: <stable@vger.kernel.org> # 5.6+
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/rtc/rtc-ds1343.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index ed5a6ba89a3e..484b5756b55c 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -361,13 +361,10 @@ static int ds1343_probe(struct spi_device *spi)
 	if (!priv)
 		return -ENOMEM;
 
-	/* RTC DS1347 works in spi mode 3 and
-	 * its chip select is active high. Active high should be defined as
-	 * "inverse polarity" as GPIO-based chip selects can be logically
-	 * active high but inverted by the GPIO library.
+	/*
+	 * RTC DS1347 works in spi mode 3 and its chip select is active high.
 	 */
-	spi->mode |= SPI_MODE_3;
-	spi->mode ^= SPI_CS_HIGH;
+	spi->mode |= SPI_MODE_3 | SPI_CS_HIGH;
 	spi->bits_per_word = 8;
 	res = spi_setup(spi);
 	if (res)
-- 
2.43.0


