Return-Path: <stable+bounces-143188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC7AB345F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A69A3B5AD8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A42586E7;
	Mon, 12 May 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1EDR/2RP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1A19E97C
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044163; cv=none; b=OULB76s6PbAzT6jmfzqaK/P1Q66XCXyefV95VjyPdLPeaBJWMn+F4Of9r2sa/qk+sVum+4wuF3t7+Cm9gZ+6t3DsxfGczM4MNV8RuR1tzae1AFvIkS1MVthgVFhG0wXG29r0E+6lkaEFjcBpGUbMkhH3ruqxYGAOWSBBdQ0spO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044163; c=relaxed/simple;
	bh=J2MiRIMMUEwdwwVAFU72YDRru11ZBuVV5yfdI6Cvg5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bH35jlmUfE9tqmJUTy1/sxEeYmZ1Q1Oy81LZMHy9kb/ZiRBgMITtGqOeVjoIrwOZQl4x+HV5Ixwl9UEzq5xbRogrK8iZCPLgDG3NPcvspR1Az29AAk8aGuvrRgKvL9jMfEEe/JFLDIOmsKbwCvnlU+a75UpWuum3BTGgOHbm/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1EDR/2RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A4C4CEE7;
	Mon, 12 May 2025 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044162;
	bh=J2MiRIMMUEwdwwVAFU72YDRru11ZBuVV5yfdI6Cvg5U=;
	h=Subject:To:Cc:From:Date:From;
	b=1EDR/2RPqz5StsTMVbkx89f5ei4S6GQWGKo/ybO8UXJaYOIvLjCLWnFNj8BAUU9h/
	 WhzKAgKc/2kew9Zkxq9fZdM4Ykshe5OUOym3lvNNNuQu6fdS2WRV5LD17PEVns8Q9/
	 mjvSLvrZUaKeYN503OmwsSATMT2s4DH5Xj8XVXjg=
Subject: FAILED: patch "[PATCH] iio: adc: ad7606: check for NULL before calling" failed to apply to 6.14-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:02:39 +0200
Message-ID: <2025051239-superior-nutlike-e1b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 5257d80e22bf27009d6742e4c174f42cfe54e425
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051239-superior-nutlike-e1b7@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5257d80e22bf27009d6742e4c174f42cfe54e425 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:09 -0500
Subject: [PATCH] iio: adc: ad7606: check for NULL before calling
 sw_mode_config()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check that the sw_mode_config function pointer is not NULL before
calling it. Not all buses define this callback, which resulted in a NULL
pointer dereference.

Fixes: e571c1902116 ("iio: adc: ad7606: move scale_setup as function pointer on chip-info")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250318-iio-adc-ad7606-improvements-v2-1-4b605427774c@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 1a314fddd7eb..703556eb7257 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1236,9 +1236,11 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7616_write_scale_sw;
 	st->write_os = &ad7616_write_os_sw;
 
-	ret = st->bops->sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
+	if (st->bops->sw_mode_config) {
+		ret = st->bops->sw_mode_config(indio_dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Activate Burst mode and SEQEN MODE */
 	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
@@ -1268,6 +1270,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7606_write_scale_sw;
 	st->write_os = &ad7606_write_os_sw;
 
+	if (!st->bops->sw_mode_config)
+		return 0;
+
 	return st->bops->sw_mode_config(indio_dev);
 }
 


