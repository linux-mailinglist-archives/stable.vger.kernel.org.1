Return-Path: <stable+bounces-81405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDB993425
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428E41F23290
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA221DD539;
	Mon,  7 Oct 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="anm39HO9"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36C1DD52F
	for <Stable@vger.kernel.org>; Mon,  7 Oct 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320099; cv=none; b=Jz2aNhLmUFUsuFG3aPeRujwTq9FgD1h3sbYg/otQUtXNtoFTDypVCBOnOZ8rla9HoDIynSz7o/xaaSXxHmepUSFxYEKtEjwJmOKC/pE1fZsv/1ILvzSc1mSqyh3+Wk8zbeYAUs9s4ZCX20LUA2J+kNVpq2SqyhG6G/XUQdY4fJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320099; c=relaxed/simple;
	bh=KHDXd2ppW7lPxknQrauVl1avxCNmGhx/BlP8IndGEmI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lF/TaEhzv7/aDjVKPzrKe2EVXCedSMrs9GC+S6B8l/csm+KVtYlERcHuNt+/UTJ8dcXBenBeLRHkRy5VM0aHdeEoa7Esc0PH9eCUdoJVEhAursnpPRnz2p2fvE7SCm04aZdv4ZW4Dga9BtE82e396DEEbvOCvrGJ1agMloOvTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=anm39HO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF093C4CEC6;
	Mon,  7 Oct 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320099;
	bh=KHDXd2ppW7lPxknQrauVl1avxCNmGhx/BlP8IndGEmI=;
	h=Subject:To:Cc:From:Date:From;
	b=anm39HO9OLpnQD9haJANIX16A4Z9bsJTIsNPDEQk9lza8Nh1dCJ+Nlk/O2iY6CxeW
	 XPbF0bE2RM/3WnvtMpwMz3vl/yWtUM+2bY1/54+is8vyJM3y3P88W+7Sn0/xHl/gXU
	 KKRj6XgII1f1Xfzem1VvCmxHrVI1WuK8UnUZuyp8=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Fix waiting time for BMP3xx" failed to apply to 6.6-stable tree
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:54:40 +0200
Message-ID: <2024100740-hundredth-lunchtime-a9da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 262a6634bcc4f0c1c53d13aa89882909f281a6aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100740-hundredth-lunchtime-a9da@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

262a6634bcc4 ("iio: pressure: bmp280: Fix waiting time for BMP3xx configuration")
439ce8961bdd ("iio: pressure: bmp280: Improve indentation and line wrapping")
a2d43f44628f ("iio: pressure: fix some word spelling errors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 262a6634bcc4f0c1c53d13aa89882909f281a6aa Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:50 +0200
Subject: [PATCH] iio: pressure: bmp280: Fix waiting time for BMP3xx
 configuration

According to the datasheet, both pressure and temperature can go up to
oversampling x32. With this option, the maximum measurement time is not
80ms (this is for press x32 and temp x2), but it is 130ms nominal
(calculated from table 3.9.2) and since most of the maximum values
are around +15%, it is configured to 150ms.

Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://patch.msgid.link/20240711211558.106327-3-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index cc8553177977..3deaa57bb3f5 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1581,10 +1581,11 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 		/*
 		 * Waits for measurement before checking configuration error
-		 * flag. Selected longest measure time indicated in
-		 * section 3.9.1 in the datasheet.
+		 * flag. Selected longest measurement time, calculated from
+		 * formula in datasheet section 3.9.2 with an offset of ~+15%
+		 * as it seen as well in table 3.9.1.
 		 */
-		msleep(80);
+		msleep(150);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);


