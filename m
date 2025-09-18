Return-Path: <stable+bounces-177133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494BB40381
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5434A16B986
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB143093CE;
	Tue,  2 Sep 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClENT+1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936C30BBB9;
	Tue,  2 Sep 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819685; cv=none; b=MvtpN+NwM2rzc2o/i4hl3uVf7Lf7VkttmXD9cr05b5oqJPomzlFKDBSlwannVsHqoLKme2xFSYEsbbLF6pqKRvBGkc4XynAiwNs5rE+E/4AidXb2EMtykvyx77auSAJCTrIEYd0oI7vVPOjHpJQcj7YXFADYGMTmc4jaSgosPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819685; c=relaxed/simple;
	bh=24Urkx0QZ6U/VRDZOVc8pwu8BaXbmaxZytGkfxU30j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahp1kuADOAt7mprS/PezvZ+WZksqOu45uvUONXH1K8SJR2KeFUAdUIsMNqTzZCAamAA/yE+VCO9dZiGOaMdtnu+KOwSck4HR44RLWfGA8689JYK5AgOK1BnwtYsJ5AAxvtIg1qgzTaLBkLwpgIlxzRLoDjPzUYN1VMNiGQ/Az+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClENT+1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40815C4CEF5;
	Tue,  2 Sep 2025 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819684;
	bh=24Urkx0QZ6U/VRDZOVc8pwu8BaXbmaxZytGkfxU30j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClENT+1z2qXlfP/Dlzvil9EOBVCrR6x7aqk3/+181rTxxKZrn3vO8WVyPBIjT64QU
	 yU4qmBw3Xmx0HxQz7Cr0EXT9DCUceqRLe+qvo9DiruDTRoovnJOlv2NOH2WtiuKnTn
	 jpud3mrRRyzplr6fv+HmwBHY/Zsd9a+qJ2A06jyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qasim Ijaz <qasdev00@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.16 109/142] HID: asus: fix UAF via HID_CLAIMED_INPUT validation
Date: Tue,  2 Sep 2025 15:20:11 +0200
Message-ID: <20250902131952.453543401@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit d3af6ca9a8c34bbd8cff32b469b84c9021c9e7e4 upstream.

After hid_hw_start() is called hidinput_connect() will eventually be
called to set up the device with the input layer since the
HID_CONNECT_DEFAULT connect mask is used. During hidinput_connect()
all input and output reports are processed and corresponding hid_inputs
are allocated and configured via hidinput_configure_usages(). This
process involves slot tagging report fields and configuring usages
by setting relevant bits in the capability bitmaps. However it is possible
that the capability bitmaps are not set at all leading to the subsequent
hidinput_has_been_populated() check to fail leading to the freeing of the
hid_input and the underlying input device.

This becomes problematic because a malicious HID device like a
ASUS ROG N-Key keyboard can trigger the above scenario via a
specially crafted descriptor which then leads to a user-after-free
when the name of the freed input device is written to later on after
hid_hw_start(). Below, report 93 intentionally utilises the
HID_UP_UNDEFINED Usage Page which is skipped during usage
configuration, leading to the frees.

0x05, 0x0D,        // Usage Page (Digitizer)
0x09, 0x05,        // Usage (Touch Pad)
0xA1, 0x01,        // Collection (Application)
0x85, 0x0D,        //   Report ID (13)
0x06, 0x00, 0xFF,  //   Usage Page (Vendor Defined 0xFF00)
0x09, 0xC5,        //   Usage (0xC5)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x04,        //   Report Count (4)
0xB1, 0x02,        //   Feature (Data,Var,Abs)
0x85, 0x5D,        //   Report ID (93)
0x06, 0x00, 0x00,  //   Usage Page (Undefined)
0x09, 0x01,        //   Usage (0x01)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x1B,        //   Report Count (27)
0x81, 0x02,        //   Input (Data,Var,Abs)
0xC0,              // End Collection

Below is the KASAN splat after triggering the UAF:

