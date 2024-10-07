Return-Path: <stable+bounces-81404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105A993424
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29E31C234C7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A201DD530;
	Mon,  7 Oct 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoXHd5/z"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CC1D9673
	for <Stable@vger.kernel.org>; Mon,  7 Oct 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320096; cv=none; b=scI86R6KYiAyI05r6JxFRSrU1VvPHsXxahAEKThHwNjaBzngbR8BLxNYJ+fEM4tJ9k3ASbVwQH5iPyhNkC8AitakhkfhzTgLJRYgW4Wrkxv1oOh7cVbSjmyyo7b7AZAM9KMnqkD5lWIECHUdUwrtaMzQvCseu0MoF1dYkprhUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320096; c=relaxed/simple;
	bh=lV0wwHUowfsBfmPBKic8J3e0rmFcxswQVTrPTMSS+5I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RTESmXTM+ZkMZKp08oF7H+PdyAuaEB1gXz3PCB2UJBawsvbgD9SS4s9HpBJ9NJSX+EVkZ0mWlKbdXd2qXaLe69jKunhENn+hRyUj9lZmWwMXxA24fxTz+zoOUgRhferb4a2paCM68cTUjS7CYoY3Yua/lVjLjMniVcuFJeCAOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoXHd5/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52556C4CEC6;
	Mon,  7 Oct 2024 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320095;
	bh=lV0wwHUowfsBfmPBKic8J3e0rmFcxswQVTrPTMSS+5I=;
	h=Subject:To:Cc:From:Date:From;
	b=ZoXHd5/zY8MBQW1sSohgctH79h6FVvdcV9ibBRdiMyC0MizdXRmEaOf0+gUo01TVJ
	 xvTeK02n24nnsOdZZs1hoKYXdHmP+tytHpnoV0sHeSyIB1ZvubIfLxQYrg0d3wkOPY
	 HIFGKGDCAFkFVVDFDODEdt3hUFs282DY0YAP4Xdc=
Subject: FAILED: patch "[PATCH] iio: pressure: bmp280: Fix waiting time for BMP3xx" failed to apply to 6.10-stable tree
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:54:39 +0200
Message-ID: <2024100739-enunciate-catnap-78cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 262a6634bcc4f0c1c53d13aa89882909f281a6aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100739-enunciate-catnap-78cf@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

262a6634bcc4 ("iio: pressure: bmp280: Fix waiting time for BMP3xx configuration")
439ce8961bdd ("iio: pressure: bmp280: Improve indentation and line wrapping")

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


