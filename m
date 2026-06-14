Return-Path: <stable+bounces-263057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4heNMrdELmrJrgQAu9opvQ
	(envelope-from <stable+bounces-263057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:05:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998C680757
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wOJYpQeo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263057-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263057-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0581830041FC
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 06:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99C02F8BEE;
	Sun, 14 Jun 2026 06:05:41 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34528AB0B
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417141; cv=none; b=fnOP4HHKZB/ZRXCRRCet6uEyRa9eEqg0ifIvuOVpObPSRBvqwMo2ww6cNsWvWVdi/ulw8VKq7zJ+XTwLL2IXdaz49+rXrsxlm5NHhMz1LsgcnAZi5EsljQEZKDwn82NjO0H2zWKjEXWGed5lLXFT96ErY2qqJYnSBkXwCjuZzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417141; c=relaxed/simple;
	bh=msyvBo7cpQ4jxgsVYP8kzFTidBNx04zzSjO6+joVvBw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=j5z7e0AWrE/hyq0Jifx82f43ym8vNcQo7vyDQnn2I2IzRluUVNQ9VJohrXMILqSZmQg/Xdig7psAw1X7MTVwYH4e2f9EdSC6N5DzmjsekF+anOQtm4Zg9VtkeY5OxMdaNr41YMwL2ihjyVI/9ChhZZrqLYhqmUM5rplB587a/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOJYpQeo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022B61F000E9;
	Sun, 14 Jun 2026 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417140;
	bh=Iaf1XQsH9ISVxh671LBk5Ooz5R9Y70bggqHeWNlFVDY=;
	h=Subject:To:From:Date;
	b=wOJYpQeowvHobG2t9Gl4Gbn8GBBKTN/WFmOx9OKLpvQZvVW01UWy/yTn3MaBrm1Sx
	 IfeM7Q3jjU4Ad2ED/2SgLzfp9QmqivSmbpo2+lh1kb3BwArVvJIyrvx0siD6t0+t9m
	 lSqNs+yM2kR8y54aT5XKPHZEEiAzwaoWcxZ9ljdg=
Subject: patch "iio: adc: ad_sigma_delta: fix CS held asserted and state leaks" added to char-misc-next
To: radu.sabau@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:41 +0200
Message-ID: <2026061441-unblended-graceful-6bc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263057-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:radu.sabau@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,gregkh:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8998C680757


This is a note to let you know that I've just added the patch titled

    iio: adc: ad_sigma_delta: fix CS held asserted and state leaks

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c72da0688575e5ef39c36bb44fed53aa18f8ae65 Mon Sep 17 00:00:00 2001
From: Radu Sabau <radu.sabau@analog.com>
Date: Wed, 27 May 2026 12:38:38 +0300
Subject: iio: adc: ad_sigma_delta: fix CS held asserted and state leaks

In ad_sigma_delta_single_conversion(), set_mode(AD_SD_MODE_IDLE) and
disable_one() were called from the out: block while keep_cs_asserted
was still true. This caused any SPI transfer issued by those callbacks
to carry cs_change=1, leaving CS permanently asserted after the
conversion. Fix by moving both calls into the out_unlock: block, after
keep_cs_asserted is cleared, matching the pattern already used in
ad_sd_calibrate().

In the error path of ad_sd_buffer_postenable(), if an operation fails
after set_mode(AD_SD_MODE_CONTINUOUS) has already succeeded (e.g.
spi_offload_trigger_enable()), the device is left in continuous
conversion mode with CS physically asserted. Additionally,
bus_locked remaining true after spi_bus_unlock() causes subsequent
SPI operations to call spi_sync_locked() without the bus lock actually
held, allowing concurrent SPI access.

Fix the error path by clearing keep_cs_asserted first, then calling
set_mode(AD_SD_MODE_IDLE) to revert the device mode and deassert CS,
then clearing bus_locked before releasing the bus.

For devices that implement neither set_mode nor disable_one (such as
MAX11205, which has no physical CS pin), no SPI transfer is issued
during cleanup and the cs_change flag has no effect on any physical
line.

Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready signals")
Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a955556f9ec8..651ade67ad2e 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -441,11 +441,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 out:
 	ad_sd_disable_irq(sigma_delta);
 
-	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
-	ad_sigma_delta_disable_one(sigma_delta, chan->address);
-
 out_unlock:
 	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, chan->address);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 out_release:
@@ -578,6 +577,9 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return 0;
 
 err_unlock:
+	sigma_delta->keep_cs_asserted = false;
+	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 	spi_unoptimize_message(&sigma_delta->sample_msg);
 
-- 
2.54.0



