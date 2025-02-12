Return-Path: <stable+bounces-115035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE5A3221B
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D1162A26
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB1205E24;
	Wed, 12 Feb 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rjJLyaHz"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6702046A1
	for <Stable@vger.kernel.org>; Wed, 12 Feb 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352498; cv=none; b=nAIzh6fKUyRv+ZRDTKca4mffcCvWoYiZwagOkuDki46CsOkF9D94UNQDxElhGWPmk0GpGyRO0scZGZmYnD+m6qnjNW42CHhShxMyRzKU6i9M8AgnLmmPGNxs3wMtiofyEpH+IiuzKAMDukDJ0Q7YHls5/u/X6MG4Ke3fK2jyy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352498; c=relaxed/simple;
	bh=Zh6yxqhv/3lM/EhJImGuQYv/Qak4Ttlw5mXnuDUWjkk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=UdGCBovK2t83S4KDi6KtcBaDj+qbT97Fsy0DA+zzz4uu9S1iYCnv9HopthcIsdEKHoy6wKZn+lplsOUvVtmr7474sx+xTdHf3wBvbV3bclKVnFMCs6Km8g+gKE0Gu5RENNgLPjNb1iJ2Pn/RlR+QaiNhLxpyY/MdZS23CM+y64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rjJLyaHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4350DC4CEDF;
	Wed, 12 Feb 2025 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739352497;
	bh=Zh6yxqhv/3lM/EhJImGuQYv/Qak4Ttlw5mXnuDUWjkk=;
	h=Subject:To:From:Date:From;
	b=rjJLyaHz7S0XcGTn8WJvqrrLyXunbGbSeJrUYgtlXVtW9dIDsYaAUZtAaE7hQ6ZrQ
	 YNfxZ0gZ+Nlp3xKRhmoUQAq/1o4KRDidaArUs0C3kAnk9Y8DgOGKT4hhUcyyC+kPkO
	 LXMFdcee0SdMBbAP/bGF/CT3zLUosFoTENIFw1ug=
Subject: patch "iio: adc: ad7192: fix channel select" added to char-misc-linus
To: markus.burri@mt.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Feb 2025 10:27:04 +0100
Message-ID: <2025021204-gangway-overcook-5332@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7192: fix channel select

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 21d7241faf406e8aee3ce348451cc362d5db6a02 Mon Sep 17 00:00:00 2001
From: Markus Burri <markus.burri@mt.com>
Date: Fri, 24 Jan 2025 16:07:03 +0100
Subject: iio: adc: ad7192: fix channel select
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Channel configuration doesn't work as expected.
For FIELD_PREP the bit mask is needed and not the bit number.

Fixes: 874bbd1219c7 ("iio: adc: ad7192: Use bitfield access macros")
Signed-off-by: Markus Burri <markus.burri@mt.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250124150703.97848-1-markus.burri@mt.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index e96a5ae92375..cfaf8f7e0a07 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1084,7 +1084,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
 
 	conf &= ~AD7192_CONF_CHAN_MASK;
 	for_each_set_bit(i, scan_mask, 8)
-		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
+		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
 	if (ret < 0)
-- 
2.48.1



