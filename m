Return-Path: <stable+bounces-230925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFaSER4pyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:29:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD83523DC
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73BAE3004435
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F1375F69;
	Sun, 29 Mar 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TpYGo5BL"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE23644D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790936; cv=none; b=jRNnTL9U00rkhfKavaxyHn2Vztdvdn+J69LIpwWkWLAeh2lS1mMExePIB/Lzze8iLp7kTTyVLm5pKlIsyswy5UJqzHxVmqHdXZXQB7VQkXOBS/ddr4SwenKq1K+8Za7eAq4atHF/V2Shfd/zSZKqpKKqNqT1WBSZp8Fkrbq7U2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790936; c=relaxed/simple;
	bh=JAe4AGkxENJZ7IFlNw931yNPIEAHfTABMNF48xvMtVo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=k7UHAl7+1z8p78TF1iTFjagNVDwVyOh0ZuYYpi3zKUzuHkJE/ra0bWRYK5huMePO+ihqmbaTT3bqwNVyqNzlHXx7HQ6bFk/B+gYmpE2wbFnxhSUOUCBuOrbn65om424khSNUygGI/VPdSCycByqQv16ysrtlBmBksj/2XGskGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TpYGo5BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462D4C116C6;
	Sun, 29 Mar 2026 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790936;
	bh=JAe4AGkxENJZ7IFlNw931yNPIEAHfTABMNF48xvMtVo=;
	h=Subject:To:From:Date:From;
	b=TpYGo5BLJRRKV3bczNkSdnmN5JnQ6qHUOWKXh6fGxAnG0KvTpcbAXHkj99L4YaFNB
	 Ii5/7k5++maIxKhv7BCE1JCjlE6amFIf6Rl9M6mEQFVT/DNJj9wNpin8lsCRuw1XSO
	 O0aVT8vGu4t/D69b2WkO8Wf8aWoRpApvq236WGkE=
Subject: patch "iio: light: vcnl4035: fix scan buffer on big-endian" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:15 +0200
Message-ID: <2026032915-hug-reflux-35d6@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230925-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,baylibre.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68AD83523DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: light: vcnl4035: fix scan buffer on big-endian

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fdc7aa54a5d44c05880a4aad7cfb41aacfd16d7b Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 17:18:10 -0500
Subject: iio: light: vcnl4035: fix scan buffer on big-endian

Rework vcnl4035_trigger_consumer_handler() so that we are not passing
what should be a u16 value as an int * to regmap_read(). This won't
work on bit endian systems.

Instead, add a new unsigned int variable to pass to regmap_read(). Then
copy that value into the buffer struct.

The buffer array is replaced with a struct since there is only one value
being read. This allows us to use the correct u16 data type and has a
side-effect of simplifying the alignment specification.

Also fix the endianness of the scan format from little-endian to CPU
endianness. Since we are using regmap to read the value, it will be
CPU-endian.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 963747927425..16aeb17067bc 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -103,17 +103,23 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
+	struct {
+		u16 als_data;
+		aligned_s64 timestamp;
+	} buffer = { };
+	unsigned int val;
 	int ret;
 
-	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
+	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
 		goto fail_read;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-					iio_get_time_ns(indio_dev));
+
+	buffer.als_data = val;
+	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
+					   iio_get_time_ns(indio_dev));
 
 fail_read:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -381,7 +387,7 @@ static const struct iio_chan_spec vcnl4035_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_LE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -395,7 +401,7 @@ static const struct iio_chan_spec vcnl4035_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_LE,
+			.endianness = IIO_CPU,
 		},
 	},
 };
-- 
2.53.0



