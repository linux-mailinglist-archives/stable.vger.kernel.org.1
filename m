Return-Path: <stable+bounces-198253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F5C9F797
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE460300079A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D6430C358;
	Wed,  3 Dec 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AFx/j6fp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45492E03E6;
	Wed,  3 Dec 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775931; cv=none; b=coQNfqme8Se/7E/132VCiaKgMLPGWv2vnApEyBAGaewXvAUfOi3Go2UvxaS3f6kHj9wTHK9OHLJqwz3WSFwzFOsA26+6UpKzYIAKUB94Qvr55LYby+m4SxYPqan8k//HjTYuWXB69HMRpNJFhX0meDNHqmNRtA2g2MB/vN7Cf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775931; c=relaxed/simple;
	bh=L4d7LXf2rM6tTUHz9ld+Xt6KYLBmwmNZpw+nijaJxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbw7EQAnaIgMQU6NOt0SpdZFK7K5B/7yvZjnB/erRcRIA8BOogU33mqdTgOJkjDcGXDP1CvHMEnAJR3h2WUjrq1XoJDisFI66Z+jWcKRm0ANfVRkG56XG+IavlWovNcs3Rx1I/wFEaK9GpYOamPLRNnH5x3ye/5pmsFXBUeylbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AFx/j6fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2063FC4CEF5;
	Wed,  3 Dec 2025 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764775931;
	bh=L4d7LXf2rM6tTUHz9ld+Xt6KYLBmwmNZpw+nijaJxX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFx/j6fpOaBOyiv2K4k+3U7e/bolEBjULiBiD+YzjeO1lytDGrV0c7DixLsJ7KNll
	 XI2MRqZfxg3TPHwaSK9VV8zabk/HQhA8kBnA0gEViUhWRPUNrCbmbt6wghX5AHZpuJ
	 OD53C5ByzoA3w5UkFSIlv7HqkXTTm/ZJdhOFb87A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.10 008/300] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
Date: Wed,  3 Dec 2025 16:23:32 +0100
Message-ID: <20251203152400.768062123@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuhao Jiang <danisjiang@gmail.com>

commit 8f067aa59430266386b83c18b983ca583faa6a11 upstream.

The switch_brightness_work delayed work accesses device->brightness
and device->backlight, freed by acpi_video_dev_unregister_backlight()
during device removal.

If the work executes after acpi_video_bus_unregister_backlight()
frees these resources, it causes a use-after-free when
acpi_video_switch_brightness() dereferences device->brightness or
device->backlight.

Fix this by calling cancel_delayed_work_sync() for each device's
switch_brightness_work in acpi_video_bus_remove_notify_handler()
after removing the notify handler that queues the work. This ensures
the work completes before the memory is freed.

Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a brightness up/down keypress")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
[ rjw: Changelog edit ]
Link: https://patch.msgid.link/20251022200704.2655507-1-danisjiang@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_video.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2028,8 +2028,10 @@ static void acpi_video_bus_remove_notify
 	struct acpi_video_device *dev;
 
 	mutex_lock(&video->device_list_lock);
-	list_for_each_entry(dev, &video->video_device_list, entry)
+	list_for_each_entry(dev, &video->video_device_list, entry) {
 		acpi_video_dev_remove_notify_handler(dev);
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
+	}
 	mutex_unlock(&video->device_list_lock);
 
 	acpi_video_bus_stop_devices(video);



