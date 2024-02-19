Return-Path: <stable+bounces-20620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D585A984
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B2D1C228F6
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA744390;
	Mon, 19 Feb 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EsBWPdV2"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1944389
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362171; cv=none; b=Nyqs6l531pdSQBbyWZIx1wHSaE7k41jvPdrH0OZiHAEHLlmE0/SRjmqna/CvFv+pM8mmhqfrOvriz9oGhGOYV8ZhyOGysP2zXwbNExz27ISKQuKkDobSGIkzDYI0hRU/1fp1bK8WbC03w9aMW3X3btCR2GIaANZoKyLXALdJwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362171; c=relaxed/simple;
	bh=kWUb6fLPX1fASJi+tu3i6+kZkrwT1n+/iLHmNItyHDA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bXowkpto0QUHTu5rD+9+8kjtpG0yVxqAE5cl8hZ/5sIDxbT0tElbxWhs02IrVSjDsdaFV5aXz79xwWzk3Q8rx0p9OkR4dTNXQYjsTTp9NpIkNkv+vcKWLMEXAOJMZQVDOtTSa36VO/cacEdhEH5Bs9SV5i0O+Ab162bK9BaXCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EsBWPdV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F044C433F1;
	Mon, 19 Feb 2024 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708362171;
	bh=kWUb6fLPX1fASJi+tu3i6+kZkrwT1n+/iLHmNItyHDA=;
	h=Subject:To:Cc:From:Date:From;
	b=EsBWPdV29HdV1tH+ow3UlnjQm5v4vxuwPDH1kvyrxNikLvAjUstMbqDSmUCmAhrwX
	 pziIwO5t44wjy6Z7f88hFNclRNQDM8cqDQg9h0XAS256eE+JwmhLVzG1lq4i+gHReL
	 ZfO5Za5Snt5ah8PuCj4uhRXSH0kglSWw5PObmk2U=
Subject: FAILED: patch "[PATCH] iio: imu: adis: ensure proper DMA alignment" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 18:01:45 +0100
Message-ID: <2024021945-lens-driving-5e11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8e98b87f515d8c4bae521048a037b2cc431c3fd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021945-lens-driving-5e11@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8e98b87f515d ("iio: imu: adis: ensure proper DMA alignment")
c39010ea6ba1 ("iio: adis: stylistic changes")
31fa357ac809 ("iio: adis: handle devices that cannot unmask the drdy pin")
b600bd7eb333 ("iio: adis: do not disabe IRQs in 'adis_init()'")
7e77ef8b8d60 ("iio: adis: set GPIO reset pin direction")
30f6a542b7d3 ("iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e98b87f515d8c4bae521048a037b2cc431c3fd5 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 14:10:49 +0100
Subject: [PATCH] iio: imu: adis: ensure proper DMA alignment

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
 


