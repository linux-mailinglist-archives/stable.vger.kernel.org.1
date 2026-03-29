Return-Path: <stable+bounces-230890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMV8HHAjyWljvAUAu9opvQ
	(envelope-from <stable+bounces-230890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:04:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBA352121
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F7B3013AA7
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCED35F5FE;
	Sun, 29 Mar 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwxG91Xf"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C72ECEA5
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789250; cv=none; b=TtNA94FWyDEYpagodD9rZskNETmg3KGf2WWIdSEX7VetciHgW0Sj4eXvdC2U+B+tQiySDsVlrHkgYA/T+CLC1vel/iXLQtgp9Pj6gfJmGwwpE/IdWqXCc+jNsVMKvTM4NjqVyLCeU4abQTwsSLNuvhA+6d4Q8e3hVMR5RoFDhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789250; c=relaxed/simple;
	bh=Dj065f5DmjzanqBrDL1O9moCaU1iS8JAo7trqDSDqs4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=dz63U8+8latvbHRfgbx+LFILR40582vUSJceBXkkonsgRtySpsBtmUEQL4eqOmVaPTmaxwf9AbHfPH+5MNsUpl56gcRSwaiWmkOX6Q88eCVAdugAlx/5qHh159ZvN19FIvuWMA/sLCMZqAaSUC9CJBbcQOvtC4cXHjn8wTHdIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwxG91Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C399C116C6;
	Sun, 29 Mar 2026 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774789249;
	bh=Dj065f5DmjzanqBrDL1O9moCaU1iS8JAo7trqDSDqs4=;
	h=Subject:To:From:Date:From;
	b=VwxG91XfPYPD7FiDiw3rDbXd8K7jkg85RqxWWROnsBkAbrNgzmK1aU7SRS4I9Y+Ta
	 6kjIEWEIsZlAhqfZYprSq4Og5tVagE79cNe8a5V26ryXzhSAB8NAaUmkMZbXhI8Ztm
	 c5Fc8ZIK3mcdlX+Js13aIWT1rz5J8O16YdrYKagc=
Subject: patch "iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:42:22 +0200
Message-ID: <2026032922-unsocial-hurt-3184@gregkh>
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
	TAGGED_FROM(0.00)[bounces-230890-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C2BBA352121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads7950: use iio_push_to_buffers_with_ts_unaligned()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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