[   21.672709] ==================================================================
[   21.673700] BUG: KASAN: slab-use-after-free in asus_probe+0xeeb/0xf80
[   21.673700] Write of size 8 at addr ffff88810a0ac000 by task kworker/1:2/54
[   21.673700]
[   21.673700] CPU: 1 UID: 0 PID: 54 Comm: kworker/1:2 Not tainted 6.16.0-rc4-g9773391cf4dd-dirty #36 PREEMPT(voluntary)
[   21.673700] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   21.673700] Call Trace:
[   21.673700]  <TASK>
[   21.673700]  dump_stack_lvl+0x5f/0x80
[   21.673700]  print_report+0xd1/0x660
[   21.673700]  kasan_report+0xe5/0x120
[   21.673700]  __asan_report_store8_noabort+0x1b/0x30
[   21.673700]  asus_probe+0xeeb/0xf80
[   21.673700]  hid_device_probe+0x2ee/0x700
[   21.673700]  really_probe+0x1c6/0x6b0
[   21.673700]  __driver_probe_device+0x24f/0x310
[   21.673700]  driver_probe_device+0x4e/0x220
[...]
[   21.673700]
[   21.673700] Allocated by task 54:
[   21.673700]  kasan_save_stack+0x3d/0x60
[   21.673700]  kasan_save_track+0x18/0x40
[   21.673700]  kasan_save_alloc_info+0x3b/0x50
[   21.673700]  __kasan_kmalloc+0x9c/0xa0
[   21.673700]  __kmalloc_cache_noprof+0x139/0x340
[   21.673700]  input_allocate_device+0x44/0x370
[   21.673700]  hidinput_connect+0xcb6/0x2630
[   21.673700]  hid_connect+0xf74/0x1d60
[   21.673700]  hid_hw_start+0x8c/0x110
[   21.673700]  asus_probe+0x5a3/0xf80
[   21.673700]  hid_device_probe+0x2ee/0x700
[   21.673700]  really_probe+0x1c6/0x6b0
[   21.673700]  __driver_probe_device+0x24f/0x310
[   21.673700]  driver_probe_device+0x4e/0x220
[...]
[   21.673700]
[   21.673700] Freed by task 54:
[   21.673700]  kasan_save_stack+0x3d/0x60
[   21.673700]  kasan_save_track+0x18/0x40
[   21.673700]  kasan_save_free_info+0x3f/0x60
[   21.673700]  __kasan_slab_free+0x3c/0x50
[   21.673700]  kfree+0xcf/0x350
[   21.673700]  input_dev_release+0xab/0xd0
[   21.673700]  device_release+0x9f/0x220
[   21.673700]  kobject_put+0x12b/0x220
[   21.673700]  put_device+0x12/0x20
[   21.673700]  input_free_device+0x4c/0xb0
[   21.673700]  hidinput_connect+0x1862/0x2630
[   21.673700]  hid_connect+0xf74/0x1d60
[   21.673700]  hid_hw_start+0x8c/0x110
[   21.673700]  asus_probe+0x5a3/0xf80
[   21.673700]  hid_device_probe+0x2ee/0x700
[   21.673700]  really_probe+0x1c6/0x6b0
[   21.673700]  __driver_probe_device+0x24f/0x310
[   21.673700]  driver_probe_device+0x4e/0x220
[...]

Fixes: 9ce12d8be12c ("HID: asus: Add i2c touchpad support")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Link: https://patch.msgid.link/20250810181041.44874-1-qasdev00@gmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-asus.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1213,7 +1213,13 @@ static int asus_probe(struct hid_device
 		return ret;
 	}
 
-	if (!drvdata->input) {
+	/*
+	 * Check that input registration succeeded. Checking that
+	 * HID_CLAIMED_INPUT is set prevents a UAF when all input devices
+	 * were freed during registration due to no usages being mapped,
+	 * leaving drvdata->input pointing to freed memory.
+	 */
+	if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "Asus input not registered\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;



