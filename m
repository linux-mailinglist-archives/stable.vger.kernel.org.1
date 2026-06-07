Return-Path: <stable+bounces-261493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YOUgGglLJWosGQIAu9opvQ
	(envelope-from <stable+bounces-261493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B864FECD
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Fs0x/ljn";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261493-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261493-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68350304C62B
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D43254A9;
	Sun,  7 Jun 2026 10:39:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AC2D3A69;
	Sun,  7 Jun 2026 10:39:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828767; cv=none; b=RMm7a2o9z4Ls91KAO2HgTYXhiHgkUhY2+cZ8L1d1G6fLE7lcUwo0f9OzVZespu6YlvMAwvWKCc077GigSEbIIAx1kPkgrxbANrIo9kdkMrrwfXKCFze9A0rOMzWP3S7SxQKz0dHUezsW6UUWtYOcYb4dVmw+XtQPs3IAky/EdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828767; c=relaxed/simple;
	bh=shBthcWBQe1VwxNj4WahceN/nZmNpYKjDPam1cVPw44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxFjXm0YP9mPb/8LF4B5+PDJAhFbUdosyS/aD0+B4KEoZX8D2wL+2V2YSID2Bjq12vfHTvnJoa1Qyp9qz1785tKhyJ68xLcCaR/sRHEm5S7WiHbjJhetQJ4ohZbzQTkZKrtJRiRTuU4ylm074x0Xzk3YIGJy7oOiSEcuXPnurmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fs0x/ljn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3141F00893;
	Sun,  7 Jun 2026 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828766;
	bh=0Uyo9TfhgBG2t12ReH8jkAcSphtqAFwMQZDSV1/ZGpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fs0x/ljnTa9KwXWV33h+vAtv4KecQVAoyvT5b9KXfkThem3P+HiHUpyEv9+2F7RP0
	 rzvRMHFhijZ1Pw7UfzoMOYj8HGXu0FK82AJjeYW2o6H5v9nZQ23ghZo3UM3vBHmNj0
	 m78EUfbUw50DcUAigOMg1Q+KRLB5BHcwVUKU94uo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.18 160/315] iio: dac: ad5686: fix powerdown control on dual-channel devices
Date: Sun,  7 Jun 2026 11:59:07 +0200
Message-ID: <20260607095733.470777819@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rodrigo.alencar@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA4B864FECD

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

commit 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb upstream.

Fix powerdown control by using a proper bit shift for the powerdown mask
values. During initialization, powerdown bits are initialized so that
unused bits are set to 1 and the correct bit shift is used. Dual-channel
devices use one-hot encoding in the address and that reflects on the
position of the powerdown bits, which are not channel-index based
for that case. Quad-channel devices also use one-hot encoding for the
channel address but the result of log2(address) coincides with the channel
index value. Mask as 0x3U is used rather than 0x3, because shift can reach
value of 30 (last channel of a 16-channel device), which would mess with
the sign bit. The issue was introduced when first adding support for
dual-channel devices, which overlooked powerdown control differences.

Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad5686.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,26 +25,37 @@ static const char * const ad5686_powerdo
 	"three_state"
 };
 
+static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
+{
+	if (chan->channel == chan->address)
+		return chan->channel * 2;
+
+	/* one-hot encoding is used in dual/quad channel devices */
+	return __ffs(chan->address) * 2;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	st->pwr_down_mode &= ~(0x3U << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -59,12 +70,12 @@ static const struct iio_enum ad5686_powe
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -86,9 +97,9 @@ static ssize_t ad5686_write_dac_powerdow
 	guard(mutex)(&st->lock);
 
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -468,7 +479,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	bool has_external_vref;
 	u8 cmd;
 	int ret, i;
@@ -492,9 +503,18 @@ int ad5686_probe(struct device *dev,
 	has_external_vref = ret != -ENODEV;
 	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
+	/* Initialize masks to all ones provided the max shift (last channel) */
+	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
+	st->pwr_down_mask = GENMASK(shift + 1, 0);
+	st->pwr_down_mode = GENMASK(shift + 1, 0);
+
 	/* Set all the power down mode for all channels to 1K pulldown */
-	for (i = 0; i < st->chip_info->num_channels; i++)
-		st->pwr_down_mode |= (0x01 << (i * 2));
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
+		st->pwr_down_mask &= ~(0x3U << shift); /* powered up state */
+		st->pwr_down_mode &= ~(0x3U << shift);
+		st->pwr_down_mode |= 0x01U << shift;
+	}
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;



