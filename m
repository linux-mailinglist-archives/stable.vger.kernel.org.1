Return-Path: <stable+bounces-161119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF5AFD379
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18885169DF0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EE2E041C;
	Tue,  8 Jul 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3LjDAzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4F2DA77B;
	Tue,  8 Jul 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993651; cv=none; b=PtB6wZWQRKRShMGeye0wokRGgubnnwecSFm97oMargFc4dwLicEiNY4PwY9ARUCcV1hIvH7j2IAXe00/HfFM1n0jPDLMfeFipSISI4d+ACrijFAJyFJkfLPW9myYd2KRW9pWSZ+5Vjmy1yMEZgQfhy0S3+zFQhzHbAJYaagpGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993651; c=relaxed/simple;
	bh=vfDzABtbVsMThDcjUIsA/K6lyr8Uhwf6NIe60Nx3Jso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDlwmemMj7Taz+eKOt75zrJjo2x10Kg0Akobjp0NPwhKD01vOyKXGKtJKpSbayomru7T7AyK7yL8S4NFVOWBhKlbY/F6D98lUWTJkCQrNZeTNQZZOMFJUPGzPWt4gE860hc9yG7+ohvvP3fD+9ukogM9gI3DDPErccNsIqsGwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3LjDAzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437E3C4CEED;
	Tue,  8 Jul 2025 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993650;
	bh=vfDzABtbVsMThDcjUIsA/K6lyr8Uhwf6NIe60Nx3Jso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3LjDAzUFQasJ1uh9PwE4Sw6iz8+59uydAE42sfSB2Imr9UnnGE6eS+nhp6nfPx1z
	 0qXBoTvenmtdRi4Lq1aJL+dvMrFP1DZPoFi9hfOQlIStsHxr4GKfXJ1EAZiouJcHJY
	 D1Ai11Qyhnts6/vFyBt/PLq9I1Mk6WhJsetcjOaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aditya Garg <gargaditya08@live.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.15 147/178] HID: appletb-kbd: fix memory corruption of input_handler_list
Date: Tue,  8 Jul 2025 18:23:04 +0200
Message-ID: <20250708162240.364116305@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit c80f2b047d5cc42fbd2dff9d1942d4ba7545100f upstream.

In appletb_kbd_probe an input handler is initialised and then registered
with input core through input_register_handler(). When this happens input
core will add the input handler (specifically its node) to the global
input_handler_list. The input_handler_list is central to the functionality
of input core and is traversed in various places in input core. An example
of this is when a new input device is plugged in and gets registered with
input core.

The input_handler in probe is allocated as device managed memory. If a
probe failure occurs after input_register_handler() the input_handler
memory is freed, yet it will remain in the input_handler_list. This
effectively means the input_handler_list contains a dangling pointer
to data belonging to a freed input handler.

This causes an issue when any other input device is plugged in - in my
case I had an old PixArt HP USB optical mouse and I decided to
plug it in after a failure occurred after input_register_handler().
This lead to the registration of this input device via
input_register_device which involves traversing over every handler
in the corrupted input_handler_list and calling input_attach_handler(),
giving each handler a chance to bind to newly registered device.

The core of this bug is a UAF which causes memory corruption of
input_handler_list and to fix it we must ensure the input handler is
unregistered from input core, this is done through
input_unregister_handler().

