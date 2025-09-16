Return-Path: <stable+bounces-179705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1951B590C4
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7926317CEAB
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1927A456;
	Tue, 16 Sep 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Owd0ViO6"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3423313E
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011635; cv=none; b=GkcNtf2Lnl9wiEeg9CMXJJbWcmfvG8unQtJZOTrInCG5xcdn6gR2TU57RH0gdzWI5FjPZNVAUjO0Z2tcB22O+SpJmhN+8MVZtvkTFx3VggZvqe4iB3e8rS07JJCmv3n98OalAbZAjJf8z6vahGC4YVNJML870NmoH0yCnkLExEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011635; c=relaxed/simple;
	bh=W+cRqd6H4Wt1kl8ItkPq2Ry6e4hJky9Oxg03UpTR0lk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RwoLELTYSMPVsp9UlKmGufMOd4HsXyyFRumiTLfFgO74CjCJyUIFvgy5OrnNzx2IYgkcojDaimc3yopq33t5fnrI+w2bIiir7tt7e/mC61PjUFxThv/W/Tu6MvyCqxQrOR0n+OjseNGeiJIy5XtXm/MP0/zG1tNmdb6m1xRqvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Owd0ViO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF2C4CEEB;
	Tue, 16 Sep 2025 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011634;
	bh=W+cRqd6H4Wt1kl8ItkPq2Ry6e4hJky9Oxg03UpTR0lk=;
	h=Subject:To:From:Date:From;
	b=Owd0ViO6H498CiaR+dLb0UuI31hGbsoa/75FSVbLOln58MA/IZfzJ8AfXiRDBJpVS
	 PhkbMznMB6BqaW27/SOsandHMBPdUDC2cxvql2pTdC2BkM+2fR0GoDu7yIjqAEndT/
	 88sz1IjSx7kwBRJ0+vz/i2J1tlk+qpJIx3LX4ViU=
Subject: patch "iio: frequency: adf4350: Fix prescaler usage." added to char-misc-next
To: michael.hennerich@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy@kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:33:01 +0200
Message-ID: <2025091601-sprout-juvenile-f7a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: frequency: adf4350: Fix prescaler usage.

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 33d7ecbf69aa7dd4145e3b77962bcb8759eede3d Mon Sep 17 00:00:00 2001
From: Michael Hennerich <michael.hennerich@analog.com>
Date: Fri, 29 Aug 2025 12:25:42 +0100
Subject: iio: frequency: adf4350: Fix prescaler usage.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
When set to 4/5, the maximum RF frequency allowed is 3 GHz.
Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
In this context not the RF output frequency is meant
- it's the VCO frequency.

Therefore move the prescaler selection after we derived the VCO frequency
from the desired RF output frequency.

This BUG may have caused PLL lock instabilities when operating the VCO at
the very high range close to 4.4 GHz.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/adf4350.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 47f1c7e9efa9..475a7a653bfb 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -149,6 +149,19 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 	if (freq > ADF4350_MAX_OUT_FREQ || freq < st->min_out_freq)
 		return -EINVAL;
 
+	st->r4_rf_div_sel = 0;
+
+	/*
+	 * !\TODO: The below computation is making sure we get a power of 2
+	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
+	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
+	 * and friends.
+	 */
+	while (freq < ADF4350_MIN_VCO_FREQ) {
+		freq <<= 1;
+		st->r4_rf_div_sel++;
+	}
+
 	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
 		prescaler = ADF4350_REG1_PRESCALER;
 		mdiv = 75;
@@ -157,13 +170,6 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
 		mdiv = 23;
 	}
 
-	st->r4_rf_div_sel = 0;
-
-	while (freq < ADF4350_MIN_VCO_FREQ) {
-		freq <<= 1;
-		st->r4_rf_div_sel++;
-	}
-
 	/*
 	 * Allow a predefined reference division factor
 	 * if not set, compute our own
-- 
2.51.0



