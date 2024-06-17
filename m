Return-Path: <stable+bounces-52587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5990B901
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DE91F21B19
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BF19AD5C;
	Mon, 17 Jun 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V247qSpc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6319AD59
	for <Stable@vger.kernel.org>; Mon, 17 Jun 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647380; cv=none; b=jtW/MsWmY3YSgzpYMiy6YX1Hu1o9NlhPARoa6YK9M8hKYoOgKkrMxej81LG2BRPXfDNDua3DHeUX33Rdz/7eoTD4rM5HzGnGJYn1/GkOSQgEcgYxfQes17Wzf99a+aWRO5YYb36N0JfXSQi0kZtDf0TVSslve/Cl5JWAH5XDrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647380; c=relaxed/simple;
	bh=/BwFEH1e8e8yaTi+tDCfj7oZ2DmlSHvy2tWzzk1Gaco=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Uubx5nBH3DxfDFdleNFYTQLx/KnAhIawguqup5bfPJgsIlPR7+diqnW0fGtcKPEQBzDHuKHhW1B+tlKP9+7K0G90ErBPDwkcKVKK154YL1V769FUIkN8DBi62sPmYxS/wCTpS3U99JQYdHqfGiOyMQr/5BoRc3hW6tFToq/e7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V247qSpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFE0C2BD10;
	Mon, 17 Jun 2024 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647380;
	bh=/BwFEH1e8e8yaTi+tDCfj7oZ2DmlSHvy2tWzzk1Gaco=;
	h=Subject:To:From:Date:From;
	b=V247qSpc7Aoeg+p19YVBHAMB1iJUiWDJJ7W/zDtwCYI2ly0KF5cORrjdBF7SBlAGq
	 rDTzNzheSvyuobk8H+3hWhIP/k+ln5ADwUzJQ6iK5I8+wrctD8ckxmWi1ef0lXoUd2
	 WHWyyt+QLn3vyMeUbwj2rAD8qj23XaBf5K1911YU=
Subject: patch "iio: chemical: bme680: Fix pressure value output" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:02:42 +0200
Message-ID: <2024061741-stowaway-enactment-15bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: bme680: Fix pressure value output

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ae1f7b93b52095be6776d0f34957b4f35dda44d9 Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 6 Jun 2024 23:22:53 +0200
Subject: iio: chemical: bme680: Fix pressure value output

The IIO standard units are measured in kPa while the driver
is using hPa.

Apart from checking the userspace value itself, it is mentioned also
in the Bosch API [1] that the pressure value is in Pascal.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L742

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240606212313.207550-2-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ef5e0e46fd34..2c40c13fe97a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -678,7 +678,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
-- 
2.45.2



