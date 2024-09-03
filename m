Return-Path: <stable+bounces-72808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DB969A24
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EA1C23350
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F5C1B982E;
	Tue,  3 Sep 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJJ/242b"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1D1AD26D
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359334; cv=none; b=qpxGD+aTR1xU0ddINQtSHV7x4RTZ/NA2l4DDnclox7hnE78INiyg/0Het5l5xKgoJe2uQlOXMKIfD/2htirwM2jxykJp5RR33EhNaYQIvKd4WrWr8MVoo6rOC6mMdxzjLHhh0ccNHFos5XVjo5siMGYnMVzV4JzSWv/5rHygnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359334; c=relaxed/simple;
	bh=MGRA2/We1vj+sj+JuoAwwg2ofAjMD3WYqNNuSvMQBR0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=keawnJvGc19EzqdF1RHQJ6GVY0dzdTViRtNSQYcRW89/nGkE44hSiptd05S/D3dJO3i7iNlWSz7DoQUl92Ey8eOBKipjgljcqJHBDi5p0g0cy1teJ6gWaR35colxd3TNUBsuJ5DyTf8aseCHGtBhS05pDQAfvkmtx292bCPoRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJJ/242b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FACC4CEC4;
	Tue,  3 Sep 2024 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725359334;
	bh=MGRA2/We1vj+sj+JuoAwwg2ofAjMD3WYqNNuSvMQBR0=;
	h=Subject:To:From:Date:From;
	b=dJJ/242bunIP6Hp4ZJqyLKi33IPQH0103b7Inq9ROrgvoZfthw2Ort7GjcUgCcbiT
	 KB6dyf/p35UtjHs1RY5f5wJbHDGJN/FwTsnOnZvNvJqS8jTC2/fnyOz2m9shhV55RC
	 Rjz0AC7dNtnoYVUvFirWMyb5DCZdtd7VMkZrSRWM=
Subject: patch "iio: pressure: bmp280: Fix waiting time for BMP3xx configuration" added to char-misc-next
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:01:10 +0200
Message-ID: <2024090310-drone-stream-edf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 262a6634bcc4f0c1c53d13aa89882909f281a6aa Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 11 Jul 2024 23:15:50 +0200
Subject: iio: pressure: bmp280: Fix waiting time for BMP3xx configuration

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
---
 drivers/iio/pressure/bmp280-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
-- 
2.46.0



