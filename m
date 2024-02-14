Return-Path: <stable+bounces-20192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F3C854CA6
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227E2B27213
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BDD5C914;
	Wed, 14 Feb 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m7C+Xs4F"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F15C910
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924409; cv=none; b=G8xuUVcswf+5L6Q7GKbaotRwvqHZ2tCNU9Wqkx8nHyKg9JSKvqlDFyEir6iuBy9JRHCCUejqN96Mgyh7jcycireHOUTctPPV6sexLPAp/1YeTWrGRC7uDMhZgFAx3aePKGxDL+bFu3co7bCwplVeckmi53U+mNrHlofxwVB9UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924409; c=relaxed/simple;
	bh=xQf+HufpCGQNjGKymtJF8+5m0Hr56zmFYPW9euaWNCg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bO5HIkefKnp72LRizpfkOhLWXCzZwKXOVhjdf9golN1ek4SHxMp4Pd0MMSm/HC3Y+zEA5We6L3XEDx7NShyI76FQ9fBJJ0w5ph6ZebGLuQ3KVVKSMBMcMrmYZDFTZrX0ozPn6z/c5swyOGTez83Wlpc6UR5T4WCjbOdJjn+cFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7C+Xs4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17846C433C7;
	Wed, 14 Feb 2024 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924409;
	bh=xQf+HufpCGQNjGKymtJF8+5m0Hr56zmFYPW9euaWNCg=;
	h=Subject:To:From:Date:From;
	b=m7C+Xs4FObBsMhlUxWuOk2AIV2YE2h/xLyZAGf8f8FO32RaOskvZabOa+uUElWFGO
	 xbRTKLz4dEfsgmv8QT0mzk9c4atHl85kWUyuXO29QLpYQhtPNtWL1FOYjVk17iDhgo
	 o15PSmcrPe3fQlGLbJXWEwr5X0Y5aBsQ5eNQCufw=
Subject: patch "iio: commom: st_sensors: ensure proper DMA alignment" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:11 +0100
Message-ID: <2024021411-escapist-passivism-831d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: commom: st_sensors: ensure proper DMA alignment

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 862cf85fef85becc55a173387527adb4f076fab0 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 31 Jan 2024 10:16:47 +0100
Subject: iio: commom: st_sensors: ensure proper DMA alignment

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for st_sensors common buffer.

While at it, moved the odr_lock before buffer_data as we definitely
don't want any other data to share a cacheline with the buffer.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each buffer enable")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240131-dev_dma_safety_stm-v2-1-580c07fae51b@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/common/st_sensors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 607c3a89a647..f9ae5cdd884f 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -258,9 +258,9 @@ struct st_sensor_data {
 	bool hw_irq_trigger;
 	s64 hw_timestamp;
 
-	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
-
 	struct mutex odr_lock;
+
+	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
 #ifdef CONFIG_IIO_BUFFER
-- 
2.43.1



