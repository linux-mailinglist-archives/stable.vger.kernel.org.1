Return-Path: <stable+bounces-139326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A3AA60EC
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF7A9A34DC
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E920B7F3;
	Thu,  1 May 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQfjcv6L"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4B1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114608; cv=none; b=BceNxG71mvosimhgdgOjsY5ZyTLQ6xIc91/TCW1on8q1GGu6ZKEdnNhSW5Gu//LHLSalFCdNOvPWjGbZxtFIMnyHpaAXc7AJN/z0lR4yjy14WzvlurSATtuie+qACueDpLiOo4rLDYxhVpIDujIw3hGWPPm/y6OpSO/5JvJG834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114608; c=relaxed/simple;
	bh=K7s8TDDIrdMRl2icj9oKvAvLFJ6yKJhnEKJyNm6L2F0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BZsmNNyzrSEb1Vg/+2Ol5FryFrXIrslbCCUavi6QcJdid48HY8rSGnsjcNVQ0fSkb/4KZQtTx0dtCHlV7GguFdRWSYaMuX3iCXJgNPIotb5+PsNz2QUNDhXA6t87JcaGjwHrQihSODz+3c5yOHibHsfc3Qxg5RNMIcbsMdRmHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQfjcv6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B4CC4CEED;
	Thu,  1 May 2025 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114607;
	bh=K7s8TDDIrdMRl2icj9oKvAvLFJ6yKJhnEKJyNm6L2F0=;
	h=Subject:To:From:Date:From;
	b=TQfjcv6Lq6DJ7MEdjhoccXF2V/lg/IiZsPLpX1P7CXFiu91qpeW+INtyHZl0jk7JT
	 FEdiKi50U/nUjdZ6K7q/SDcRV/xIoa6Jivlbr7BieLk9926Dk0+OKM1DDW6+/wo8QU
	 fszH+e8NlE3I5HM8bXkaBu6bcUANYEJtx03vI7cI=
Subject: patch "iio: adc: ad7768-1: Fix insufficient alignment of timestamp." added to char-misc-linus
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:49:01 +0200
Message-ID: <2025050101-resolute-booted-02eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:25 +0100
Subject: iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is not 64-bit aligned, this may result
insufficient alignment of the timestamp and the structure being too small.
Use aligned_s64 to force the alignment.

Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-3-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5a863005aca6..5e0be36af0c5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -168,7 +168,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];
-- 
2.49.0



