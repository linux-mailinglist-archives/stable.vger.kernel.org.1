Return-Path: <stable+bounces-230894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGgJFVYlyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:12:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8863521AD
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E29E3012CCA
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EEC370D51;
	Sun, 29 Mar 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4iPlRRw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADD36B05F
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789969; cv=none; b=s+jskCgBcaZhTnFQsQLkAmIFJyCRhBg2KBi8UzkSkAWhxMrQ9AbGee+vU8vv6HUZBXY+tLVQjS3zs2iEa2+RmScr/4Jap9+fl2Sxm8gK65jeKDHohGguNTO6OvYB+Yy5D11eiQFgRGfgdz2eJVz2fkQ6AaO2Y7Qe/8QX61V0m8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789969; c=relaxed/simple;
	bh=UEWYV4iqiHVmrrP7kCyGsZdxcAHT632D/XEu/h2YUsc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Q+5GSOG8jrTnWhJ+PNS2p095o1wgyYWFlkNbe/Fsl0T7QsWRyYc5bp7cGShRLbYzc+LOxTnlXrpuvbdW56n6Tje57SLNBKa8XHTD2JPro66MlcLHWT+AVlswFj7cJFecqIDk5nqo5H2OQbqExnBepdUe7hQt6zJxg/FMr9utrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4iPlRRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B75FC116C6;
	Sun, 29 Mar 2026 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774789968;
	bh=UEWYV4iqiHVmrrP7kCyGsZdxcAHT632D/XEu/h2YUsc=;
	h=Subject:To:From:Date:From;
	b=p4iPlRRw4OZtvJSgQXSYHp3eEcVwpbfNckWcvHaw4SA1Kf5grWNzW70cIkNre8Rl9
	 QfUJ6gphLLk/gDcUW3sLPK9tl9LDPKhKS28sNt3ZdfQPl0F8qnzQ42r7LcFBuGA4vh
	 KTFQpsR4KH6uKlGZnd3+wJ5YtvyPr5QWy1DdXt6I=
Subject: patch "iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:44:19 +0200
Message-ID: <2026032919-facebook-plasma-e48f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230894-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: BF8863521AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 7806c060cceb2d6895efbb6cff2f2f17cf1ec5de Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 16:12:24 -0500
Subject: iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
when writing the timestamp in the rx_buf.

The previous implementation would have been fine on architectures that
support 4-byte alignment of 64-bit integers but could cause issues on
architectures that require 8-byte alignment.

Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads7950.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index fa3b446495ec..4e9359b259fc 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -47,8 +47,6 @@
 #define TI_ADS7950_MAX_CHAN	16
 #define TI_ADS7950_NUM_GPIOS	4
 
-#define TI_ADS7950_TIMESTAMP_SIZE (sizeof(int64_t) / sizeof(__be16))
-
 /* val = value, dec = left shift, bits = number of bits of the mask */
 #define TI_ADS7950_EXTRACT(val, dec, bits) \
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
@@ -105,8 +103,7 @@ struct ti_ads7950_state {
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
-		__aligned(IIO_DMA_MINALIGN);
+	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
 	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
 	u16 single_tx;
 	u16 single_rx;
@@ -307,8 +304,10 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
+					      sizeof(*st->rx_buf) *
+					      TI_ADS7950_MAX_CHAN,
+					      iio_get_time_ns(indio_dev));
 
 out:
 	mutex_unlock(&st->slock);
-- 
2.53.0



