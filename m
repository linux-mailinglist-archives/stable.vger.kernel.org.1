Return-Path: <stable+bounces-115037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70AA3222D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D647A33F7
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B41F0E25;
	Wed, 12 Feb 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNnBQgU2"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C191EDA22
	for <Stable@vger.kernel.org>; Wed, 12 Feb 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352690; cv=none; b=p2jAVdkVYS+VKmxNJhGVkHeORAeQzIb+TkaqaQYRpRrvfL5lv+Il7iK3hcmLESfBgg4znivBp7ifnkaaaQXhSbnS2uqbUN9LzfVMRHh00HJqlRpfd2kUPZyIjHb1tJml9pfgL54sB2BvIiNT4XMCxd20A1zLItXsr/FEKsXXWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352690; c=relaxed/simple;
	bh=xO8MV+NDtWUfjHcK6pHakutd3MjLZ1yTGZdUxMcCgXI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OKiWKRigA0lZp94YbDwmRf7yceiusj0Fnr9i0kmXm4Q/XSHAQvav3Ak5lADwhTjT8XWU9WJ+TwLM0SZjc+C2q6oj6gZ444A3sWftZ3+F5P/kB6kYaibRjJBgdH183vqn9f7t3FgwbQuQ8CldJAVfZ7fpJs7yQ1bEFe6uXIMfkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BNnBQgU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9756C4CEDF;
	Wed, 12 Feb 2025 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739352690;
	bh=xO8MV+NDtWUfjHcK6pHakutd3MjLZ1yTGZdUxMcCgXI=;
	h=Subject:To:From:Date:From;
	b=BNnBQgU2p+4IxihmtkNLrR4kuU1XawEns+Ky6EbdgPxvu5TX5A3VOL8pYGXKehZQ3
	 ztTPvn5uvVKXbVLym+NOrHvH5jQ8SB1/XM8wmw9d3GJW4XCQHymBTnU1eDoJAoWYlC
	 43f8w5i7qS2MGl/RK9ejY6d6GIkquTC/Famv6aVQ=
Subject: patch "iio: dac: ad3552r: clear reset status flag" added to char-misc-linus
To: adureghello@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Feb 2025 10:27:04 +0100
Message-ID: <2025021204-script-stark-16b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r: clear reset status flag

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e17b9f20da7d2bc1f48878ab2230523b2512d965 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Sat, 25 Jan 2025 17:24:32 +0100
Subject: iio: dac: ad3552r: clear reset status flag

Clear reset status flag, to keep error status register clean after reset
(ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the "Error
Status Register" was dirty (0x01). It is important to clear this bit, so
if there is any reset event over normal working mode, it is possible to
detect it.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250125-wip-bl-ad3552r-clear-reset-v2-1-aa3a27f3ff8c@baylibre.com
Cc: <Stable@vger..kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3552r.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e7206af53af6..7944f5c1d264 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -410,6 +410,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
 					AD3552R_MASK_ADDR_ASCENSION,
-- 
2.48.1



