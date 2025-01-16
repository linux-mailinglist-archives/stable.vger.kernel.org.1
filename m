Return-Path: <stable+bounces-109265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384FA13A2F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6AA1679F3
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BD1DE89D;
	Thu, 16 Jan 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ge29SYzq"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A981DE4EA
	for <Stable@vger.kernel.org>; Thu, 16 Jan 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031617; cv=none; b=a41UBB6PdvkKa3EpZ57MDDs+MSW2K/t/9jeFWMNGURmkqxEi4Sd2tyImFt/HO3wonEKiLN4nlCrBy8iwRniVGDxDPNPu4Qi4BDKtll6DbO0NH1XhKD2/wKwi2YoLlUgr+ffwqWNCRlmOUhz1uwXwS4y23zu58qis/B7nrQKxhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031617; c=relaxed/simple;
	bh=Ngtb5GYGoX5S3jWq4z3VB3QEPtSW+IMgAdbozW/5QJg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RbfN/v6A5Od5yniqbEnRJDYJ/S3raI8QMG5D7QOnCD61fudEGfs5cCTX2aDhLjGEQt9kHOqNzgdM2Om9SQfLTLRZ1HfsGKJWtB3jrvyE9oeObkmC+II0pVTmL0bRcmRW6eBQB87zdDABkavLkqJT9G+bttPZu2j2DIX7rR8acjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ge29SYzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86172C4CEE2;
	Thu, 16 Jan 2025 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737031616;
	bh=Ngtb5GYGoX5S3jWq4z3VB3QEPtSW+IMgAdbozW/5QJg=;
	h=Subject:To:From:Date:From;
	b=Ge29SYzqDG5SoJEp83ZK3RXGCUeRHTjyLUID8mw7+bDwtLHTFQEccrzCqH+W/bTqd
	 /Rs1yzibBW85lHa/l6IyLy2v5VE5oPlbb/9cTrZUV08Rrj0dcw6rwFzdmG+V0E6DRT
	 U1oZ1ZtJSgaIlnn+xoz8wPlzoUauetwlM1WJfQUo=
Subject: patch "iio: dac: ad3552r-hs: clear reset status flag" added to char-misc-next
To: adureghello@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jan 2025 13:46:39 +0100
Message-ID: <2025011639-gargle-multitude-f714@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r-hs: clear reset status flag

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 012b8276f08a67b9f2e2fd0f35363ae4a75e5267 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Wed, 8 Jan 2025 18:29:16 +0100
Subject: iio: dac: ad3552r-hs: clear reset status flag

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3552r-hs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..8974df625670 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);
-- 
2.48.1



