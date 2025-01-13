Return-Path: <stable+bounces-108410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9B0A0B4AD
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402383A2537
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225C21ADBC;
	Mon, 13 Jan 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s0QY+Z3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140342AA5
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764813; cv=none; b=WkA++o1k3l0MWhu++jXBMz1P+o6BiXkM573555vRfJiS9+hWqJnh/qmWgRD2dg97Us+L9HF9MADsXbBlA9Ax5UB+67xuykBHg0jNiZf0eKzEfKhUUheOfVRN5mHyCJyuYRlSXS3Bg2Qt5unqtQKL+Efy1vZlOZCTbUYlslssjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764813; c=relaxed/simple;
	bh=8vcI7//st1vvgHuPU8ZB5HFCVUpd5KbY5k8fw9gkaQs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cgQwvApLzD4EMIolb+opfOCELHmnpFFc9ujNJ8Rw1SZtjvYfJb3XPo2xAeCLlqBlSOol6A3KDPAI8LU+TJevDgd6NC+OZzJ31wVUd/IDEbXV7CaTVnx9Y8K+u358L8KnDQqIphVfqsMWrN/DCNZncG4qkMU+cCtoWikZN4NdtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s0QY+Z3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFEFC4CEDD;
	Mon, 13 Jan 2025 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736764812;
	bh=8vcI7//st1vvgHuPU8ZB5HFCVUpd5KbY5k8fw9gkaQs=;
	h=Subject:To:Cc:From:Date:From;
	b=s0QY+Z3c078gqr0sK6rRzC3mA17bXTCcBhWqEiUNtKhzUARWch0r7dLxZU3nMNoS7
	 Gdu3sN5n4DfOSs9aKcuJ5+FIqacAVQbXfvdvRcky13qvpBN0HhlPeH20a512HkpoKr
	 /4XPcvXT2gN18yfrd1vlkNhFEmEpSaBiKJBomXgA=
Subject: FAILED: patch "[PATCH] iio: adc: rockchip_saradc: fix information leak in triggered" failed to apply to 6.1-stable tree
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2025 11:40:09 +0100
Message-ID: <2025011309-swab-bootie-b4f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 38724591364e1e3b278b4053f102b49ea06ee17c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011309-swab-bootie-b4f4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


