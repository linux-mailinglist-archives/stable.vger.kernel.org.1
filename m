Return-Path: <stable+bounces-163564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B2B0C2DC
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5165414D0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5229B782;
	Mon, 21 Jul 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5pNhTJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FD29B761
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097139; cv=none; b=i2Gmm6VaxErW5a+fNTep2qMA0jNlb/t7S4PvS6By+ayhaJl3sLn3AeNTGSCqsPvinXohWPYTNLbuW1Lbunn0yn1JUHPcUancUikehqHk1wOn9Szg0tA7DvRsiV3lnyvR5Wwm7QpMRcWsfMT+MoGOfA5hqsyGb+owQQeZDUhCUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097139; c=relaxed/simple;
	bh=ZFCQo7fbYYPV2aokpU7gr1Ea7Gmuv9uuEtn7GGTXfIU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YscpTtF1mCG2E5cI/g5c+4r863YB892EudCPIxvMMGRmHy2GiElSKrxIct5Y/SpTHoHVusvjHvwb5FEmSFF2uXa2e2B7K+Iymmp6HznKekJ1Be8rr/otqHU7E0YgedXfLVDE0R1LXDpzKMbcE6hzfxR2e9KYdBD9j1PDmpu+lpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v5pNhTJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D8C4CEED;
	Mon, 21 Jul 2025 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753097136;
	bh=ZFCQo7fbYYPV2aokpU7gr1Ea7Gmuv9uuEtn7GGTXfIU=;
	h=Subject:To:Cc:From:Date:From;
	b=v5pNhTJljQG77fVrjVNgqt7eAnmPDMozj4dqcmNZn5S0l3mpbPW6E5pa22V4TU3C5
	 Q52rbLeFR+gcCHGeWH6JDBpxzOXbPLjdxmIMyCteFe5ECd5uljG3oM5KaU4wQjvOyl
	 eyYzWiipXb2x2T0e0OmdsJDtuEOc5rZX+U/9A5U0=
Subject: FAILED: patch "[PATCH] iio: accel: fxls8962af: Fix use after free in" failed to apply to 5.15-stable tree
To: sean@geanix.com,Jonathan.Cameron@huawei.com,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:24:25 +0200
Message-ID: <2025072125-spyglass-uncharted-ba31@gregkh>
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
git cherry-pick -x 1fe16dc1a2f5057772e5391ec042ed7442966c9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072125-spyglass-uncharted-ba31@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fe16dc1a2f5057772e5391ec042ed7442966c9a Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 3 Jun 2025 14:25:44 +0200
Subject: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush

fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
iio_for_each_active_channel()) without making sure the indio_dev
stays in buffer mode.
There is a race if indio_dev exits buffer mode in the middle of the
interrupt that flushes the fifo. Fix this by calling
synchronize_irq() to ensure that no interrupt is currently running when
disabling buffer mode.

Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[...]
_find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
irq_thread_fn from irq_thread+0x110/0x1f4
irq_thread from kthread+0xe0/0xfc
kthread from ret_from_fork+0x14/0x2c

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Cc: stable@vger.kernel.org
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 12598feaa693..b10a30960e1e 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -877,6 +877,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	synchronize_irq(data->irq);
+
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
 	if (data->enable_event)


