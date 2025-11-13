Return-Path: <stable+bounces-194754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F97C5A57F
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740514F05F6
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163829A9CD;
	Thu, 13 Nov 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lzsZsv5m"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD776026
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073312; cv=none; b=KOtz2Qb3baBVydu9cSMGGzCmS41kd+dVN3OUuIA085sDNll9AlwxFCcOzbHkfrfGCrW2ruEp50/ZaQicP1QIAd8l7RW2vtX3ea9Ch6jibgxcxPR81Vm9U7XZWIbjj2dYGI5X3Ep9STpOWrLgutJQnwJfiBA/OdAQjlLbDfcSaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073312; c=relaxed/simple;
	bh=ixhqPdAbCk8V/Gsp3wKKTLZdtGupZUcEomgaqgzvqvM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=R8ZHyv2oa4yLTmSHW8frDYWYEaRDXlUIQoGvm/8/re0wRramQAqs0AMNV0c603jujYHx0qrc2WJzCaZtkFCa41pIW/tf8f3aMJuPKooKattQ9YwytHxhPxmTmP/Q5eZpSFJzhwYqPjwaBd8/eH9ST/a1w3ZqTN+GeiSy0JjMoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lzsZsv5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06536C4CEF7;
	Thu, 13 Nov 2025 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073312;
	bh=ixhqPdAbCk8V/Gsp3wKKTLZdtGupZUcEomgaqgzvqvM=;
	h=Subject:To:From:Date:From;
	b=lzsZsv5mNAqDjAJ6Ds4P8Vxfh7CrA/X3b9czgjeMfYKusUYIRK918DgNxnuzejQDg
	 R6H2phK3uZDd5Iq0cD++ptRfaDvLASveLbWKr02WOY3pDCJ8x4n/Xcg9UsgpI8bumR
	 0y3J7YXZ/RYnmRcu/+FlWmjE3V0J62IOr38m7FXg=
Subject: patch "iio: humditiy: hdc3020: fix units for temperature and humidity" added to char-misc-linus
To: dimitri.fedrau@liebherr.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,chris.lesiak@licorbio.com,javier.carrasco.cruz@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:54 -0500
Message-ID: <2025111354-cane-comply-8747@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: humditiy: hdc3020: fix units for temperature and humidity

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 7b8dc11c0a830caa0d890c603d597161c6c26095 Mon Sep 17 00:00:00 2001
From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Date: Thu, 16 Oct 2025 07:20:38 +0200
Subject: iio: humditiy: hdc3020: fix units for temperature and humidity
 measurement

According to the ABI the units after application of scale and offset are
milli degrees for temperature measurements and milli percent for relative
humidity measurements. Currently the resulting units are degree celsius for
temperature measurements and percent for relative humidity measurements.
Change scale factor to fix this issue.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/hdc3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8..8aa567d9aded 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175 * MILLI;
 		else
-			*val = 100;
+			*val = 100 * MILLI;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:
-- 
2.51.2



