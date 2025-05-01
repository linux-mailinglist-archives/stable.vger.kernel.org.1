Return-Path: <stable+bounces-139325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B08AA60ED
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2C7A7034
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E92045AD;
	Thu,  1 May 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L5Rv/8W/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577A1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114605; cv=none; b=KWsdO5JSgYds/ZAXTrVfrRGdDRimRze0g5vrFzukNGj6VWuOrrj7uY+VMcasyCaa6xM/gtO1zxdkqlXzH4Eznv61oUCpjhd441HBjqqkB96dAWG7uGXzgPbfhp1YKiFAUFdM/lK31FtUs+FyB+KUEytecdW6NsZgTY2wQ0RcsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114605; c=relaxed/simple;
	bh=93gibNgG6vUSXbPhPA5OdEW++68h4fkhooyJRQfTCJs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Jwpf26b92Likxi/t5q7AVy/7jUlpjm/mXHvAKgpwmBj+yLHmqxVAl/Hx9SXKmBBeTLdgiaC1KKoUWuffc7FU/haa44mLgrQmSoT8f3hmROh6vMjPqfQ3IFI/92jJ8H3MP4dKa6WQUz6+ytsiGkgLuBgjtq0xjTkLD2ooEscpmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L5Rv/8W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F782C4CEED;
	Thu,  1 May 2025 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114604;
	bh=93gibNgG6vUSXbPhPA5OdEW++68h4fkhooyJRQfTCJs=;
	h=Subject:To:From:Date:From;
	b=L5Rv/8W/hQE7Vssl+ViHHvfoBEXjE52vL4a7qU/JOU1qKxt47zGHzaS9eO9F0w28s
	 Tgj8BVUJke/DABQRI4bfNsjT4IHDGW0+l7nj/HavH6ILMMZU/k3IRYPrfdpVECXJgX
	 gf9uN3LJ5MS3fSibqGEqTbeRbxylB0NC5TrHmfXU=
Subject: patch "iio: adc: ad7266: Fix potential timestamp alignment issue." added to char-misc-linus
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:49:01 +0200
Message-ID: <2025050101-pancake-fragility-b9ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7266: Fix potential timestamp alignment issue.

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 52d349884738c346961e153f195f4c7fe186fcf4 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:24 +0100
Subject: iio: adc: ad7266: Fix potential timestamp alignment issue.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is only 32-bit aligned insufficient padding
would be left between the earlier elements and the timestamp. Use
aligned_s64 to enforce the correct placement and ensure the storage is
large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 18559757f908..7fef2727f89e 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
-- 
2.49.0



