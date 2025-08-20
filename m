Return-Path: <stable+bounces-171878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83DB2D780
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D023F5E4B98
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225492D7813;
	Wed, 20 Aug 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lGiRH67b"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3209283153
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680746; cv=none; b=SCL9u3s7NJm+nVu8qE0QcJ+ZvhAR7m5uAUOHxon0OerNKSEXDpHNkb4J9yCJLbHHC36DCSdrWDNpNSX+74pkp+f3piN/mHQEC+kpY1n/rUqqKLhp2jM4gIS7N36BUkBGa23vdqko1EdjICe7GsyuQ/H0bqA+Ta+sEQQN4B9Jz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680746; c=relaxed/simple;
	bh=48zR95M+bnbFC0/UtlN8LdVVFdgabawDwMez5KGAwjY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=d0pEH8L5sAOyPnM5tdaFbXixQLkI3rknBGwG/A3l88Lzf+7IDOrkix7AQvWw53h1najTldJeqnsnBnU/PCYBu2I3GvCsm6es9G7xd1aerXFZfpKK7irxK86lbXaYlYf/4HzjSco/ucWBQFam8rJBHH7J2pMOK0GCdI9txfa12go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lGiRH67b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B37C4CEEB;
	Wed, 20 Aug 2025 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680746;
	bh=48zR95M+bnbFC0/UtlN8LdVVFdgabawDwMez5KGAwjY=;
	h=Subject:To:From:Date:From;
	b=lGiRH67by7lGV9tFJym5pqIXzxkbMiZBKolE2CAiqnhFRDWErjlyTZilJRDYkRud5
	 Koov8CCIU9FEjrYNSplIcWIaOT8nzD1aCGNK0hIC3exzH3kqzDTu9YJDo1M/PYHF2u
	 YMmEYLZL0C2SOAxHVKe6xlcC1Drnn268F5gUl0l0=
Subject: patch "iio: adc: ad7124: fix channel lookup in syscalib functions" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:34 +0200
Message-ID: <2025082034-semifinal-robust-d503@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: fix channel lookup in syscalib functions

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 197e299aae42ffa19028eaea92b2f30dd9fb8445 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 26 Jul 2025 11:28:48 -0500
Subject: iio: adc: ad7124: fix channel lookup in syscalib functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix possible incorrect channel lookup in the syscalib functions by using
the correct channel address instead of the channel number.

In the ad7124 driver, the channel field of struct iio_chan_spec is the
input pin number of the positive input of the channel. This can be, but
is not always the same as the index in the channels array. The correct
index in the channels array is stored in the address field (and also
scan_index). We use the address field to perform the correct lookup.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-v1-1-b9d14bb684af@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9808df2e9242..4d8c6bafd1c3 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -849,7 +849,7 @@ enum {
 static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
 {
 	struct device *dev = &st->sd.spi->dev;
-	struct ad7124_channel *ch = &st->channels[chan->channel];
+	struct ad7124_channel *ch = &st->channels[chan->address];
 	int ret;
 
 	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
@@ -865,8 +865,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
-			chan->channel, ch->cfg.calibration_offset);
+		dev_dbg(dev, "offset for channel %lu after zero-scale calibration: 0x%x\n",
+			chan->address, ch->cfg.calibration_offset);
 	} else {
 		ch->cfg.calibration_gain = st->gain_default;
 
@@ -880,8 +880,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
-			chan->channel, ch->cfg.calibration_gain);
+		dev_dbg(dev, "gain for channel %lu after full-scale calibration: 0x%x\n",
+			chan->address, ch->cfg.calibration_gain);
 	}
 
 	return 0;
@@ -924,7 +924,7 @@ static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 
-	st->channels[chan->channel].syscalib_mode = mode;
+	st->channels[chan->address].syscalib_mode = mode;
 
 	return 0;
 }
@@ -934,7 +934,7 @@ static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 
-	return st->channels[chan->channel].syscalib_mode;
+	return st->channels[chan->address].syscalib_mode;
 }
 
 static const struct iio_enum ad7124_syscalib_mode_enum = {
-- 
2.50.1



