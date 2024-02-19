Return-Path: <stable+bounces-20614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83C85A944
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12A51C21CCE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C594405D3;
	Mon, 19 Feb 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEUamHsK"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208DBA42
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361273; cv=none; b=Gt9cyjOQbGr9hkgT1mfwRP8XLxBjWqUr+tLNLLKVuMW2J6IuRvvvlbyBZaACxOmOvTDM+8DcspkRGbP1N8/xAPZT7TzH0k4/fKnAiCeo9RE8ANrezoMRlVPlf+lmNtdUQi4CtGPquXB37olhI9fhwLuZ3ZE1WIHovI0+oEl1Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361273; c=relaxed/simple;
	bh=M2MQu5Ky0c5bFN9baIKIabUWo+e+MWVrqszTcb0BZHI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TSaOjYbZBERnG9ez81CX7GptVNhLUJnEmx9mV+it6uaivSWvrl/78Rp6mO0wfAIRk9GQDNIF7FXX/TuZ1B3azTgPWseqJRkQ/9nS4/vdJlw3NHH17EQIgUEHYg0nwlToRNdlUxsY7iEfHJzQg25dV/WaD8JWY82j9jK9a0zF88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEUamHsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFF2C433C7;
	Mon, 19 Feb 2024 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708361272;
	bh=M2MQu5Ky0c5bFN9baIKIabUWo+e+MWVrqszTcb0BZHI=;
	h=Subject:To:Cc:From:Date:From;
	b=aEUamHsK/HB+cg1Qp+QMw7qUDedhWMislFpB+rfv2xts1ewcsIwqnFViQcggf7eIp
	 ki9TCcuPsFNdwhRXrhKh+6YXRJ95kYwUyno7AgjXIrQJesHsssXaqPBVxL69uqioV7
	 hA+vQLnzMrUKNOW3E4hGfJ3S5vP4+uUQ7i9nui54=
Subject: FAILED: patch "[PATCH] iio: commom: st_sensors: ensure proper DMA alignment" failed to apply to 5.4-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:46:59 +0100
Message-ID: <2024021959-muscular-rerun-5993@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 862cf85fef85becc55a173387527adb4f076fab0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021959-muscular-rerun-5993@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

862cf85fef85 ("iio: commom: st_sensors: ensure proper DMA alignment")
474010127e25 ("iio: st_sensors: Add a local lock for protecting odr")
e450e07c14ab ("iio: st_sensors: rely on odr mask to know if odr can be set")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 862cf85fef85becc55a173387527adb4f076fab0 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 31 Jan 2024 10:16:47 +0100
Subject: [PATCH] iio: commom: st_sensors: ensure proper DMA alignment

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


