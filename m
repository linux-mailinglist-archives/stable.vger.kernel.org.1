Return-Path: <stable+bounces-122026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F01A59D8E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFC63A5662
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB4230BF6;
	Mon, 10 Mar 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfvEGh6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036F226D0B;
	Mon, 10 Mar 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627315; cv=none; b=Ktz2cJmU7Od6qZy2QZ0KRsiwbKfaRa3SvAO0Z+G+SfGmlb+NgOFrh24vEe/9SxnsTDKg4RzQZMkZWpXy0XDf8vJwx0RxNXnkVmNvoYxxcLJZAXAf7ntCiD9j3jcTNe8U/14u0SP5Ve7bVidvIV9ocQunhMZvw/n+lHkgysNtiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627315; c=relaxed/simple;
	bh=xKxeArNywlCWoIpXUdk7I4pG8iQe/swEyRahv6ahIfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY99N2JXqD3McuvrdDVrIBPfmxqp2DzbSyZepoi10CzE+tsLKGhVfrSeUUIMP3J68/L6TCpJV8XllciIkVW1V8Ec9WV256PttKvWI3mFIN+2T7yzJyo854QU4yeS704Pl5DzFZai3V4UkMrrF9lwl1AHtoK/se0oo9lBlWZrgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfvEGh6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BC3C4CEE5;
	Mon, 10 Mar 2025 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627315;
	bh=xKxeArNywlCWoIpXUdk7I4pG8iQe/swEyRahv6ahIfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfvEGh6Y/ZOmq6ZU3HFlo/zqCC+XQ6/tB9kXif+X2r8LTWKIFNseONDCBhijvKt7z
	 2u92GHlrwIAAMd108gIB+YEpcZQHp/qA6KD1hpWP0o9M601/Q8e2YnvU42zAY01BaP
	 IREZEMLpACIB+YMxnQzTQuftXcarmIQli14TZdR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <koichiro.den@canonical.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.12 088/269] gpio: aggregator: protect driver attr handlers against module unload
Date: Mon, 10 Mar 2025 18:04:01 +0100
Message-ID: <20250310170501.224634951@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <koichiro.den@canonical.com>

commit 12f65d1203507f7db3ba59930fe29a3b8eee9945 upstream.

Both new_device_store and delete_device_store touch module global
resources (e.g. gpio_aggregator_lock). To prevent race conditions with
module unload, a reference needs to be held.

Add try_module_get() in these handlers.

For new_device_store, this eliminates what appears to be the most dangerous
scenario: if an id is allocated from gpio_aggregator_idr but
platform_device_register has not yet been called or completed, a concurrent
module unload could fail to unregister/delete the device, leaving behind a
dangling platform device/GPIO forwarder. This can result in various issues.
The following simple reproducer demonstrates these problems:

  #!/bin/bash
  while :; do
    # note: whether 'gpiochip0 0' exists or not does not matter.
    echo 'gpiochip0 0' > /sys/bus/platform/drivers/gpio-aggregator/new_device
  done &
  while :; do
    modprobe gpio-aggregator
    modprobe -r gpio-aggregator
  done &
  wait

  Starting with the following warning, several kinds of warnings will appear
  and the system may become unstable:

  ------------[ cut here ]------------
  list_del corruption, ffff888103e2e980->next is LIST_POISON1 (dead000000000100)
  WARNING: CPU: 1 PID: 1327 at lib/list_debug.c:56 __list_del_entry_valid_or_report+0xa3/0x120
  [...]
  RIP: 0010:__list_del_entry_valid_or_report+0xa3/0x120
  [...]
  Call Trace:
   <TASK>
   ? __list_del_entry_valid_or_report+0xa3/0x120
   ? __warn.cold+0x93/0xf2
   ? __list_del_entry_valid_or_report+0xa3/0x120
   ? report_bug+0xe6/0x170
   ? __irq_work_queue_local+0x39/0xe0
   ? handle_bug+0x58/0x90
   ? exc_invalid_op+0x13/0x60
   ? asm_exc_invalid_op+0x16/0x20
   ? __list_del_entry_valid_or_report+0xa3/0x120
   gpiod_remove_lookup_table+0x22/0x60
   new_device_store+0x315/0x350 [gpio_aggregator]
   kernfs_fop_write_iter+0x137/0x1f0
   vfs_write+0x262/0x430
   ksys_write+0x60/0xd0
   do_syscall_64+0x6c/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   [...]
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 828546e24280 ("gpio: Add GPIO Aggregator")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
Link: https://lore.kernel.org/r/20250224143134.3024598-2-koichiro.den@canonical.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-aggregator.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -121,10 +121,15 @@ static ssize_t new_device_store(struct d
 	struct platform_device *pdev;
 	int res, id;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	/* kernfs guarantees string termination, so count + 1 is safe */
 	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -163,6 +168,7 @@ static ssize_t new_device_store(struct d
 	}
 
 	aggr->pdev = pdev;
+	module_put(THIS_MODULE);
 	return count;
 
 remove_table:
@@ -177,6 +183,8 @@ free_table:
 	kfree(aggr->lookups);
 free_ga:
 	kfree(aggr);
+put_module:
+	module_put(THIS_MODULE);
 	return res;
 }
 
@@ -205,13 +213,19 @@ static ssize_t delete_device_store(struc
 	if (error)
 		return error;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	mutex_lock(&gpio_aggregator_lock);
 	aggr = idr_remove(&gpio_aggregator_idr, id);
 	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
+	if (!aggr) {
+		module_put(THIS_MODULE);
 		return -ENOENT;
+	}
 
 	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
 	return count;
 }
 static DRIVER_ATTR_WO(delete_device);



