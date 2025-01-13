Return-Path: <stable+bounces-108411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F05A0B4AE
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DD47A061A
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACB21ADBC;
	Mon, 13 Jan 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVa/z1Du"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66142AA5
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764822; cv=none; b=IX3GadrYbsJKjtdCF0e8RWIJlxyJY3qBUbqsiOgWbh8B1Bpgnbp0fcsukTlCgavcB+TLXroQP9sY0By/DSis4baAKVQwphKNa3Z24HGfehq0lExssX+SHXvaDSCaDcfG2EYcMkeimEEt9mcCWJygZdLY4dGCZsi2112tqLuEvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764822; c=relaxed/simple;
	bh=hys7LG3CnfSx2mIyoh5OYGTLZkDdYTVAI4H/qgU6qi0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fvgr9D5Pizd60hcMQJYQcntdK9KRtxc/oub196gyVc2HoFfmqzJdjGpK37yDNhF8hOVyUuR3Y5P4MajhbB/p0kYjjtgfVPERiQIPGqV4biL2f4elQ2ugluLQNVB0NMW2XxYOGZbnxp/t18MVNsumS74zRi5zi+k2smDNoYEwKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVa/z1Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC01C4CEDD;
	Mon, 13 Jan 2025 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736764821;
	bh=hys7LG3CnfSx2mIyoh5OYGTLZkDdYTVAI4H/qgU6qi0=;
	h=Subject:To:Cc:From:Date:From;
	b=dVa/z1DueOrdQGQAQdUY01oun43rQ0TG7G84wbXxOnNxvnHneQfTEETlRFss3DxlT
	 g9PxBa+aAln2ZQAqyCaVwymnsB/SBMxWFXyHfBuF18gOMf0iuDU/Lm6nxXxLe/MNBj
	 WUk4/qRZ9iML0umZnNieIo6P93pU4XOEnNOjj3r4=
Subject: FAILED: patch "[PATCH] iio: adc: rockchip_saradc: fix information leak in triggered" failed to apply to 5.15-stable tree
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:40:10 +0100
Message-ID: <2025011310-spider-motor-0ef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 38724591364e1e3b278b4053f102b49ea06ee17c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011310-spider-motor-0ef7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38724591364e1e3b278b4053f102b49ea06ee17c Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 25 Nov 2024 22:16:12 +0100
Subject: [PATCH] iio: adc: rockchip_saradc: fix information leak in triggered
 buffer

The 'data' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 240cfa391674..dfd47a6e1f4a 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -368,6 +368,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&info->lock);
 
 	iio_for_each_active_channel(i_dev, i) {


