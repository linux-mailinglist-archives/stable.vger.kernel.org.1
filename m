Return-Path: <stable+bounces-160207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B84AF9589
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30BF1C86AE1
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126071A4F3C;
	Fri,  4 Jul 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lomAupqI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863A19F115
	for <Stable@vger.kernel.org>; Fri,  4 Jul 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639489; cv=none; b=dRTucYbuhfRZqVDT5V7R5ix7BZxQPI8tJAV7fpvOE9Xop5Ypq779hmxCPCPto691UImlyWqIC1rxcW7z52xOziR4i5svD/Dzspv0iNQ7NNQno+7RXbrpq0Qsg1tVdXMHJPnVvIvo0sPOeG+VV/GWNf4dtkf9AZcelaaG0Jki3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639489; c=relaxed/simple;
	bh=gJig4g5Hv24wBQ9SIfn1PhXMlFW6Z70DafLdQHqXybo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=VfM2dbKRWkTOdnOqUYWJ0xg8iSSRrIWSkiLxW8eRjEHxXuz/0MdGlukb1LR3zg3y+QF8gjHiJPAS9GtHWia4guLZnD0VMiRmTOkseyNgtaFcNkgbLjvnnjHTaunMbsvpJbyyHk+E2acneOkMenSrbXz4FhUqz2bvCbPVvgjFoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lomAupqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF9FC4CEEB;
	Fri,  4 Jul 2025 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639489;
	bh=gJig4g5Hv24wBQ9SIfn1PhXMlFW6Z70DafLdQHqXybo=;
	h=Subject:To:From:Date:From;
	b=lomAupqIn8fLezIil7KPwjnm+u+btJQGtVZIRX3M0simOESPNAjUEord/AvgxQOT/
	 vZORNjmIo2KBJ3jv8vaIGzmEDHV/pyef9+WD9jXb3li8GhfcokKwqhMmV9Bqggar2a
	 4/mVHcnebe8f4hfm73+2x+Jl/xqrCR3YMySEYRbE=
Subject: patch "iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in" added to char-misc-linus
To: kimseer.paller@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Jul 2025 16:30:52 +0200
Message-ID: <2025070452-repeater-dwelling-09e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1131e70558bc70f1fc52515281de2663e961e1cc Mon Sep 17 00:00:00 2001
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 26 Jun 2025 16:38:12 +0800
Subject: iio: dac: ad3530r: Fix incorrect masking for channels 4-7 in
 powerdown mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the current implementation of ad3530r_set_dac_powerdown() function,
the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
the bitmask for the operating mode of a specific channel. However, this
macro does not account for channels 4-7, which map to the second
register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
a result, the bitmask is incorrectly calculated for these channels,
leading to improper configuration of the powerdown mode. Resolve this
issue by adjusting the channel index for channels 4-7 by subtracting 4
before applying the macro. This ensures that the correct bitmask is
generated for the second register.

Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250626-bug_fix-v1-1-eb3c2b370f10@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3530r.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index f9752a571aa5..6134613777b8 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -166,7 +166,9 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	      AD3530R_OUTPUT_OPERATING_MODE_0 :
 	      AD3530R_OUTPUT_OPERATING_MODE_1;
 	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
-	mask = AD3530R_OP_MODE_CHAN_MSK(chan->channel);
+	mask = chan->channel < AD3531R_MAX_CHANNELS ?
+	       AD3530R_OP_MODE_CHAN_MSK(chan->channel) :
+	       AD3530R_OP_MODE_CHAN_MSK(chan->channel - 4);
 	val = field_prep(mask, pdmode);
 
 	ret = regmap_update_bits(st->regmap, reg, mask, val);
-- 
2.50.0



