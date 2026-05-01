Return-Path: <stable+bounces-242314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPVbGZyJ9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:08:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC54ABE5D
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA83B3009982
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E375387378;
	Fri,  1 May 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tisZF75T"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8D35F5E1
	for <Stable@vger.kernel.org>; Fri,  1 May 2026 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633688; cv=none; b=BjG7+leh7ikB/lPlASX14EQKgrd3NCWA2lcJXbh9R1h/7Dm0sXu5S8HKJDdqTsxjbTqP3CKakL7TLMsB+/2CHRYOQXunLyzQ/8qsEs57BfgaE8os614WSbetOdleqjj8wZTrK1DOpM73KPVwF4Xz7Sn4ae7QWU4pCc+guz88n5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633688; c=relaxed/simple;
	bh=gqoAS2E0Qeh1pIECB9NTPQhqN9r5nPp+BsFupPzR0CU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FLjdckg+wnYCGkvkghWnNEfChp//38RrOJh1IYNd/INUy4wx3mOuFdxjraJQFFRxrUkiy4I8IMY0SaJ8iFe6srfZarYzoHL8OTKkI69b6r+WCJ2vEKlOJACHZULhwd1f1SaCpQt+/OAIb3Zs6QfGzxsy1150Fx8Vi5kK0PFjM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tisZF75T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1228C2BCB4;
	Fri,  1 May 2026 11:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633688;
	bh=gqoAS2E0Qeh1pIECB9NTPQhqN9r5nPp+BsFupPzR0CU=;
	h=Subject:To:Cc:From:Date:From;
	b=tisZF75TeFXAK1Cj3SU9rnS+iyFQIo4aZChme0fIiNieTGAa/GqFO0EuI5xLGjt0d
	 nLv5gVPX9m0TqccpbK3V92M5KttjytCYzKtgvdSCghnWsVcgtmkf6+q+2kplSIElr/
	 VnIEfvdAbKqgd+oumzWYCHR4lGzAzj5qVz+jfLmw=
Subject: FAILED: patch "[PATCH] iio: adc: ti-ads7950: use" failed to apply to 5.15-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:08:05 +0200
Message-ID: <2026050105-cozily-nucleus-6263@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0AC54ABE5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-242314-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,huawei.com:email,baylibre.com:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7806c060cceb2d6895efbb6cff2f2f17cf1ec5de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050105-cozily-nucleus-6263@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7806c060cceb2d6895efbb6cff2f2f17cf1ec5de Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 16:12:24 -0500
Subject: [PATCH] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()

Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
when writing the timestamp in the rx_buf.

The previous implementation would have been fine on architectures that
support 4-byte alignment of 64-bit integers but could cause issues on
architectures that require 8-byte alignment.

Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


