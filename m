Return-Path: <stable+bounces-57939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE6926335
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BE6281E7F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507713DDD3;
	Wed,  3 Jul 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udmo4rst"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C921FBA
	for <Stable@vger.kernel.org>; Wed,  3 Jul 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016247; cv=none; b=BnGjC8MkPTeUlsAWNnY/poyNiNlUmEFFjhs7SyJDpHMpOBT8yujWs0NoRXuYmmyCcPFvv9IC3QFUbaRUMsdLiTTRP0HITl9olm8S/u/cVuFpckzEFF0ArwMDvx5K/ITKBBA7axfP8gA3q17J3paoalISL7DDFC/s3I7Lxmag8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016247; c=relaxed/simple;
	bh=VOCCg+qqD34bFpkmpp2RoPAyH5dwn+zXhVjTOB//h+I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=pk46S5eXJ0Z18ZFwLtFVl0aiKwweOXm4RpPdhnKTVExK9eZbNqoq6PSjKa3ENiBY33KSoZxgrFnzlXb9EDFmS0auafQ8jEGjkzEatvZ4kmbWkRnoMlJ9JTw1rptu7/WdvVtVJX2cnK7HDiHdT3CCGNRGGBCvEB6xoM7/9UTcfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=udmo4rst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71060C32781;
	Wed,  3 Jul 2024 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720016246;
	bh=VOCCg+qqD34bFpkmpp2RoPAyH5dwn+zXhVjTOB//h+I=;
	h=Subject:To:From:Date:From;
	b=udmo4rstqg0d5Hy0nFxJ2HcjlMMn2s/eJfR4S6pp5aRz7qzw1VAYfv9e1X936n3jJ
	 GuqEhHyXcHIanulAtU6A0uXz1/aLXh+WBkOLvQq5NJOWnkk0IU7n20dVJq9ERVIEgz
	 +JCiqcBIvWzocdTh/guaIGEaTFQJnx3joihxGh0I=
Subject: patch "iio: light: apds9306: Fix error handing" added to char-misc-linus
To: muditsharma.info@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,subhajit.ghosh@tweaklogic.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jul 2024 16:17:16 +0200
Message-ID: <2024070315-carefully-mating-21ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: apds9306: Fix error handing

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1a5cba43096c9242fab503a40b053ec6b93d313a Mon Sep 17 00:00:00 2001
From: Mudit Sharma <muditsharma.info@gmail.com>
Date: Tue, 25 Jun 2024 22:02:01 +0100
Subject: iio: light: apds9306: Fix error handing

The return value of 'iio_gts_find_int_time_by_sel()' is assigned to
variable 'intg_old' but value of 'ret' is checked for error. Update to
use 'intg_old' for error checking.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
Reviewed-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Link: https://patch.msgid.link/20240625210203.522179-1-muditsharma.info@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/apds9306.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index d6627b3e6000..66a063ea3db4 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -583,8 +583,8 @@ static int apds9306_intg_time_set(struct apds9306_data *data, int val2)
 		return ret;
 
 	intg_old = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
-	if (ret < 0)
-		return ret;
+	if (intg_old < 0)
+		return intg_old;
 
 	if (intg_old == val2)
 		return 0;
-- 
2.45.2



