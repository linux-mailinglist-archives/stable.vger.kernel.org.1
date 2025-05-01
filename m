Return-Path: <stable+bounces-139321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA4AA60E6
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD599A30AD
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F83201262;
	Thu,  1 May 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7p2AET0"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932D1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114554; cv=none; b=awN+F3zdVtwchsLOsjQ7StjRz0ZX+GFmEJFZRsmfeE0//gRW3d24sMt30DIlJN6SEv0unA/AVMletpIXztssq+OGywwqnSWbFFGuEijil+A1ohlvR6P4FJJ1/bvL7DVhJIbfbG9jyP/3NPeGZmr6S7wKaSqI37y5OjMIfdjz58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114554; c=relaxed/simple;
	bh=8fIVFSQfbo1mE83h/RUbi8PnyTIgMsS5kaWfFyabFrw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bj3fH63gYlGJ1NVXJguo7flkocCKcSyaPRE7ePB5NVG2Y4xvjcgvzojp/0I7GVinCXljgZbmMucGYMQofprb0tSksvSc6ksw8t6NaJDn5K9qIOoqeh7ipvNmSI99POjmu49abGX5TK5O82i0nN5HaReSLdiBN+CxH9H99OH9D5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7p2AET0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB58C4CEE3;
	Thu,  1 May 2025 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114553;
	bh=8fIVFSQfbo1mE83h/RUbi8PnyTIgMsS5kaWfFyabFrw=;
	h=Subject:To:From:Date:From;
	b=b7p2AET0iLr0exTgipB4RlHggPqZn4nPWq93R6BhGBt+dBIbEYxkznJb/t0H941o/
	 +McWBbGIjGtF92M/a+HXrsSNQDbN3cQDgNv5+UtwieL7YBqiZXeIpsqaVQQpq7Ae2H
	 OL/J81ddKhlsiT5q42ByM3sdlpgoHl/89WyRb56s=
Subject: patch "iio: adc: ad7606: check for NULL before calling sw_mode_config()" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:55 +0200
Message-ID: <2025050155-edge-reverence-32c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7606: check for NULL before calling sw_mode_config()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 5257d80e22bf27009d6742e4c174f42cfe54e425 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:09 -0500
Subject: iio: adc: ad7606: check for NULL before calling sw_mode_config()
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
---
 drivers/iio/adc/ad7606.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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
 
-- 
2.49.0



