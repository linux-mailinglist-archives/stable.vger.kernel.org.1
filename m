Return-Path: <stable+bounces-52586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3190B900
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821BD1C2342A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01319B583;
	Mon, 17 Jun 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gn0UQwI4"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24519AD56
	for <Stable@vger.kernel.org>; Mon, 17 Jun 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647377; cv=none; b=hVEV8a7r2uHyKmj3nlDW4LW206v48iqdcrvv3rZ9thQVn/WLm+1QKv5ktsIg06zHPXOCCz3rp1e58uF/I2IK7Zc+5lKjIm+E9+5M/q+NXDAyj/dqX2hwta2weIvvaqyB3kDGSVvXzlIHptDcmdmRMYujWrdZgQcHy9VJALrlhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647377; c=relaxed/simple;
	bh=EPFw1PsVc5fvX9umgoL5bNyjAarKiDwUnGdM7ExHtpI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=QZs61WpvIhfAvTnbC2Y7JkFEyyyO6FzWoCHIa6vmjj406ecnDrxRfIUJyieXNloZc4rNRdQRtqpctI0cheHJqlmEsDryQ3XcumVTRR/bze/Xl6Nsn1E99MxF5deIugEoWm3zV8/qgN1hziln0TepE4x45/0J3zwjNVAKh1ITuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gn0UQwI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA861C3277B;
	Mon, 17 Jun 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647377;
	bh=EPFw1PsVc5fvX9umgoL5bNyjAarKiDwUnGdM7ExHtpI=;
	h=Subject:To:From:Date:From;
	b=gn0UQwI4sMHMJHIvheN7COIGFEBaw8a0opNxk40sbqesfJ4oQ61o6yO4B8KCIyJKS
	 LjsDKP64BTWkgWHJJ1e6IV5z1KU3DKnnXZBnLa9nSR5ae2dkpGMzJ+fwP31/kvnsVc
	 I7diBufHYzFdXutvZ9Y/eGennEodD6lvzRyMBAOI=
Subject: patch "iio: chemical: bme680: Fix calibration data variable" added to char-misc-linus
To: vassilisamir@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:02:42 +0200
Message-ID: <2024061742-labrador-groggily-a1df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: bme680: Fix calibration data variable

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b47c0fee73a810c4503c4a94ea34858a1d865bba Mon Sep 17 00:00:00 2001
From: Vasileios Amoiridis <vassilisamir@gmail.com>
Date: Thu, 6 Jun 2024 23:22:54 +0200
Subject: iio: chemical: bme680: Fix calibration data variable

According to the BME68x Sensor API [1], the h6 calibration
data variable should be an unsigned integer of size 8.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x_defs.h#L789

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240606212313.207550-3-vassilisamir@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2c40c13fe97a..812829841733 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -38,7 +38,7 @@ struct bme680_calib {
 	s8  par_h3;
 	s8  par_h4;
 	s8  par_h5;
-	s8  par_h6;
+	u8  par_h6;
 	s8  par_h7;
 	s8  par_gh1;
 	s16 par_gh2;
-- 
2.45.2