[   63.191597] ==================================================================
[   63.192094] BUG: KASAN: slab-use-after-free in input_attach_handler.isra.0+0x1a9/0x1e0
[   63.192094] Read of size 8 at addr ffff888105ea7c80 by task kworker/0:2/54
[   63.192094]
[   63.192094] CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.16.0-rc2-00321-g2aa6621d
[   63.192094] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.164
[   63.192094] Workqueue: usb_hub_wq hub_event
[   63.192094] Call Trace:
[   63.192094]  <TASK>
[   63.192094]  dump_stack_lvl+0x53/0x70
[   63.192094]  print_report+0xce/0x670
[   63.192094]  kasan_report+0xce/0x100
[   63.192094]  input_attach_handler.isra.0+0x1a9/0x1e0
[   63.192094]  input_register_device+0x76c/0xd00
[   63.192094]  hidinput_connect+0x686d/0xad60
[   63.192094]  hid_connect+0xf20/0x1b10
[   63.192094]  hid_hw_start+0x83/0x100
[   63.192094]  hid_device_probe+0x2d1/0x680
[   63.192094]  really_probe+0x1c3/0x690
[   63.192094]  __driver_probe_device+0x247/0x300
[   63.192094]  driver_probe_device+0x49/0x210
[   63.192094]  __device_attach_driver+0x160/0x320
[   63.192094]  bus_for_each_drv+0x10f/0x190
[   63.192094]  __device_attach+0x18e/0x370
[   63.192094]  bus_probe_device+0x123/0x170
[   63.192094]  device_add+0xd4d/0x1460
[   63.192094]  hid_add_device+0x30b/0x910
[   63.192094]  usbhid_probe+0x920/0xe00
[   63.192094]  usb_probe_interface+0x363/0x9a0
[   63.192094]  really_probe+0x1c3/0x690
[   63.192094]  __driver_probe_device+0x247/0x300
[   63.192094]  driver_probe_device+0x49/0x210
[   63.192094]  __device_attach_driver+0x160/0x320
[   63.192094]  bus_for_each_drv+0x10f/0x190
[   63.192094]  __device_attach+0x18e/0x370
[   63.192094]  bus_probe_device+0x123/0x170
[   63.192094]  device_add+0xd4d/0x1460
[   63.192094]  usb_set_configuration+0xd14/0x1880
[   63.192094]  usb_generic_driver_probe+0x78/0xb0
[   63.192094]  usb_probe_device+0xaa/0x2e0
[   63.192094]  really_probe+0x1c3/0x690
[   63.192094]  __driver_probe_device+0x247/0x300
[   63.192094]  driver_probe_device+0x49/0x210
[   63.192094]  __device_attach_driver+0x160/0x320
[   63.192094]  bus_for_each_drv+0x10f/0x190
[   63.192094]  __device_attach+0x18e/0x370
[   63.192094]  bus_probe_device+0x123/0x170
[   63.192094]  device_add+0xd4d/0x1460
[   63.192094]  usb_new_device+0x7b4/0x1000
[   63.192094]  hub_event+0x234d/0x3fa0
[   63.192094]  process_one_work+0x5bf/0xfe0
[   63.192094]  worker_thread+0x777/0x13a0
[   63.192094]  </TASK>
[   63.192094]
[   63.192094] Allocated by task 54:
[   63.192094]  kasan_save_stack+0x33/0x60
[   63.192094]  kasan_save_track+0x14/0x30
[   63.192094]  __kasan_kmalloc+0x8f/0xa0
[   63.192094]  __kmalloc_node_track_caller_noprof+0x195/0x420
[   63.192094]  devm_kmalloc+0x74/0x1e0
[   63.192094]  appletb_kbd_probe+0x39/0x440
[   63.192094]  hid_device_probe+0x2d1/0x680
[   63.192094]  really_probe+0x1c3/0x690
[   63.192094]  __driver_probe_device+0x247/0x300
[   63.192094]  driver_probe_device+0x49/0x210
[   63.192094]  __device_attach_driver+0x160/0x320
[...]
[   63.192094]
[   63.192094] Freed by task 54:
[   63.192094]  kasan_save_stack+0x33/0x60
[   63.192094]  kasan_save_track+0x14/0x30
[   63.192094]  kasan_save_free_info+0x3b/0x60
[   63.192094]  __kasan_slab_free+0x37/0x50
[   63.192094]  kfree+0xcf/0x360
[   63.192094]  devres_release_group+0x1f8/0x3c0
[   63.192094]  hid_device_probe+0x315/0x680
[   63.192094]  really_probe+0x1c3/0x690
[   63.192094]  __driver_probe_device+0x247/0x300
[   63.192094]  driver_probe_device+0x49/0x210
[   63.192094]  __device_attach_driver+0x160/0x320
[...]

Fixes: 7d62ba8deacf ("HID: hid-appletb-kbd: add support for fn toggle between media and function mode")
Cc: stable@vger.kernel.org
Reviewed-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-appletb-kbd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -427,13 +427,15 @@ static int appletb_kbd_probe(struct hid_
 	ret = appletb_kbd_set_mode(kbd, appletb_tb_def_mode);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to set touchbar mode\n");
-		goto close_hw;
+		goto unregister_handler;
 	}
 
 	hid_set_drvdata(hdev, kbd);
 
 	return 0;
 
+unregister_handler:
+	input_unregister_handler(&kbd->inp_handler);
 close_hw:
 	if (kbd->backlight_dev)
 		put_device(&kbd->backlight_dev->dev);



