Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A47C9ACA
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSes (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:34:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5DAB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:34:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E8C433C8;
        Sun, 15 Oct 2023 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394886;
        bh=GDE16A9ehUNCBPwFPpL6D5IGodWyiveOJTNpx5uLuLk=;
        h=Subject:To:Cc:From:Date:From;
        b=jJQo99XUz3naO2BEkn7oRfVSNGKxoOV1jC6MknPyHGk4begGYRna2ul/Jr1kM1JJA
         SeQkK0Y5UxUHlOOaYmqxqfwJ4T/UsFyr8onOtUldxZhHeh6UPg1vTzZtq8uUrtMZ0D
         of+PEcE5a508nCDpvF0RO/mmKkeaIWrZdVcz0UEM=
Subject: FAILED: patch "[PATCH] iio: cros_ec: fix an use-after-free in" failed to apply to 5.10-stable tree
To:     tzungbi@kernel.org, Jonathan.Cameron@huawei.com,
        groeck@chromium.org, swboyd@chromium.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:34:43 +0200
Message-ID: <2023101543-unwatched-reviver-1cd0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7771c8c80d62ad065637ef74ed2962983f6c5f6d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101543-unwatched-reviver-1cd0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7771c8c80d62ad065637ef74ed2962983f6c5f6d Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@kernel.org>
Date: Tue, 29 Aug 2023 11:06:22 +0800
Subject: [PATCH] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()

cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
calls iio_push_to_buffers_with_timestamp() without making sure the
`indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
buffer mode right before cros_ec_sensors_push_data() accesses them.

An use-after-free on `indio_dev->active_scan_mask` was observed.  The
call trace:
[...]
 _find_next_bit
 cros_ec_sensors_push_data
 cros_ec_sensorhub_event
 blocking_notifier_call_chain
 cros_ec_irq_thread

It was caused by a race condition: one thread just freed
`active_scan_mask` at [1]; while another thread tried to access the
memory at [2].

Fix it by calling iio_device_claim_buffer_mode() to ensure the
`indio_dev` can't exit buffer mode during cros_ec_sensors_push_data().

[1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industrialio-buffer.c#L1189
[2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c#L198

Cc: stable@vger.kernel.org
Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230829030622.1571852-1-tzungbi@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b72d39fc2434..6bfe5d6847e7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -190,8 +190,11 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
 	 * set but the buffer is not enabled yet.
+	 *
+	 * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buffer
+	 * is not enabled.
 	 */
-	if (!iio_buffer_enabled(indio_dev))
+	if (iio_device_claim_buffer_mode(indio_dev) < 0)
 		return 0;
 
 	out = (s16 *)st->samples;
@@ -210,6 +213,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
 					   timestamp + delta);
 
+	iio_device_release_buffer_mode(indio_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);

