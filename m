Return-Path: <stable+bounces-83626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47F99B9FB
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD56B2100C
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A65146A83;
	Sun, 13 Oct 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZ6PSCoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97F14600F
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833182; cv=none; b=pWORFuGkbSBa80w8lVat4dsOB9N58AL1NcFdi/Z4I+FMEMJ0evqj90PQlxH+PIMHBUdDRtqP8+S5AaKxxhuqMEFtoePnlJRerst2s3Z9vNWKPlWsMkR9jDm3kfPA9K107zS9RniM416RbAC3Z2KscJ0gA21pNz6fDnEEbcWPJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833182; c=relaxed/simple;
	bh=uloO0SGiBhP/Mkkd6dn3iWklb9G0kdiUKeO0mGFviUo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=UhYVQum7Zn1xFt4lEDihB08HdP8uk858r3CP/6vOw+Irk5lBbwUMbJNTke0YAtyE6tkUgQ0YaXEQtdFQwlF+BFsPbrwonfBSnwoSZeYDsDaXgZOTWCOnOPfjCrBPsYBq/eB/EKA7jDZQk36GqKkztvE5ekBWzuDKJ8oPaP3v+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tZ6PSCoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2089C4CEC5;
	Sun, 13 Oct 2024 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833182;
	bh=uloO0SGiBhP/Mkkd6dn3iWklb9G0kdiUKeO0mGFviUo=;
	h=Subject:To:From:Date:From;
	b=tZ6PSCoPMDuoNFL1zcasMd7AYO4gK9UDf/foipnTmeDk+yPz546vvW9hHlMz8uMnV
	 ke5so0IwciLv78mongRbYwBASIU9YZBXjDn4rocRrP1eY7xrdePgtqjYF1qxWAv2i5
	 wVqhYhqok2fpe7CyQ4fYwCP280+vceMLyiHNiRvM=
Subject: patch "iio: light: veml6030: fix ALS sensor resolution" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:57 +0200
Message-ID: <2024101356-paycheck-autograph-5032@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: veml6030: fix ALS sensor resolution

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c9e9746f275c45108f2b0633a4855d65d9ae0736 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:49 +0200
Subject: iio: light: veml6030: fix ALS sensor resolution

The driver still uses the sensor resolution provided in the datasheet
until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
28-Nov-2023. The original ambient light resolution has been updated from
0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
the current device datasheet.

Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
original 4608 mlux/cnt to the current value from the "Resolution and
maximum detection range" table (Application Note 84367, page 5), 5376
mlux/cnt.

Cc: <stable@vger.kernel.org>
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20240923-veml6035-v2-1-58c72a0df31c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/veml6030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index df2ba3078b91..9630de1c578e 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -779,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 
 	/* Cache currently active measurement parameters */
 	data->cur_gain = 3;
-	data->cur_resolution = 4608;
+	data->cur_resolution = 5376;
 	data->cur_integration_time = 3;
 
 	return ret;
-- 
2.47.0



