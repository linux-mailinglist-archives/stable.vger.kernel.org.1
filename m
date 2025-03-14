Return-Path: <stable+bounces-124409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A851A6093A
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 07:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3103A8E4E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B013AA2E;
	Fri, 14 Mar 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pHGLy+ue"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666A13A244
	for <Stable@vger.kernel.org>; Fri, 14 Mar 2025 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934200; cv=none; b=rLtN10cTZDUgz9LxRs7t/gnknbsYxAAdwhELg4P17Db25oDsPoowI976rjF90VAvklj1fqor+pT8K5YickH1naA/6+ExMpFPTD/1U+PoCfLZyPQSGE6FQ5s3sTEbzd5JzSrXi3AQIN7ol77BAMYZaGJCRrN3jX8qQSpyozekc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934200; c=relaxed/simple;
	bh=G8NPDi0fNEepaqPqlO5RLvnah+9yzgOhK1I8azhG6IY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ED65KaUiyfVJMKjZMPwnZgMvLi+rjIdz0WHUw2Az4DKdCt4ZgdHwC5SoEE5u2r+FZ+cugxSB4iRV7UdlU74sXoUByvel2YRKCRFRpaemaRd9QgmHM01G8BN7j71up1Y86DSiXEnR/lMZ0CpQVCjc3L3CbgWRpfAJ9XJ5/yOpVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pHGLy+ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F3C4CEE3;
	Fri, 14 Mar 2025 06:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741934200;
	bh=G8NPDi0fNEepaqPqlO5RLvnah+9yzgOhK1I8azhG6IY=;
	h=Subject:To:From:Date:From;
	b=pHGLy+uepPo3zbVIMJdOsoStdhpjphxv+1rWpD0y/sTy42SbCnTd3Nhy7C0a3P2Ef
	 U2nrPcLnhlLdZlC9l+p4sV4Jn5EoTIHQGDRv9W4VPvi5DDFZxvenOnuyfDV2bRSvTe
	 GLsjoqlIOthdI5HZEbTxlNL/EbgLwtT724TZelI0=
Subject: patch "iio: adc: ad7768-1: Fix conversion result sign" added to char-misc-testing
To: sergiu.cuciurean@analog.com,Jonathan.Cameron@huawei.com,Jonathan.Santos@analog.com,Stable@vger.kernel.org,dlechner@baylibre.com,marcelo.schmitt@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 14 Mar 2025 07:27:45 +0100
Message-ID: <2025031445-sensuous-zestfully-2d97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7768-1: Fix conversion result sign

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 8236644f5ecb180e80ad92d691c22bc509b747bb Mon Sep 17 00:00:00 2001
From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Date: Thu, 6 Mar 2025 18:00:29 -0300
Subject: iio: adc: ad7768-1: Fix conversion result sign

The ad7768-1 ADC output code is two's complement, meaning that the voltage
conversion result is a signed value.. Since the value is a 24 bit one,
stored in a 32 bit variable, the sign should be extended in order to get
the correct representation.

Also the channel description has been updated to signed representation,
to match the ADC specifications.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://patch.msgid.link/505994d3b71c2aa38ba714d909a68e021f12124c.1741268122.git.Jonathan.Santos@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index ea829c51e80b..09e7cccfd51c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -373,7 +373,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
-- 
2.48.1



