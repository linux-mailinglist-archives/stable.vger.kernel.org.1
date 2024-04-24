Return-Path: <stable+bounces-41324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4D8B0083
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1551F24CCC
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38686277;
	Wed, 24 Apr 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liCgFz66"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C5171CC
	for <Stable@vger.kernel.org>; Wed, 24 Apr 2024 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932862; cv=none; b=osNf59vjr7YuZRmCXZ/4Mruh7iIGPRgTbHjEJmdeGIY4adCwLK0ZwbLGwSMbo07tCeJvBWxLEcJuipKIMsshWwsf23d3erofczwtzvBy+YV2SNkrg3DAZDv2s6usesmdfDes/t5lJI1AwXnbzsmYa6pRf8lQPdWd+ZqcOd8tSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932862; c=relaxed/simple;
	bh=iI5N1hKx7IZEzGXTpvGHVGp3zFZXRE5BSfy9BGP8QkE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hJEsP1c04W6/rWYF5Mvq27XC3Ky2xvlZCJe4I2hMOxxRbiadninFpKiFuCtE7jPk1FmwzUY9GKDDVYw/hOevrVeAM4wxo2u6vQLfJDl7IqiDd3wfUTNghNkmI6NAjpzjkNqddCXW2YqxfbY4aRcUWyJpHOCISG8DuFh9RtfLJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liCgFz66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68FDC113CE;
	Wed, 24 Apr 2024 04:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932861;
	bh=iI5N1hKx7IZEzGXTpvGHVGp3zFZXRE5BSfy9BGP8QkE=;
	h=Subject:To:From:Date:From;
	b=liCgFz66bfL9LtTfeSQC7tpUlPCWnap79n9t4VusFq8HAsT576IXrDmkrpt+TfRO+
	 55iUnjskNKehl9LEyDm7+H41epyZG62k/0MEaOjjEgH7etGD+aQGvHL3yHjsywefYf
	 VavtetQ6c1Ze2qyI9LFI1bQpmz6Xp7iT000o5xLU=
Subject: patch "iio:imu: adis16475: Fix sync mode setting" added to char-misc-linus
To: ramona.bolboaca13@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 21:27:28 -0700
Message-ID: <2024042328-battering-plaything-57fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio:imu: adis16475: Fix sync mode setting

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 74a72baf204fd509bbe8b53eec35e39869d94341 Mon Sep 17 00:00:00 2001
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Date: Fri, 5 Apr 2024 07:53:09 +0300
Subject: iio:imu: adis16475: Fix sync mode setting

Fix sync mode setting by applying the necessary shift bits.

Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240405045309.816328-2-ramona.bolboaca13@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16475.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..060a21c70460 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1289,6 +1289,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 val;
 
 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1350,8 +1351,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	 * I'm keeping this for simplicity and avoiding extra variables
 	 * in chip_info.
 	 */
+	val = ADIS16475_SYNC_MODE(sync->sync_mode);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
-				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
+				 ADIS16475_SYNC_MODE_MASK, val);
 	if (ret)
 		return ret;
 
-- 
2.44.0



