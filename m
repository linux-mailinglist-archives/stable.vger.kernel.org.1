Return-Path: <stable+bounces-20188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29322854CA0
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB9F1C210F2
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72FF5C8F8;
	Wed, 14 Feb 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5XltpUU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE743157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924386; cv=none; b=XM9z++b2v4mKGi9IQzc/OMhak4CZkQXMi4BvwHReRALrr2AUm//skgCwZoJpAck//mmQ3gO3quBNhbs6BE8yO2telIBMMMrk/lDN0X5odQj1ftjFemZSL0S3LZSzuqvcQJB5mPpzWbAxkb3L/lfOL6TFQVnLEK6vFVb0H7GgXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924386; c=relaxed/simple;
	bh=p59L3R+ZkRrDWknJak2fEEY4lAonxV1kmMiWSZZ+eFU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=MFMGZZqTDajcJI5Vv+zf1q9+LA+/mo84VizeWXzbGsgist/ON102I0DykIfiWiDtvfR/Jp3ZsOy3b5r5ovPoeFg4XVNEKwdHthl22Vosp8ISo08FPhObcKJvLWSse08kapMvGP8LN+Ocgk7YWaHkLRV4x4x9h8nbQh5kB03eR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5XltpUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB89BC433F1;
	Wed, 14 Feb 2024 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924386;
	bh=p59L3R+ZkRrDWknJak2fEEY4lAonxV1kmMiWSZZ+eFU=;
	h=Subject:To:From:Date:From;
	b=y5XltpUU33vkVHOCWX92Fiw9nCBZQAjEy7I91wPGGfkwHKgwPVFAmdFnfW3A511YY
	 4NjNf1oaQFjYE0sh9fcUW2vOZCtw3vIK6YoNWX08LU3qS3RwnsxJpUxTiYHOsS+DV4
	 Qrb+Ug2IRSTXehd465a8End7clI4UJC7dVWiD88s=
Subject: patch "iio: imu: adis: ensure proper DMA alignment" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:06 +0100
Message-ID: <2024021406-hypnoses-enjoyer-f063@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: adis: ensure proper DMA alignment

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8e98b87f515d8c4bae521048a037b2cc431c3fd5 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 14:10:49 +0100
Subject: iio: imu: adis: ensure proper DMA alignment

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for the sigma_delta ADCs.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: ccd2b52f4ac6 ("staging:iio: Add common ADIS library")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240117-adis-improv-v1-1-7f90e9fad200@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/imu/adis.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index dc9ea299e088..8898966bc0f0 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -11,6 +11,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/interrupt.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 
 #define ADIS_WRITE_REG(reg) ((0x80 | (reg)))
@@ -131,7 +132,7 @@ struct adis {
 	unsigned long		irq_flag;
 	void			*buffer;
 
-	u8			tx[10] ____cacheline_aligned;
+	u8			tx[10] __aligned(IIO_DMA_MINALIGN);
 	u8			rx[4];
 };
 
-- 
2.43.1



