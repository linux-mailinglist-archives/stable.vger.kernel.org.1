Return-Path: <stable+bounces-260545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yTkMO2xIWrZLQEAu9opvQ
	(envelope-from <stable+bounces-260545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 19:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4F6423B9
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 19:12:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Tew3MkVf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260545-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260545-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAECA3005A88
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC28495505;
	Thu,  4 Jun 2026 17:10:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E348C8BD
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 17:10:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593007; cv=none; b=QFTIPHvDQOTrmazDdy9hd+H+qqXzAHHMtUQA9sKFxfLc6yGVifNMo3U6mklFLHJ0+lwFbC5E+2ByjG07rDbv4AqwJ7HBCUy5/7Socl79hxanerdVrjfHp6E1Xz1KkwMAHHmA9ffg4U1EVeMBLKp3PgZmdQnv26WTo4BW9x8ltBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593007; c=relaxed/simple;
	bh=+ZF9IzaQpwC0XZ+xT78JZ0zbZYMNPWGEVTL1j3BOpw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMrMy6+Ne4EY3KEIpDzI7r6AaFAri12QlnZQf82sH3q6tLB6cQM0rsBeIX2/1xp0jvddv/68vvF729PvbbDlcwRh7LfwlEJZJxkjbHTV7IJ9pgaq0QcuVQawXPU4vq4daY3BjS/tJmR16Tt5XlHHSZPS4RfBspaeOAf0v83WudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tew3MkVf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305A1F00893;
	Thu,  4 Jun 2026 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780593006;
	bh=9pqPXtKJKGTnLbBhrWyvwb4AtViNUjLUdT/KMU4Ibp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tew3MkVfxa4AAzALyXdUAwqM1LoZMu936Jbf9FyPomrlCGXYPYTcG2lYqgk4LyNap
	 OmPqm5iJhMdZyy58MXDEDUaX6HCFFrUse3lPElSbA1qHCT0xsxhvaQcfBiCqU3b69I
	 +jMcobM2/lS1c+Gg7OEopeaWyzRR+2Yp11dIXJxNDKRrLMG5y/WGPUVadwya3p2aYO
	 UqDl8PENCaUqouoPhNAGoc5T3Dr7pxSB/Zjkx0ppHA6rSnNneokdwYo1bQcAF8XzED
	 VUxE+AfMo0Ui7O0v7CcJDpzLCrmvA9JiuxMWVTrV6LFKNhEtB26n7WjjOpiYia/uog
	 cCbddK2Li8L8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: dac: ad5686: fix powerdown control on dual-channel devices
Date: Thu,  4 Jun 2026 13:10:02 -0400
Message-ID: <20260604171002.4023757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060443-oxygen-unscathed-a75b@gregkh>
References: <2026060443-oxygen-unscathed-a75b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260545-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rodrigo.alencar@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,analog.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60C4F6423B9

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

[ Upstream commit 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5686.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index be705f8148cc39..315d213be83a8e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,22 +25,37 @@ static const char * const ad5686_powerdown_modes[] = {
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
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	guard(mutex)(&st->lock);
+
+	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	guard(mutex)(&st->lock);
+
+	st->pwr_down_mode &= ~(0x3U << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -55,10 +70,12 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	guard(mutex)(&st->lock);
+
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -78,9 +95,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		return ret;
 
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -453,7 +470,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	u8 cmd;
 	int ret, i, voltage_uv = 0;
 
@@ -488,9 +505,18 @@ int ad5686_probe(struct device *dev,
 	else
 		st->vref_mv = st->chip_info->int_vref_mv;
 
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
-- 
2.53.0


