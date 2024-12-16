Return-Path: <stable+bounces-104369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF29F3487
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A570161A1A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0C136345;
	Mon, 16 Dec 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzBCXelR"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207317C64
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363107; cv=none; b=o15tTVBkihsD0BraRctdmTzcjzhNzqTpmt14eYglyXyLi4Hb8awnTzHiNmyZRHc1Cq7don97Cxz8hPGW9vjfm8Ww77FuOmE7nQRqMP477fsZWnglvaUALCyT89ELcnuXccY9s5W8BxPd5R33+0DkxyI2GWgarVdGVCw78tH1pOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363107; c=relaxed/simple;
	bh=dzNltERgHojdOu5jHbnUFl479qnhEGlKd4ruu+6axzY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rs0NsTpKsQqhKEMwjhgE7B+VM87WMkg1bZu6+QI9tzGdnmtAYMZq+ofcB/l3KgOSRy1QU630c7oVRTTSj4tsfWOiLw31nwU3esx9PRmlct/b9VwyVXLlBKWX+hzq+AO0mWIyxGbUcV8fS+THkg8wWZ92++KKs2XXhutVTAdlgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzBCXelR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFFC4CED0;
	Mon, 16 Dec 2024 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363106;
	bh=dzNltERgHojdOu5jHbnUFl479qnhEGlKd4ruu+6axzY=;
	h=Subject:To:From:Date:From;
	b=WzBCXelRXQx2rL6MF+OWRXSfveGRuE3CgotDvThsCd3/KrckdEl0nKRoC+M8FFb88
	 h5p3Mj/qTkxWamlU5YvS+oI2eoArND4Y42RHady8ol8iOC4i7uYkkQ2LsXvHBYI6p4
	 RnliXSu7VU5Cxl8VXm0TXDJZ9/SYOwKCGY6/uaQc=
Subject: patch "iio: gyro: fxas21002c: Fix missing data update in trigger handler" added to char-misc-linus
To: carlos.song@nxp.com,Frank.Li@nxp.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:33 +0100
Message-ID: <2024121633-patriot-wages-77e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: gyro: fxas21002c: Fix missing data update in trigger handler

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fa13ac6cdf9b6c358e7d77c29fb60145c7a87965 Mon Sep 17 00:00:00 2001
From: Carlos Song <carlos.song@nxp.com>
Date: Sat, 16 Nov 2024 10:29:45 -0500
Subject: iio: gyro: fxas21002c: Fix missing data update in trigger handler

The fxas21002c_trigger_handler() may fail to acquire sample data because
the runtime PM enters the autosuspend state and sensor can not return
sample data in standby mode..

Resume the sensor before reading the sample data into the buffer within the
trigger handler. After the data is read, place the sensor back into the
autosuspend state.

Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20241116152945.4006374-1-Frank.Li@nxp.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 0391c78c2f18..754c8a564ba4 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -730,14 +730,21 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 	int ret;
 
 	mutex_lock(&data->lock);
-	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
-			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
+	ret = fxas21002c_pm_get(data);
 	if (ret < 0)
 		goto out_unlock;
 
+	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
+			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
+	if (ret < 0)
+		goto out_pm_put;
+
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
 
+out_pm_put:
+	fxas21002c_pm_put(data);
+
 out_unlock:
 	mutex_unlock(&data->lock);
 
-- 
2.47.1



