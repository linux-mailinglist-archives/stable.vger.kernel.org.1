Return-Path: <stable+bounces-163426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C69B0AE92
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5212D16E1F0
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE723314B;
	Sat, 19 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgsVWGSP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76533EC
	for <Stable@vger.kernel.org>; Sat, 19 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912766; cv=none; b=SR3iSDaULJ1Es86z3Jru/eYELsU8KWQufjVg5hpKhKZymU4e1psC91CBeUyhuoIe5bLVetRF2muAXQaE2Vd5is5NHG3/9Z6aSGHYrd0YXEafZSk45113CLnxt4VTo++kglKnvQVAttaWOvL1WIDZiUpJFLs+uIXItKr+dkU1i8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912766; c=relaxed/simple;
	bh=fQ+CKbNW4zHlyidLPQmcCBDCWmo2KKC9NNe0NaylZas=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BB16M+1FCU9/tj0mJ45jbA+Bi3FdsOzamt/GY/sM0d+vyWTGQWSkaGz8QsEZFqvZg7XSRflcWrfHM75OpWMYX5TaOKaX7Qv3MBKT2pRzR8f9/bXA0IWWbl8S8WsFCwjozs1tdTIta0Qc4uKaaZv4tF2WsosCb3OOCTZnu7ASbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgsVWGSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4EBC4CEE3;
	Sat, 19 Jul 2025 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912766;
	bh=fQ+CKbNW4zHlyidLPQmcCBDCWmo2KKC9NNe0NaylZas=;
	h=Subject:To:From:Date:From;
	b=SgsVWGSPg2hb3ThIc1GLFyVfqLYMVm7fyIRCVuv907SbCSoHeZrvt+seNtmdl7S54
	 whlBzM0ija33MVGzv97aVQSNZSAM677MwXbE8JOC4dSZTnTMdiARp2utpQEKxxCiGm
	 AsWjwtSWLbPWAb0Nx44XYH6z8gzWEZ1hQF9v/2lQ=
Subject: patch "iio: adc: ad7173: fix calibration channel" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:51:44 +0200
Message-ID: <2025071944-flatware-curing-0885@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix calibration channel

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 1d9a21ffb43b6fd326ead98f0d0afd6d104b739a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 8 Jul 2025 20:38:33 -0500
Subject: iio: adc: ad7173: fix calibration channel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the channel index values passed to ad_sd_calibrate() in
ad7173_calibrate_all().

ad7173_calibrate_all() expects these values to be that of the CHANNELx
register assigned to the channel, not the datasheet INPUTx number of the
channel. The incorrect values were causing register writes to fail for
some channels because they set the WEN bit that must always be 0 for
register access and set the R/W bit to read instead of write. For other
channels, the channel number was just wrong because the CHANNELx
registers are generally assigned in reverse order and so almost never
match the INPUTx numbers.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 1f9e91a2e3f9..2173455c0169 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -391,13 +391,12 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 		if (indio_dev->channels[i].type != IIO_VOLTAGE)
 			continue;
 
-		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st->channels[i].ain);
+		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, i);
 		if (ret < 0)
 			return ret;
 
 		if (st->info->has_internal_fs_calibration) {
-			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL,
-					      st->channels[i].ain);
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL, i);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.50.1



