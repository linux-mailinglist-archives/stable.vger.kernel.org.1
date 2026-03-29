Return-Path: <stable+bounces-230892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LMNF6AkyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:09:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D3352167
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C3C300E712
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C3D30DEB8;
	Sun, 29 Mar 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFZGXy6Q"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C9433AD
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789673; cv=none; b=M75YEXBxt7sraYhv9mJcT3ls6bW1LT7zHqghPkoXmpC/zCf+G+8sLgW/d58dz1dzJ/QIpgDIhFbXhcy7uk2Bs/mVYZCIgMyi0m11X+X6XSKdeISd3t5v6Pi1DAqMHphv5NdPWNlBZdIG0SBqAQUqg4+dM3XSz2Os6FQmhPfFe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789673; c=relaxed/simple;
	bh=8vKl4VALwd/EIEB3Z7Ky+d1IztGqeEFlcxHiQnOzj/k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=JNeANWumc2gk8r2IWjQZm0NwbSMaKK+/TFafe7vYEkCrla0af1tHycRSUfyHIRNBlYe3BcJxgTNy0PeV2o3VK1CP2cdZ8VYXpBMYJ7jpJAa0AG2lXcPQkn+uUxosooWfK+ZLSVm7djpbhCtjxypgQLZHJCj8OA4ZvU3FdPTAYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFZGXy6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5E9C116C6;
	Sun, 29 Mar 2026 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774789673;
	bh=8vKl4VALwd/EIEB3Z7Ky+d1IztGqeEFlcxHiQnOzj/k=;
	h=Subject:To:From:Date:From;
	b=IFZGXy6QBmPYI7neO4XXaFjgK48xjsJ/9CmwRDzeG5BJyambiscwrvbFL5wn3+fwb
	 NnSxMW5hJAUuY8hWjCl71sP30Xtt4Omb2308ZeXzFHQTGG3MRfe5fYE50KQsubRkTF
	 fpgXPI4IdjBESaa4t/OwfHtICCB0gJL0adQBtYDU=
Subject: patch "iio: adc: ad7768-1: remove switch to one-shot mode" added to char-misc-next
To: Jonathan.Santos@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:43:48 +0200
Message-ID: <2026032948-traffic-boggle-556b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230892-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 8A3D3352167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7768-1: remove switch to one-shot mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 81fdc3127d013a552465c3bf9829afbed5184406 Mon Sep 17 00:00:00 2001
From: Jonathan Santos <Jonathan.Santos@analog.com>
Date: Mon, 23 Feb 2026 08:59:35 -0300
Subject: iio: adc: ad7768-1: remove switch to one-shot mode

wideband low ripple FIR Filter is not available in one-shot mode. In
order to make direct reads work for all filter options, remove the
switch for one-shot mode and guarantee device is always in continuous
conversion mode.

Fixes: fb1d3b24ebf5 ("iio: adc: ad7768-1: add filter type and oversampling ratio attributes")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 4cb63ab4768a..a927ae288fbb 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,17 +463,8 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
-	if (ret < 0)
-		return ret;
-
 	reinit_completion(&st->completion);
 
-	/* One-shot mode requires a SYNC pulse to generate a new sample */
-	ret = ad7768_send_sync_pulse(st);
-	if (ret)
-		return ret;
-
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
@@ -492,14 +483,6 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (st->oversampling_ratio == 8)
 		readval >>= 8;
 
-	/*
-	 * Any SPI configuration of the AD7768-1 can only be
-	 * performed in continuous conversion mode.
-	 */
-	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
-	if (ret < 0)
-		return ret;
-
 	return readval;
 }
 
@@ -1248,6 +1231,10 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
+	if (ret)
+		return ret;
+
 	/* For backwards compatibility, try the adi,sync-in-gpios property */
 	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
 						   GPIOD_OUT_LOW);
-- 
2.53.0



