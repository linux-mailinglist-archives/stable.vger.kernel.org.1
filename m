Return-Path: <stable+bounces-83647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580D99BA10
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C8B1C20A18
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8500146D6A;
	Sun, 13 Oct 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DB6u1G8v"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA414600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833249; cv=none; b=BUT+I1tAuQ3phttSBCNeyslIfQakk94fI2Wt0o7LQ+eNoKJmhpJ1Q/OaUdqLOhnf3aB2KNKLD+aojmTHN/tRdwhk+EnlPaaCxAIzEChY5jwyFV+GYD3r+HGSKUSvKuwPeTBjsw3zIU88njxFH9avwb+rOqJQVPH/k6IeYoOL3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833249; c=relaxed/simple;
	bh=evCI1rnpu14wee8djaJte0/Ck+eJK/alxD+SqbPxvVQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=IaCQlNjRTM6wXJQyYb724hM06mqhbwP++AyMe+5UYLmLiJY6rBKLv2PJoewt8zhULGEZnvhrSrV8gLDrccx9C+sC3eS32E2Nw1DfXCRYTY3LbaSRLixrLHL/u1tBp5CskzRB0gv4iy/PuBVHB7HXtZZrXagn3wE27Pn2nYqyytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DB6u1G8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD43C4CEC5;
	Sun, 13 Oct 2024 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833249;
	bh=evCI1rnpu14wee8djaJte0/Ck+eJK/alxD+SqbPxvVQ=;
	h=Subject:To:From:Date:From;
	b=DB6u1G8vruoZRG5BBdipTrz6ooAfNnVHxAMI41WaAasJz2FoBXeOd2HrE4w/xm/2D
	 gp6PBJq2cWgmVvn0gO2hTRvZGP8gNDk8VIunTs2w/cLkTdF7q5Zf5Ahs6AE4SEnPWo
	 rMar2XWqs+fm6uE1JG9FB9aCtWz/Cz2FUJrQkLz8=
Subject: patch "iioc: dac: ltc2664: Fix span variable usage in" added to char-misc-linus
To: pvmohammedanees2003@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:07 +0200
Message-ID: <2024101307-visa-pretzel-72b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iioc: dac: ltc2664: Fix span variable usage in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ccf9af8b0dadd0aecc24503ef289cbc178208418 Mon Sep 17 00:00:00 2001
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
Date: Sun, 6 Oct 2024 01:34:35 +0530
Subject: iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config()

In the current implementation of the ltc2664_channel_config() function,
a variable named span is declared and initialized to 0, intended to
capture the return value of the ltc2664_set_span() function. However,
the output of ltc2664_set_span() is directly assigned to chan->span,
leaving span unchanged. As a result, when the function later checks
if (span < 0), this condition will never trigger an error since
span remains 0, this flaw leads to ineffective error handling. Resolve
this issue by using the ret variable to get the return value and later
assign it if successful and remove unused span variable.

Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Link: https://patch.msgid.link/20241005200435.25061-1-pvmohammedanees2003@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ltc2664.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 5be5345ac5c8..67f14046cf77 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 	const struct ltc2664_chip_info *chip_info = st->chip_info;
 	struct device *dev = &st->spi->dev;
 	u32 reg, tmp[2], mspan;
-	int ret, span = 0;
+	int ret;
 
 	mspan = LTC2664_MSPAN_SOFTSPAN;
 	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
@@ -579,20 +579,21 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
-			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
-						      tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			ret = ltc2664_set_span(st, tmp[0] / 1000, tmp[1] / 1000, reg);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			chan->span = ret;
 		}
 
 		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret) {
-			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			chan->span = ret;
 		}
 	}
 
-- 
2.47.0



